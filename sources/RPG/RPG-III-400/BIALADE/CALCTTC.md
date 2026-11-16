---
bibliotheque: BIALADE
fichier_source: QRPGSRC
membre: CALCTTC
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-16
---

# BIALADE/QRPGSRC/CALCTTC

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
     C           *ENTRY    PLIST
     C                     PARM           PRIXHT  82
     C                     PARM           TVA     82
     C                     SETON                     LR
     C                     Z-ADD0         PRIXTT  82
     C                     Z-ADD0         LAVAL   82
     C           PRIXHT    MULT TVA       LAVAL
     C           LAVAL     DIV  100       LAVAL
     C           LAVAL     ADD  PRIXHT    PRIXTT
     C           PRIXTT    DSPLY
     C           PRIXHT    DSPLY
     C           TVA       DSPLY
```
