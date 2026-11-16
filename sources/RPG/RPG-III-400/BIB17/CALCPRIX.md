---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: CALCPRIX
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 13
modifie: 2026-11-16
---

# BIB17/QRPGSRC/CALCPRIX

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     C           *ENTRY    PLIST
     C                     PARM           HT      62
     C                     PARM           TVAT    42
     C*                    Z-ADD100       HT      62
     C*                    Z-ADD20        TVAT    42
     C                     Z-ADD0         TTC     62
     C           HT        MULT TVAT      TVAM    62
     C           TVAM      DIV  100       TVAM
     C           HT        ADD  TVAM      TTC
     C           HT        DSPLY
     C           TVAM      DSPLY
     C           TTC       DSPLY
     C                     SETON                     LR
```
