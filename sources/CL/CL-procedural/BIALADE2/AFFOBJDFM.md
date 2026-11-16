---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: AFFOBJDFM
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 35
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/AFFOBJDFM

```cl
     A*%%TS  SD  20260923  143415  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260923  143415  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  7SYSNAME
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  7USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 32'Afficher un objet'
     A                                  9 14'Library:'
     A            ODLBNM    R        O  9 24REFFLD(QLIDOBJD/ODLBNM PHAN/DSPOBJD)
     A                                 10 15'Object:'
     A            ODOBNM    R        O 10 24REFFLD(QLIDOBJD/ODOBNM PHAN/DSPOBJD)
     A                                 11 10'Object Type:'
     A            ODOBTP    R        O 11 24REFFLD(QLIDOBJD/ODOBTP PHAN/DSPOBJD)
     A                                 12  5'Object Attribute:'
     A            ODOBAT    R        O 12 24REFFLD(QLIDOBJD/ODOBAT PHAN/DSPOBJD)
     A                                 13 10'Object Size:'
     A            ODOBSZ    R        O 13 24REFFLD(QLIDOBJD/ODOBSZ PHAN/DSPOBJD)
     A                                 22 35'F3=Exit'
```
