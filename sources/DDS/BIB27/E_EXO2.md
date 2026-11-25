---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: E_EXO2
type: DDS
longueur_enregistrement: 160
lignes: 37
modifie: 2026-11-25
---

# BIB27/QFREESRC/E_EXO2

```text
     A*%%TS  SD  20231207  102640  LEO2        REL-V7R4M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A                                      CA03(03)
     A          R FMT1                                                               A*%%TS  SD  20231207  102640  LEO2        REL-V7R4M0  5770-WDS
     A                                  1 34'pokemon free'                           A                                      COLOR(WHT)
     A                                  1 69DATE                                     A                                      EDTCDE(Y)
     A                                  1  3SYSNAME                                  A                                 10 17'Pokemon name :'
     A                                      COLOR(WHT)                               A            E_NAME        25A  B 10 36CHECK(LC)
     A  70                                  ERRMSG('entrer le nom du pokemon')       A  71                                  ERRMSG('pokemon existe pas')
     A                                 17 16'f3 = quitter'                           A                                      COLOR(BLU)
     A          R FMT2                                                               A*%%TS  SD  20231205  154922  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF08(08)                                 A                                  1 34'pokemon free'
     A                                      COLOR(WHT)                               A                                  1 69DATE
     A                                      EDTCDE(Y)                                A                                  1  3SYSNAME
     A                                 22 37'f3=exit'                                A                                      COLOR(BLU)
     A                                  7  1'ID:'                                    A            E_ID      R        B  7 20REFFLD(POKEMON/ID BIB27/POKEMON2G)
     A  60                                  DSPATR(PR)                               A                                  8  1'POKEDEX_NUMBER:'
     A            E_POKENUM R        B  8 20REFFLD(POKEMON/POKED00001 BIB27/P-     A                                      OKEMON2G)
     A  60                                  DSPATR(PR)                               A                                  9  1'NAME:'
     A            E1_NAME       25A  B  9 20                                         A  60                                  DSPATR(PR)
     A                                 10  1'HP:'                                    A            E_HP      R        B 10 20REFFLD(POKEMON/HP BIB27/POKEMON2G)
     A                                 11  1'ATTACK:'                                A            E_ATTACK  R        B 11 20REFFLD(POKEMON/ATTACK BIB27/POKEM-
     A                                      ON2G)                                    A                                 12  1'DEFENSE:'
     A            E_DEFENSE R        B 12 20REFFLD(POKEMON/DEFENSE BIB27/POKE-     A                                      MON2G)
     A                                 13  1'SPEED:'                                 A            E_SPEED   R        B 13 20REFFLD(POKEMON/SPEED BIB27/POKEMO-
     A                                      N2G)                                     A                                 14  1'SPECIAL_ATTACK:'
     A            E_SPATTACKR        B 14 20REFFLD(POKEMON/SPECI00001 BIB27/P-     A                                      OKEMON2G)
     A                                 15  1'SPECIAL_DEFENSE:'                       A            E_SPDEFENSR        B 15 20REFFLD(POKEMON/SPECI00002 BIB27/P-
     A                                      OKEMON2G)                                A                                 16  1'TYPE1:'
     A            E_TYPE1   R        B 16 20REFFLD(POKEMON/TYPE1 BIB27/POKEMO-     A                                      N2G)
     A  60                                  DSPATR(PR)                               A                                 17  1'TYPE2:'
     A            E_TYPE2   R        B 17 20REFFLD(POKEMON/TYPE2 BIB27/POKEMO-     A                                      N2G)
     A  60                                  DSPATR(PR)                               A                                 20 36'f8=update'
     A                                      COLOR(BLU)                               A          R FMT3
     A*%%TS  SD  20231205  155302  LEO2        REL-V7R4M0  5770-WDS                  A                                      WINDOW(5 12 10 50)
     A                                  2  3'êtes vous sure de vouloir modifier-     A                                       le pokemon ?'
     A                                      COLOR(WHT)                               A            VALID          3   B  6 18
     A                                  6 30'(yes/no)'                               A                                      COLOR(BLU)
```
