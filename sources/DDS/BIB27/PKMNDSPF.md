---
bibliotheque: BIB27
fichier_source: QDDSSRC
membre: PKMNDSPF
type: DDS
longueur_enregistrement: 160
lignes: 84
modifie: 2026-11-25
---

# BIB27/QDDSSRC/PKMNDSPF

```text
     A*%%TS  SD  20210414  152704  SYLVAIN     REL-V7R4M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(27 132 *DS4)                      A                                      CA03(03 'Exit')
     A                                      CA05(05 'Réafficher')
     A          R SFL1                      SFL                                      A            OPT            1A  I  7  2
     A            E1NAME        20A  O  7  7                                         A            E1TYPE1       10A  O  7 28
     A            E1TYPE2       10A  O  7 39                                         A            E1TALENT      20A  O  7 50
     A            E1PV           3S 0O  7 71                                         A            E1ATK          3S 0O  7 75
     A            E1DEF          3S 0O  7 79                                         A            E1ATS          3S 0O  7 83
     A            E1DFS          3S 0O  7 87                                         A            E1VIT          3S 0O  7 91
                                                                                     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)                             A                                      SFLPAG(0012)
     A                                      OVERLAY                                  A N31                                  SFLDSPCTL
     A N32                                  SFLDSP                                   A  31                                  SFLCLR
     A  61                                  SFLMSG('Vide')                           A N90                                  ROLLUP(39)
     A  90                                  SFLEND(*MORE)                            A            RANG           4S 0H      SFLRCDNBR
     A                                  6  7'Pokémon'                                A                                      DSPATR(HI)
     A                                  6 28'Type1'                                  A                                      DSPATR(HI)
     A                                  6 71'PV'                                     A                                      DSPATR(HI)
     A                                  6 50'Talent'                                 A                                      DSPATR(HI)
     A                                  1  2'SFDSPSQL'                               A                                  1 71DATE
     A                                      EDTCDE(Y)                                A                                  2 71TIME
     A                                  1 25'Sous-fichier Dynamique API'             A                                      DSPATR(HI)
     A                                  6  2'Opt'                                    A                                      DSPATR(HI)
     A                                  3  2'Indiquez vos options, puis appuyez-     A                                       sur ENTREE.'
     A                                      COLOR(BLU)                               A                                  4  3'2=Editer'
     A                                      COLOR(BLU)                               A                                  4 14'4=Supprimer'
     A                                      COLOR(BLU)                               A                                  6 39'Type2'
     A                                      DSPATR(HI)                               A                                  6 75'ATK'
     A                                      DSPATR(HI)                               A                                  6 79'DEF'
     A                                      DSPATR(HI)                               A                                  6 83'ATS'
     A                                      DSPATR(HI)                               A                                  6 87'DFS'
     A                                      DSPATR(HI)                               A                                  6 91'VIT'
     A                                      DSPATR(HI)                               A          R FKEY1
     A                                 23  2'F3=Exit'                                A                                      COLOR(BLU)
     A                                 23 13'F5=Réafficher'                          A                                      COLOR(BLU)
     A          R FMT4                                                               A                                      CF23(23)
     A                                  1 27'Suppression d''un utilisateur'          A                                      COLOR(WHT)
     A                                  1  2USER                                     A                                      COLOR(BLU)
     A                                  1 73DATE                                     A                                      COLOR(BLU)
     A                                  2  2'USER API'                               A                                      COLOR(BLU)
     A                                  2 72TIME                                     A                                      COLOR(BLU)
     A            E4IDUSER      20A  O  7 21                                         A            E4NAME        20A  O  8 21
     A            E4STATUS      20A  O  9 21                                         A            E4GENDER      20A  O 10 21
     A            E1EMAIL       30A  O 11 21                                         A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)                               A                                 23 14'F12=Annuler'
     A                                      COLOR(BLU)                               A                                  7  3'IdUser'
     A                                  7 17':'                                      A                                  8  3'Name'
     A                                  8 17':'                                      A                                  9  3'Status'
     A                                  9 17':'                                      A                                 10  3'Gender'
     A                                 10 17':'                                      A                                  2 30'F23=Confirmation'
     A                                      COLOR(RED)                               A                                 11  3'Email'
     A                                 11 17':'                                      A          R FMT2
     A                                      CF23(23)                                 A                                  1 27'Modification d''un user'
     A                                      COLOR(WHT)                               A                                  1  2USER
     A                                      COLOR(BLU)                               A                                  1 73DATE
     A                                      COLOR(BLU)                               A                                  2  2'ENTREPOT'
     A                                      COLOR(BLU)                               A                                  2 72TIME
     A                                      COLOR(BLU)                               A            E2IDUSER      20A  O  7 21
     A            E2NAME        20A  B  8 21CHECK(LC)                                A            E2STATUS      20A  B  9 21CHECK(LC)
     A            E2GENDER      20A  B 10 21CHECK(LC)                                A            E2EMAIL       30A  B 11 21CHECK(LC)
     A                                 23  2'F3=Exit'                                A                                      COLOR(BLU)
     A                                 23 14'F12=Annuler'                            A                                      COLOR(BLU)
     A                                  7  3'IdUser'                                 A                                  7 17':'
     A                                  8  3'Name'                                   A                                  8 17':'
     A                                  9  3'Status'                                 A                                  9 17':'
     A                                 10  3'Gender'                                 A                                 10 17':'
     A                                  2 30'F23=Confirmation'                       A                                      COLOR(RED)
     A                                 11  3'Email'                                  A                                 11 17':'
     A          R FMT6                                                               A                                      CF23(23)
     A                                  1 27'Création d''un User'                    A                                      COLOR(WHT)
     A                                  1  2USER                                     A                                      COLOR(BLU)
     A                                  1 73DATE                                     A                                      COLOR(BLU)
     A                                  2  2'ENTREPOT'                               A                                      COLOR(BLU)
     A                                  2 72TIME                                     A                                      COLOR(BLU)
     A            E6NAME        20A  I  8 21CHECK(LC)                                A            E6STATUS      20A  I  9 21CHECK(LC)
     A            E6GENDER      20A  I 10 21CHECK(LC)                                A            E6EMAIL       30A  I 11 21CHECK(LC)
     A                                 23  2'F3=Exit'                                A                                      COLOR(BLU)
     A                                 23 14'F12=Annuler'                            A                                      COLOR(BLU)
     A                                  8  3'Name'                                   A                                  8 17':'
     A                                  9  3'Status'                                 A                                  9 17':'
     A                                 10  3'Gender'                                 A                                 10 17':'
     A                                      COLOR(GRN)                               A                                  2 29'F23=Confirmation'
     A                                      COLOR(RED)                               A                                 11  3'Email'
     A                                 11 17':'                                      A                                      COLOR(GRN)
```
