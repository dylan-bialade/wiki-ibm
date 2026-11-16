---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: CALCFM
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 45
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/CALCFM

```cl
     A*%%TS  SD  20260922  160112  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R CALCFM1
     A*%%TS  SD  20260922  160112  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF06(06)
     A                                  1 11'  ___   __   __     ___  _  _  __ -
     A                                         ____  ____  ____  ____ '
     A                                  2 11' / __) / _\ (  )   / __)/ )( \(  )-
     A                                        (  __)(_  _)(_  _)(  __)'
     A                                  3 11'( (__ /    \/ (_/\( (__ ) \/ (/ (_-
     A                                      /\ ) _)   )(    )(   ) _) '
     A                                  4 11' \___)\_/\_/\____/ \___)\____/\___-
     A                                      _/(____) (__)  (__) (____)'
     A                                  5  2SYSNAME
     A                                  6  2USER
     A                                  5 72DATE
     A                                      EDTCDE(Y)
     A                                  6 72TIME
     A                                  9 39'Cop'
     A                                      DSPATR(HI)
     A                                      DSPATR(RI)
     A                                  9 23'Facteur 1'
     A                                      DSPATR(RI)
     A                                      COLOR(WHT)
     A            FAC1          10Y 2B 11 20EDTCDE(N)
     A                                      CHECK(RB)
     A                                  9 48'Facteur 2'
     A                                      DSPATR(RI)
     A                                      COLOR(WHT)
     A            FAC2          10Y 2B 11 46EDTCDE(N)
     A                                      CHECK(RB)
     A                                 14 23'Resultat =>'
     A                                      DSPATR(RI)
     A                                      COLOR(WHT)
     A                                 23  4'F3=Fin'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A                                 23 19'F6=RAZ'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A            COP            1A  B 11 40
     A            RESULT        12Y 2B 14 37CHECK(RB)
     A                                      EDTCDE(N)
```
