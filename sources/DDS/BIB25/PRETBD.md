---
bibliotheque: BIB25
fichier_source: QILESRC
membre: PRETBD
type: DDS
longueur_enregistrement: 80
lignes: 107
modifie: 2026-11-25
---

# BIB25/QILESRC/PRETBD

```text
     A*%%TS  SD  20250206  155400  LEO2        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA12(12 'Annulation')
     A          R FMT1
     A*%%TS  SD  20241223  110623  LEO2        REL-V7R5M0  5770-WDS
     A                                      OVERLAY
     A                                  1 28'Calcul de prêts immobilier'
     A                                      COLOR(WHT)
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  2TIME
     A                                  1 71USER
     A                                  2 71SYSNAME
     A            TYPE           2Y 0B  7  3SNGCHCFLD(*AUTOSLT (*NUMCOL 1))
     A                                      CHOICE(1 'Annuités constantes')
     A                                      CHOICE(2 'Amortissement constant')
     A            TYPEC         60A  O 11  4COLOR(BLU)
     A  80                                  DSPATR(ND)
     A                                  5  4'Veuillez choisir un type de prêt p-
     A                                      uis appuyer sur ENTREE :'
     A                                      COLOR(BLU)
     A          R FNKEYS
     A*%%TS  SD  20241220  113511  LEO2        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 16'F12=Annuler'
     A                                      COLOR(BLU)
     A          R INFO
     A*%%TS  SD  20250206  155400  LEO2        REL-V7R5M0  5770-WDS
     A                                 12  7'Montant :'
     A                                      COLOR(WHT)
     A            EMONTANT       9Y 2I 12 19
     A                                 13  7'Durée   :'
     A                                      COLOR(WHT)
     A            EDUREE         2S 0I 13 19
     A                                 14  7'Taux    :'
     A                                      COLOR(WHT)
     A                                 12  7'Caractéristiques du prêt :'
     A                                      COLOR(WHT)
     A                                 14 27'(%)'
     A                                      COLOR(WHT)
     A                                 13 27'(année)'
     A                                      COLOR(WHT)
     A                                 12 32'(€)'
     A                                      COLOR(WHT)
     A            ETAUX          4Y 2I 14 19
     A                                 16  7'Assurance emprunteur :'
     A                                      COLOR(WHT)
     A            EASSURANCE     4Y 2I 16 33
     A                                 16 42'(% annuel du capital emprunté)'
     A                                      COLOR(WHT)
     A                                 17  7'Frais hypothèque     :'
     A                                      COLOR(WHT)
     A            EHYPO          4Y 2I 17 33
     A                                 17 42'(% du capital emprunté)'
     A                                      COLOR(WHT)
     A                                 18  7'Frais de caution     :'
     A                                      COLOR(WHT)
     A            ECAUTION       4Y 2I 18 33
     A                                 18 42'(% du capital emprunté)'
     A                                      COLOR(WHT)
     A                                 23  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 16'F12=Annuler'
     A                                      COLOR(BLU)
     A          R SFL1                      SFL
     A*%%TS  SD  20241227  150159  LEO2        REL-V7R5M0  5770-WDS
     A            E1_MOIS        3Y 0O 11  4EDTCDE(A)
     A            E1_CAPRD       9Y 2O 11 10EDTCDE(A)
     A            E1_INTERET     9Y 2O 11 28EDTCDE(A)
     A            E1_RCAP        9Y 2O 11 43EDTCDE(A)
     A            E1_MENS        9Y 2O 11 60EDTCDE(A)
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20241227  150556  LEO2        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0009)
     A                                      SFLPAG(0008)
     A                                      OVERLAY
     A  50                                  SFLDSP
     A  51                                  SFLDSPCTL
     A  52                                  SFLCLR
     A  53                                  SFLEND(*MORE)
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  2TIME
     A                                  1 28'Calcul du pret immobilier'
     A                                      COLOR(WHT)
     A                                  2 30'Tableau Amortissement'
     A                                      COLOR(WHT)
     A                                  1 68USER
     A                                  4  3'Tableau des Amortissements : '
     A                                      COLOR(BLU)
     A                                 10  4'Mois'
     A                                      COLOR(WHT)
     A                                 10 10'Capital restant dû'
     A                                      COLOR(WHT)
     A                                 10 33'Intérêts'
     A                                      COLOR(WHT)
     A                                 10 45'Remb. Capital'
     A                                      COLOR(WHT)
     A                                 10 64'Mensualité'
     A                                      COLOR(WHT)
     A                                  6  4'Coût total du prêt :'
     A                                  7  4'Coût des intérêts  :'
     A            E1_CT          9Y 2O  6 29EDTCDE(A)
     A            E1_CI          9Y 2O  7 29EDTCDE(A)
```
