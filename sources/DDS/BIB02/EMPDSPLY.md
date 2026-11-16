---
bibliotheque: BIB02
fichier_source: QCHATGPT
membre: EMPDSPLY
type: DDS
longueur_enregistrement: 100
lignes: 27
modifie: 2026-11-16
---

# BIB02/QCHATGPT/EMPDSPLY

```text
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A                                      ERRSFL
     A          R SFLREC                    SFL
     A            COL1          10A  O  6  2
     A            COL2          10A  O  6 13
     A            COL3          10A  O  6 24
     A            COL4          10A  O  6 35
     A                                 24  2'F3=Exit F12=Previous'
     A                                      COLOR(BLU)
     A          R SFLCTL                    SFLCTL(SFLREC)
     A                                      OVERLAY
     A                                      SFLPAG(0010)
     A                                      SFLSIZ(0011)
     A  91                                  SFLDSP
     A  92                                  SFLDSPCTL
     A  93                                  SFLCLR
     A  90                                  SFLEND(*MORE)
     A N90                                  SFLSIZ(0020)
     A  94                                  SFLLIN(0001)
     A                                      ERRSFL
     A                                  1 40'TITLE'
     A                                      COLOR(WHT)
     A                                  2  3'1. Option One'
     A                                      COLOR(BLU)
     A                                  3  3'2. Option Two'
     A                                      COLOR(BLU)
```
