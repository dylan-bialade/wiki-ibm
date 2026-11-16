---
bibliotheque: BIB02
fichier_source: QRPGLESRC2
membre: SQLFET
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 40
modifie: 2026-11-16
---

# BIB02/QRPGLESRC2/SQLFET

```rpg
**FREE
ctl-opt dftactgrp(*no);

Dcl-S codproduit Char(5);   // Variable pour codpro
Dcl-S nomproduit Char(30);  // Variable pour nmpro
Dcl-S quantite zoned(3:0);  // Variable pour qtpro
Dcl-S dateinv Date;         // Variable pour dtdinv

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

// Première récupération des résultats dans les variables correspondantes
exec sql fetch C1 into :codproduit, :nomproduit, :quantite, :dateinv;

// Boucle de récupération des résultats
dow sqlcode = 0;
  // Affichage du nom produit ou autre logique
  dsply ('Nom récupéré : ' + %trim(nomproduit));

  // Récupération de la prochaine ligne
  exec sql fetch C1 into :codproduit, :nomproduit, :quantite, :dateinv;

enddo;

// Fermeture du curseur
exec sql close C1;

setll (key1:key2) fichierpf;

*inlr = *on;
```
