---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: EXAMPSSF
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 96
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/EXAMPSSF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20261013  132029  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R FMT2
     A*%%TS  SD  20261007  155506  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CF12(12)
     A                                      CF23(23)
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
     A                                  1 33'Données du livre'
     A                                      COLOR(BLU)
     A                                  6  7'Numero ISBN:'
     A                                  7 13'Titre:'
     A                                  8 12'Auteur:'
     A                                  9 13'Dispo:'
     A            ISBN           5S 0O  6 20
     A            TITRE         30A  B  7 20
     A            AUTEUR        30A  B  8 20
     A            DISPO          1A  B  9 20
     A                                 22 15'F3=Exit'
     A                                      COLOR(BLU)
     A                                 22 26'F12=Retour'
     A                                      COLOR(BLU)
     A                                 22 40'F23=Suprimer le livre '
     A                                      COLOR(BLU)
     A                                 13 14'Entre pour modifier '
     A                                      COLOR(BLU)
     A            MSG            6A  B 12 15
     A                                 11 13' vous:'
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      CF05(05)
     A          R SFL1                      SFL
     A*%%TS  SD  20261009  115049  DYLAN2      REL-V7R5M0  5770-WDS
     A            OPT            1   B  9  5
     A            VAL1          15   O  9 11
     A            VAL2          15   O  9 31
     A            VAL3          15   O  9 51
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261009  145737  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      OVERLAY
     A  30                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                      SFLSIZ(0010)
     A                                      SFLPAG(0009)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 32'exemple sfl'
     A                                  4  4'indiquer vos option, puis appuyer -
     A                                      sur entrée.'
     A                                  5  4'2=editer    3=copier    4=supprime-
     A                                      r  5=afficher '
     A                                  7  4'opt'
     A                                  7 11'menbre'
     A                                  7 31'type'
     A                                  7 51'texte'
     A          R FOOTER
     A*%%TS  SD  20261009  145546  DYLAN2      REL-V7R5M0  5770-WDS
     A  06                                  CF06
     A                                 23  2'f3=exit'
     A                                 23 12'f6=crée'
     A                                 23 22'f5=refresh'
     A          R WIN1
     A*%%TS  SD  20261013  132029  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      WINDOW(10 10 10 50)
     A                                  1 21'suppresion'
     A                                  4  4'tes sur:'
     A            FLD001        20   O  4 13
     A                                  7  5'vraiment OUI/NON'
     A            FLD002         3   B  7 23
     A                                  7 27'(OUI/NON)'
     A          R BIDON
     A*%%TS  SD  20261013  132029  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      ASSUME
     A                                  1  3' '
```
