---
bibliotheque: BIB25
fichier_source: QTEST
membre: PGM1ABDE
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 17
modifie: 2026-11-25
---

# BIB25/QTEST/PGM1ABDE

```rpg
**free
CTL-OPT dftactgrp(*no) actgrp(*new) BNDDIR('BNDABDE');

dcl-pr Addition packed(7:2);
    num1 packed(5:2);
    num2 packed(5:2);
end-pr;


dcl-s num1 packed(5:2) INZ(50);
dcl-s num2 packed(5:2) INZ(100);
dcl-s result packed(7:2);


result = Addition(num1:num2);
dsply %char(result);
*inlr = *on;
```
