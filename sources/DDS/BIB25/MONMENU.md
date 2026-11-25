---
bibliotheque: BIB25
fichier_source: QF_PFLF
membre: MONMENU
type: DDS
longueur_enregistrement: 80
lignes: 61
modifie: 2026-11-25
---

# BIB25/QF_PFLF/MONMENU

```text
     A* Menu de format libre : MONMENU
     A*%%TS  SD  20250214  163217  LEO2        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R MONMENU
     A*%%TS  SD  20250214  163217  LEO2        REL-V7R5M0  5770-WDS
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP
     A                                      HOME
     A                                      HLPRTN
     A                                  1  2'MONMENU'
     A                                      COLOR(BLU)
     A                                  1 33'MONMENU Menu'
     A                                      DSPATR(HI)
     A                                  3  2'Choisir une des options suivantes -
     A                                      :'
     A                                      COLOR(BLU)
     A                                  5  7'1.'
     A                                  6  7'2.'
     A                                  7  7'3.'
     A                                  8  7'4.'
     A                                  9  7'5.'
     A                                 10  7'6.'
     A                                 11  7'7.'
     A                                 12  7'8.'
     A                                 13  7'9.'
     A                                 14  6'10.'
     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019  2'Option ou commande                -
     A                                          '
     A                                  5 11'Gestion des spools'
     A                                  6 11'Suppression des spools'
     A          R £H0101
     A*%%TS  SD  20250214  163217  LEO2        REL-V7R5M0  5770-WDS
     A                                      TEXT('Aide pour option 01')
     A                                      CLRL(*ALL)
     A                                  1  2'HELP'
     A                                      COLOR(BLU)
     A                                  1 31'Aide pour option 01'
     A                                      DSPATR(HI)
     A                                  5  5'Cette option permet de gérer vos f-
     A                                      ichiers spools'
     A          R £H0202
     A*%%TS  SD  20250214  163217  LEO2        REL-V7R5M0  5770-WDS
     A                                      TEXT('Aide pour option 02')
     A                                      CLRL(*ALL)
     A                                  1  2'HELP'
     A                                      COLOR(BLU)
     A                                  1 31'Aide pour option 02'
     A                                      DSPATR(HI)
     A                                  4  3'Cette option permet de supprimer l-
     A                                      es fichiers spools'
```
