---
bibliotheque: BIB27
fichier_source: QSQLRPGLE
membre: E_TPJEUX
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 94
modifie: 2026-11-25
---

# BIB27/QSQLRPGLE/E_TPJEUX

```text
     A*%%TS  SD  20231208  131508  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A          R FMT1
     A*%%TS  SD  20231208  092926  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF06(06)
     A                                  1 67DATE
     A                                      EDTCDE(Y)
     A                                  1  7SYSNAME
     A                                  1 33'tp jeux vidéos'
     A                                      COLOR(WHT)
     A                                 22 36'f3 = exit'
     A                                      COLOR(BLU)
     A                                  5  5'Veuillez saisir un nom de jeu :'
     A                                      COLOR(WHT)
     A            E1_NOM        35A  B  5 38CHECK(LC)
     A  70                                  ERRMSG('ce jeux n''existe pas dans -
     A                                      la table' 70)
     A  71                                  ERRMSG('veuillez rentrer un jeu' 71)
     A  72                                  ERRMSG('update réussi !!!' 72)
     A  73                                  ERRMSG('update echoué !!!' 73)
     A                                 20 35'f6 = create'
     A                                      COLOR(BLU)
     A          R FMT2
     A*%%TS  SD  20231208  115321  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF02(02)
     A                                      CF08(08)
     A                                      CF23(23)
     A                                  1 67DATE
     A                                      EDTCDE(Y)
     A                                  1  7SYSNAME
     A                                  1 33'tp jeux videos '
     A                                      COLOR(WHT)
     A                                 22 36'f3 = exit'
     A                                      COLOR(BLU)
     A                                  6 13'IDJEU:'
     A  83                                  DSPATR(ND)
     A            E2_IDJEU  R        B  6 22REFFLD(JEUX/IDJEU BIB27/JEUX)
     A  60                                  DSPATR(PR)
     A  83                                  DSPATR(ND)
     A                                  7 12'NOMJEU:'
     A            E2_NOMJEU R        B  7 22REFFLD(JEUX/NOMJEU BIB27/JEUX)
     A                                  8 14'DATE:'
     A            E2_DATE   R        B  8 22REFFLD(JEUX/DATE BIB27/JEUX)
     A                                      DATFMT(*ISO)
     A                                  9 12'IDEDIT:'
     A  83                                  DSPATR(ND)
     A            E2_IDEDIT R        B  9 22REFFLD(EDITEURS/IDEDIT BIB27/EDIT-
     A                                      EURS)
     A  60                                  DSPATR(PR)
     A  83                                  DSPATR(ND)
     A                                 10 11'NOMEDIT:'
     A            E2_NOMEDITR        B 10 22REFFLD(EDITEURS/NOMEDIT BIB27/EDI-
     A                                      TEURS)
     A                                      CHECK(LC)
     A                                 11  9'VILLEEDIT:'
     A            E2_VILLE  R        B 11 22REFFLD(EDITEURS/VILLEEDIT BIB27/E-
     A                                      DITEURS)
     A                                 12  8'DEVISEEDIT:'
     A                                 20 35'f2 = update'
     A  81                                  DSPATR(ND)
     A                                      COLOR(BLU)
     A                                 18 35'f8 = create'
     A  82                                  DSPATR(ND)
     A                                      COLOR(BLU)
     A            E2_DEVISE      1A  B 12 22
     A                                 16 33'f23 = supprimer'
     A                                      COLOR(BLU)
     A  84                                  DSPATR(ND)
     A          R FMT3
     A*%%TS  SD  20231207  161039  LEO2        REL-V7R4M0  5770-WDS
     A                                      WINDOW(5 25 10 30)
     A                                  1  5'voulez vous modifier ?'
     A                                      COLOR(WHT)
     A            VALID          3   B  5 15
     A                                  7 12'(YES/NO)'
     A                                      COLOR(RED)
     A          R FMT4
     A*%%TS  SD  20231208  094139  LEO2        REL-V7R4M0  5770-WDS
     A                                      WINDOW(5 25 10 30)
     A                                  1  7'voulez vous créer?'
     A                                      COLOR(WHT)
     A            VALID1         3A  B  5 15
     A                                  7 12'(YES/NO)'
     A                                      COLOR(RED)
     A          R FMT5
     A*%%TS  SD  20231208  120405  LEO2        REL-V7R4M0  5770-WDS
     A                                      WINDOW(5 25 10 30)
     A                                  1  5'voulez vous supprimer?'
     A                                      COLOR(WHT)
     A            VALID2         3A  B  5 15
     A                                  7 12'(YES/NO)'
     A                                      COLOR(RED)
```
