---
bibliotheque: BIB02
fichier_source: QERROR
membre: ERRMOS2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 25
modifie: 2026-11-16
---

# BIB02/QERROR/ERRMOS2

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt);

dcl-s Num1 int(10);
dcl-s Num2 int(10);
dcl-s Result int(5); // Déclaré avec une capacité intentionnellement limitée
dcl-s ErrorCode int(10);

Num1 = 2147483647; // Valeur maximale pour un entier signé 32 bits
Num2 = 1;

monitor;
   Result = Num1 / Num2; // Risque de débordement
on-error;
   ErrorCode = %status;
   if ErrorCode = 102;  // Division par zéro
      dsply 'Erreur: Division par zéro.';
   elseif ErrorCode = 103; // Débordement
      dsply 'Erreur: Débordement lors de la division.';
   else;
      dsply 'Erreur inconnue. Code d''erreur : '   %char(ErrorCode);
   endif;
endmon;

*inlr = *on;
```
