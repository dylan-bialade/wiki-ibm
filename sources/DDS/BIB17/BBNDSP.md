---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: BBNDSP
type: DDS
longueur_enregistrement: 80
lignes: 94
modifie: 2026-11-16
---

# BIB17/QDDSSRC/BBNDSP

```text
     A*%%TS  SD  20261013  142717  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R SFL1                      SFL
     A*%%TS  SD  20261012  152239  REMI        REL-V7R5M0  5770-WDS
     A            NOM       R        O  7  8REFFLD(FBONBON/NOM BIB17/BONBO-
     A                                      N)
     A            MARQUE    R        O  7 29REFFLD(FBONBON/MARQUE BIB17/BO-
     A                                      NBON)
     A            COULEUR   R        O  7 50REFFLD(FBONBON/COULEUR BIB17/B-
     A                                      ONBON)
     A            PRIX      R        O  7 62REFFLD(FBONBON/PRIX BIB17/BONB-
     A                                      ON)
     A                                      EDTWRD(' 0 ,  €')
     A            NUMBER    R        O  7 72REFFLD(FBONBON/NUMBER BIB17/BO-
     A                                      NBON)
     A            D1OPT          1A  B  7  4
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261013  142717  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF06(06)
     A  82                                  SFLDSP
     A  81                                  SFLDSPCTL
     A  80                                  SFLCLR
     A  83                                  SFLEND(*MORE)
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0011)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 32'liste des bonbons'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  6  3'Opt'
     A                                      COLOR(BLU)
     A                                  6  8'Nom'
     A                                      COLOR(BLU)
     A                                  6 29'Marque'
     A                                      COLOR(BLU)
     A                                  6 50'Couleur'
     A                                      COLOR(BLU)
     A                                  6 62'Prix'
     A                                      COLOR(BLU)
     A                                  6 72'Number'
     A                                      COLOR(BLU)
     A                                  4  4'Filtre nom:'
     A            FLTNOM        20A  B  4 17CHECK(LC)
     A                                      CHANGE(70)
     A                                  5  5'2=Modifier 4=Supprimer 5=Afficher'
     A                                      COLOR(BLU)
     A          R FOOT
     A*%%TS  SD  20261012  133702  REMI        REL-V7R5M0  5770-WDS
     A                                 22  3'F3=quitter'
     A                                      COLOR(BLU)
     A          R MODBBN
     A*%%TS  SD  20261013  113434  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF20(20)
     A                                      CF12(12)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 32'Gestion de bonbons'
     A                                      COLOR(WHT)
     A            MODMOD        15A  O  2 33
     A                                  8 10'Nom....:'
     A                                 10 10'Marque.:'
     A                                 12 10'Couleur:'
     A                                 14 10'Prix...:'
     A  49                             16 10'Number.:'
     A            NOM       R        B  8 19REFFLD(FBONBON/NOM BIB17/BONBO-
     A                                      N)
     A  50                                  DSPATR(PR)
     A  40                                  ERRMSG('Nom obligatoire' 40)
     A            MARQUE    R        B 10 19REFFLD(FBONBON/MARQUE BIB17/BO-
     A                                      NBON)
     A  50                                  DSPATR(PR)
     A  41                                  ERRMSG('Marque obligatoire' 41)
     A            COULEUR   R        B 12 19REFFLD(FBONBON/COULEUR BIB17/B-
     A                                      ONBON)
     A  50                                  DSPATR(PR)
     A  42                                  ERRMSG('couleur obligatoire' 42)
     A            PRIX      R        B 14 19REFFLD(FBONBON/PRIX BIB17/BONB-
     A                                      ON)
     A  50                                  DSPATR(PR)
     A  43                                  ERRMSG('Prix obligatoire' 43)
     A  49        NUMBER    R        B 16 19REFFLD(FBONBON/NUMBER BIB17/BO-
     A                                      NBON)
     A                                      DSPATR(PR)
     A                                 22  5'F3=Quitter F12=Retour F20=imprimer'
     A                                      COLOR(BLU)
```
