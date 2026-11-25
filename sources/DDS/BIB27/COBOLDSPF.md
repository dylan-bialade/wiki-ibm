---
bibliotheque: BIB27
fichier_source: QDDSSRC
membre: COBOLDSPF
type: DDS
longueur_enregistrement: 160
lignes: 41
modifie: 2026-11-25
---

# BIB27/QDDSSRC/COBOLDSPF

```text
     A*%%TS  SD  20240611  161459  LEO2        REL-V7R4M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R FMT2
     A*%%TS  SD  20240611  161459  LEO2        REL-V7R4M0  5770-WDS                  A                                      CA03(03)
     A                                      CA12(12)                                 A                                      CF23(23)
     A                                  1  3SYSNAME                                  A                                  2  3USER
     A                                  1 68DATE                                     A                                      EDTCDE(Y)
     A                                  2 68TIME                                     A                                  1 36'TEST COBOL'
     A                                      COLOR(WHT)                               A                                  6  8'Nom :'
     A                                  8  8'Prénom :'                               A                                 10  8'Taille :'
     A                                 12  8'Equipe :'                               A                                 16  8'Age :'
     A                                 23  3'F3=EXIT'                                A                                      COLOR(BLU)
     A                                 14  8'Titres :'                               A            NOM           50A  O  6 20
     A            PRENOM        50A  O  8 20                                         A            TAILLE         3Y 2O 10 20EDTCDE(2)
     A            EQUIPE        50A  O 12 20                                         A            NBR_TITRE      1S 0O 14 20
     A            AGE            2S 0O 16 20                                         A                                 23 14'F12=BACK'
     A                                      COLOR(BLU)                               A                                 23 25'F23=DELETE'
     A                                      COLOR(BLU)                               A          R FMT1
     A*%%TS  SD  20240611  142920  LEO2        REL-V7R4M0  5770-WDS                  A                                      CA03(03)
     A                                      CA06(06)                                 A                                  1  2SYSNAME
     A                                  2  2USER                                     A                                  1 36'TEST COBOL'
     A                                      COLOR(WHT)                               A                                  1 73DATE
     A                                      EDTCDE(Y)                                A                                  2 73TIME
     A                                  8 26'BIENVENUE CHEZ NOS JOUEURS NBA'         A                                      COLOR(BLU)
     A                                 13 17'Appuyer sur ENTREE pour voir les j-     A                                      oueurs 1 par 1'
     A                                 23  2'F3=EXIT'                                A                                      COLOR(BLU)
     A                                 23 12'F6=CREATE'                              A                                      COLOR(BLU)
     A          R FMT3                                                               A*%%TS  SD  20240611  161459  LEO2        REL-V7R4M0  5770-WDS
     A                                      CA03(03)                                 A                                      CF22(22)
     A                                      CA12(12)                                 A                                  1  3SYSNAME
     A                                  2  3USER                                     A                                  1 68DATE
     A                                      EDTCDE(Y)                                A                                  2 68TIME
     A                                  1 36'TEST COBOL'                             A                                      COLOR(WHT)
     A                                  6  8'Nom :'                                  A                                  8  8'Prénom :'
     A                                 10  8'Taille :'                               A                                 12  8'Equipe :'
     A                                 23  3'F3=EXIT'                                A                                      COLOR(BLU)
     A                                 14  8'Titres :'                               A                                 16  8'Age :'
     A            NOM2          50A  I  6 20                                         A            PRENOM2       50A  I  8 20
     A            TAILLE2        3Y 2I 10 20                                         A            EQUIPE2       50A  I 12 20
     A            NBR_TITRE2     1S 0I 14 20                                         A            AGE2           2S 0I 16 20
     A                                 23 23'F22=CREATE'                             A                                      COLOR(BLU)
     A                                 23 13'F12=BACK'                               A                                      COLOR(BLU)
```
