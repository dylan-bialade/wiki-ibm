---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: MENU1
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 42
modifie: 2026-11-25
---

# BIB27/QCLSRC/MENU1

```cl
     A* Menu de format libre : MENU1
     A*%%TS  SD  20231106  111529  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R MENU1
     A*%%TS  SD  20231106  111529  LEO2        REL-V7R4M0  5770-WDS
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP
     A                                      HOME
     A                                      HLPRTN
     A                                  1  2'MENU1'
     A                                      COLOR(BLU)
     A                                  1 34'MENU1 Menu'
     A                                      DSPATR(HI)
     A                                  3  2'Choisir une des options suivantes -
     A                                      :'
     A                                      COLOR(BLU)
     A                                  5  7'1.'
     A                                  6  7'2.'
     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019  2'Option ou commande                -
     A                                          '
     A                                  5 10'gestion des membres'
     A                                  6 10'gestion des objets'
     A                                      COLOR(YLW)
     A                                      DSPATR(HI)
     A                                 16  6'99.'
     A                                 16 10'sign off'
     A                                  1 61SYSNAME
     A                                  2 61USER
     A                                  3 61DATE
     A                                      EDTCDE(Y)
     A                                  4 61TIME
```
