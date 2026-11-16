---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: PGM1TP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/PGM1TP

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

// Déclaration des variables à transmettre
dcl-s N1 zoned(5) inz(15);   // Valeur 1
dcl-s N2 zoned(5) inz(10);   // Valeur 2
dcl-s N3 zoned(5) inz(5);    // Valeur 3
dcl-s Moyenne zoned(5);         // Résultat à afficher

// Prototype du programme secondaire appelé (PGM2TP)
dcl-pr PGM2TP extpgm('PGM2TP');
  P_N1 zoned(5);
  P_N2 zoned(5);
  P_N3 zoned(5);
  P_Moyenne zoned(5);
end-pr;

// Appel de PGM2TP avec les 3 valeurs, Moyenne sera rempli
PGM2TP(N1 : N2 : N3 : Moyenne);

// Affichage de la moyenne
dsply Moyenne;

*inlr = *on;
```
