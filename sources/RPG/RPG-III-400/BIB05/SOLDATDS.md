---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: SOLDATDS
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 81
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/SOLDATDS

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20261009  143223  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R FMT1
     A*%%TS  SD  20261009  143223  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CF06(06)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 32'Gestion des soldat'
     A                                      DSPATR(UL)
     A                                 23 37'F3=Exit'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A                                  8 24'numero sold:'
     A            IDSLD          5D 0B  8 37
     A                                 23 46'F6=Creer'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A          R FMT2
     A*%%TS  SD  20261008  143012  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CF12(12)
     A                                      CF23(23)
     A                                      CF02(02)
     A                                      CF07(07)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 72TIME
     A                                  1 33'gestion des sold'
     A                                      COLOR(BLU)
     A                                  6  7'Numero sold:'
     A                                  7 13'nom:  '
     A                                  8 12'prenom:'
     A                                  9 13'arme: '
     A            IDSLD          5D 0B  6 20
     A            NOM           30A  B  7 20
     A            PRENOM        30A  B  8 20
     A            ARME          30A  B  9 20
     A            CLASSE        30A  B 10 20
     A                                 22 15'F3=Exit'
     A                                      COLOR(BLU)
     A                                 22 26'F12=Retour'
     A                                      COLOR(BLU)
     A                                 22 40'F23=Suprimer          '
     A                                      COLOR(BLU)
     A                                 13 14'Entre pour modifier '
     A                                      COLOR(BLU)
     A            MSG            6A  B 12 15
     A                                 10 13'class:'
     A            FLD001         5A  B 10 20
     A                                 22  2'f2=modifier'
     A                                 21  2'f7=valider'
```
