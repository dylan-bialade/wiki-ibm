---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: AGENCE
type: DDS
longueur_enregistrement: 100
lignes: 11
modifie: 2026-11-16
---

# BIB02/QDDSRC/AGENCE

```text
     A                                      UNIQUE
     A          R FORMAT
     A            CODCLI         5P 0
     A            CODAGN         3A
     A            NOM           15A
     A            RUE           30           ALWNULL
     A            CP             5A
     A            VILLE         50          VARLEN(10)
     A            REGION         5          VALUES('NORD' 'SUD' -
     A                                      'EST' 'OUEST' 'SIEGE')
     A            DATE            L
```
