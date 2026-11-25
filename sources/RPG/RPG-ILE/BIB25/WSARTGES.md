---
bibliotheque: BIB25
fichier_source: QWEBSRVTP
membre: WSARTGES
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 360
modifie: 2026-11-25
---

# BIB25/QWEBSRVTP/WSARTGES

```rpg
**free
//==================================================================================================
// Programme   : WSARTGES
// Objet       : TP Web services (corrige) - gestion des articles par sous-fichier, via le service
// Cote        : consommateur (personne B)
//--------------------------------------------------------------------------------------------------
// Aucun acces a la table WSARTICLE : toutes les donnees passent par la couche d'appel WSARTAPL.
// Aucune regle metier : les controles RG01 a RG09 sont faits par le service, le programme
// affiche son message (code HTTP, regle violee, texte).
//
// Options : 2 = Modifier, 4 = Supprimer, 5 = Afficher
// Touches : F3 = Sortie, F5 = Actualiser, F6 = Creer, F12 = Annuler
//
// Prerequis : data area WSARTURL (adresse du service) dans la liste de bibliotheques
//   CRTDTAARA DTAARA(BIB25/WSARTURL) TYPE(*CHAR) LEN(200)
//             VALUE('https://localhost:10443/web/services/WSART00')
//
// Compilation :
//   CRTRPGMOD MODULE(BIB25/WSARTGES) SRCFILE(BIB25/QWEBSRVTP) SRCMBR(WSARTGES)
//             DBGVIEW(*SOURCE) REPLACE(*YES)
//   CRTPGM    PGM(BIB25/WSARTGES) MODULE(BIB25/WSARTGES BIB25/WSARTAPL)
//             ACTGRP(*NEW) REPLACE(*YES)
// Appel       : ADDLIBLE BIB25 puis CALL WSARTGES
//==================================================================================================
ctl-opt main(main)
        option(*srcstmt : *nodebugio)
        decedit('0,');

dcl-f WSARTE workstn sfile(SFL01 : rang) indds(indic);

/copy QWEBSRVTP,WSARTAPPR

dcl-ds indic qualified;
   sortie       ind pos(3);
   actualiser   ind pos(5);
   creer        ind pos(6);
   annuler      ind pos(12);
   sflDsp       ind pos(31);
   sflDspCtl    ind pos(32);
   sflClr       ind pos(33);
   sflEnd       ind pos(34);
   modeCreation ind pos(41);
   modeAffich   ind pos(42);
end-ds;

// Modes de l'ecran de detail
dcl-c MODE_CREATION     'C';
dcl-c MODE_MODIFICATION 'M';
dcl-c MODE_AFFICHAGE    'A';

dcl-s rang     packed(4 : 0);                  // rang dans le sous-fichier
dcl-s nbLignes int(10);                        // nombre de lignes chargees


//==================================================================================================
// Boucle principale : liste des articles
//==================================================================================================
dcl-proc main;

   dcl-s recharger ind;

   chargerListe();

   dow 1 = 1;
      write BAS;
      exfmt CTL01;
      MSG = '';

      select;
      when indic.sortie or indic.annuler;
         leave;

      when indic.actualiser;
         chargerListe();
         if MSG = '';
            MSG = 'Liste actualisée.';
         endif;

      when indic.creer;
         if detail(MODE_CREATION : '');
            chargerListe();
         endif;

      other;
         // Options saisies dans le sous-fichier, puis positionnement
         recharger = traiterOptions();
         if recharger;
            chargerListe();
         endif;
         positionner();
      endsl;
   enddo;

   close *all;
end-proc;


//==================================================================================================
// Charge tout le sous-fichier depuis le service. Le message d'erreur eventuel est conserve.
//==================================================================================================
dcl-proc chargerListe;

   dcl-ds articles likeds(appel_article_t) dim(APPEL_MAX);
   dcl-ds retour   likeds(appel_retour_t);
   dcl-s  i        int(10);

   // Vidage du sous-fichier
   indic.sflClr = *on;
   write CTL01;
   indic.sflClr = *off;
   nbLignes = 0;

   if not appel_lister(articles : nbLignes : retour);
      MSG = formaterMessage(retour);
      nbLignes = 0;
   endif;

   for i = 1 to nbLignes;
      rang    = i;
      SOPT    = '';
      SCODE   = articles(i).code;
      SLIB    = articles(i).libelle;
      SFAM    = articles(i).famille;
      SPRIXHT = articles(i).prixHT;
      STTC    = articles(i).prixTTC;
      SSTOCK  = articles(i).stock;
      write SFL01;
   endfor;

   indic.sflDsp    = (nbLignes > 0);
   indic.sflDspCtl = *on;
   indic.sflEnd    = *on;
   RCDNBR        = 1;
   if nbLignes = 0 and MSG = '';
      MSG = 'Aucun article. F6 pour en créer un.';
   endif;
end-proc;


//==================================================================================================
// Traite les options 2, 4 et 5 saisies dans le sous-fichier.
// Renvoie *on si la liste doit etre rechargee (article cree, modifie, supprime ou disparu).
//==================================================================================================
dcl-proc traiterOptions;
   dcl-pi *n ind;
   end-pi;

   dcl-s recharger ind inz(*off);

   if nbLignes = 0;
      return *off;
   endif;

   readc SFL01;
   dow not %eof(WSARTE);
      select;
      when SOPT = '2';
         recharger = detail(MODE_MODIFICATION : SCODE) or recharger;
      when SOPT = '4';
         recharger = supprimer(SCODE : SLIB) or recharger;
      when SOPT = '5';
         recharger = detail(MODE_AFFICHAGE : SCODE) or recharger;
      endsl;

      SOPT = '';
      update SFL01;
      readc SFL01;
   enddo;

   return recharger;
end-proc;


//==================================================================================================
// Positionne la premiere page sur le premier code >= POSCOD
//==================================================================================================
dcl-proc positionner;

   if POSCOD = '' or nbLignes = 0;
      return;
   endif;

   for rang = 1 to nbLignes;
      chain rang SFL01;
      if SCODE >= POSCOD;
         leave;
      endif;
   endfor;

   RCDNBR = %min(rang : nbLignes);
   POSCOD = '';
end-proc;


//==================================================================================================
// Ecran de detail : creation, modification ou affichage.
// Renvoie *on si la liste doit etre rechargee.
//==================================================================================================
dcl-proc detail;
   dcl-pi *n ind;
      mode  char(1) const;
      code  char(6) const;
   end-pi;

   dcl-ds article likeds(appel_article_t);
   dcl-ds retour  likeds(appel_retour_t);
   dcl-s  ok      ind;

   indic.modeCreation = (mode = MODE_CREATION);
   indic.modeAffich   = (mode = MODE_AFFICHAGE);

   // Modification et affichage : l'article est relu aupres du service, il a pu changer
   if mode = MODE_CREATION;
      DTITRE = 'Création d''un article';
      clear article;
      article.tauxTVA = 20;
   else;
      if not appel_lire(code : article : retour);
         MSG = formaterMessage(retour);
         if retour.httpCode = 404;
            MSG = 'Article ' + code + ' supprimé entre-temps. Liste rechargée.';
            return *on;
         endif;
         return *off;
      endif;
      if mode = MODE_MODIFICATION;
         DTITRE = 'Modification d''un article';
      else;
         DTITRE = 'Affichage d''un article';
      endif;
   endif;

   versEcran(article);
   MSG = '';

   dow 1 = 1;
      exfmt DET01;

      if indic.annuler;
         MSG = '';
         return *off;
      endif;

      if mode = MODE_AFFICHAGE;
         return *off;
      endif;

      // La saisie reste a l'ecran en cas d'echec : l'utilisateur la corrige
      depuisEcran(article);
      if mode = MODE_CREATION;
         ok = appel_creer(article : retour);
      else;
         ok = appel_modifier(article : retour);
      endif;

      if ok;
         if mode = MODE_CREATION;
            MSG = 'Article ' + article.code + ' créé (HTTP ' + %char(retour.httpCode) + ').';
         else;
            MSG = 'Article ' + article.code + ' modifié (HTTP '
                + %char(retour.httpCode) + ').';
         endif;
         return *on;
      endif;

      // 404 en modification : supprime par un autre utilisateur, pas une erreur du programme
      if mode = MODE_MODIFICATION and retour.httpCode = 404;
         MSG = 'Article ' + article.code + ' supprimé entre-temps. Liste rechargée.';
         return *on;
      endif;

      MSG = formaterMessage(retour);
   enddo;
end-proc;


//==================================================================================================
// Suppression apres confirmation. Renvoie *on si la liste doit etre rechargee.
//==================================================================================================
dcl-proc supprimer;
   dcl-pi *n ind;
      code     char(6) const;
      libelle  char(30) const;
   end-pi;

   dcl-ds retour likeds(appel_retour_t);

   WCODE = code;
   WLIB  = libelle;
   WREP  = 'N';
   exfmt CONF01;

   if indic.annuler or WREP <> 'O';
      MSG = 'Suppression de ' + code + ' abandonnée.';
      return *off;
   endif;

   if appel_supprimer(code : retour);
      MSG = 'Article ' + code + ' supprimé (HTTP ' + %char(retour.httpCode) + ').';
      return *on;
   endif;

   MSG = formaterMessage(retour);
   return (retour.httpCode = 404);
end-proc;


//==================================================================================================
// Ligne de message : "HTTP 422 RG05 Prix HT : de 0.01 a 99999.99"
//==================================================================================================
dcl-proc formaterMessage;
   dcl-pi *n varchar(78);
      retour likeds(appel_retour_t) const;
   end-pi;

   dcl-s texte varchar(120);

   if retour.httpCode = 0;
      texte = 'Service indisponible : ' + retour.message;
   else;
      texte = 'HTTP ' + %char(retour.httpCode) + ' ';
      if retour.regle <> '';
         texte += %trim(retour.regle) + ' ';
      endif;
      texte += retour.message;
   endif;

   return %subst(texte : 1 : %min(%len(texte) : 78));
end-proc;


//==================================================================================================
// Article <-> zones de l'ecran de detail
//==================================================================================================
dcl-proc versEcran;
   dcl-pi *n;
      article likeds(appel_article_t) const;
   end-pi;

   DCODE   = article.code;
   DLIB    = article.libelle;
   DFAM    = article.famille;
   DPRIXHT = article.prixHT;
   DTVA    = article.tauxTVA;
   DSTOCK  = article.stock;
   DTTC    = article.prixTTC;
end-proc;

dcl-proc depuisEcran;
   dcl-pi *n;
      article likeds(appel_article_t);
   end-pi;

   article.code    = DCODE;
   article.libelle = DLIB;
   article.famille = DFAM;
   article.prixHT  = DPRIXHT;
   article.tauxTVA = DTVA;
   article.stock   = DSTOCK;
end-proc;
```
