---
bibliotheque: BIB02
fichier_source: QRPGLESRC2
membre: SQLFET2
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 57
modifie: 2026-11-16
---

# BIB02/QRPGLESRC2/SQLFET2

```rpg
**FREE
ctl-opt dftactgrp(*no);

Dcl-S codproduit Char(5);   // Variable pour CODPRO
Dcl-S nomproduit Char(30);  // Variable pour nmpro
Dcl-S quantite zoned(3:0);  // Variable pour qtpro
Dcl-S dateinv Date;         // Variable pour dtdinv
Dcl-S sqlcod Int(10);      // Variable pour SQLCODE

// Option de compilation SQL
exec sql
   set option commit = *none, alwcpydta = *optimize, closqlcsr = *endmod;

// Déclaration du curseur pour récupérer les données dans la table entrepot
exec sql
   declare C1 cursor for
   select codpro, nmpro, qtpro, dtdinv
   from entrepot;

// Ouverture du curseur
exec sql open C1;

// Vérifier si l'ouverture du curseur a échoué
exec sql get diagnostics :sqlcode = sqlcod;
if sqlcode <> 0;
   dsply ('Erreur lors de l''ouverture du curseur, SQLCODE : ' + %char(sqlcode));
   *inlr = *on;
   return;
endif;

// Première récupération des résultats dans les variables correspondantes
exec sql fetch C1 into :codproduit, :nomproduit, :quantite, :dateinv;

// Récupération du SQLCODE
exec sql get diagnostics :sqlcod  = sqlcod ;

// Boucle de récupération des résultats
dow sqlcode = 0;
  // Affichage du nom produit ou autre logique
  dsply ('Nom récupéré : ' + %trim(nomproduit));

  // Récupération de la prochaine ligne
  exec sql fetch C1 into :codproduit, :nomproduit, :quantite, :dateinv;

  // Récupération du SQLCODE après chaque FETCH
  exec sql get diagnostics :sqlcod  = sqlcod;

  // Si une erreur survient lors du fetch, afficher un message d'erreur
  if sqlcod  <> 0 and sqlcod  <> 100; // 100 est le code de fin des résultats
     dsply ('Erreur lors du fetch, SQLCODE : ' + %char(sqlcode));
  endif;
enddo;

// Fermeture du curseur
exec sql close C1;

*inlr = *on;
```
