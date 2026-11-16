---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: EXPSRCIFSD
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 46
modifie: 2026-11-16
---

# BIB17/QCLPSRC/EXPSRCIFSD

```cl
     A*%%TS  SD  20260925  100919  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260925  100919  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  1USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 28'Exporter des sources IBM I'
     A                                      COLOR(BLU)
     A                                 23  8'F3:Quitter'
     A                                      COLOR(BLU)
     A                                  6 14'Bibliothèque.:'
     A                                      COLOR(BLU)
     A                                  7 14'Fichier......:'
     A                                      COLOR(BLU)
     A            PBIB          10A  B  6 31
     A  90                                  ERRMSG('Erreur : bibliothèque inexi-
     A                                      stante')
     A            PFIC          10A  B  7 31
     A  91                                  ERRMSG('Erreur : fichier inexistant-
     A                                      ')
     A          R FMT2
     A*%%TS  SD  20260925  094445  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  1USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 28'Exporter des sources IBMI'
     A                                      COLOR(BLU)
     A                                  7  3'Les sources ont été exporté dans l-
     A                                      e dossier:'
     A                                      COLOR(BLU)
     A                                 11  3'et il y a'
     A                                      COLOR(BLU)
     A            COUNT          6  0O 11 14
     A            CHMIFS        40   O  8  4
     A                                 11 22'membres sources'
     A                                      COLOR(BLU)
     A                                 23 22'F3:quitter'
     A                                      COLOR(BLU)
```
