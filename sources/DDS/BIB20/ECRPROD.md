---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: ECRPROD
type: DDS
longueur_enregistrement: 80
lignes: 93
modifie: 2026-11-16
---

# BIB20/QDDSSRC/ECRPROD

```text
     A*%%TS  SD  20251110  103811  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20251110  103811  GGEOFFREY   REL-V7R5M0  5770-WDS
                                            CA03(03)
     A            PRODUCTNUMR        B 10 42REFFLD(INVENTORY/PROD_NUM TPSQL/PRO-
     A                                      DUITS)
     A                                      CHECK(ME)
     A                                 10 20'Numéro du produit :'
     A                                  1 31'Détails d''un produit'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  2  2SYSNAME
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                 23  4'F3=Sortir'
     A                                      COLOR(BLU)
     A  50        MSGERR       100   M
     A          R FMT2
                                            CA03(03)
                                            CA12(12)
                                            CA05(05)
     A                                  1 31'Détails d''un produit'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  2  2SYSNAME
     A                                      COLOR(BLU)
     A                                  1 73DATE(*Y)
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  7 14'Type  . . . :'
     A                                  9 14'Catégorie   :'
     A                                 13 14'Modèle  . . :'
     A                                 11 14'Nom   . . . :'
     A                                 15 14'Qte en stock:'
     A            PRODTYPE  R        O  7 30REFFLD(INVENTORY/PRODTYPE +
     A                                      TPSQL/PRODUITS)
     A            PRODCAT   R        O  9 30REFFLD(INVENTORY/PRODCAT +
     A                                      TPSQL/PRODUITS)
     A            PRODNAME  R        O 11 30REFFLD(INVENTORY/PRODNAME +
     A                                      TPSQL/PRODUITS)
     A            MODEL     R        O 13 30REFFLD(INVENTORY/MODEL TPSQL/PRODUI-
     A                                      TS)
     A            QTY_IN_STKR        O 15 30REFFLD(INVENTORY/QTY_IN_STK +
     A                                      TPSQL/PRODUITS)
     A                                 24 52'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 24  5'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 24 19'F5=Voir commande associé'
     A                                      COLOR(BLU)
     A          R FMT3
                                            CA03(03)
                                            CA12(12)
     A                                  1 33'Commande associé'
     A                                      COLOR(BLU)
     A                                  4  9'Commande du produit numéro :'
     A                                      COLOR(YLW)
     A            PROD_NUM  R        O  4 39REFFLD(INVENTORY/PROD_NUM +
     A                                      TPSQL/PRODUITS)
     A                                      COLOR(WHT)
     A                                  7  9'Numéro de la commande'
     A                                      COLOR(GRN)
     A                                  9  9'Date de la commande'
     A                                      COLOR(GRN)
     A                                 11  9'Date de la livraison'
     A                                      COLOR(GRN)
     A                                 13  9'Total (€) '
     A                                      COLOR(GRN)
     A            ORDER_NUM R           7 34REFFLD(ORDERS/ORDER_NUM TPSQL/COMMA-
     A                                      NDES)
     A                                      COLOR(WHT)
     A            ORDER_DATER           9 34REFFLD(ORDERS/ORDER_DATE +
     A                                      TPSQL/COMMANDES)
     A                                      COLOR(WHT)
     A            SHIP_DATE R          11 34REFFLD(ORDERS/SHIP_DATE TPSQL/COMMA-
     A                                      NDES)
     A                                      COLOR(WHT)
     A            LINEPRICE R          13 34REFFLD(ORDERS/LINEPRICE TPSQL/COMMA-
     A                                      NDES)
     A                                      COLOR(WHT)
     A                                      EDTCDE(N)
     A                                 18  6'Appuyez sur ENTREE pour passer à l-
     A                                      a suivante commande, si elle existe-
     A                                      .'
     A                                      COLOR(BLU)
```
