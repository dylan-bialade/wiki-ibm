---
bibliotheque: BIB25
fichier_source: QDDSSRC
membre: MENU_TST
type: DDS
longueur_enregistrement: 120
lignes: 42
modifie: 2026-11-25
---

# BIB25/QDDSSRC/MENU_TST

```text
     A* Menu de format libre : MENU_TST                                              A*%%TS  SD  20250228  121019  LEO2
       REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -     A
           27 132 *DS4)                      A                                      CHGINPDFT
     A                                      INDARA                                   A
    PRINT(*LIBL/QSYSPRT)                     A          R MENU_TST
     A*%%TS  SD  20250217  161713  LEO2        REL-V7R5M0  5770-WDS                  A
    DSPMOD(*DS3)                             A                                      LOCK
     A                                      SLNO(01)                                 A
    CLRL(*ALL)                               A                                      ALWROL
     A                                      CF03                                     A
    HELP                                     A                                      HOME
     A                                      HLPRTN                                   A
1  2'dENU_TST'                               A                                      COLOR(BLU)
     A                                  3  2'Choisir une des options suivantes -     A
    :'                                       A                                      COLOR(BLU)
     A                                  5  7'1.'                                     A
6  7'2.'                                     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019  2'Option ou commande                -     A
        '                                    A                                  5 11'Gestion des fichiers spools'
     A                                  6 11'Suppression des fichiers spools'        A
1 31'Menu Fichier spools'                    A                                      COLOR(WHT)
     A          R £H0000                                                             A*%%TS  SD  20250217  161713  LEO2
       REL-V7R5M0  5770-WDS                  A                                      TEXT('Aide générale pour menu MENU_-
     A                                      TST')                                    A
    CLRL(*ALL)                               A                                  1  2'HELP'
     A                                      COLOR(BLU)                               A
1 25'Aide générale pour menu MENU_TST'       A                                      DSPATR(HI)
     A                                  5  3'Ceci est le menu des fichiers spoo-     A
    ls'                                      A          R £H0101
     A*%%TS  SD  20250217  162029  LEO2        REL-V7R5M0  5770-WDS                  A
    TEXT('Aide pour option 01')              A                                      CLRL(*ALL)
     A                                  1  2'HELP'                                   A
    COLOR(BLU)                               A                                  1 31'Aide pour option 01'
     A                                      DSPATR(HI)                               A
5  4'Cette option permet de visualiser -     A                                      vos fichiers spools'
     A          R £H0202                                                             A*%%TS  SD  20250228  121019  LEO2
       REL-V7R5M0  5770-WDS                  A                                      TEXT('Aide pour option 02')
     A                                      CLRL(*ALL)                               A
1  2'HELP'                                   A                                      COLOR(BLU)
     A                                  1 31'Aide pour option 02'                    A
    DSPATR(HI)                               A                                  7 31'suppresion des spools'
```
