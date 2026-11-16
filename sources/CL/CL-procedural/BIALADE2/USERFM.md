---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: USERFM
type: CL/CL-procedural
longueur_enregistrement: 160
lignes: 46
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/USERFM

```cl
     A*%%TS  SD  20260923  113539  XUAN        REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R FMT1
     A*%%TS  SD  20260923  101844  XUAN        REL-V7R5M0  5770-WDS                  A                                      CF03(03)
     A                                  1  2'SYS'                                    A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  1  6SYSNAME
     A                                  2  2'USR'                                    A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  2  6USER
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2 72TIME                                     A                                  1 67'DATE'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  2 67'TIME'                                   A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  1 35'USER SELECT'
     A                                 10 10'Profil Utilisateur:'                    A                                      DSPATR(UL)
     A                                      COLOR(BLU)                               A            USER          10A  I 10 39
     A  99                                  ERRMSG('Utilisateur introuvable!')       A                                 23  3'F3=exit'
     A                                      COLOR(BLU)                               A                                      DSPATR(RI)
     A                                 10 30'.  .  .'                                A                                      COLOR(BLU)
     A          R FMT2                                                               A*%%TS  SD  20260923  113539  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)                                 A                                      CF12(12)
     A                                  1  2'SYS'                                    A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  2  2'USR'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  1  6SYSNAME                                  A                                  2  6USER
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2 72TIME                                     A                                  1 67'DATE'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  2 67'TIME'                                   A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  1 36'INFO USER'
     A            PROFIL        10A  O  8 45DSPATR(UL)                               A            CURLIB        10A  O 10 45DSPATR(UL)
     A            INLPGM        10A  O 12 45DSPATR(UL)                               A            CCSID          5S 0B 14 45
     A            OUTQ          10A  O 16 45DSPATR(UL)                               A                                  8 10'Profil Utilisateur:'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                 10 15'*CURLIB:'                               A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                 12 15'*INLPGM:'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                 14 15'*CCSID:'                                A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                 16 15'*OUTQ:'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  8 30'.  .  .  .  .'                          A                                      COLOR(BLU)
     A                                 10 24'.  .  .  .  .  .  .'                    A                                      COLOR(BLU)
     A                                 12 24'.  .  .  .  .  .  .'                    A                                      COLOR(BLU)
     A                                 14 24'.  .  .  .  .  .  .'                    A                                      COLOR(BLU)
     A                                 16 24'.  .  .  .  .  .  .'                    A                                      COLOR(BLU)
     A                                 23  3'F3=Exit'                                A                                      COLOR(BLU)
     A                                      DSPATR(RI)                               A                                 23 16'F12=Retour'
     A                                      COLOR(BLU)                               A                                      DSPATR(RI)
```
