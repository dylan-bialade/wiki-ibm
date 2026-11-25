---
bibliotheque: BIB27
fichier_source: QDDSSRC
membre: PLANETE
type: DDS
longueur_enregistrement: 80
lignes: 76
modifie: 2026-11-25
---

# BIB27/QDDSSRC/PLANETE

```text
     A*%%TS  SD  20240625  161540  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A                                      CA05(05)
     A                                      CA08(08)
     A          R SFL1                      SFL
     A*%%TS  SD  20240625  110225  LEO2        REL-V7R4M0  5770-WDS
     A            OPT            1A  B  9  5
     A            E1NAME        20A  O  9 10
     A            E1DIAMETRE    10Y 2O  9 32EDTWRD('        .  ')
     A            E1DENSITE      5Y 2O  9 47EDTWRD('   .  ')
     A            E1PERIOD      10Y 2O  9 61EDTWRD('        .  ')
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20240625  134717  LEO2        REL-V7R4M0  5770-WDS
     A                                      SFLSIZ(0009)
     A                                      SFLPAG(0008)
     A                                      OVERLAY
     A  30                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  4  3'Aficher à partir de :'
     A                                  5  3'Choisissez une option, puis appuye-
     A                                      r sur ENTREE :'
     A                                      COLOR(BLU)
     A                                  6  4'2=Modifier'
     A                                      COLOR(BLU)
     A                                  6 18'5=Afficher'
     A                                      COLOR(BLU)
     A                                  8  4'Opt'
     A                                      COLOR(WHT)
     A                                  8 10'Name'
     A                                      COLOR(WHT)
     A                                  8 32'Diamètre(km)'
     A                                      COLOR(WHT)
     A                                  8 46'Densité(g/cm³)'
     A                                      COLOR(WHT)
     A                                  8 62'Période orbitale(j)'
     A                                      COLOR(WHT)
     A                                  1 71TIME
     A                                  2 71DATE
     A                                      EDTCDE(Y)
     A            TITLE         10A  O  1 36COLOR(WHT)
     A          R BAS
     A*%%TS  SD  20240625  143429  LEO2        REL-V7R4M0  5770-WDS
     A                                 23  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 16'F5=Actualiser'
     A                                      COLOR(BLU)
     A                                 23 32'F8=MOON/PLANETS'
     A                                      COLOR(BLU)
     A          R FMT1
     A*%%TS  SD  20240625  161540  LEO2        REL-V7R4M0  5770-WDS
     A                                  1  2SYSNAME
     A                                  2  2USER
     A            FLD001        10   O  1 36COLOR(WHT)
     A                                  1 73TIME
     A                                  2 73DATE
     A                                      EDTCDE(Y)
     A                                  5  3'Nom..............:'
     A                                  7  3'Diamètre.........:'
     A                                  9  3'Densité.........: '
     A                                 11  3'Périod Orbitale.: '
     A                                 13  3'Planèt associée.: '
     A  50                                  DSPATR(ND)
     A                                 23  2'F3=Quiter '
     A                                      COLOR(BLU)
     A            E2NAME        20   O  5 23
     A            E2DIAMETRE    10  2O  7 23EDTWRD('        .  ')
     A            E2DENSITE      5  2O  9 23EDTWRD('   .  ')
     A            E2PERIOD      10  2O 11 23EDTWRD('        .  ')
     A            E2PLANETE     20   O 13 23
     A  50                                  DSPATR(ND)
```
