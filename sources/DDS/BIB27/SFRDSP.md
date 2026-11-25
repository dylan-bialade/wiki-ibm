---
bibliotheque: BIB27
fichier_source: QDDSSRC
membre: SFRDSP
type: DDS
longueur_enregistrement: 80
lignes: 43
modifie: 2026-11-25
---

# BIB27/QDDSSRC/SFRDSP

```text
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')
     A                                      CA12(12 'Retour')
     A                                      INDARA

     A          R SFL1                      SFL
     A            E1PRDN         7S 0O  5  2
     A            E1PRDNAME     30A  O  5 11
     A            E1PRDCAT      10A  O  5 43
     A            E1PRDPRICE     7S 2O  5 55
     A            E1PRDQTY       5S 0O  5 64
     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A                                      ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  4  2'N°pro'
     A                                      DSPATR(HI)
     A                                  4 11'Nom produit'
     A                                      DSPATR(HI)
     A                                  4 43'Catégorie'
     A                                      DSPATR(HI)
     A                                  4 55'Prix'
     A                                      DSPATR(HI)
     A                                  1  2'SFRDSP'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 24'Sous-fichier Produits'
     A                                      DSPATR(HI)
     A                                  4 64'Qte'
     A                                      DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
```
