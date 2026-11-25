---
bibliotheque: BIB25
fichier_source: QWEBSRVTP
membre: WSARTAPL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 413
modifie: 2026-11-25
---

# BIB25/QWEBSRVTP/WSARTAPL

```rpg
**free
//==================================================================================================
// Module      : WSARTAPL
// Objet       : TP Web services (corrige) - couche d'appel au service REST des articles
// Cote        : consommateur (personne B)
//--------------------------------------------------------------------------------------------------
// Seul module de l'application qui connait les URL, le HTTP et le JSON.
//
// Adresse du service : lue dans la data area WSARTURL (*LIBL), jamais ecrite en dur. Pour pointer
// vers le service d'une autre equipe, sans recompiler :
//   CHGDTAARA DTAARA(BIB25/WSARTURL)
//             VALUE('https://localhost:10443/web/services/WSART01')
//
// Appels : fonctions QSYS2.HTTP_xxx_VERBOSE. Contrairement a QSYS2.HTTP_GET, elles ne levent pas
// d'erreur SQL sur une reponse 4xx : on recupere le code HTTP (en-tete HTTP_STATUS_CODE) et le
// corps d'erreur, qu'on peut alors afficher.
// Option sslTolerate : le certificat du serveur ne porte pas le nom "localhost".
// Une erreur SQL (service arrete, hote inconnu, data area absente) donne httpCode = 0 et un
// message : le programme appelant ne plante jamais.
//
// Compilation :
//   CRTSQLRPGI OBJ(BIB25/WSARTAPL) SRCFILE(BIB25/QWEBSRVTP) SRCMBR(WSARTAPL)
//              OBJTYPE(*MODULE) COMMIT(*NONE) DBGVIEW(*SOURCE) REPLACE(*YES)
// Liaison     : CRTPGM PGM(BIB25/WSARTGES) MODULE(BIB25/WSARTGES BIB25/WSARTAPL)
//==================================================================================================
ctl-opt nomain
        option(*srcstmt : *nodebugio);

exec sql set option commit    = *none,
                    naming    = *sys,
                    closqlcsr = *endmod;

/copy QWEBSRVTP,WSARTAPPR

// Options des fonctions HTTP (variables : une constante RPG ne peut pas etre variable hote SQL)
dcl-s optLecture  varchar(100) inz('{"sslTolerate":"true"}');
dcl-s optEcriture varchar(100)
                  inz('{"sslTolerate":"true","header":"Content-Type,application/json"}');

// Adresse du service : data area WSARTURL de la *LIBL, relue a chaque appel
// (DTAARA n'est pas admis sur une variable locale)
dcl-s urlBase char(200) dtaara('WSARTURL');

// Corps de reponse : CLOB, une variable hote VARCHAR est limitee a 32 740 octets.
// La longueur des SQLTYPE(CLOB : 65536) doit etre ecrite en dur (constante refusee).
dcl-c CORPS_MAX 65536;


//==================================================================================================
// Liste des articles
//==================================================================================================
dcl-proc appel_lister export;
   dcl-pi *n ind;
      articles likeds(appel_article_t) dim(APPEL_MAX);
      nombre   int(10);
      retour   likeds(appel_retour_t);
   end-pi;

   dcl-s  statut int(10);
   dcl-s  corps  sqltype(CLOB : 65536);
   dcl-ds art   likeds(appel_article_t);
   dcl-s  url   varchar(256);

   nombre = 0;
   clear articles;

   if not urlService('' : url : retour);
      return *off;
   endif;

   exec sql
      SELECT JSON_VALUE(RESPONSE_HTTP_HEADER, '$.HTTP_STATUS_CODE' RETURNING INTEGER),
             COALESCE(RESPONSE_MESSAGE, '')
        INTO :statut, :corps
        FROM TABLE(QSYS2.HTTP_GET_VERBOSE(:url, :optLecture));

   if not analyser(statut : extrait(corps_data : corps_len) : 200 : retour);
      return *off;
   endif;

   // Tableau JSON -> lignes
   exec sql
      DECLARE C_ARTICLES CURSOR FOR
         SELECT J.CODE, J.LIBELLE, J.FAMILLE, J.PRIXHT, J.TAUXTVA, J.STOCK, J.PRIXTTC
           FROM JSON_TABLE(:corps FORMAT JSON, '$[*]'
                   COLUMNS(CODE    CHAR(6)       PATH '$.code',
                           LIBELLE CHAR(30)      PATH '$.libelle',
                           FAMILLE CHAR(3)       PATH '$.famille',
                           PRIXHT  DECIMAL(7, 2) PATH '$.prixHT',
                           TAUXTVA DECIMAL(4, 2) PATH '$.tauxTVA',
                           STOCK   DECIMAL(5, 0) PATH '$.stock',
                           PRIXTTC DECIMAL(9, 2) PATH '$.prixTTC')) AS J;

   exec sql OPEN C_ARTICLES;
   if sqlcode < 0;
      return erreurSql('Liste illisible' : retour);
   endif;

   dow nombre < APPEL_MAX;
      exec sql
         FETCH C_ARTICLES INTO :art.code, :art.libelle, :art.famille, :art.prixHT,
                               :art.tauxTVA, :art.stock, :art.prixTTC;
      if sqlcode = 100;
         leave;
      endif;
      if sqlcode < 0;
         erreurSql('Liste illisible' : retour);     // avant le CLOSE, qui ecrase le SQLCODE
         exec sql CLOSE C_ARTICLES;
         return *off;
      endif;
      nombre += 1;
      articles(nombre) = art;
   enddo;

   exec sql CLOSE C_ARTICLES;
   return *on;
end-proc;


//==================================================================================================
// Lecture d'un article
//==================================================================================================
dcl-proc appel_lire export;
   dcl-pi *n ind;
      code     char(6) const;
      article  likeds(appel_article_t);
      retour   likeds(appel_retour_t);
   end-pi;

   dcl-s  statut int(10);
   dcl-s  corps  sqltype(CLOB : 65536);
   dcl-s  url   varchar(256);

   clear article;

   if not urlService(code : url : retour);
      return *off;
   endif;

   exec sql
      SELECT JSON_VALUE(RESPONSE_HTTP_HEADER, '$.HTTP_STATUS_CODE' RETURNING INTEGER),
             COALESCE(RESPONSE_MESSAGE, '')
        INTO :statut, :corps
        FROM TABLE(QSYS2.HTTP_GET_VERBOSE(:url, :optLecture));

   if not analyser(statut : extrait(corps_data : corps_len) : 200 : retour);
      return *off;
   endif;

   exec sql
      SELECT J.CODE, J.LIBELLE, J.FAMILLE, J.PRIXHT, J.TAUXTVA, J.STOCK, J.PRIXTTC
        INTO :article.code, :article.libelle, :article.famille, :article.prixHT,
             :article.tauxTVA, :article.stock, :article.prixTTC
        FROM JSON_TABLE(:corps FORMAT JSON, '$'
                COLUMNS(CODE    CHAR(6)       PATH '$.code',
                        LIBELLE CHAR(30)      PATH '$.libelle',
                        FAMILLE CHAR(3)       PATH '$.famille',
                        PRIXHT  DECIMAL(7, 2) PATH '$.prixHT',
                        TAUXTVA DECIMAL(4, 2) PATH '$.tauxTVA',
                        STOCK   DECIMAL(5, 0) PATH '$.stock',
                        PRIXTTC DECIMAL(9, 2) PATH '$.prixTTC')) AS J;

   if sqlcode <> 0;
      return erreurSql('Article illisible' : retour);
   endif;

   return *on;
end-proc;


//==================================================================================================
// Creation d'un article (POST, le code est dans le corps)
//==================================================================================================
dcl-proc appel_creer export;
   dcl-pi *n ind;
      article  likeds(appel_article_t) const;
      retour   likeds(appel_retour_t);
   end-pi;

   dcl-s  statut int(10);
   dcl-s  corps  sqltype(CLOB : 65536);
   dcl-s  url   varchar(256);
   dcl-s  json  varchar(1000);

   if not urlService('' : url : retour);
      return *off;
   endif;

   if not versJSON(article : *on : json : retour);
      return *off;
   endif;

   exec sql
      SELECT JSON_VALUE(RESPONSE_HTTP_HEADER, '$.HTTP_STATUS_CODE' RETURNING INTEGER),
             COALESCE(RESPONSE_MESSAGE, '')
        INTO :statut, :corps
        FROM TABLE(QSYS2.HTTP_POST_VERBOSE(:url, :json, :optEcriture));

   return analyser(statut : extrait(corps_data : corps_len) : 201 : retour);
end-proc;


//==================================================================================================
// Modification d'un article (PUT /{code}, le code n'est pas dans le corps)
//==================================================================================================
dcl-proc appel_modifier export;
   dcl-pi *n ind;
      article  likeds(appel_article_t) const;
      retour   likeds(appel_retour_t);
   end-pi;

   dcl-s  statut int(10);
   dcl-s  corps  sqltype(CLOB : 65536);
   dcl-s  url   varchar(256);
   dcl-s  json  varchar(1000);

   if not urlService(article.code : url : retour);
      return *off;
   endif;

   if not versJSON(article : *off : json : retour);
      return *off;
   endif;

   exec sql
      SELECT JSON_VALUE(RESPONSE_HTTP_HEADER, '$.HTTP_STATUS_CODE' RETURNING INTEGER),
             COALESCE(RESPONSE_MESSAGE, '')
        INTO :statut, :corps
        FROM TABLE(QSYS2.HTTP_PUT_VERBOSE(:url, :json, :optEcriture));

   return analyser(statut : extrait(corps_data : corps_len) : 204 : retour);
end-proc;


//==================================================================================================
// Suppression d'un article
//==================================================================================================
dcl-proc appel_supprimer export;
   dcl-pi *n ind;
      code     char(6) const;
      retour   likeds(appel_retour_t);
   end-pi;

   dcl-s  statut int(10);
   dcl-s  corps  sqltype(CLOB : 65536);
   dcl-s  url   varchar(256);

   if not urlService(code : url : retour);
      return *off;
   endif;

   exec sql
      SELECT JSON_VALUE(RESPONSE_HTTP_HEADER, '$.HTTP_STATUS_CODE' RETURNING INTEGER),
             COALESCE(RESPONSE_MESSAGE, '')
        INTO :statut, :corps
        FROM TABLE(QSYS2.HTTP_DELETE_VERBOSE(:url, :optLecture));

   return analyser(statut : extrait(corps_data : corps_len) : 204 : retour);
end-proc;


//==================================================================================================
// Procedure interne : URL du service (data area WSARTURL), suivie de /code si un code est donne
//==================================================================================================
dcl-proc urlService;
   dcl-pi *n ind;
      code     varchar(6) const;
      url      varchar(256);
      retour   likeds(appel_retour_t);
   end-pi;

   clear retour;

   monitor;
      in urlBase;
   on-error;
      retour.message = 'Data area WSARTURL introuvable : adresse du service inconnue';
      return *off;
   endmon;

   url = %trimr(urlBase);
   if url = '';
      retour.message = 'Data area WSARTURL vide : adresse du service inconnue';
      return *off;
   endif;

   if %trim(code) <> '';
      url += '/' + %trim(code);
   endif;
   return *on;
end-proc;


//==================================================================================================
// Procedure interne : article -> corps JSON (sans le code pour une modification)
//==================================================================================================
dcl-proc versJSON;
   dcl-pi *n ind;
      article   likeds(appel_article_t) const;
      avecCode  ind const;
      json      varchar(1000);
      retour    likeds(appel_retour_t);
   end-pi;

   dcl-s code char(6);

   // Un code NULL n'apparait pas dans le JSON (ABSENT ON NULL)
   code = article.code;

   exec sql
      SET :json = JSON_OBJECT(KEY 'code'    VALUE CASE WHEN :avecCode = '1'
                                                       THEN TRIM(:code) END,
                              KEY 'libelle' VALUE TRIM(:article.libelle),
                              KEY 'famille' VALUE TRIM(:article.famille),
                              KEY 'prixHT'  VALUE :article.prixHT,
                              KEY 'tauxTVA' VALUE :article.tauxTVA,
                              KEY 'stock'   VALUE :article.stock
                              ABSENT ON NULL);

   if sqlcode < 0;
      return erreurSql('Article non convertible en JSON' : retour);
   endif;
   return *on;
end-proc;


//==================================================================================================
// Procedure interne : interprete la reponse. *on si le code HTTP est celui attendu.
// Sinon, le corps d'erreur du contrat {"regle":"..","msg":".."} alimente le retour.
//==================================================================================================
dcl-proc analyser;
   dcl-pi *n ind;
      statut   int(10) const;
      texte    varchar(1000) const;     // debut du corps de la reponse
      attendu  int(10) const;
      retour   likeds(appel_retour_t);
   end-pi;

   dcl-s regle  varchar(10);
   dcl-s msg    varchar(70);
   dcl-s indReg int(5);
   dcl-s indMsg int(5);

   clear retour;

   // Erreur SQL sur l'appel lui-meme : service arrete, hote inconnu, certificat...
   if sqlcode < 0;
      return erreurSql('Service injoignable' : retour);
   endif;

   retour.httpCode = statut;
   if statut = attendu;
      return *on;
   endif;

   // Corps d'erreur au format du contrat ? (sinon page HTML d'Apache ou d'IWS)
   exec sql
      SET :regle :indReg = JSON_VALUE(:texte FORMAT JSON, '$.regle'),
          :msg   :indMsg = JSON_VALUE(:texte FORMAT JSON, '$.msg');

   if sqlcode = 0 and indMsg >= 0;
      if indReg >= 0;
         retour.regle = regle;
      endif;
      retour.message = msg;
   else;
      select;
      when statut = 404;
         retour.message = 'Ressource introuvable : service non deploye ?';
      when statut >= 500;
         retour.message = 'Erreur du serveur';
      other;
         retour.message = 'Reponse inattendue du service';
      endsl;
   endif;

   return *off;
end-proc;


//==================================================================================================
// Procedure interne : erreur SQL -> httpCode 0 et message avec le SQLCODE. Renvoie toujours *off.
//==================================================================================================
dcl-proc erreurSql;
   dcl-pi *n ind;
      texte   varchar(40) const;
      retour  likeds(appel_retour_t);
   end-pi;

   dcl-s codeSql int(10);

   codeSql = sqlcode;
   retour.httpCode = 0;
   retour.regle    = '';
   retour.message  = texte + ' (SQLCODE ' + %char(codeSql) + ')';
   return *off;
end-proc;


//==================================================================================================
// Procedure interne : debut du corps de la reponse (assez pour lire un corps d'erreur)
//==================================================================================================
dcl-proc extrait;
   dcl-pi *n varchar(1000);
      donnees  char(CORPS_MAX) const;
      longueur uns(10) const;
   end-pi;

   if longueur = 0;
      return '';
   endif;
   return %subst(donnees : 1 : %min(longueur : 1000));
end-proc;
```
