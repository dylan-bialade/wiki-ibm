---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: PGM2TP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 15
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/PGM2TP

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

// Interface du programme secondaire (paramètres reçus)
dcl-pi *n;
  P_N1 zoned(5);      // Valeur 1
  P_N2 zoned(5);      // Valeur 2
  P_N3 zoned(5);      // Valeur 3
  P_Moyenne zoned(5);       // Paramètre en sortie : résultat
end-pi;

// Calcul de la moyenne
P_Moyenne = (P_N1 + P_N2 + P_N3) / 3;

*inlr = *on;
```
