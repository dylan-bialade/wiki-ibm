---
bibliotheque: BIB25
fichier_source: QDDSSRC
membre: MENUIZI6
type: DDS
longueur_enregistrement: 80
lignes: 42
modifie: 2026-11-25
---

# BIB25/QDDSSRC/MENUIZI6

```text
     A* Menu de format libre : MENUIZI6
     A*%%TS  SD  20250228  120618  LEO2        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R MENUIZI6
     A*%%TS  SD  20250228  115107  LEO2        REL-V7R5M0  5770-WDS
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP
     A                                      HOME
     A                                      HLPRTN
     A                                  1  2'MENUIZI6'
     A                                      COLOR(BLU)
     A                                  1 32'MENUIZI6 Menu'
     A                                      DSPATR(HI)
     A                                  3  2'Choisir une des options suivantes -
     A                                      :'
     A                                      COLOR(BLU)
     A                                  5  7'1.'
     A                                  6  7'2.'
     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019  2'Option ou commande                -
     A                                          '
     A                                  5 11'AfficHAge des spools'
     A                                  6 11'Suppression des spools'
     A          R £H0101
     A*%%TS  SD  20250228  115107  LEO2        REL-V7R5M0  5770-WDS
     A                                      TEXT('Aide pour option 01')
     A                                      CLRL(*ALL)
     A                                  1  2'HELP'
     A                                      COLOR(BLU)
     A                                  1 31'Aide pour option 01'
     A                                      DSPATR(HI)
     A                                  4  8'ce menu gère les spools'
```
