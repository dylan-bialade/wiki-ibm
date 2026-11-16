---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: RTVUSR1
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 27
modifie: 2026-11-16
---

# BIB17/QCLPSRC/RTVUSR1

```cl
     A*%%TS  SD  20260923  095634  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R RTVUSRFMT1
     A*%%TS  SD  20260923  095634  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  3USER
     A                                  2  3SYSNAME
     A            INPUTNM       10A  I 10 36
     A          R RTVUSRFMT2
     A*%%TS  SD  20260923  095634  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  6 11'Profil:'
     A                                  7 11'*CURLIB:'
     A                                  8 11'*INLPGM:'
     A                                  9 11'*CCSID:'
     A                                 10 11'OUTQ:'
     A            PROFIL        10A  O  6 26
     A            CURLIB        10A  O  7 26
     A                                  8  9' '
     A                                  9  9' '
     A            INLPGM        10A  O  8 26
     A                                  9  7' '
     A            CCSID         10A  O  9 26
     A            OUTQ          10A  O 10 26
```
