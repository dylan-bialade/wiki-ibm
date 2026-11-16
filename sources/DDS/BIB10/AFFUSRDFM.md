---
bibliotheque: BIB10
fichier_source: QDSPSRC
membre: AFFUSRDFM
type: DDS
longueur_enregistrement: 80
lignes: 50
modifie: 2026-11-16
---

# BIB10/QDSPSRC/AFFUSRDFM

```text
     A*%%TS  SD  20260923  162125  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260923  162125  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  1 34'Afficher user'
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
     A                                  8 32'User:'
     A            UPUPRF    R        O  8 42REFFLD(QSYDSUPB/UPUPRF QSYS/QADSPUP-
     A                                      B)
     A                                 11 21'Initial Program:'
     A            UPINPG    R        O 11 42REFFLD(QSYDSUPB/UPINPG QSYS/QADSPUP-
     A                                      B)
     A                                  9 16'Password Change Date:'
     A            UPPWCD    R        O  9 42REFFLD(QSYDSUPB/UPPWCD QSYS/QADSPUP-
     A                                      B)
     A                                 12 13'Initial Program Library:'
     A            UPINPL    R        O 12 42REFFLD(QSYDSUPB/UPINPL QSYS/QADSPUP-
     A                                      B)
     A                                 22 37'F3=Exit'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A                                 16 20'Appuyez sur'
     A                                      COLOR(WHT)
     A                                 16 32'Entrer'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 16 39'pour passer au suivant'
     A                                      COLOR(WHT)
     A                                  5 55'Nombre de Profil:'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A            NBUSR         21   O  6 54
```
