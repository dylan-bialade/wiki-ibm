---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: BONBONSF
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 104
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/BONBONSF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20261013  134050  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      CF05(05)
     A                                      CF06(06)
     A          R SFL1                      SFL
     A*%%TS  SD  20261012  145821  DYLAN2      REL-V7R5M0  5770-WDS
     A            OPT            1A  B  9  5
     A            VAL1          10A  O  9 11
     A            VAL2          10A  O  9 24
     A            VAL3          10A  O  9 37
     A            VAL4          10A  O  9 50
     A            VAL5          10A  O  9 63
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261012  135315  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0010)
     A                                      SFLPAG(0009)
     A                                      OVERLAY
     A  30                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
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
     A                                  7 11'   nom'
     A                                  7 26'marque'
     A                                  7 65'number'
     A                                  7 52'prix'
     A                                  7 39'couleur'
     A                                  3 33'search:'
     A            VAL6          20A  I  3 41CHECK(LC)
     A          R FOOTER
     A*%%TS  SD  20261013  112226  DYLAN2      REL-V7R5M0  5770-WDS
     A                                 23  2'f3=exit'
     A                                 23 12'f6=crée'
     A                                 23 22'f5=refresh'
     A          R FMT1
     A*%%TS  SD  20261013  114702  DYLAN2      REL-V7R5M0  5770-WDS
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
     A                                  1 33'Données du bonbon'
     A                                      COLOR(BLU)
     A                                  7  4'opt'
     A                                  7 11'   nom'
     A                                  7 26'marque'
     A                                  7 65'number'
     A                                  7 52'prix'
     A                                  7 39'couleur'
     A            OPT            1A  B  9  5
     A            VAL1          10A  B  9 11
     A            VAL2          10A  B  9 24
     A            VAL3          10A  B  9 37
     A            VAL4          10A  B  9 50
     A            VAL5          10A  B  9 63
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
     A          R WIN1
     A*%%TS  SD  20261013  134050  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      WINDOW(9 11 10 50)
     A                                  1 18'suppression'
     A                                  3  4'tes sur:'
     A            VAL8          20A  O  3 14
     A                                  7  6'vraiment?'
     A            VAL7           3A  B  7 17
     A                                  7 24'OUI/NON'
     A          R BIDON
     A*%%TS  SD  20261013  133356  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      ASSUME
     A                                  1  3' '
```
