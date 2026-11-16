---
bibliotheque: BIB12
fichier_source: QDDSSRC
membre: ANIME
type: DDS
longueur_enregistrement: 100
lignes: 62
modifie: 2026-11-16
---

# BIB12/QDDSSRC/ANIME

```text
     A*%%TS  SD  20261027  093742  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Exit')
     A          R FMT1
     A*%%TS  SD  20261026  142411  XUAN        REL-V7R5M0  5770-WDS
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                  2 73TIME
     A                                  1 30'Selection de l''univers'
     A                                      COLOR(WHT)
     A                                  7  8'Choisissez un anime :'
     A                                      COLOR(WHT)
     A                                 23  4'F3=Quitter'
     A                                      COLOR(BLU)
     A            ANIMEC         2Y 0B  7 40SNGCHCFLD
     A                                      CHOICE(1 'Dragon Ball')
     A                                      CHOICE(2 'One Piece')
     A                                      CHOICE(3 'Naruto')
     A                                      CHOICE(4 'Tout')
     A          R SFL1                      SFL
     A*%%TS  SD  20261027  093742  XUAN        REL-V7R5M0  5770-WDS
     A            NOM       R        O  6  3REFFLD(PERSOF/NOM BIB12/PERSO)
     A            PRENOM    R        O  6 21REFFLD(PERSOF/PRENOM BIB12/PERSO)
     A            W_UNI         20A  O  6 38
     A            W_TEMPS       20A  O  6 60
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261026  165618  XUAN        REL-V7R5M0  5770-WDS
     A                                      CA12(12 'annuler')
     A                                      OVERLAY
     A  83                                  SFLDSP
     A  82                                  SFLDSPCTL
     A  80                                  SFLCLR
     A  81                                  SFLEND(*MORE)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 28'Affichage des personnages'
     A                                      COLOR(WHT)
     A                                  5  3'Nom'
     A                                      COLOR(WHT)
     A                                  5 21'Prénom'
     A                                      COLOR(WHT)
     A                                  5 42'Univers'
     A                                      COLOR(WHT)
     A                                  5 58'Temps d''apparition'
     A                                      COLOR(WHT)
     A          R FOOT
     A*%%TS  SD  20261026  161633  XUAN        REL-V7R5M0  5770-WDS
     A                                 23  4'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 21'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 21 20' Nombre de personnages dans la lis-
     A                                      te:'
     A            NBPRESO        5S 0O 21 58
```
