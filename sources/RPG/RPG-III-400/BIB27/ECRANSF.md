---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: ECRANSF
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 49
modifie: 2026-11-25
---

# BIB27/QRPGSRC/ECRANSF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20231127  142246  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R CL01                      SFL
     A*%%TS  SD  20231127  113045  LEO2        REL-V7R4M0  5770-WDS
     A            NOM       R        O  7 12REFFLD(RBONBON/NOM BIB27/BONBON)
     A            MARQUE    R        O  7 34REFFLD(RBONBON/MARQUE BIB27/BONBO-
     A                                      N)
     A            COULEUR   R        O  7 55REFFLD(RBONBON/COULEUR BIB27/BONB-
     A                                      ON)
     A            PRIX      R        O  7 67REFFLD(RBONBON/PRIX BIB27/BONBON)
     A            FLD001         1   B  7  5
     A          R CTL01                     SFLCTL(CL01)
     A*%%TS  SD  20231127  142246  LEO2        REL-V7R4M0  5770-WDS
     A                                      OVERLAY
     A  50                                  SFLDSP
     A  51                                  SFLDSPCTL
     A  52                                  SFLDLT
     A  53                                  SFLEND(*MORE)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A                                  6  4'opt'
     A                                      COLOR(WHT)
     A                                  6 12'nom'
     A                                      COLOR(WHT)
     A                                  6 34'marque'
     A                                      COLOR(WHT)
     A                                  6 55'couleur'
     A                                      COLOR(WHT)
     A                                  6 67'prix'
     A                                      COLOR(WHT)
     A          R FMT1
     A*%%TS  SD  20231127  141859  LEO2        REL-V7R4M0  5770-WDS
     A                                      OVERLAY
     A                                 20 36'f3 = exit'
     A                                      COLOR(BLU)
     A          R FMT2
     A*%%TS  SD  20231127  142246  LEO2        REL-V7R4M0  5770-WDS
     A                                      OVERLAY
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 38'bonbon'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  3 26'affichage de tous les bonbons'
     A                                      COLOR(WHT)
```
