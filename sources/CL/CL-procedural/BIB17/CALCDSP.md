---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: CALCDSP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 23
modifie: 2026-11-16
---

# BIB17/QCLPSRC/CALCDSP

```cl
     A*%%TS  SD  20260922  155938  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R CALCFMT
     A*%%TS  SD  20260922  155938  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF06(06)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 35'Calculatrice'
     A                                  1 65DATE
     A                                      EDTCDE(Y)
     A                                  2 65TIME
     A                                  8 39'cop'
     A                                  8 23'Facteur 1'
     A                                  8 50'Facteur 2'
     A            COP            1A  I 10 40
     A            FAC01         10Y 2B 10 23EDTCDE(J)
     A            FAC02         10Y 2B 10 50EDTCDE(J)
     A                                 13 18'Résultat =>'
     A            RESULT        15Y 5B 13 32EDTCDE(J)
     A                                 21  6'F3=Fin'
     A                                 21 16'F6=RAZ'
```
