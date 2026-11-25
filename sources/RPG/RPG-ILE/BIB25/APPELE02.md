---
bibliotheque: BIB25
fichier_source: QILESRC
membre: APPELE02
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 10
modifie: 2026-11-25
---

# BIB25/QILESRC/APPELE02

```rpg
**free
CTL-OPT NOMAIN;

DCL-PROC Soustraction EXPORT;
  DCL-PI *N packed(6:2);
    num1 packed(5:2);
    num2 packed(5:2);
  END-PI;
  return num1 - num2;
END-PROC;
```
