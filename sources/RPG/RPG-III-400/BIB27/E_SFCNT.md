---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: E_SFCNT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 44
modifie: 2026-11-25
---

# BIB27/QRPGSRC/E_SFCNT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20231129  161604  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      CF05(05)
     A          R SF01                      SFL
     A*%%TS  SD  20231129  094145  LEO2        REL-V7R4M0  5770-WDS
     A            OPT            1A  B  7  8
     A            ID             9S 0H
     A            EPAYCOD   R        O  7 17REFFLD(PAYSF/PAYCOD BIB27/PAYS)
     A            EPAYLIB   R        O  7 29REFFLD(PAYSF/PAYLIB BIB27/PAYS)
     A          R CTL01                     SFLCTL(SF01)
     A*%%TS  SD  20231129  161604  LEO2        REL-V7R4M0  5770-WDS
     A                                      ROLLUP(59)
     A                                      OVERLAY
     A  50                                  SFLDSP
     A  51                                  SFLDSPCTL
     A  52                                  SFLCLR
     A  53                                  SFLEND(*MORE)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A                                  6  7'opt'
     A                                      COLOR(WHT)
     A                                  6 14'code pays'
     A                                      COLOR(WHT)
     A                                  6 29'nom du pays'
     A                                      COLOR(WHT)
     A          R FMT1
     A*%%TS  SD  20231129  094749  LEO2        REL-V7R4M0  5770-WDS
     A                                      OVERLAY
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 35'joueurs nba'
     A                                      COLOR(WHT)
     A                                  1 73TIME
     A                                  2 73DATE
     A                                      EDTCDE(Y)
     A                                  4 54'5= afficher'
     A                                      COLOR(BLU)
     A          R FMT2
     A*%%TS  SD  20231129  094849  LEO2        REL-V7R4M0  5770-WDS
     A                                      OVERLAY
     A                                 21 36'f3 = exit'
     A                                      COLOR(BLU)
```
