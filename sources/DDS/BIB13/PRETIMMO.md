---
bibliotheque: BIB13
fichier_source: QDDSSRC
membre: PRETIMMO
type: DDS
longueur_enregistrement: 80
lignes: 83
modifie: 2026-11-16
---

# BIB13/QDDSSRC/PRETIMMO

```text
     A*%%TS  SD  20261104  161332  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'exit')
     A          R FMT1
     A*%%TS  SD  20261104  112819  XUAN        REL-V7R5M0  5770-WDS
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  2TIME
     A                                  1 70USER
     A                                  2 70SYSNAME
     A                                  1 28'Calcul de pret immobilier'
     A                                      COLOR(WHT)
     A                                  9  4'Vous avez choisi les annuités cons-
     A                                      tantes :'
     A                                      COLOR(BLU)
     A                                 10  9'Montant :'
     A                                      COLOR(WHT)
     A                                 11  9'Durée   :'
     A                                      COLOR(WHT)
     A                                 12  9'Taux    :'
     A                                      COLOR(WHT)
     A            F_MONTANT     10  0B 10 20
     A                                 10 34'(€)'
     A                                      COLOR(WHT)
     A            F_DUREE        3  0B 11 20
     A                                 11 34'(année)'
     A                                      COLOR(WHT)
     A            F_TAUX         4  2B 12 20EDTWRD('  .  ')
     A                                 12 34'(%)'
     A                                      COLOR(WHT)
     A                                 23  4'F3=Exit'
     A                                      COLOR(BLU)
     A          R SFL1                      SFL
     A*%%TS  SD  20261104  161332  XUAN        REL-V7R5M0  5770-WDS
     A            S_MOIS         3Y 0O 10  5EDTCDE(4)
     A            S_CAP         12Y 2O 10 11EDTWRD(' .   .   .   ,  &€')
     A            S_INTR         6Y 2O 10 33EDTWRD(' .   ,  &€')
     A            S_CAPR         6Y 2O 10 47EDTWRD(' .   ,  &€')
     A            S_MENS         6Y 2O 10 62EDTWRD(' .   ,  &€')
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261104  161332  XUAN        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A                                      CA12(12 'retour')
     A                                      OVERLAY
     A  33                                  SFLDSP
     A  32                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  31                                  SFLEND(*MORE)
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  2TIME
     A                                  1 70USER
     A                                  2 70SYSNAME
     A                                  1 28'Calcul du prêt immobilier'
     A                                      COLOR(WHT)
     A                                  2 30'Tableau Amortissement'
     A                                      COLOR(WHT)
     A                                  4  4'Tableau des Amortissements :'
     A                                      COLOR(BLU)
     A                                  7  5'Coût total du prêt :'
     A                                  6  5'Coût des interets  :'
     A            C_TOTAL       12Y 2O  7 27EDTWRD(' .   .   .   ,  &€')
     A            C_INTERET     12  2O  6 27EDTWRD(' .   .   .   ,  &€')
     A                                  9  5'Mois'
     A                                      COLOR(WHT)
     A                                  9 11'Capital restant dû'
     A                                      COLOR(WHT)
     A                                  9 33'Intérêts'
     A                                      COLOR(WHT)
     A                                  9 45'Remb. Capital'
     A                                      COLOR(WHT)
     A                                  9 62'Mensualité'
     A                                      COLOR(WHT)
     A                                  5  5'Mensualité         :'
     A            C_MENS         6Y 2O  5 35EDTWRD(' .   ,  &€')
     A          R FOOT
     A*%%TS  SD  20261104  112819  XUAN        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 14'F12=Quitter'
     A                                      COLOR(BLU)
```
