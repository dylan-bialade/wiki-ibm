---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: CALCUL_AGE
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 11
modifie: 2026-11-25
---

# BIB25/QRPGSRC/CALCUL_AGE

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
CTL-OPT NOMAIN;
// Calcul d'âge en fonction d'une date
DCL-PROC CALCUL_AGE EXPORT;
  // Réceptions des paramètres
  DCL-PI CALCUL_AGE packed(3:0);
    date_n date;
  END-PI;
  // Retour de l'âge
  return %diff(%date() : date_n :  *years);
END-PROC;
```
