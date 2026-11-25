---
bibliotheque: BIB25
fichier_source: QWEBSRVTP
membre: WSARTPR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 53
modifie: 2026-11-25
---

# BIB25/QWEBSRVTP/WSARTPR

```rpg
**free
//==================================================================================================
// Copie       : WSARTPR
// Objet       : TP Web services (corrige) - cote fournisseur (personne A)
//               Article "metier" et prototypes du module de regles WSARTREG.
// Utilisee par: WSARTREG (module de regles) et WSARTCRUD (module CRUD)
//--------------------------------------------------------------------------------------------------
// Les zones sont volontairement plus larges que les colonnes de la table : la regle metier doit
// voir la valeur reellement envoyee (un libelle de 40 caracteres, un stock de 1 000 000...) pour
// pouvoir la refuser. Une valeur tronquee en amont passerait les controles sans erreur.
//==================================================================================================

// Un article tel que le voient les regles de gestion
dcl-ds wsart_article_t qualified template;
   code     varchar(20);       // RG01
   libelle  varchar(200);      // RG02
   famille  varchar(20);       // RG03
   prixHT   packed(15 : 2);    // RG05, RG09
   tauxTVA  packed(15 : 2);    // RG04
   stock    int(20);           // RG06, RG07
end-ds;

// Resultat d'un controle : regle violee et message court (le corps d'erreur IWS tient en
// 64 caracteres : {"regle":"RG05","msg":"..."} laisse 39 caracteres au message)
dcl-ds wsart_resultat_t qualified template;
   regle    char(4);
   message  varchar(39);
end-ds;

// Creation : RG01 a RG06
dcl-pr wsart_controlerCreation ind;
   article  likeds(wsart_article_t) const;
   resultat likeds(wsart_resultat_t);
end-pr;

// Modification : RG02 a RG06, puis RG09 par rapport a l'article actuellement en base
dcl-pr wsart_controlerModification ind;
   article  likeds(wsart_article_t) const;
   actuel   likeds(wsart_article_t) const;
   resultat likeds(wsart_resultat_t);
end-pr;

// Suppression : RG07
dcl-pr wsart_controlerSuppression ind;
   actuel   likeds(wsart_article_t) const;
   resultat likeds(wsart_resultat_t);
end-pr;

// Lecture : RG08, prix TTC arrondi au centime
dcl-pr wsart_prixTTC packed(9 : 2);
   prixHT   packed(15 : 2) const;
   tauxTVA  packed(15 : 2) const;
end-pr;
```
