---
bibliotheque: BIB25
fichier_source: QILESRC
membre: MODULE1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 11
modifie: 2026-11-25
---

# BIB25/QILESRC/MODULE1

```rpg
**free
CTL-OPT NOMAIN;

dcl-proc Addition EXPORT;
  dcl-pi *n packed(5:0);
    num1 packed(5:0);
    num2 packed(5:0);
  END-PI;

  return num1 + num2;
END-PROC;
```
