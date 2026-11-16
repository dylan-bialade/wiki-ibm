---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: PRETIMMO
type: DDS
longueur_enregistrement: 80
lignes: 82
modifie: 2026-11-16
---

# BIB20/QDDSSRC/PRETIMMO

```text
w     A*%%TS  SD  20251125  154609  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R MAIN
     A*%%TS  SD  20251125  144850  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A                                  1 30'Calcul prêt immobilier'
     A                                      COLOR(WHT)
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  7 10'Montant :'
     A            MONTANT       12Y 2B  7 21EDTCDE(Q)
     A                                      CHECK(ME)
     A            DUREE          3  0B  9 21CHECK(ME)
     A            TAUX           5Y 2B 11 21CHECK(ME)
     A                                      EDTCDE(Q)
     A                                  9 12'Durée :'
     A                                 11 13'Taux :'
     A                                  7 35'(€)'
     A                                  9 28'(Année)'
     A                                 11 30'(%)'
     A                                 23  3'F3=Sortir'
     A                                      COLOR(BLU)
     A          R SFL                       SFL
     A*%%TS  SD  20251125  154609  GGEOFFREY   REL-V7R5M0  5770-WDS
     A            MOIS           4Y 0O 11  4EDTCDE(Q)
     A            REMBCAP       10Y 2O 11 28EDTCDE(A)
     A            REMBINT       10Y 2O 11 48EDTCDE(A)
     A            MENS          10Y 2O 11 64EDTCDE(A)
     A            CAPITAL       10Y 2O 11 11EDTCDE(A)
     A          R CTL                       SFLCTL(SFL)
     A*%%TS  SD  20251125  154609  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0011)
     A                                      CA12(12)
                                            CA03(03)
                                            OVERLAY
     A N30                                  SFLDSP
     A N31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  1 30'Calcul prêt immobilier'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  4  3'Montant total du prêt :'
     A                                  6  3'Montant total des intérets :'
     A            PRETTX        13Y 2O  4 27EDTCDE(A)
     A            INTERETTTX    12Y 2O  6 32EDTCDE(A)
     A                                  5 47'Afficher à partir de (Mois) :'
     A            SEARCH         3S 0B  5 77
     A                                  9  4'Mois'
     A                                      COLOR(WHT)
     A                                  9 68'Mensualité'
     A                                      COLOR(WHT)
     A                                  8 13'Capital'
     A                                      COLOR(WHT)
     A                                  9 12'restant du'
     A                                      COLOR(WHT)
     A                                  8 28'Remboursement'
     A                                      COLOR(WHT)
     A                                  9 32'capital'
     A                                      COLOR(WHT)
     A                                  8 49'Remboursement'
     A                                      COLOR(WHT)
     A                                  9 53'interêt'
     A                                      COLOR(WHT)
     A          R FONCTION
     A*%%TS  SD  20251125  144850  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Sortir   F12=Retour'
     A                                      COLOR(BLU)
```
