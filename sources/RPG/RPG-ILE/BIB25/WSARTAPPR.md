---
bibliotheque: BIB25
fichier_source: QWEBSRVTP
membre: WSARTAPPR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 60
modifie: 2026-11-25
---

# BIB25/QWEBSRVTP/WSARTAPPR

```rpg
**free
//==================================================================================================
// Copie       : WSARTAPPR
// Objet       : TP Web services (corrige) - cote consommateur (personne B)
//               Article vu par l'application et prototypes de la couche d'appel WSARTAPL.
// Utilisee par: WSARTAPL (couche d'appel) et WSARTGES (programme d'ecran)
//--------------------------------------------------------------------------------------------------
// Le programme d'ecran ne manipule que ces structures : il ne voit jamais d'URL ni de JSON.
// Prefixe appel_ : ces procedures envoient une requete HTTP au service. Elles ne doivent pas porter
// les noms des procedures du CRUD (WSART_LISTER...) : RPG exporte les noms en majuscules, et le
// programme ne doit jamais etre lie au programme de service du fournisseur.
//==================================================================================================

dcl-c APPEL_MAX 999;                   // nombre maximal d'articles charges dans la liste

// Un article tel que l'affiche l'application
dcl-ds appel_article_t qualified template;
   code     char(6);
   libelle  char(30);
   famille  char(3);
   prixHT   packed(7 : 2);
   tauxTVA  packed(4 : 2);
   stock    packed(5 : 0);
   prixTTC  packed(9 : 2);
end-ds;

// Compte rendu d'un appel
dcl-ds appel_retour_t qualified template;
   httpCode int(5);                    // code HTTP recu, 0 = service injoignable
   regle    char(4);                   // regle violee (RG01...), REQ, ART, SQL ou blanc
   message  varchar(70);               // message a afficher
end-ds;

// Liste triee par code. *on = appel reussi (2xx)
dcl-pr appel_lister ind;
   articles likeds(appel_article_t) dim(APPEL_MAX);
   nombre   int(10);
   retour   likeds(appel_retour_t);
end-pr;

dcl-pr appel_lire ind;
   code     char(6) const;
   article  likeds(appel_article_t);
   retour   likeds(appel_retour_t);
end-pr;

dcl-pr appel_creer ind;
   article  likeds(appel_article_t) const;
   retour   likeds(appel_retour_t);
end-pr;

dcl-pr appel_modifier ind;
   article  likeds(appel_article_t) const;
   retour   likeds(appel_retour_t);
end-pr;

dcl-pr appel_supprimer ind;
   code     char(6) const;
   retour   likeds(appel_retour_t);
end-pr;
```
