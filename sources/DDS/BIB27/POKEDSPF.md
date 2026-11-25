---
bibliotheque: BIB27
fichier_source: QDDSSRC
membre: POKEDSPF
type: DDS
longueur_enregistrement: 160
lignes: 30
modifie: 2026-11-25
---

# BIB27/QDDSSRC/POKEDSPF

```text
     A*%%TS  SD  20240523  144351  LEO2        REL-V7R4M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R FMT1
     A*%%TS  SD  20240523  144351  LEO2        REL-V7R4M0  5770-WDS                  A                                      CA03(03 'Sortie du programme')
     A                                  1  2SYSNAME                                  A                                  2  2DATE
     A                                      EDTCDE(Y)                                A                                  3  2TIME
     A                                  1 32'TEST API POKE API'                      A                                      COLOR(WHT)
     A                                 23  1'F3=Exit'                                A                                      COLOR(BLU)
     A                                  7 23'Veuillez saisir le nom d un pokemo-     A                                      n'
     A                                      COLOR(WHT)                               A            E1_NAME       25A  I 10 28
     A            E1_ERR        50   O 21  2COLOR(RED)                               A          R FMT2
     A*%%TS  SD  20240523  141208  LEO2        REL-V7R4M0  5770-WDS                  A                                      CA03(03 'Sortie du programme')
     A                                      CA12(12 'Ecran précédent')               A                                  1  2SYSNAME
     A                                  2  2DATE                                     A                                      EDTCDE(Y)
     A                                  3  2TIME                                     A                                  1 32'TEST API POKE API'
     A                                      COLOR(WHT)                               A                                 23  2'F3=Quitter'
     A                                      COLOR(BLU)                               A                                 23 15'F12=Précédent'
     A                                      COLOR(BLU)                               A            E2_NAME       20A  O  6 42
     A                                  6 22'Informations sur :'                     A                                      COLOR(WHT)
     A                                  9  3'Puissance Attaque   :'                  A                                      COLOR(WHT)
     A                                 10  3'Puissance Défence   :'                  A                                      COLOR(WHT)
     A                                  8  3'Points de vie       :'                  A                                      COLOR(WHT)
     A                                 11  3'Puissance S-Attaque :'                  A                                      COLOR(WHT)
     A                                 12  3'Puissance S-Défence :'                  A                                      COLOR(WHT)
     A                                 13  3'Vitesse du pokemon  :'                  A                                      COLOR(WHT)
     A                                 14  3'Type du pokemon     :'                  A                                      COLOR(WHT)
     A                                 15  3'Capacité principale :'                  A                                      COLOR(WHT)
     A            E2_PV          3  0O  8 27                                         A            E2_ATTACK      3  0O  9 27
     A            E2_DEF         3  0O 10 27                                         A            E2_SATTACK     3  0O 11 27
     A            E2_SDEF        3  0O 12 27                                         A            E2_VIT         3  0O 13 27
     A            E2_TYPE       20   O 14 27                                         A            E2_ABILITY    20   O 15 27
```
