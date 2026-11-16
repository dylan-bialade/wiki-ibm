---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: SQLINSDSP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 20
modifie: 2026-11-16
---

# BIB17/QCLPSRC/SQLINSDSP

```cl
     A*%%TS  SD  20260930  112624  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R SQLINSFMT
     A*%%TS  SD  20260930  112624  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 30'Insertion dans clients'
     A                                  7 11'Nom....:'
     A                                  8 11'Prénom.:'
     A                                  9 11'Age....:'
     A                                 23  8'F3: Quitter'
     A                                      COLOR(BLU)
     A            D_NOM         50   B  7 22
     A            D_PRENOM      50   B  8 22
     A            D_AGE          3  0B  9 22
```
