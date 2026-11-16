---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: SRCMBDSP
type: DDS
longueur_enregistrement: 80
lignes: 58
modifie: 2026-11-16
---

# BIB17/QDDSSRC/SRCMBDSP

```text
     A*%%TS  SD  20261015  152658  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R SFL1                      SFL
     A*%%TS  SD  20261015  134049  REMI        REL-V7R5M0  5770-WDS
     A            DBXFIL    R        O  8  9REFFLD(FMTDBX/DBXFIL BIB17/LST-
     A                                      SRC)
     A            DBXMBR    R        O  8 24REFFLD(FMTDBX/DBXMBR BIB17/LST-
     A                                      SRC)
     A            DBXTYP    R        O  8 39REFFLD(FMTDBX/DBXTYP BIB17/LST-
     A                                      SRC)
     A            DBXNBL    R        O  8 56REFFLD(FMTDBX/DBXNBL BIB17/LST-
     A                                      SRC)
     A            DBXTXT    R        O  9  4REFFLD(FMTDBX/DBXTXT BIB17/LST-
     A                                      SRC)
     A            SFLOPT         1  0B  8  4
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261015  152658  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF12(12)
     A                                      CF21(21)
     A                                      OVERLAY
     A  32                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                      SFLDROP(CF11)
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0006)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 32'Liste des membres'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  5  4'--'
     A            DBXLIB        10A  O  2 36
     A                                  7  4'Opt'
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A                                  7  9'Source'
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A                                  7 24'Membre'
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A                                  7 39'Type'
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A                                  7 56'Nb lignes'
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A          R FOOT
     A*%%TS  SD  20261015  113356  REMI        REL-V7R5M0  5770-WDS
     A                                 22  4'F3=Quitter  F12=Retour  F11=Affich-
     A                                      er texte'
     A                                      COLOR(BLU)
```
