---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: E_TPTEST
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 23
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/E_TPTEST

```text
     A*%%TS  SD  20231215  153844  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A          R SF1                       SFL
     A*%%TS  SD  20231215  144618  LEO2        REL-V7R4M0  5770-WDS
     A            VALEUR    R        O  6 22REFFLD(TEST/VALEUR BIB27/TEST_TP)
     A          R CTL1                      SFLCTL(SF1)
     A*%%TS  SD  20231215  153548  LEO2        REL-V7R4M0  5770-WDS
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A                                      OVERLAY
     A  51                                  SFLDSP
     A  52                                  SFLDSPCTL
     A  50                                  SFLCLR
     A  49                                  SFLEND
     A                                  5 22'VALEUR'
     A                                  2 35'afficher à partir de:'
     A            E_SRH         10A  I  2 58CHECK(LC)
     A          R BAS
     A*%%TS  SD  20231215  144618  LEO2        REL-V7R4M0  5770-WDS
     A                                      OVERLAY
     A                                 18  8'f3=exit'
```
