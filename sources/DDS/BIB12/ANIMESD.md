---
bibliotheque: BIB12
fichier_source: QDDSSRC
membre: ANIMESD
type: DDS
longueur_enregistrement: 100
lignes: 124
modifie: 2026-11-16
---

# BIB12/QDDSSRC/ANIMESD

```text
     A*%%TS  SD  20261028  162722  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Exit')
     A          R FMT1
     A*%%TS  SD  20261028  131719  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF10(10 'choix')
     A                                      CF22(22 'V2')
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
     A                                      CHOICE(9 'Fullmetal Alchemist')
     A                                      CHOICE(10 'Sword Art Online')
     A                                      CHOICE(13 'Fairy Tail')
     A                                      CHOICE(99 'Tout')
     A                                 23 21'F10=Choix univers'
     A                                      COLOR(BLU)
     A                                 23 43'F22=Choix V2'
     A                                      COLOR(BLU)
     A          R SFL1                      SFL
     A*%%TS  SD  20261028  091602  XUAN        REL-V7R5M0  5770-WDS
     A            W_NOM         15   O  6  2
     A            W_PRENOM      15   O  6 19
     A            W_UNIPREV     20   O  6 36
     A            W_TEMPS       20   O  6 58
     A            W_UNI        100   O  7 11
     A                                  7  2'Univers:'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261028  131704  XUAN        REL-V7R5M0  5770-WDS
     A                                      CA12(12 'annuler')
     A                                      ROLLUP(84)
     A                                      CA05(05 'refresh')
     A                                      CF10(10)
     A                                      CF22(22 'animev2')
                                            CA08(08)
     A                                      OVERLAY
     A  83                                  SFLDSP
     A  82                                  SFLDSPCTL
     A  80                                  SFLCLR
     A  81                                  SFLEND(*MORE)
     A                                      SFLDROP(CA11)
     A                                      SFLSIZ(0006)
     A                                      SFLPAG(0005)
     A            W_CURSOR       4S 0H      SFLRCDNBR
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
     A*%%TS  SD  20261028  091602  XUAN        REL-V7R5M0  5770-WDS
     A                                 23  4'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 21'F12=Annuler'
     A                                      COLOR(BLU)
     A            NBPRESO        5Y 0O 22 58COLOR(YLW)
     A                                      EDTCDE(3)
     A                                 23 36'F10=Choix anime'
     A                                      COLOR(BLU)
     A                                 23 67'F22=Choix V2'
     A                                      COLOR(BLU)
     A                                 23 53'F11=detail'
     A                                      COLOR(BLU)
     A                                 22 21'Nombre de personnages dans la list-
     A                                      e:'
     A                                      COLOR(YLW)
     A          R ANICHOIX                  SFL
     A*%%TS  SD  20261028  160650  XUAN        REL-V7R5M0  5770-WDS
     A            F_OPT          1A  B  8  1
     A            F_UNICDE       9S 0H
     A            F_UNI1        37A  O  8  3
     A            F_UNI2        37A  O  9  3
     A            F_UNI3        37A  O 10  3
     A          R CTL2                      SFLCTL(ANICHOIX)
     A*%%TS  SD  20261028  162722  XUAN        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0005)
     A                                      SFLPAG(0004)
     A                                      WINDOW(1 35 21 40)
     A                                      CA12(12 'annuler')
     A                                      ROLLUP(84)
     A  63                                  SFLDSP
     A  62                                  SFLDSPCTL
     A  60                                  SFLCLR
     A  61                                  SFLEND(*MORE)
     A                                      SFLDROP(CA11)
     A            F_CURSOR       4S 0H      SFLRCDNBR
     A                                  1 12'Choix de l''univers'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A                                  5  1'Selectionnez vos univers: 1 puis'
     A                                      COLOR(BLU)
     A                                  6  3'appuyez sur ENTREE'
     A                                      COLOR(BLU)
     A                                  7  1'Opt'
     A                                      COLOR(WHT)
     A                                  7  9'Univers'
     A                                      COLOR(WHT)
     A                                  6 22'F11=Detail'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  3  1'Filtre nom univers:'
     A                                      COLOR(BLU)
     A            F_FILTRE      20A  B  3 21CHECK(LC)
```
