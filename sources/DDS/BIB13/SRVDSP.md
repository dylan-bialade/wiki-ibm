---
bibliotheque: BIB13
fichier_source: QDDSSRC
membre: SRVDSP
type: DDS
longueur_enregistrement: 80
lignes: 49
modifie: 2026-11-16
---

# BIB13/QDDSSRC/SRVDSP

```text
     A*%%TS  SD  20261105  105706  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Exit')
     A          R MNU
     A*%%TS  SD  20261105  105706  XUAN        REL-V7R5M0  5770-WDS
     A                                  1 24'Analyse d''un programme de service'
     A                                      COLOR(WHT)
     A                                  4  8'Programme de service . :'
     A                                  5 10'Bibliothèque . . . . :'
     A            M_PGM         10   B  4 34
     A            M_LIB         10   B  5 34
     A                                  4 46'Nom'
     A                                  5 46'Nom, *LIBL'
     A                                 23  4'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 18'Entree=Valider'
     A                                      COLOR(BLU)
     A          R WIN
     A*%%TS  SD  20261105  105706  XUAN        REL-V7R5M0  5770-WDS
     A                                      CA12(12 'retour')
     A                                      WINDOW(7 14 10 55)
     A                                  1  3'Programme de service . :'
     A                                  2  5'Bibliothèque . . . . :'
     A            W_PGM         10   O  1 30COLOR(WHT)
     A            W_LIB         10   O  2 30COLOR(WHT)
     A                                  4  3'1. Programmes liés à ce programme -
     A                                      de service'
     A                                  5  3'2. Modules du programme de service'
     A                                  6  3'3. Procedures exportées'
     A                                  8  3'Choix . . . . . . . .  :'
     A            W_CHX          1   B  8 29
     A                                 10  4'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 10 19'F12=Retour'
     A                                      COLOR(BLU)
     A          R MOD                       SFL
     A*%%TS  SD  20261105  105706  XUAN        REL-V7R5M0  5770-WDS
     A          R CTLMOD                    SFLCTL(MOD)
     A*%%TS  SD  20261105  105706  XUAN        REL-V7R5M0  5770-WDS
     A                                      OVERLAY
     A  33                                  SFLDSP
     A  32                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  31                                  SFLEND
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0011)
     A N33                                  SFLMSG('(Aucun module lié a se SRVP-
     A                                      GM)' 33)
```
