---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: ANIMSFLD3
type: DDS
longueur_enregistrement: 80
lignes: 123
modifie: 2026-11-16
---

# BIB17/QDDSSRC/ANIMSFLD3

```text
     A*%%TS  SD  20261030  093609  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A          R SFL1                      SFL
     A*%%TS  SD  20261028  094009  REMI        REL-V7R5M0  5770-WDS
     A            NOM       R        O  7  2REFFLD(PERSOF/NOM BIB17/PERSO)
     A            PRENOM    R        O  7 18REFFLD(PERSOF/PRENOM BIB17/PER-
     A                                      SO)
     A            UNIAPR    R        O  7 34REFFLD(UNIVERSF/UNINAME BIB17/-
     A                                      UNIVERS)
     A            TMPAPPAR      22A  O  7 58
     A            UNINAM1       50A  O  8  7
     A            UNINAM2       50A  O  9  7
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261030  093609  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF05(05)
     A                                      CF12(12)
     A                                      CF10(10)
     A                                      ROLLUP(39)
     A                                      CF22(22)
     A                                      CF08(08)
     A                                      OVERLAY
     A  32                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                      SFLDROP(CF11)
     A                                      SFLSIZ(0005)
     A                                      SFLPAG(0004)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 26'Affichage des personnages'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  5  3'Nom'
     A                                      COLOR(WHT)
     A            RCDNBR         4S 0H      SFLRCDNBR(CURSOR)
     A                                  5 18'Prénom'
     A                                      COLOR(WHT)
     A                                  5 34'Univers apercu'
     A                                      COLOR(WHT)
     A                                  5 58'Temps apparition'
     A                                      COLOR(WHT)
     A          R FOOT
     A*%%TS  SD  20261030  093609  REMI        REL-V7R5M0  5770-WDS
     A                                 22  3'F3=Quitter   F12=Retour  F10=Choix-
     A                                       univers  F5=Raffraichir  F11=Dépli-
     A                                      er'
     A                                      COLOR(BLU)
     A                                 20 15'Nombre de personnages dans la list-
     A                                      e :'
     A                                      COLOR(YLW)
     A            RANG           4S 0O 20 54COLOR(YLW)
     A                                 23  3'F22=Universv2  F8=Imprimer'
     A                                      COLOR(BLU)
     A          R WDWSFLCH                  SFL
     A*%%TS  SD  20261028  094009  REMI        REL-V7R5M0  5770-WDS
     A            WDWOPT         1S 0B  6  3
     A            WUNIVID        9S 0H
     A            UNINAM2       50   O  7  7
     A            UNINAM1       50   O  6  7
     A          R WDWCTLCH                  SFLCTL(WDWSFLCH)
     A*%%TS  SD  20261029  090809  REMI        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0005)
     A                                      SFLPAG(0004)
     A                                      WINDOW(4 8 15 65)
     A                                      CF12(12)
     A                                      ROLLUP(49)
     A  42                                  SFLDSP
     A  41                                  SFLDSPCTL
     A  40                                  SFLCLR
     A  43                                  SFLEND(*MORE)
     A                                      SFLDROP(CF11)
     A                                  5  2'Opt'
     A                                      COLOR(WHT)
     A                                  5  7'Univers'
     A                                      COLOR(WHT)
     A                                  4  3'1=Choisir'
     A                                      COLOR(BLU)
     A                                  1 26'Choix d''univers'
     A                                      COLOR(WHT)
     A            WRCDNBR        4S 0H      SFLRCDNBR(CURSOR)
     A                                  3  4'Recherche:'
     A            FLTUNIV       40A  B  3 15CHANGE(44)
     A          R FMT1
     A*%%TS  SD  20261028  100323  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF10(10)
     A                                      CF22(22)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 30'Selection de l''univers'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                 23  4'F3=Quitter   F10=Plus de choix  F2-
     A                                      2=Universv2'
     A                                      COLOR(BLU)
     A                                  8  5'Choisissez un anime'
     A                                      COLOR(WHT)
     A            CHOIX          2Y 0B  8 26SNGCHCFLD((*NUMROW 4))
     A                                      CHOICE(1 '>Dragon ball')
     A                                      CHOICE(8 '>Hunter x Hunter')
     A                                      CHOICE(11 '>Bleach')
     A                                      CHOICE(99 '>Tous')
     A          R WDWNOTIF                  WINDOW(7 15 10 50)
     A                                      WDWBORDER((*COLOR TRQ) (*DSPATR RI))
     A                                      WDWTITLE((*TEXT 'Notification') +
     A                                      *TOP *CENTER)
     A            NOTIFMSG     294   B  3  2CNTFLD(49)
     A*%%RS+<record-sequences>
     A*%%RS+ <sequence name="Sans titre">
     A*%%RS+  <device type="display" width="80" height="24" />
     A*%%RS+ </sequence>
     A*%%RS+ <sequence name="Sans titre1">
     A*%%RS+  <device type="display" width="80" height="24" />
     A*%%RS+ </sequence>
     A*%%RS </record-sequences>
```
