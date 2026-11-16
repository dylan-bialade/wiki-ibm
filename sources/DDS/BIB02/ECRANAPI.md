---
bibliotheque: BIB02
fichier_source: QTESTSRC
membre: ECRANAPI
type: DDS
longueur_enregistrement: 100
lignes: 150
modifie: 2026-11-16
---

# BIB02/QTESTSRC/ECRANAPI

```text
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')
     A                                      CA12(12 'Retour')
     A                                      CA08(08 'Imprimer')
     A                                      CA07(07 'Participant')
     A                                      CA09(09 'Formation')
     A                                      ERRSFL
                                            INDARA
     A                                      ALTHELP(CA01)
     A                                      HLPTITLE('Aide au programme')
     A                                      HELP

     A          R SFL1                      SFL
     A            OPT            1A  I  9  2
     A            E1CODFOR       5   O  9  5
     A            E1NM           9A  O  9 11
     A            E1MAIL        20A  O  9 22
     A            E1GENRE        9A  O  9 43
     A            E1STATUS      10A  O  9 54
     A

     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A                                      ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A
     A          H                           HLPPNLGRP('GENERAL' HLP)
     A                                      HLPARA(1 1 2 24)
     A          H                           HLPPNLGRP('ETAT'  HLP)
     A                                      HLPARA(8 60 8 63)
     A          H                           HLPPNLGRP('TYPE' HLP)
     A                                      HLPARA(8 64 8 67)
     A          H                           HLPPNLGRP('FILTRE' HLP)
     A                                      HLPARA(3 25 4 48)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  8  5'Id'
     A                                      DSPATR(HI)
     A                                  8 11'Nom'
     A                                      DSPATR(HI)
     A                                  8 43'Genre'
     A                                      DSPATR(HI)
     A                                  1  2'ECRANAPI'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 24'API UTILISATEUR'
     A                                      DSPATR(HI)
     A                                  8  1'Opt'
     A                                      DSPATR(HI)
     A                                  3  2'Indiquez vos option, puis appuyez-
     A                                       sur ENTREE.'
     A                                      COLOR(BLU)
     A                                  4  3'2=Editer'
     A                                      COLOR(BLU)
     A                                  4 12'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  8 54'Status'
                                             DSPATR(HI)
     A                                  8 22'Email'
                                             DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
     A                                 23 12'F6=Ajouter une personne'
     A                                      COLOR(BLU)
     A          R FMT4
     A                                      CF23(23)
     A                                  1 31'Suppression de l''utilisateur'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)


     A            E4CODFOR       4   O  7 28
     A            E4NM          10   O  8 28
     A            E4MAIL        20   O  9 28
     A            E4STATUS      10   O 11 28
     A            E4GENRE       10   O 10 28

     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 12'F12=Retour'
     A                                      COLOR(BLU)
     A                                  7  3'Code..................: '
     A                                  8  3'Nom...................:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  9  3'Mail..................:'
     A                                 10  3'Genre.................:'
     A                                 11  3'Status................:'
     A          R FMT2
     A                                      CF23(23)
     A                                  1 31'Modifier l''utilisateur'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E2CODFOR       4   H
     A            E2NM          10   B  6 28
     A            E2MAIL        20   B  7 28
     A            E2STATUS      10   B  9 28
     A            E2GENRE       10   B  8 28
     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 12'F12=Retour'
     A                                      COLOR(BLU)
     A                                  6  3'Nom..................:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  7  3'Mail.................:'
     A                                  8  3'Genre................:'
     A                                  9  3'Status...............:'
     A          R FMT6
                                             CF23(23)
     A                                  1 31'Ajouter un utilisateur'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E6NM          10   I  5 27
     A            E6MAIL        20   I  6 27
     A            E6STATUS      10   I  8 27
     A            E6GENRE       10   I  7 27
     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 12'F12=Retour'
     A                                      COLOR(BLU)
     A                                  5  3'Nom...................:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  6  3'Mail..................:'
     A                                  7  3'Genre.................:'
     A                                  8  3'Status................:'
     A
```
