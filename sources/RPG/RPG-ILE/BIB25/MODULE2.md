---
bibliotheque: BIB25
fichier_source: QILESRC
membre: MODULE2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 20
modifie: 2026-11-25
---

# BIB25/QILESRC/MODULE2

```rpg
**FREE


CTL-OPT NOMAIN;

dcl-proc proc1 export;
  dcl-pi *n packed(5:0);
    num1 packed(5:0);
  END-PI;

  return num1 + 10;
END-PROC;

dcl-proc proc2 export;
  dcl-pi *n packed(5:0);
    num1 packed(5:0);
  END-PI;

  return num1 - 10;
END-PROC;
```
