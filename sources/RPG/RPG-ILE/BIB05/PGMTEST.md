---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: PGMTEST
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 17
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/PGMTEST

```rpg
**free
ctl-opt dftactgrp(*no) actgrp(*caller) bnddir('REP');

dcl-pr modulo zoned(5:0);
  num1 zoned(5:0);
  num2 zoned(5:0);
end-pr;

dcl-s resultat zoned(5:0);
dcl-s nombre1 zoned(5:0) inz(27);
dcl-s nombre2 zoned(5:0) inz(10);

resultat = modulo(nombre1:nombre2);

dsply %char(resultat);

*inlr = *on;
```
