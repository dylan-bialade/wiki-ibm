---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: DLTCLI
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 11
modifie: 2026-11-16
---

# BIB10/QRPGSRC/DLTCLI

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================*
      *              SUPPRESSION SUR ID               *
      *                                                *
      *=================================================*
     FCLIENTL1UF  E           K        DISK
      *
     C                     SETON                         LR
     C                     MOVE 6         IDX     60
     C*          IDX       SETLLCLIENTS
     C           IDX       CHAINCLIENTS              90
     C  N90                DELETCLIENTS
```
