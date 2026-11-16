---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: INSCLI
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-16
---

# BIB10/QRPGSRC/INSCLI

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
     FCLIENTL1UF  E           K        DISK                      A
      *
     C                     SETON                         LR
     C           *HIVAL    SETLLCLIENTS
     C                     READPCLIENTS                  90
     C                     MOVE IDCLI     ID      60
     C           ID        ADD  1         IDCLI
     C                     MOVE *BLANK    PRECLI
     C                     MOVEL'TOM'     PRECLI
     C                     Z-ADD*ZEROS    AGE
     C                     MOVE 26        AGE
     C                     MOVE *BLANK    NOMCLI
     C                     MOVEL'JERY'    NOMCLI
     C                     WRITECLIENTS
```
