---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: NEWANE
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-16
---

# BIB20/QRPGSRC/NEWANE

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H* NEWANE - Souhaite la bonne annee le 1er janvier (style RPG II)
     H
     FQSYSPRT O   F     132            PRINTER
     C* Indicateurs : 10 = mois 01, 11 = jour 01, 12 = 1er janvier
     C           UMONTH    COMP 1                        10
     C           UDAY      COMP 1                        11
     C   10 11             SETON                     12
     C                     SETON                     LR
     OQSYSPRT D  1    N1P 12
     O                                   30 'BONNE ANNEE !'
     OQSYSPRT D  1    N1PN12
     O                                   27 'CE N EST PAS LE 1ER JANV'
     OQSYSPRT D  1    N1P
     O                                   10 'DATE :'
     O                         UDATE Y   20
```
