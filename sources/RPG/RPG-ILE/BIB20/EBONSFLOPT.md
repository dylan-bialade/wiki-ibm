---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: EBONSFLOPT
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 182
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/EBONSFLOPT

```text
     A*%%TS  SD  20251113  112938  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      HLPTITLE('Aide pour les cons')
     A                                      ALTHELP(CA01)
     A                                      INDARA
     A                                      HELP
     A          R EBONSFLF                  SFL
     A*%%TS  SD  20251103  114435  GGEOFFREY   REL-V7R5M0  5770-WDS
     A  77                                  SFLNXTCHG
     A            OPT            1S 0B 10  3VALUES(2 4 5)
                                            CHECK(AB)
     A            NUMBB     R        O 10 32REFFLD(FBONBON/NUMBB BIB20/BONBON)
     A  50                                  COLOR(RED)
     A N50                                  COLOR(GRN)
     A            NOM       R        O 10  9REFFLD(FBONBON/NOM BIB20/BONBON)
     A            MARQUE    R        O 10 44REFFLD(FBONBON/MARQUE BIB20/BONBON)
     A            COULEU    R        O 10 69REFFLD(FBONBON/COULEU BIB20/BONBON)
     A          R EBONCTL                   SFLCTL(EBONSFLF)
     A*%%TS  SD  20251113  112938  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      OVERLAY
     A                                      CA06(06)
     A                                      CA03(03)
     A                                      CA07(07)
     A                                      CA13(13)
     A                                      ROLLUP(29)
     A  30                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A          H                           HLPPNLGRP(TITRE BONBONHLP)
     A                                      HLPARA(01 001 02 024)
     A          H                           HLPPNLGRP(OPT BONBONHLP)
     A                                      HLPARA(08 003 19 004)
     A          H                           HLPPNLGRP(NOM BONBONHLP)
     A                                      HLPARA(08 008 19 028)
     A          H                           HLPPNLGRP(NUMBB BONBONHLP)
     A                                      HLPARA(08 032 19 037)
     A          H                           HLPPNLGRP(MARQUE BONBONHLP)
     A                                      HLPARA(08 044 19 063)
     A          H                           HLPPNLGRP(COULEUR BONBONHLP)
     A                                      HLPARA(08 069 19 078)
     A            SCROLL         5S 0H      SFLSCROLL
     A            RANG           4S 0H      SFLRCDNBR
     A                                  7 34'N°'
     A                                      COLOR(WHT)
     A                                  7 16'Nom'
     A                                      COLOR(WHT)
     A                                  7 50'Marque'
     A                                      COLOR(WHT)
     A                                  7 70'Couleur'
     A                                      COLOR(WHT)
     A                                  1 38'Bonbon'
     A                                      COLOR(WHT)
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  2  3'Agrion'
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  4 34'Rechercher à partir de:'
     A                                      COLOR(WHT)
     A            SEARCH        20A  B  4 58COLOR(WHT)
     A                                      CHECK(LC)
     A                                  7  3'Opt'
     A                                      COLOR(WHT)
     A  55        MSGTEXT      100   M
     A                                  5  4'Option :'
     A                                      COLOR(BLU)
     A                                  6  4'2=Modifier  4=Supprimer  5=Affiche-
     A                                      r'
     A                                      COLOR(BLU)
     A            TRIMARQUE     20   B  8 44
     A            TRICOULEU     10   B  8 69
     A          R CREATION
     A*%%TS  SD  20251103  163331  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      WINDOW(4 22 16 35)
     A                                      CA12(12)
     A                                      CA03(03)
     A                                      OVERLAY
     A                                      WDWBORDER((*COLOR PNK) (*DSPATR RI)-
     A                                       (*CHAR '        '))
     A                                  1 10'Ajouter un bonbon'
     A                                      COLOR(WHT)
     A                                  3  2'N° bonbon :'
     A            NUMBB     R        B  3 14REFFLD(FBONBON/NUMBB BIB20/BONBON)
     A                                      CHECK(ME)
     A                                  5  2'Nom . . . :'
     A            NOM       R        B  5 14REFFLD(FBONBON/NOM BIB20/BONBON)
     A                                      CHECK(ME)
     A                                      CHECK(LC)
     A            MARQUE    R        B  7 14REFFLD(FBONBON/MARQUE BIB20/BONBON)
     A                                      CHECK(ME)
     A                                      CHECK(LC)
     A            COULEU    R        B  9 14REFFLD(FBONBON/COULEU BIB20/BONBON)
     A                                      CHECK(ME)
     A                                      CHECK(LC)
     A            PRIX      R        B 11 14REFFLD(FBONBON/PRIX BIB20/BONBON)
     A                                      CHECK(ME)
     A                                      EDTCDE(Q)
     A                                  7  2'Marque  . :'
     A                                  9  2'Couleur . :'
     A                                 11  2'Prix  . . :'
     A                                 15  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 15 18'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 11 22'€'
     A            MSGCREA       33A  O 13  2
     A N90                                  COLOR(WHT)
     A  90                                  COLOR(RED)
     A          R EXIT
     A*%%TS  SD  20251107  093843  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                 23 14'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 30'F6=Créer'
     A                                      COLOR(BLU)
     A                                 23 43'F7=Impression'
     A                                      COLOR(BLU)
     A                                 23  3'F1=Aide'
     A                                      COLOR(BLU)
     A                                 23 59'F13=Choix fichier'
     A                                      COLOR(BLU)
     A          R MODIF
     A*%%TS  SD  20251104  120551  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CA12(12)
     A                                      CA03(03)
     A                                      OVERLAY
     A                                      WINDOW(4 22 8 35)
     A                                      WDWBORDER((*COLOR BLU) (*DSPATR RI)-
     A                                       (*CHAR '        '))
     A                                  1 10'Modifier un bonbon'
     A                                      COLOR(WHT)
     A                                  5  3'Nom :'
     A                                  3  3'N°  :'
     A            NUMBB     R        O  3  9REFFLD(FBONBON/NUMBB BIB20/BONBON)
     A            NOM       R        B  5  9REFFLD(FBONBON/NOM BIB20/BONBON)
     A                                  7  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                  7 15'F12=Annuler'
     A                                      COLOR(BLU)
     A          R AFFICHE
     A*%%TS  SD  20251103  163331  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      WINDOW(4 22 16 35)
     A                                      WDWTITLE((*TEXT 'DÉTAILS D''UN BONB-
                                            ON') (*COLOR WHT))
     A                                      CA12(12)
     A                                      CA03(03)
     A                                      WDWBORDER((*COLOR TRQ) (*DSPATR RI)-
     A                                       (*CHAR '        '))
     A                                  3  2'N° bonbon :'
     A            NUMBB     R        O  3 14REFFLD(FBONBON/NUMBB BIB20/BONBON)
     A                                  5  2'Nom . . . :'
     A            NOM       R        O  5 14REFFLD(FBONBON/NOM BIB20/BONBON)
     A            MARQUE    R        O  7 14REFFLD(FBONBON/MARQUE BIB20/BONBON)
     A            COULEU    R        O  9 14REFFLD(FBONBON/COULEU BIB20/BONBON)
     A            PRIX      R        O 11 14REFFLD(FBONBON/PRIX BIB20/BONBON)
     A                                      EDTCDE(Q)
     A                                  7  2'Marque  . :'
     A                                  9  2'Couleur . :'
     A                                 11  2'Prix  . . :'
     A                                 15  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 15 18'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 11 22'€'
     A          R CHOOSEFILE                WINDOW(2 28 4 37)
                                            CA03(03)
                                            CA12(12)
     A                                      WDWBORDER((*COLOR RED) (*DSPATR RI)-
     A                                       (*CHAR '        '))
     A                                      WDWTITLE((*TEXT 'CHOIX FICHIER') +
     A                                      *TOP *CENTER)
     A            FILE          10   B  2 26
     A            BIB           10   B  3 26
     A                                  2  3'FICHIER BD . . . . :'
     A                                  3  6'BIBLIOTHEQUE  . :'
```
