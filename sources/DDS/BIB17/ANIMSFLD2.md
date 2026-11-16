---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: ANIMSFLD2
type: DDS
longueur_enregistrement: 80
lignes: 89
modifie: 2026-11-16
---

# BIB17/QDDSSRC/ANIMSFLD2

```text
     A*%%TS  SD  20261027  114259  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A          R SFL1                      SFL
     A*%%TS  SD  20261026  155617  REMI        REL-V7R5M0  5770-WDS
     A            NOM       R        O  7  3REFFLD(PERSOF/NOM BIB17/PERSO)
     A            PRENOM    R        O  7 20REFFLD(PERSOF/PRENOM BIB17/PER-
     A                                      SO)
     A            UNINAME   R        O  7 37REFFLD(UNIVERSF/UNINAME BIB17/-
     A                                      UNIVERS)
     A            TMPAPPAR      20A  O  7 60
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261026  161523  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF05(05)
     A                                      CF12(12)
     A                                      CF10(10)
     A                                      OVERLAY
     A                                      ROLLUP(39)
     A  32                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0011)
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
     A          R FOOT
     A*%%TS  SD  20261027  114259  REMI        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Quitter   F12=Retour  F10=Choix-
     A                                       univers  F5=Raffraichir'
     A                                      COLOR(BLU)
     A                                 20 15'Nombre de personnages dans la list-
     A                                      e :'
     A                                      COLOR(YLW)
     A            RANG           4S 0O 20 54COLOR(YLW)
     A          R WDWSFLCH                  SFL
     A*%%TS  SD  20261027  110735  REMI        REL-V7R5M0  5770-WDS
     A            WDWOPT         1  0B  7  6
     A            UNINAME   R        O  7 12REFFLD(UNIVERSF/UNINAME BIB17/-
     A                                      UNIVERS)
     A            UNIVER         4  0H
     A          R WDWCTLCH                  SFLCTL(WDWSFLCH)
     A                                      CF12(12)
     A*%%TS  SD  20261027  110735  REMI        REL-V7R5M0  5770-WDS
     A  42                                  SFLDSP
     A  41                                  SFLDSPCTL
     A  40                                  SFLCLR
     A  43                                  SFLEND(*MORE)
     A                                      SFLSIZ(0006)
     A                                      SFLPAG(0005)
     A                                      WINDOW(4 8 15 65)
     A                                  5  5'Opt'
     A                                      COLOR(WHT)
     A                                  5 12'Univers'
     A                                      COLOR(WHT)
     A                                  3  5'1=Choisir'
     A                                      COLOR(BLU)
     A                                  1 26'Choix d''univers'
     A                                      COLOR(WHT)
     A          R FMT1
     A*%%TS  SD  20261027  150629  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF10(10)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 30'Selection de l''univers'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                 23  4'F3=Quitter   F10=Plus de choix'
     A                                      COLOR(BLU)
     A                                  8  5'Choisissez un anime'
     A                                      COLOR(WHT)
     A            CHOIX          2Y 0B  8 26SNGCHCFLD((*NUMROW 4))
     A                                      CHOICE(1 '>Dragon ball')
     A                                      CHOICE(8 '>Hunter x Hunter')
     A                                      CHOICE(11 '>Bleach')
     A                                      CHOICE(99 '>Tous')
```
