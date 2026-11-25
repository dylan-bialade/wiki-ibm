---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: INFOUSER
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-25
---

# BIB27/QCLSRC/INFOUSER

```cl
     A*%%TS  SD  20231112  120010  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      CF21(21)
     A          R FMT1
     A*%%TS  SD  20231112  120010  LEO2        REL-V7R4M0  5770-WDS
     A                                      CHANGE(50)
     A                                  1  7SYSNAME
     A                                  2  7USER
     A                                  1 37'INFO USER'
     A                                      COLOR(BLU)
     A                                  1 62DATE
     A                                      EDTCDE(Y)
     A                                  2 62TIME
     A                                  8 22'MSGQ :'
     A                                 10 22'JOBD :'
     A                                 12 22'CURLIB :'
     A                                 14 22'INLMNU :'
     A            MSGQ          10A  B  8 31
     A            JOBD          10A  B 10 31
     A            CURLIB        10A  B 12 31
     A            INLMNU        10A  B 14 31
     A            USER          10A  O  4 35
     A                                 20 12'f3=quiter '
     A                                      COLOR(BLU)
     A                                 20 41'f21 ligne de CMD '
     A                                      COLOR(RED)
     A            ERREUR        25A  O 17 23
```
