---
bibliotheque: BIB27
fichier_source: QMNUSRC
membre: MENUTEST
type: Menus
longueur_enregistrement: 80
lignes: 66
modifie: 2026-11-25
---

# BIB27/QMNUSRC/MENUTEST

```text
     A* Menu de format libre : MENUTEST
     A*%%TS  SD  20240605  100010  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R MENUTEST
     A*%%TS  SD  20240605  095037  LEO2        REL-V7R4M0  5770-WDS
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP
     A                                      HOME
     A                                      HLPRTN
     A                                  1  2'MENUTEST'
     A                                      COLOR(BLU)
     A                                  1 32'MENUTEST Menu'
     A                                      DSPATR(HI)
     A                                  3  2'Choisir une des options suivantes -
     A                                      :'
     A                                      COLOR(BLU)
     A                                  5  7'1.'
     A                                  6  7'2.'
     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019  2'Option ou commande                -
     A                                          '
     A                                  5 11'Pokemon'
     A                                  6 11'Harry Potter'
     A          R £H0000
     A*%%TS  SD  20240605  095839  LEO2        REL-V7R4M0  5770-WDS
     A                                      TEXT('Aide générale pour menu MENUT-
     A                                      EST')
     A                                      CLRL(*ALL)
     A                                  1  2'HELP'
     A                                      COLOR(BLU)
     A                                  1 25'Aide générale pour menu MENUTEST'
     A                                      DSPATR(HI)
     A                                  8 25'aide générale'
     A          R £H0101
     A*%%TS  SD  20240605  095238  LEO2        REL-V7R4M0  5770-WDS
     A                                      TEXT('Aide pour option 01')
     A                                      CLRL(*ALL)
     A                                  1  2'HELP'
     A                                      COLOR(BLU)
     A                                  1 31'Aide pour option 01'
     A                                      DSPATR(HI)
     A                                  5  4'Ceci est un programme qui consulte-
     A                                       une API : POKEAPI'
     A                                  7  4'Renseignez un nom de pokemon (en a-
     A                                      nglais) pour récupérer ses informat-
     A                                      ions'
     A          R £H0202
     A*%%TS  SD  20240605  095238  LEO2        REL-V7R4M0  5770-WDS
     A                                      TEXT('Aide pour option 02')
     A                                      CLRL(*ALL)
     A                                  1  2'HELP'
     A                                      COLOR(BLU)
     A                                  1 31'Aide pour option 02'
     A                                      DSPATR(HI)
     A                                  5  3'Ceci est un sous fichier sur Harry-
     A                                       Potter'
```
