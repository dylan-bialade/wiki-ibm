---
bibliotheque: BIB02
fichier_source: QERROR
membre: ERRMO
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 18
modifie: 2026-11-16
---

# BIB02/QERROR/ERRMO

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt);

dcl-s Num1 int(10);
dcl-s Num2 int(10);
dcl-s Result int(10);

Num1 = 10;
Num2 = 0;

monitor;
   Result = Num1 / Num2; // Tentative de division par zéro
on-error;
   // Gestion de l'erreur
   dsply 'Une erreur est survenue lors de la division.';
endmon;

*inlr = *on;
```
