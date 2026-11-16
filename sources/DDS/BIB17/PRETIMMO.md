---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: PRETIMMO
type: DDS
longueur_enregistrement: 80
lignes: 69
modifie: 2026-11-16
---

# BIB17/QDDSSRC/PRETIMMO

```text
     A*%%TS  SD  20261104  163324  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20261104  163324  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                 23  2'F3=quitter'
     A                                      COLOR(BLU)
     A                                  1 33'Pret immobilier'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  5  5'Montant  :'
     A                                  7  5'Taux     :'
     A                                  9  5'Durée    :'
     A            MONTANT       10Y 0B  5 17EDTCDE(1)
     A            TAUX           5Y 2B  7 17EDTCDE(3)
     A            DUREE          2S 0B  9 17
     A                                 11  5'Méthode  :'
     A            METHODE        2Y 0B 11 17SNGCHCFLD((*NUMROW 2))
     A                                      CHOICE(1 '>Mensualités constantes')
     A                                      CHOICE(2 '>Amortissement constant')
     A          R SFL1                      SFL
     A*%%TS  SD  20261104  163324  REMI        REL-V7R5M0  5770-WDS
     A            MOIS           4S 0O 10  2
     A            CAPRESTDU     12Y 2O 10  9EDTCDE(1)
     A            INTERET        8Y 2O 10 30EDTCDE(2)
     A            REMBCAP        8Y 2O 10 46EDTCDE(2)
     A            MENSUALITE     8Y 2O 10 66EDTCDE(2)
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261104  163324  REMI        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0010)
     A                                      SFLPAG(0008)
     A                                      CF03(03)
     A                                      CF12(12)
     A  32                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 30'Tableau ammortissement'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  4  4'Tableau des Amortissements :'
     A                                      COLOR(BLU)
     A                                  6  8'Coût total du prêt  :'
     A                                  7  8'Coût des intérets   :'
     A            TOTPRET       13Y 2O  6 31EDTCDE(1)
     A            TOTINT        13Y 2O  7 31EDTCDE(1)
     A                                  9  2'Mois'
     A                                      COLOR(WHT)
     A                                  9  9'Capital restant dû'
     A                                      COLOR(WHT)
     A                                  9 31'Intérets'
     A                                      COLOR(WHT)
     A                                  9 44'Remb. Capital'
     A                                      COLOR(WHT)
     A                                  9 66'Mensualité'
     A                                      COLOR(WHT)
     A          R FOOT
     A*%%TS  SD  20261104  112949  REMI        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Quitter   F12=Retour'
     A                                      COLOR(BLU)
```
