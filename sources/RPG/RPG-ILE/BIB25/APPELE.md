---
bibliotheque: BIB25
fichier_source: QILESRC
membre: APPELE
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 10
modifie: 2026-11-25
---

# BIB25/QILESRC/APPELE

```rpg
**free
CTL-OPT NOMAIN;

// procédure calcul TVA
DCL-PROC calculTVA EXPORT;
  DCL-PI *N packed(5:2);
    prix packed(5:2) CONST;
  END-PI;
  return prix * 1.2;
END-PROC;
```
