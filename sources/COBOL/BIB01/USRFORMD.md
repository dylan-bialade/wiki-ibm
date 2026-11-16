---
bibliotheque: BIB01
fichier_source: QCBLLESRC
membre: USRFORMD
type: COBOL
longueur_enregistrement: 80
lignes: 47
modifie: 2026-11-16
---

# BIB01/QCBLLESRC/USRFORMD

```text
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A          R USRFORMF01
     A                                      INZRCD
     A*%%TS  SD  20260320  164055  ANTONY      REL-V7R5M0  5770-WDS
     A                                  1 31'Créer un Utilisateur'
     A                                      TEXT('Titre du formulaire')
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A                                  1  3'USRFORMD'
     A                                      COLOR(BLU)
     A                                  2  3USER
     A                                      COLOR(BLU)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A            NAME          30A  B 10 26CHECK(ME)
     A                                      CHECK(ER)
     A                                      CHECK(LC)
     A  90                                  ERRMSG('Une erreur est survenue sur-
     A                                       le NOM')
     A            FIRSTNAME     30A  B 12 26CHECK(ME)
     A                                      CHECK(ER)
     A                                      CHECK(LC)
     A  91                                  ERRMSG('Une erreur est survenur sur-
     A                                       le PRENOM')
     A            GROUP         10A  B 14 26CHECK(ME)
     A                                      CHECK(ER)
     A                                      CHECK(LC)
     A  92                                  ERRMSG('Une erreur est survenue sur-
     A                                       le GROUP')
     A                                      VALUES('SUPERUSR' 'OPERATOR' 'PILOT-
     A                                      ')
     A            RESULT        10A  O 16 26COLOR(TRQ)
     A  93                                  ERRMSG('UN AUTRE TRAITEMENT DE CRÉ-
                                            ATION EST EN COURS')
     A                                 10 19'NOM :'
     A                                 12 16'PRENOM :'
     A                                 14 16'GROUPE :'
     A                                 16 11'IDENTIFIANT :'
     A                                  6 19'Formulaire de création utilisateur-
     A                                       AIRFLEET'
                  ZONH          16   H
```
