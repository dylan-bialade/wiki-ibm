---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: EXPSRCIFSD
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 69
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/EXPSRCIFSD

```cl
     A*%%TS  SD  20260925  151304  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260925  151304  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 28'Exporter des sources IBM I'
     A                                      DSPATR(UL)
     A                                 10 17'Bibliothèque . :'
     A                                      COLOR(BLU)
     A                                 11 17'Fichier. . . . :'
     A                                      COLOR(BLU)
     A            PBIB          10A  B 10 35
     A  90                                  ERRMSG('Erreur: Bibliothèque inexis-
     A                                      tante')
     A            PFIC          10A  B 11 35
     A  91                                  ERRMSG('Erreur: fichier inexistant')
     A  92                                  ERRMSG('Erreur: le fichier n est pa-
     A                                      s un fichier source !!')
     A                                 23 37'F3=Exit'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A          R FMT2
     A*%%TS  SD  20260925  115918  XUAN        REL-V7R5M0  5770-WDS
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
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
     A                                  1 25'Exporter des sources IBM I'
     A                                      COLOR(BLU)
     A                                 10  3'Les sources ont été exporté dans l-
     A                                      e dossier :'
     A                                      COLOR(BLU)
     A            CHMIFS        40A  O 11  4
     A                                 12  3'et il y a'
     A                                      COLOR(BLU)
     A            COUNT          6S 0O 12 13
     A                                 12 20'membres sources'
     A                                      COLOR(BLU)
```
