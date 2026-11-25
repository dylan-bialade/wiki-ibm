---
bibliotheque: BIB25
fichier_source: QTEST
membre: MODTEST2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 10
modifie: 2026-11-25
---

# BIB25/QTEST/MODTEST2

```rpg
**free
ctl-opt nomain;

dcl-proc soustraction export;
dcl-pi *n packed(7:0);
num1 packed(6:0);
num2 packed(6:0);
end-pi;
return num1 - num2;
end-proc;
```
