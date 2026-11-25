---
bibliotheque: BIB25
fichier_source: QWEBSRVTP
membre: WSARTREG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 167
modifie: 2026-11-25
---

# BIB25/QWEBSRVTP/WSARTREG

```rpg
**free
//==================================================================================================
// Module      : WSARTREG
// Objet       : TP Web services (corrige) - module de regles metier des articles (RG01 a RG09)
// Cote        : fournisseur (personne A)
//--------------------------------------------------------------------------------------------------
// Ce module ne fait ni SQL, ni HTTP : il recoit des articles et repond "conforme" (*on) ou
// "non conforme" (*off, avec la regle violee et un message). Il peut donc etre reutilise tel quel
// par un batch, un autre ecran ou un test unitaire RPGUnit.
// Il est appele par le module CRUD, lui-meme appele par le serveur IWS (multithread) :
// THREAD(*CONCURRENT) et aucune variable globale modifiee.
//
// Compilation :
//   CRTRPGMOD MODULE(BIB25/WSARTREG) SRCFILE(BIB25/QWEBSRVTP) SRCMBR(WSARTREG)
//             DBGVIEW(*SOURCE) REPLACE(*YES)
// Liaison     : avec WSARTCRUD dans le programme de service du TP (EXPORT(*ALL))
//==================================================================================================
ctl-opt nomain
        thread(*concurrent)
        option(*srcstmt : *nodebugio);

/copy QWEBSRVTP,WSARTPR

dcl-c MAJUSCULES   'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
dcl-c CHIFFRES     '0123456789';
dcl-c VARIATION_MAX 0.50;              // RG09 : 50 % du prix actuel


//==================================================================================================
// Creation : RG01 (code) puis RG02 a RG06 (zones communes)
//==================================================================================================
dcl-proc wsart_controlerCreation export;
   dcl-pi *n ind;
      article  likeds(wsart_article_t) const;
      resultat likeds(wsart_resultat_t);
   end-pi;

   clear resultat;

   // RG01 : 6 caracteres, majuscules et chiffres, commence par une lettre
   if %len(article.code) <> 6
   or %check(MAJUSCULES + CHIFFRES : article.code) > 0
   or %scan(%subst(article.code : 1 : 1) : MAJUSCULES) = 0;
      return refuser('RG01' : 'Code : 6 car. A-Z 0-9, 1 lettre' : resultat);
   endif;

   return controlerZones(article : resultat);
end-proc;


//==================================================================================================
// Modification : RG02 a RG06, puis RG09 (comparaison avec l'article actuel)
//==================================================================================================
dcl-proc wsart_controlerModification export;
   dcl-pi *n ind;
      article  likeds(wsart_article_t) const;
      actuel   likeds(wsart_article_t) const;
      resultat likeds(wsart_resultat_t);
   end-pi;

   clear resultat;

   if not controlerZones(article : resultat);
      return *off;
   endif;

   // RG09 : le prix HT ne varie pas de plus de 50 % par rapport au prix actuel
   if %abs(article.prixHT - actuel.prixHT) > actuel.prixHT * VARIATION_MAX;
      return refuser('RG09' : 'Prix HT : variation de plus de 50 %' : resultat);
   endif;

   return *on;
end-proc;


//==================================================================================================
// Suppression : RG07
//==================================================================================================
dcl-proc wsart_controlerSuppression export;
   dcl-pi *n ind;
      actuel   likeds(wsart_article_t) const;
      resultat likeds(wsart_resultat_t);
   end-pi;

   clear resultat;

   // RG07 : un article encore en stock ne peut pas etre supprime
   if actuel.stock > 0;
      return refuser('RG07' : 'Stock > 0 : suppression refusee' : resultat);
   endif;

   return *on;
end-proc;


//==================================================================================================
// RG08 : prix TTC = prix HT x (1 + TVA / 100), arrondi au centime
//==================================================================================================
dcl-proc wsart_prixTTC export;
   dcl-pi *n packed(9 : 2);
      prixHT   packed(15 : 2) const;
      tauxTVA  packed(15 : 2) const;
   end-pi;

   dcl-s ttc packed(9 : 2);

   eval(h) ttc = prixHT * (1 + tauxTVA / 100);
   return ttc;
end-proc;


//==================================================================================================
// Procedure interne : regles communes a la creation et a la modification (RG02 a RG06)
//==================================================================================================
dcl-proc controlerZones;
   dcl-pi *n ind;
      article  likeds(wsart_article_t) const;
      resultat likeds(wsart_resultat_t);
   end-pi;

   dcl-s longueur int(10);

   // RG02 : libelle de 3 a 30 caracteres significatifs
   longueur = %len(%trim(article.libelle));
   if longueur < 3 or longueur > 30;
      return refuser('RG02' : 'Libelle : 3 a 30 caracteres' : resultat);
   endif;

   // RG03 : famille connue
   if article.famille <> 'INF' and article.famille <> 'BUR'
   and article.famille <> 'MOB' and article.famille <> 'ENT';
      return refuser('RG03' : 'Famille : INF, BUR, MOB ou ENT' : resultat);
   endif;

   // RG04 : taux de TVA autorises
   if article.tauxTVA <> 5.50 and article.tauxTVA <> 10.00 and article.tauxTVA <> 20.00;
      return refuser('RG04' : 'TVA : 5.50, 10.00 ou 20.00' : resultat);
   endif;

   // RG05 : prix HT entre 0,01 et 99 999,99
   if article.prixHT < 0.01 or article.prixHT > 99999.99;
      return refuser('RG05' : 'Prix HT : de 0.01 a 99999.99' : resultat);
   endif;

   // RG06 : stock entre 0 et 99 999
   if article.stock < 0 or article.stock > 99999;
      return refuser('RG06' : 'Stock : de 0 a 99999' : resultat);
   endif;

   return *on;
end-proc;


//==================================================================================================
// Procedure interne : alimente le resultat d'un refus et renvoie *off
//==================================================================================================
dcl-proc refuser;
   dcl-pi *n ind;
      regle    char(4)     const;
      message  varchar(39) const;
      resultat likeds(wsart_resultat_t);
   end-pi;

   resultat.regle   = regle;
   resultat.message = message;
   return *off;
end-proc;
```
