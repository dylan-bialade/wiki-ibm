---
bibliotheque: BIB25
fichier_source: QWEBSRVTP
membre: WSARTCRUD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 596
modifie: 2026-11-25
---

# BIB25/QWEBSRVTP/WSARTCRUD

```rpg
**free
//==================================================================================================
// Module      : WSARTCRUD
// Objet       : TP Web services (corrige) - CRUD REST IWS sur la table WSARTICLE
// Cote        : fournisseur (personne A)
//--------------------------------------------------------------------------------------------------
// Contrat d'interface de l'equipe 00 (service WSART00, serveur IWS FORMATIONS) :
//   Base : https://<systeme>:10443/web/services/WSART00
//
//   Procedure        Methode  URL       Entree           Succes                Codes possibles
//   WSART_LISTER     GET      /         -                200 + tableau JSON    200 500
//   WSART_LIRE       GET      /{code}   -                200 + objet JSON      200 404 500
//   WSART_CREER      POST     /         article complet  201 sans corps        201 400 409 422 500
//   WSART_MODIFIER   PUT      /{code}   article sans code 204 sans corps       204 400 404 422 500
//   WSART_SUPPRIMER  DELETE   /{code}   -                204 sans corps        204 404 409 500
//
//   Article (la casse des cles compte) :
//     {"code":"A00001","libelle":"CLAVIER USB AZERTY","famille":"INF","prixHT":19.90,
//      "tauxTVA":20.00,"stock":12,"prixTTC":23.88,"dateMaj":"2026-11-24 10:15:00"}
//     En entree : code (POST uniquement), libelle, famille, prixHT, tauxTVA, stock.
//     prixTTC et dateMaj sont renvoyes en lecture uniquement.
//
//   Erreur (tout code >= 400) : {"regle":"RG05","msg":"Prix HT : de 0.01 a 99999.99"}
//     regle = RG01 a RG09, REQ (requete illisible), ART (article inconnu ou deja existant),
//             SQL (erreur technique).
//
// Conventions IWS (les parametres sont reconnus par leur nom grace a PGMINFO *DCLCASE) :
//   http_code (sortie) statut HTTP, http_text (sortie) corps en cas d'echec (64 caracteres),
//   p_JSON corps de la reponse (GET) ou de la requete (POST, PUT), p_code parametre de chemin.
//   Au deploiement : sortie non encapsulee (wrap output = non), entree non encapsulee pour POST
//   et PUT (wrap input = non), sinon IWS attend {"p_JSON":"..."}.
//
// Compilation :
//   CRTSQLRPGI OBJ(BIB25/WSARTCRUD) SRCFILE(BIB25/QWEBSRVTP) SRCMBR(WSARTCRUD)
//              OBJTYPE(*MODULE) COMMIT(*NONE) DBGVIEW(*SOURCE) REPLACE(*YES)
//   (BIB25 en liste de bibliotheques : table et copie sont resolues par la *LIBL)
// Liaison     : avec WSARTREG dans le programme de service du TP (EXPORT(*ALL))
//==================================================================================================
ctl-opt nomain
        thread(*concurrent)
        option(*srcstmt : *nodebugio)
        pgminfo(*pcml : *dclcase : *module : *v7);

exec sql set option commit    = *none,
                    naming    = *sys,
                    datfmt    = *iso,
                    closqlcsr = *endmod;

/copy QWEBSRVTP,WSARTPR

// Codes HTTP imposes par le TP
dcl-c HTTP_OK           200;
dcl-c HTTP_CREATED      201;
dcl-c HTTP_NO_CONTENT   204;
dcl-c HTTP_BAD_REQUEST  400;
dcl-c HTTP_NOT_FOUND    404;
dcl-c HTTP_CONFLICT     409;
dcl-c HTTP_UNPROCESSABLE 422;
dcl-c HTTP_SERVER_ERROR 500;

dcl-c JSON_MAX          65536;
dcl-c SQLCODE_DOUBLON   -803;

// Modes de lecture du corps JSON
dcl-c MODE_CREATION     'C';
dcl-c MODE_MODIFICATION 'M';

// Une ligne de la table
dcl-ds ligne_t qualified template;
   code     char(6);
   libelle  varchar(30);
   famille  char(3);
   prixHT   packed(7 : 2);
   tauxTVA  packed(4 : 2);
   stock    int(10);
   dateMaj  varchar(19);
end-ds;


//==================================================================================================
// GET / : liste des articles triee par code
//==================================================================================================
dcl-proc WSART_LISTER serialize export;
   dcl-pi *n;
      http_code  int(5);
      http_text  char(64);
      p_JSON     char(JSON_MAX);
   end-pi;

   dcl-ds ligne   likeds(ligne_t);
   dcl-s  objet   varchar(1000);
   dcl-s  liste   varchar(65000);
   dcl-s  premier ind inz(*on);

   http_code = HTTP_SERVER_ERROR;
   http_text = '';
   p_JSON    = '[]';

   exec sql
      DECLARE C_LISTE CURSOR FOR
         SELECT CODE, LIBELLE, FAMILLE, PRIX_HT, TAUX_TVA, STOCK,
                VARCHAR_FORMAT(DATE_MAJ, 'YYYY-MM-DD HH24:MI:SS')
           FROM WSARTICLE
          ORDER BY CODE;

   exec sql OPEN C_LISTE;
   if sqlcode < 0;
      repondreErreurSql(http_code : http_text);
      return;
   endif;

   liste = '[';
   dow 1 = 1;
      exec sql
         FETCH C_LISTE INTO :ligne.code, :ligne.libelle, :ligne.famille, :ligne.prixHT,
                            :ligne.tauxTVA, :ligne.stock, :ligne.dateMaj;
      if sqlcode = 100;
         leave;
      endif;
      if sqlcode < 0 or not versJSON(ligne : objet);
         repondreErreurSql(http_code : http_text);
         exec sql CLOSE C_LISTE;
         return;
      endif;

      // Garde-fou : la reponse doit tenir dans p_JSON
      if %len(liste) + %len(objet) + 2 > %len(liste : *max);
         repondreErreur(HTTP_SERVER_ERROR : 'SQL' : 'Liste trop longue' : http_code : http_text);
         exec sql CLOSE C_LISTE;
         return;
      endif;

      if not premier;
         liste += ',';
      endif;
      liste += objet;
      premier = *off;
   enddo;

   exec sql CLOSE C_LISTE;

   p_JSON    = liste + ']';
   http_code = HTTP_OK;
end-proc;


//==================================================================================================
// GET /{code} : un article
//==================================================================================================
dcl-proc WSART_LIRE serialize export;
   dcl-pi *n;
      p_code     char(20) const;
      http_code  int(5);
      http_text  char(64);
      p_JSON     char(JSON_MAX);
   end-pi;

   dcl-ds ligne likeds(ligne_t);
   dcl-s  objet varchar(1000);

   http_code = HTTP_SERVER_ERROR;
   http_text = '';
   p_JSON    = '{}';

   if not lireLigne(p_code : ligne : http_code : http_text);
      return;
   endif;

   if not versJSON(ligne : objet);
      repondreErreurSql(http_code : http_text);
      return;
   endif;

   p_JSON    = objet;
   http_code = HTTP_OK;
end-proc;


//==================================================================================================
// POST / : creation d'un article
//==================================================================================================
dcl-proc WSART_CREER serialize export;
   dcl-pi *n;
      p_JSON     char(JSON_MAX) const;
      http_code  int(5);
      http_text  char(64);
   end-pi;

   dcl-ds article  likeds(wsart_article_t);
   dcl-ds resultat likeds(wsart_resultat_t);
   dcl-s  code     char(6);
   dcl-s  libelle  varchar(30);
   dcl-s  famille  char(3);
   dcl-s  prixHT   packed(7 : 2);
   dcl-s  tauxTVA  packed(4 : 2);
   dcl-s  stock    int(10);

   http_code = HTTP_SERVER_ERROR;
   http_text = '';

   // 400 : requete illisible
   if not lireCorps(p_JSON : MODE_CREATION : article : http_code : http_text);
      return;
   endif;

   // 422 : regle metier violee (RG01 a RG06)
   if not wsart_controlerCreation(article : resultat);
      repondreErreur(HTTP_UNPROCESSABLE : resultat.regle : resultat.message
                    : http_code : http_text);
      return;
   endif;

   // Les regles garantissent que chaque valeur tient dans sa colonne
   code    = article.code;
   libelle = %trim(article.libelle);
   famille = article.famille;
   prixHT  = article.prixHT;
   tauxTVA = article.tauxTVA;
   stock   = article.stock;

   exec sql
      INSERT INTO WSARTICLE (CODE, LIBELLE, FAMILLE, PRIX_HT, TAUX_TVA, STOCK)
      VALUES (:code, :libelle, :famille, :prixHT, :tauxTVA, :stock);

   // 409 : code deja existant
   if sqlcode = SQLCODE_DOUBLON;
      repondreErreur(HTTP_CONFLICT : 'ART' : 'Article ' + code + ' deja existant'
                    : http_code : http_text);
      return;
   endif;

   if sqlcode < 0;
      repondreErreurSql(http_code : http_text);
      return;
   endif;

   http_code = HTTP_CREATED;
end-proc;


//==================================================================================================
// PUT /{code} : modification d'un article (le code est dans l'URL, pas dans le corps)
//==================================================================================================
dcl-proc WSART_MODIFIER serialize export;
   dcl-pi *n;
      p_code     char(20) const;
      p_JSON     char(JSON_MAX) const;
      http_code  int(5);
      http_text  char(64);
   end-pi;

   dcl-ds ligne    likeds(ligne_t);
   dcl-ds article  likeds(wsart_article_t);
   dcl-ds actuel   likeds(wsart_article_t);
   dcl-ds resultat likeds(wsart_resultat_t);
   dcl-s  libelle  varchar(30);
   dcl-s  famille  char(3);
   dcl-s  prixHT   packed(7 : 2);
   dcl-s  tauxTVA  packed(4 : 2);
   dcl-s  stock    int(10);

   http_code = HTTP_SERVER_ERROR;
   http_text = '';

   // 400 : requete illisible
   if not lireCorps(p_JSON : MODE_MODIFICATION : article : http_code : http_text);
      return;
   endif;

   // Un code dans le corps est tolere s'il est identique a celui de l'URL
   if article.code <> '' and article.code <> %trim(p_code);
      repondreErreur(HTTP_BAD_REQUEST : 'REQ' : 'Code du corps different de l''URL'
                    : http_code : http_text);
      return;
   endif;

   // 404 : article inconnu ; l'article actuel sert a RG09
   if not lireLigne(p_code : ligne : http_code : http_text);
      return;
   endif;
   actuel.code    = ligne.code;
   actuel.prixHT  = ligne.prixHT;
   actuel.tauxTVA = ligne.tauxTVA;
   actuel.stock   = ligne.stock;

   // 422 : regle metier violee (RG02 a RG06, RG09)
   if not wsart_controlerModification(article : actuel : resultat);
      repondreErreur(HTTP_UNPROCESSABLE : resultat.regle : resultat.message
                    : http_code : http_text);
      return;
   endif;

   libelle = %trim(article.libelle);
   famille = article.famille;
   prixHT  = article.prixHT;
   tauxTVA = article.tauxTVA;
   stock   = article.stock;

   exec sql
      UPDATE WSARTICLE
         SET LIBELLE  = :libelle,
             FAMILLE  = :famille,
             PRIX_HT  = :prixHT,
             TAUX_TVA = :tauxTVA,
             STOCK    = :stock
       WHERE CODE = :ligne.code;

   // Supprime entre la lecture et la mise a jour
   if sqlcode = 100;
      repondreErreur(HTTP_NOT_FOUND : 'ART' : 'Article ' + ligne.code + ' inconnu'
                    : http_code : http_text);
      return;
   endif;

   if sqlcode < 0;
      repondreErreurSql(http_code : http_text);
      return;
   endif;

   http_code = HTTP_NO_CONTENT;
end-proc;


//==================================================================================================
// DELETE /{code} : suppression d'un article
//==================================================================================================
dcl-proc WSART_SUPPRIMER serialize export;
   dcl-pi *n;
      p_code     char(20) const;
      http_code  int(5);
      http_text  char(64);
   end-pi;

   dcl-ds ligne    likeds(ligne_t);
   dcl-ds actuel   likeds(wsart_article_t);
   dcl-ds resultat likeds(wsart_resultat_t);

   http_code = HTTP_SERVER_ERROR;
   http_text = '';

   // 404 : article inconnu
   if not lireLigne(p_code : ligne : http_code : http_text);
      return;
   endif;
   actuel.code  = ligne.code;
   actuel.stock = ligne.stock;

   // 409 : RG07, article encore en stock
   if not wsart_controlerSuppression(actuel : resultat);
      repondreErreur(HTTP_CONFLICT : resultat.regle : resultat.message
                    : http_code : http_text);
      return;
   endif;

   exec sql
      DELETE FROM WSARTICLE
       WHERE CODE = :ligne.code;

   if sqlcode = 100;
      repondreErreur(HTTP_NOT_FOUND : 'ART' : 'Article ' + ligne.code + ' inconnu'
                    : http_code : http_text);
      return;
   endif;

   if sqlcode < 0;
      repondreErreurSql(http_code : http_text);
      return;
   endif;

   http_code = HTTP_NO_CONTENT;
end-proc;


//==================================================================================================
// Procedure interne : lit un article par son code.
// *off : la reponse 404 ou 500 est deja preparee.
//==================================================================================================
dcl-proc lireLigne;
   dcl-pi *n ind;
      p_code     char(20) const;
      ligne      likeds(ligne_t);
      http_code  int(5);
      http_text  char(64);
   end-pi;

   dcl-s code varchar(20);

   clear ligne;
   code = %trim(p_code);

   // Un code de plus de 6 caracteres ne peut pas exister
   if %len(code) <> 6;
      repondreErreur(HTTP_NOT_FOUND : 'ART' : 'Article ' + nettoyer(code) + ' inconnu'
                    : http_code : http_text);
      return *off;
   endif;

   exec sql
      SELECT CODE, LIBELLE, FAMILLE, PRIX_HT, TAUX_TVA, STOCK,
             VARCHAR_FORMAT(DATE_MAJ, 'YYYY-MM-DD HH24:MI:SS')
        INTO :ligne.code, :ligne.libelle, :ligne.famille, :ligne.prixHT,
             :ligne.tauxTVA, :ligne.stock, :ligne.dateMaj
        FROM WSARTICLE
       WHERE CODE = :code;

   if sqlcode = 100;
      repondreErreur(HTTP_NOT_FOUND : 'ART' : 'Article ' + nettoyer(code) + ' inconnu'
                    : http_code : http_text);
      return *off;
   endif;

   if sqlcode < 0;
      repondreErreurSql(http_code : http_text);
      return *off;
   endif;

   return *on;
end-proc;


//==================================================================================================
// Procedure interne : ligne de la table -> objet JSON. Le prix TTC vient du module de regles
// (RG08) : il n'est jamais calcule en SQL. JSON_OBJECT gere l'echappement des caracteres.
//==================================================================================================
dcl-proc versJSON;
   dcl-pi *n ind;
      ligne  likeds(ligne_t) const;
      objet  varchar(1000);
   end-pi;

   dcl-s prixTTC packed(9 : 2);

   prixTTC = wsart_prixTTC(ligne.prixHT : ligne.tauxTVA);

   exec sql
      SET :objet = JSON_OBJECT(KEY 'code'    VALUE TRIM(:ligne.code),
                               KEY 'libelle' VALUE TRIM(:ligne.libelle),
                               KEY 'famille' VALUE TRIM(:ligne.famille),
                               KEY 'prixHT'  VALUE :ligne.prixHT,
                               KEY 'tauxTVA' VALUE :ligne.tauxTVA,
                               KEY 'stock'   VALUE :ligne.stock,
                               KEY 'prixTTC' VALUE :prixTTC,
                               KEY 'dateMaj' VALUE :ligne.dateMaj);

   return (sqlcode >= 0);
end-proc;


//==================================================================================================
// Procedure interne : lit le corps JSON d'un POST ou d'un PUT et verifie qu'il est lisible.
// Seuls la forme et les types sont controles ici (400). Les valeurs sont controlees par le
// module de regles (422).
// *off : la reponse 400 ou 500 est deja preparee.
//==================================================================================================
dcl-proc lireCorps;
   dcl-pi *n ind;
      p_JSON     char(JSON_MAX) const;
      mode       char(1) const;
      article    likeds(wsart_article_t);
      http_code  int(5);
      http_text  char(64);
   end-pi;

   dcl-s json     sqltype(CLOB : 65536);
   dcl-s valide   int(5);
   dcl-s code     varchar(100);
   dcl-s libelle  varchar(200);
   dcl-s famille  varchar(100);
   dcl-s prixHT   packed(15 : 2);
   dcl-s tauxTVA  packed(15 : 2);
   dcl-s stock    packed(15 : 0);
   dcl-s indCode  int(5);
   dcl-s indLib   int(5);
   dcl-s indFam   int(5);
   dcl-s indPrix  int(5);
   dcl-s indTva   int(5);
   dcl-s indStock int(5);
   dcl-s manque   varchar(10);

   clear article;

   json_data = p_JSON;
   json_len  = %len(%trimr(p_JSON));
   if json_len = 0;
      repondreErreur(HTTP_BAD_REQUEST : 'REQ' : 'Corps JSON vide' : http_code : http_text);
      return *off;
   endif;

   // Une cle absente, nulle ou d'un type non convertible donne NULL (indicateur a -1)
   exec sql
      SET :valide            = CASE WHEN :json IS JSON OBJECT THEN 1 ELSE 0 END,
          :code    :indCode  = JSON_VALUE(:json FORMAT JSON, '$.code'    RETURNING VARCHAR(100)),
          :libelle :indLib   = JSON_VALUE(:json FORMAT JSON, '$.libelle' RETURNING VARCHAR(200)),
          :famille :indFam   = JSON_VALUE(:json FORMAT JSON, '$.famille' RETURNING VARCHAR(100)),
          :prixHT  :indPrix  = JSON_VALUE(:json FORMAT JSON, '$.prixHT'
                                          RETURNING DECIMAL(15, 2)),
          :tauxTVA :indTva   = JSON_VALUE(:json FORMAT JSON, '$.tauxTVA'
                                          RETURNING DECIMAL(15, 2)),
          :stock   :indStock = JSON_VALUE(:json FORMAT JSON, '$.stock'
                                          RETURNING DECIMAL(15, 0));

   if sqlcode < 0;
      repondreErreurSql(http_code : http_text);
      return *off;
   endif;

   if valide = 0;
      repondreErreur(HTTP_BAD_REQUEST : 'REQ' : 'JSON invalide' : http_code : http_text);
      return *off;
   endif;

   // Premiere donnee obligatoire absente ou de mauvais type
   select;
   when mode = MODE_CREATION and indCode < 0;
      manque = 'code';
   when indLib < 0;
      manque = 'libelle';
   when indFam < 0;
      manque = 'famille';
   when indPrix < 0;
      manque = 'prixHT';
   when indTva < 0;
      manque = 'tauxTVA';
   when indStock < 0;
      manque = 'stock';
   endsl;

   if manque <> '';
      repondreErreur(HTTP_BAD_REQUEST : 'REQ' : manque + ' absent ou invalide'
                    : http_code : http_text);
      return *off;
   endif;

   if indCode >= 0;
      article.code = %trim(code);
   endif;
   article.libelle = libelle;
   article.famille = %trim(famille);
   article.prixHT  = prixHT;
   article.tauxTVA = tauxTVA;
   article.stock   = stock;
   return *on;
end-proc;


//==================================================================================================
// Procedure interne : prepare une reponse d'erreur {"regle":"...","msg":"..."}
//==================================================================================================
dcl-proc repondreErreur;
   dcl-pi *n;
      code       int(5)      const;
      regle      varchar(4)  const;
      message    varchar(60) const;
      http_code  int(5);
      http_text  char(64);
   end-pi;

   http_code = code;
   http_text = '{"regle":"' + %trim(regle) + '","msg":"' + message + '"}';
end-proc;


//==================================================================================================
// Procedure interne : erreur SQL -> 500. A appeler juste apres l'instruction fautive.
//==================================================================================================
dcl-proc repondreErreurSql;
   dcl-pi *n;
      http_code  int(5);
      http_text  char(64);
   end-pi;

   dcl-s codeSql int(10);
   dcl-s etatSql char(5);

   codeSql = sqlcode;
   etatSql = sqlstate;
   repondreErreur(HTTP_SERVER_ERROR : 'SQL'
                 : 'SQLCODE ' + %char(codeSql) + ' SQLSTATE ' + etatSql
                 : http_code : http_text);
end-proc;


//==================================================================================================
// Procedure interne : retire d'un code recu dans l'URL ce qui casserait le JSON d'erreur
//==================================================================================================
dcl-proc nettoyer;
   dcl-pi *n varchar(10);
      texte varchar(20) const;
   end-pi;

   dcl-s propre varchar(20);

   propre = %scanrpl('"' : '' : texte);
   propre = %scanrpl('\' : '' : propre);
   return %subst(propre : 1 : %min(%len(propre) : 10));
end-proc;
```
