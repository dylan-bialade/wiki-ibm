---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: UPDCLI
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-16
---

# BIB10/QRPGSRC/UPDCLI

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================*
      *              MON PREMIER RPG                  *
      * CONCATENATION DE STRING ET PYSPLAY SUR MESSAGE*
      *=================================================*
     FCLIENTL1UF  E           K        DISK
      *
     C                     SETON                         LR
     C                     MOVE 3         IDX     60
     C*          IDX       SETLLCLIENTL1
     C           IDX       READECLIENTL1                 90
     C  N90                MOVEL*BLANK    PRECLI
     C  N90                MOVEL'TOM'     PRECLI
     C  N90                MOVEL*BLANK    NOMCLI
     C  N90                MOVEL'JERY'    NOMCLI
     C  N90                UPDATCLIENTS
```
