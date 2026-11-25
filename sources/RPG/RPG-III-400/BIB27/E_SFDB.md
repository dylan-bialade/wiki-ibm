---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: E_SFDB
type: RPG/RPG-III-400
longueur_enregistrement: 160
lignes: 25
modifie: 2026-11-25
---

# BIB27/QRPGSRC/E_SFDB

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20231129  152202  LEO2        REL-V7R4M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A                                      CF03(03)
     A                                      CF05(05)                                 A          R SF01                      SFL
     A*%%TS  SD  20231129  150207  LEO2        REL-V7R4M0  5770-WDS                  A            OPT            1A  B  7  8
     A            ID             9S 0H                                               A            ENOM      R        O  7 14REFFLD(RBONBON/NOM BIB27/BONBON)
     A            EMARQUE   R        O  7 36REFFLD(RBONBON/MARQUE BIB27/BONBO-     A                                      N)
     A            ECOULEUR  R        O  7 58REFFLD(RBONBON/COULEUR BIB27/BONB-     A                                      ON)
     A            EPRIX     R        O  7 69REFFLD(RBONBON/PRIX BIB27/BONBON)      A          R CTL01                     SFLCTL(SF01)
     A*%%TS  SD  20231129  152202  LEO2        REL-V7R4M0  5770-WDS                  A                                      ROLLUP(59)
     A                                      OVERLAY                                  A  50                                  SFLDSP
     A  51                                  SFLDSPCTL                                A  52                                  SFLCLR
     A  53                                  SFLEND(*MORE)                            A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)                             A                                  6  7'opt'
     A                                      COLOR(WHT)                               A                                  6 14'nom'
     A                                      COLOR(WHT)                               A                                  6 36'marque'
     A                                      COLOR(WHT)                               A                                  6 58'couleur'
     A                                      COLOR(WHT)                               A                                  6 69'prix'
     A                                      COLOR(WHT)                               A          R FMT1
     A*%%TS  SD  20231129  142517  LEO2        REL-V7R4M0  5770-WDS                  A                                      OVERLAY
     A                                  1  2SYSNAME                                  A                                  2  2USER
     A                                  1 35'joueurs nba'                            A                                      COLOR(WHT)
     A                                  1 73TIME                                     A                                  2 73DATE
     A                                      EDTCDE(Y)                                A          R FMT2
     A*%%TS  SD  20231129  094849  LEO2        REL-V7R4M0  5770-WDS                  A                                      OVERLAY
     A                                 21 36'f3 = exit'                              A                                      COLOR(BLU)
```
