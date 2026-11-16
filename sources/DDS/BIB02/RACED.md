---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: RACED
type: DDS
longueur_enregistrement: 100
lignes: 313
modifie: 2026-11-16
---

# BIB02/QDDSRC/RACED

```text
     A*%%TS  SD  20220407  152238  JBORG       REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      REF(RACES/RACEP)
     A                                      INDARA
     A                                      ALTHELP(CA01)
     A                                      HLPTITLE('Aide courses')
     A                                      HELP
     A          R SFL1                      SFL
     A*%%TS  SD  20191217  160712  JBORG       REL-V7R3M0  5770-WDS
     A            OPT            1A  I  7  2
     A  85                                  DSPATR(PC)
     A  85                                  DSPATR(RI)
     A            ENORACE   R        O  7  4REFFLD(RACEFMT/NORACE)
     A            EDTRACE   R        O  7  9REFFLD(RACEFMT/DTRACE)
     A            ETPRACE   R        O  7 21REFFLD(RACEFMT/TPRACE)
     A            ENMRACE   R        O  7 26REFFLD(RACEFMT/NMRACE)
     A            EGRRACE   R        O  7 57REFFLD(RACEFMT/GRRACE)
     A            EDSRACE   R        O  7 60REFFLD(RACEFMT/DSRACE)
     A            ET1RACE   R        O  7 65REFFLD(RACEFMT/T1RACE)
     A            EP3RACE   R        O  7 75REFFLD(RACEFMT/P3RACE)
     A  70                                  COLOR(RED)
     A  71                                  COLOR(WHT)
     A                                      EDTCDE(Z)
     A            EFORME    R        H      REFFLD(RACEFMT/FORME)
     A            EVAINQ    R        H      REFFLD(RACEFMT/VAINQUEUR)
     A          R CTL1                      SFLCTL(SFL1)
     A                                      CA03(03)
     A                                      CA06(06)
     A                                      CA08(08)
     A*%%TS  SD  20191219  143215  JBORG       REL-V7R3M0  5770-WDS
     A                                      SFLSIZ(0015)
     A                                      SFLPAG(0014)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A                                      ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A          H                           HLPPNLGRP('GENERAL' *LIBL/RACEHLP)
     A                                      HLPARA(01 001 02 024)
     A          H                           HLPPNLGRP('NOM' *LIBL/RACEHLP)
     A                                      HLPARA(05 032 05 034)
     A          H                           HLPPNLGRP('CAT' *LIBL/RACEHLP)
     A                                      HLPARA(05 021 05 024)
     A            RRN1           4S 0H      SFLRCDNBR
     A                                  5  1'Opt'
     A                                      DSPATR(HI)
     A                                  5  6'N°'
     A                                      DSPATR(HI)
     A                                  5 32'Nom'
     A                                      DSPATR(HI)
     A                                  5 12'Date'
     A                                      DSPATR(HI)
     A                                  1 31'Gestion des Courses'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                       EDTCDE(Y)
     A                                  2  2'RACED'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  3 50'Afficher à partir de :'
     A            Z_NORACE  R        B  3 74REFFLD(RACEFMT/NORACE)
     A                                  5 56'Tp.'
     A                                      COLOR(WHT)
     A            Z_TYP     R        I  6 21REFFLD(RACEFMT/TPRACE)
     A                                  5 60'Dst.'
     A                                      COLOR(WHT)
     A                                  5 66'Temps'
     A                                      COLOR(WHT)
     A                                  5 75'Pos.'
     A                                      COLOR(WHT)
     A                                  5 21'Cat.'
     A                                      DSPATR(HI)
     A          R BAS1
     A*%%TS  SD  20191219  143215  JBORG       REL-V7R3M0  5770-WDS
     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 13'F6=Création'
     A                                      COLOR(BLU)
     A                                 23 25'F8=Impression'
     A                                      COLOR(BLU)
     A          R BASCREAT
     A*%%TS  SD  20191219  143215  JBORG       REL-V7R3M0  5770-WDS
     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 13'F12=Retour'
     A                                      COLOR(BLU)
     A          R FMT5
     A*%%TS  SD  20220407  152238  JBORG       REL-V7R4M0  5770-WDS
     A                                      WINDOW(*DFT 14 44)
     A                                      CA03(03)
     A                                      CA12(12)
     A                                      WDWTITLE((*TEXT 'Affichage Course'))
     A                                      WDWBORDER((*COLOR YLW) (*DSPATR RI)-
     A                                       (*CHAR '<.>::<.>'))
     A            E5NORACE  R        O  2 22REFFLD(RACEFMT/NORACE)
     A                                      DSPATR(HI)
     A            E5DTRACE  R        O  3 22REFFLD(RACEFMT/DTRACE)
     A                                      DSPATR(HI)
     A            LIBMOIS        9A  O  4 22DSPATR(HI)
     A            E5TPRACE  R        O  5 22REFFLD(RACEFMT/TPRACE)
     A                                      DSPATR(HI)
     A            E5NMRACE      10A  O  6 22DSPATR(HI)
     A            E5GRRACE  R        O  7 22REFFLD(RACEFMT/GRRACE)
     A                                      DSPATR(HI)
     A            E5DSRACE  R        O  8 22REFFLD(RACEFMT/DSRACE)
     A                                      DSPATR(HI)
     A            E5T1RACE  R        O  9 21REFFLD(RACEFMT/T1RACE)
     A                                      DSPATR(HI)
     A            E5FORME   R        O 10 21REFFLD(RACEFMT/FORME)
     A                                      DSPATR(HI)
     A            E5VAINQ   R        O 11 21REFFLD(RACEFMT/VAINQUEUR)
     A                                      DSPATR(HI)
     A                                  2  5'N° DE COURSE:'
     A                                  3  5'Date :'
     A                                  5  5'Catégorie'
     A                                  6  5'Nom'
     A                                  7  5'Type'
     A                                  8  5'Distance'
     A                                  9  5'Temps'
     A                                 10  5'Forme'
     A                                 11  5'Vainqueur'
     A          R FMT4
     A*%%TS  SD  20191219  143215  JBORG       REL-V7R3M0  5770-WDS
     A                                      CA03(03)
     A                                      CA12(12)
     A                                      CF23(23)
     A                                  1 31'Suppression des Courses'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'RACED'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E4NORACE  R        O  7 20REFFLD(RACEFMT/NORACE)
     A            E4DTRACE  R        O  8 20REFFLD(RACEFMT/DTRACE)
     A            E4TPRACE  R        O  9 20REFFLD(RACEFMT/TPRACE)
     A            E4NMRACE  R        O 10 20REFFLD(RACEFMT/NMRACE)
     A            E4GRRACE  R        O 11 20REFFLD(RACEFMT/GRRACE)
     A            E4DSRACE  R        O 12 20REFFLD(RACEFMT/DSRACE)
     A            E4T1RACE  R        O 13 20REFFLD(RACEFMT/T1RACE)
     A            E4P3RACE  R        O 14 20REFFLD(RACEFMT/P3RACE)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  7  3'N°'
     A                                  7  6'Course'
     A                                  7 13'...'
     A                                  7 17':'
     A                                  8  3'Date'
     A                                  8  8'........'
     A                                  8 17':'
     A                                  9  3'Catégorie'
     A                                  9 13'...'
     A                                  9 17':'
     A                                 10  3'Nom'
     A                                 10  7'.........'
     A                                 10 17':'
     A                                 11  3'Type'
     A                                 11  8'........'
     A                                 11 17':'
     A                                 12  3'Distance'
     A                                 12 12'....'
     A                                 12 17':'
     A                                 13  3'Temps'
     A                                 13  9'.......'
     A                                 13 17':'
     A                                 14  3'Position'
     A                                 14 12'....'
     A                                 14 17':'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(WHT)
     A            DTAECR1         L  B 16 20DATFMT(*ISO)
     A            E4NMRACE1 R   14      7 58REFFLD(RACEFMT/NMRACE)
     A                                      COLOR(TRQ)
     A          R FMT2
     A*%%TS  SD  20211110  112524  JBORG       REL-V7R4M0  5770-WDS
     A                                      CA03(03)
     A                                      CF23(23)
     A                                  1 25'Modification des Courses du type'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'RACED'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E2NORACE  R        O  7 20REFFLD(RACEFMT/NORACE)
     A            E2DTRACE  R        O  8 20REFFLD(RACEFMT/DTRACE)
     A            E2TPRACE  R        O  9 20REFFLD(RACEFMT/TPRACE)
     A            E2NMRACE  R        B 10 20REFFLD(RACEFMT/NMRACE)
     A                                      CHANGE(62)
     A            E2GRRACE  R        O 11 20REFFLD(RACEFMT/GRRACE)
     A            E2DSRACE  R        O 12 20REFFLD(RACEFMT/DSRACE)
     A            E2T1RACE  R        O 13 20REFFLD(RACEFMT/T1RACE)
     A            E2P3RACE  R        O 14 20REFFLD(RACEFMT/P3RACE)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  7  3'N°'
     A                                  7  6'Course'
     A                                  7 13'...'
     A                                  7 17':'
     A                                  8  3'Date'
     A                                  8  8'........'
     A                                  8 17':'
     A                                  9  3'Catégorie'
     A                                  9 13'...'
     A                                  9 17':'
     A                                 10  3'Nom'
     A                                 10  7'.........'
     A                                 10 17':'
     A                                 11  3'Type'
     A                                 11  8'........'
     A                                 11 17':'
     A                                 12  3'Distance'
     A                                 12 12'....'
     A                                 12 17':'
     A                                 13  3'Temps'
     A                                 13  9'.......'
     A                                 13 17':'
     A                                 14  3'Position'
     A                                 14 12'....'
     A                                 14 17':'
     A                                  2 33'F23=Confirmation'
     A          R FMT6
     A                                      CA03(03)
     A                                      CA12(12)
     A                                  1 31'Création des Courses'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'RACED'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  7  5'N° Course ... :'
     A            E6NORACE  R        B  7 22REFFLD(RACEFMT/NORACE)
     A            E6DTRACE  R        B  8 22REFFLD(RACEFMT/DTRACE)
     A            E6TPRACE  R        B  9 22REFFLD(RACEFMT/TPRACE)
     A  55                                  ERRMSGID(RAC0001 RACEMSG)
     A            E6NMRACE  R        B 10 22REFFLD(RACEFMT/NMRACE)
     A            E6GRRACE  R        B 11 22REFFLD(RACEFMT/GRRACE)
     A            E6DSRACE  R        B 12 22REFFLD(RACEFMT/DSRACE)
     A            E6T1RACE  R        B 13 22REFFLD(RACEFMT/T1RACE)
     A            E6P3RACE  R        B 14 22REFFLD(RACEFMT/P3RACE)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  8  5'Date ........ :'
     A                                  9  5'Catégorie ... :'
     A                                 10  5'Nom ......... :'
     A                                 11  5'Type ........ :'
     A                                 12  5'Distance .... :'
     A                                 13  5'Temps ....... :'
     A                                 14  5'Position .... :'
     A          R FMT7
     A                                      CA03(03)
     A                                      CA12(12)
     A                                  1 31'Création des Courses'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'RACED'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  7  5'N° Course ... :'
     A            E6NORACE  R        B  7 22REFFLD(RACEFMT/NORACE)
     A            E6DTRACE  R        B  8 22REFFLD(RACEFMT/DTRACE)
     A            E6TPRACE  R        B  9 22REFFLD(RACEFMT/TPRACE)
     A  55                                  ERRMSGID(RAC0001 RACEMSG)
     A            E6NMRACE  R        B 10 22REFFLD(RACEFMT/NMRACE)
     A            E6GRRACE  R        B 11 22REFFLD(RACEFMT/GRRACE)
     A            E6DSRACE  R        B 12 22REFFLD(RACEFMT/DSRACE)
     A            E6T1RACE  R        B 13 22REFFLD(RACEFMT/T1RACE)
     A            E6P3RACE  R        B 14 22REFFLD(RACEFMT/P3RACE)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  8  5'Date ........ :'
     A                                  9  5'Catégorie ... :'
     A                                 10  5'Nom ......... :'
     A                                 11  5'Type ........ :'
     A                                 12  5'Distance .... :'
     A                                 13  5'Temps ....... :'
     A                                 14  5'Position .... :'
     A*%%RS+<record-sequences>
     A*%%RS+ <sequence name="Sans titre">
     A*%%RS+  <device type="display" width="80" height="24" />
     A*%%RS+ </sequence>
     A*%%RS+ <sequence name="Sans titre1">
     A*%%RS+  <device type="display" width="80" height="24" />
     A*%%RS+ </sequence>
     A*%%RS </record-sequences>
```
