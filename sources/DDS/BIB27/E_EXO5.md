---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: E_EXO5
type: DDS
longueur_enregistrement: 80
lignes: 40
modifie: 2026-11-25
---

# BIB27/QFREESRC/E_EXO5

```text
     A*%%TS  SD  20231206  112732  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R RECORD1
     A*%%TS  SD  20231206  105945  LEO2        REL-V7R4M0  5770-WDS
     A                                      CA03(03)
     A                                  1 69DATE
     A                                      EDTCDE(Y)
     A                                  1  5SYSNAME
     A                                  1 34'petit jeu cool'
     A                                      COLOR(WHT)
     A                                  4 20'Veuillez saisir un nombre entre 1 -
     A                                      et 100 :'
     A                                      COLOR(WHT)
     A            NBR            3N 0I  7 39
     A  50                                  ERRMSG('plus grand')
     A  51                                  ERRMSG('plus petit')
     A                                 15 35'f3 = quitter'
     A                                      COLOR(BLU)
     A          R RECORD2
     A*%%TS  SD  20231206  112732  LEO2        REL-V7R4M0  5770-WDS
     A                                      CA03(03)
     A                                  1 69DATE
     A                                      EDTCDE(Y)
     A                                  1  5SYSNAME
     A                                  1 34'petit jeu cool'
     A                                      COLOR(WHT)
     A                                 15 35'f3 = quitter'
     A                                      COLOR(BLU)
     A                                  4 30'BRAVO VOUS AVEZ GAGNE'
     A                                      COLOR(RED)
     A                                  7 16'le bon resultat est :'
     A                                      COLOR(WHT)
     A                                  9 16'nombre essais :'
     A                                      COLOR(WHT)
     A            RESULT         3S 0B  7 45
     A            COMPT          3S 0B  9 45
     A                                 11 16'meilleur score :'
     A                                      COLOR(WHT)
     A            BEST           3  0B 11 45
```
