---
bibliotheque: BIB01
fichier_source: QDDSSRC
membre: EXPSRCIFSD
type: DDS
longueur_enregistrement: 100
lignes: 43
modifie: 2026-11-16
---

# BIB01/QDDSSRC/EXPSRCIFSD

```text
     A*%%TS  SD  20260925  113436  FADRIEN     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R FMT1
     A*%%TS  SD  20260925  113436  FADRIEN     REL-V7R5M0  5770-WDS
     A                                      OVERLAY
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 28'Exporter des sources IBM I'
     A                                      COLOR(BLU)
     A                                  6 18'Bibliothèque . :'
     A                                      COLOR(BLU)
     A                                  7 18'Fichier. . . . :'
     A                                      COLOR(BLU)
     A            PBIB          10A  B  6 36COMP(NE ' ')
     A  90                                  ERRMSG('Bibliothèque invalide' 90)
     A            PFIC          10A  B  7 36COMP(NE ' ')
     A  91                                  ERRMSG('Fichier incorrect' 91)
     A                                 22 36'F3=Quitter'
     A                                      COLOR(BLU)
     A          R FMT2
     A*%%TS  SD  20260925  083754  FADRIEN     REL-V7R5M0  5770-WDS
     A                                      OVERLAY
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 28'Exporter des sources IBM I'
     A                                      COLOR(BLU)
     A                                 10  2'Les sources ont été exporté dans l-
     A                                      e dossier :'
     A                                      COLOR(BLU)
     A            CHMIFS        40A  O 11  3
     A                                 13  2'et il y a'
     A                                      COLOR(BLU)
     A            COUNT          6Y 0O 13 12EDTCDE(4)
     A                                 13 19'membres sources'
     A                                      COLOR(BLU)
```
