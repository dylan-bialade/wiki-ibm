---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: E_FRUITS
type: DDS
longueur_enregistrement: 80
lignes: 119
modifie: 2026-11-25
---

# BIB27/QFREESRC/E_FRUITS

```text
     A*%%TS  SD  20231218  145413  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A                                      CA12(12)
     A          R SF1                       SFL
     A*%%TS  SD  20231218  113240  LEO2        REL-V7R4M0  5770-WDS
     A            E1_NOM    R        O  9  9REFFLD(FRUITFMT/NOM BIB27/FRUITS)
     A            E1_COM    R        O  9 32REFFLD(FRUITFMT/COMMESTIBL BIB27/-
     A                                      FRUITS)
     A            E1_SAISON R        O  9 47REFFLD(FRUITFMT/SAISON BIB27/FRUI-
     A                                      TS)
     A            E1_COULEURR        O  9 61REFFLD(FRUITFMT/COULEUR BIB27/FRU-
     A                                      ITS)
     A            E1_GOUT   R        O  9 75REFFLD(FRUITFMT/GOUT BIB27/FRUITS)
     A            OPT            1A  B  9  5
     A            E1_ID     R        O  9 41REFFLD(FRUITFMT/ID BIB27/FRUITS)
     A                                      DSPATR(ND)
     A          R CTL1                      SFLCTL(SF1)
     A*%%TS  SD  20231218  143237  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF06(06)
     A                                      CA05(05)
     A                                      OVERLAY
     A  50                                  SFLDSP
     A  51                                  SFLDSPCTL
     A  52                                  SFLCLR
     A  53                                  SFLEND(*MORE)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 38'Fruits'
     A                                      COLOR(WHT)
     A                                  1 71TIME
     A                                  2 71DATE
     A                                      EDTCDE(Y)
     A                                  8  4'opt'
     A                                      COLOR(WHT)
     A                                  8  9'Nom'
     A                                      COLOR(WHT)
     A                                  8 32'Commestible'
     A                                      COLOR(WHT)
     A                                  8 47'Saison'
     A                                      COLOR(WHT)
     A                                  8 61'Couleur'
     A                                      COLOR(WHT)
     A                                  8 73'Gout'
     A                                      COLOR(WHT)
     A                                  5  5'2 = modifier'
     A                                      COLOR(BLU)
     A                                  5 24'4 =supprimer'
     A                                      COLOR(BLU)
     A                                  5 42'5 = afficher'
     A                                      COLOR(BLU)
     A          R BAS
     A*%%TS  SD  20231218  103428  LEO2        REL-V7R4M0  5770-WDS
     A                                      OVERLAY
     A                                 21  4'f3=EXIT'
     A                                      COLOR(BLU)
     A                                 21 17'f5=actualiser'
     A                                      COLOR(BLU)
     A                                 21 38'f6=creer'
     A                                      COLOR(BLU)
     A          R FMT1
     A*%%TS  SD  20231218  145413  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF06(06)
     A                                      CF04(04)
     A                                      CF02(02)
     A                                  1  3SYSNAME
     A                                  2  3USER
     A                                  1 38'fruits'
     A                                      COLOR(WHT)
     A                                  1 72TIME
     A                                  2 72DATE
     A                                      EDTCDE(Y)
     A            E2_TITRE      25A  O  4 28COLOR(WHT)
     A                                  6 15'ID:'
     A            E2_ID     R        B  6 23REFFLD(FRUITFMT/ID BIB27/FRUITS)
     A  60                                  DSPATR(PR)
     A                                  7 14'NOM:'
     A            E2_NOM    R        B  7 23REFFLD(FRUITFMT/NOM BIB27/FRUITS)
     A                                      CHECK(LC)
     A  61                                  DSPATR(PR)
     A                                  8  9'NOMLATIN:'
     A            E2_LATIN  R        B  8 23REFFLD(FRUITFMT/NOMLATIN BIB27/FR-
     A                                      UITS)
     A                                      CHECK(LC)
     A  61                                  DSPATR(PR)
     A                                  9  7'COMMESTIBL:'
     A            E2_COM    R        B  9 23REFFLD(FRUITFMT/COMMESTIBL BIB27/-
     A                                      FRUITS)
     A                                      CHECK(LC)
     A  61                                  DSPATR(PR)
     A                                 10 11'SAISON:'
     A            E2_SAISON R        B 10 23REFFLD(FRUITFMT/SAISON BIB27/FRUI-
     A                                      TS)
     A                                      CHECK(LC)
     A  61                                  DSPATR(PR)
     A                                 12 13'GOUT:'
     A            E2_GOUT   R        B 12 23REFFLD(FRUITFMT/GOUT BIB27/FRUITS)
     A  61                                  DSPATR(PR)
     A                                 13 10'COULEUR:'
     A            E2_COULEURR        B 13 23REFFLD(FRUITFMT/COULEUR BIB27/FRU-
     A                                      ITS)
     A                                      CHECK(LC)
     A  61                                  DSPATR(PR)
     A                                 21  3'f3=EXIT'
     A                                      COLOR(BLU)
     A                                 21 19'f6=creer'
     A                                      COLOR(BLU)
     A  62                                  DSPATR(ND)
     A                                 21 34'f4 = supprimer'
     A                                      COLOR(BLU)
     A  63                                  DSPATR(ND)
     A                                 21 54'f2 = modifier'
     A                                      COLOR(BLU)
     A  64                                  DSPATR(ND)
     A                                 20  3'f12 = precedent'
     A                                      COLOR(BLU)
```
