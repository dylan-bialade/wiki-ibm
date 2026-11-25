---
bibliotheque: BIB25
fichier_source: QTEST
membre: TESTPGMR1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-25
---

# BIB25/QTEST/TESTPGMR1

```rpg
**free


dcl-pr addition packed(7:0);
num1 packed(6:0);
num1 packed(6:0);
end-pr;


dcl-s num1 packed(6:0) inz(45);
dcl-s num2 packed(6:0) inz(100);
dcl-s result packed(7:0) inz(45);

result = addition(num1:num2);

dsply %char(result);

*inlr = *on;
```
