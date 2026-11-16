---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: DSPUSRDSP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 27
modifie: 2026-11-16
---

# BIB17/QCLPSRC/DSPUSRDSP

```cl
     A*%%TS  SD  20260923  161519  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R DSPUSRFMT
     A*%%TS  SD  20260923  161519  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72TIME
     A                                  2 72DATE
     A                                      EDTCDE(Y)
     A                                  1 30'Affichage utilisateur'
     A                                  5 20'User:'
     A            UPUPRF    R        O  5 27REFFLD(QSYDSUPB/UPUPRF BIB17/D-
     A                                      SPUSRPRF)
     A                                  6 14'User Class:'
     A            UPUSCL    R        O  6 27REFFLD(QSYDSUPB/UPUSCL BIB17/D-
     A                                      SPUSRPRF)
     A                                  7  9'Initial Program:'
     A            UPINPG    R        O  7 27REFFLD(QSYDSUPB/UPINPG BIB17/D-
     A                                      SPUSRPRF)
     A                                  8  9'Current Library:'
     A            UPCRLB    R        O  8 27REFFLD(QSYDSUPB/UPCRLB BIB17/D-
     A                                      SPUSRPRF)
     A                                  9 12'Initial Menu:'
     A            UPINMN    R        O  9 27REFFLD(QSYDSUPB/UPINMN BIB17/D-
     A                                      SPUSRPRF)
```
