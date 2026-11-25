---
bibliotheque: BIB25
fichier_source: QILESRC
membre: SIGN_MOD
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 20
modifie: 2026-11-25
---

# BIB25/QILESRC/SIGN_MOD

```rpg
**free

CTL-OPT NOMAIN;

// procédure 1
DCL-PROC calculTVA EXPORT;
  DCL-PI *N packed(5:2);
    prix packed(5:2) CONST;
  END-PI;
  return prix * 1.2;
END-PROC;

// procédure 2
DCL-PROC Addition EXPORT;
  DCL-PI *N packed(5:2);
    num1 packed(5:2) CONST;
    num2 packed(5:2) CONST;
  END-PI;
  return num1 + num2;
END-PROC;
```
