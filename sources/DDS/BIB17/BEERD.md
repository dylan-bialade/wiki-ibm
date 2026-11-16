---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: BEERD
type: DDS
longueur_enregistrement: 160
lignes: 47
modifie: 2026-11-16
---

# BIB17/QDDSSRC/BEERD

```text
     A*%%TS  SD  20261018  135643  REMI        REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R FMT1
     A*%%TS  SD  20261018  135643  REMI        REL-V7R5M0  5770-WDS                  A                                      CF03(03)
     A                                      CF12(12)                                 A                                      CF21(21)
     A                                  1  2SYSNAME                                  A                                  2  2USER
     A                                  1 35'Fiche Biere'                            A                                      COLOR(WHT)
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2 72TIME                                     A            MODE          25A  O  2 28
     A                                  5 17'IDENTIFIANT:'                           A                                      COLOR(WHT)
     A            PRIDPR    R        O  5 30REFFLD(BEERF/PRIDPR BIB17/BIER-     A                                      E)
     A                                  7 11'REFERENCE PRODUIT:'                     A                                      COLOR(WHT)
     A                                  9 25'NOM:'                                   A                                      COLOR(WHT)
     A                                 11 15'STOCK PRODUIT:'                         A                                      COLOR(WHT)
     A                                 12 15'STOCK MINIMUM:'                         A                                      COLOR(WHT)
     A            PRREPR    R        B  7 30REFFLD(BEERF/PRREPR BIB17/BIER-     A                                      E)
     A  75                                  DSPATR(PR)                               A                                      CHECK(ME)
     A  40                                  ERRMSG('Référence obligatoire')         A            PRNOPR    R        B  9 30REFFLD(BEERF/PRNOPR BIB17/BIER-
     A                                      E)                                       A                                      CHECK(ME)
     A  75                                  DSPATR(PR)                               A  41                                  ERRMSG('Nom obligatoire')
     A            STMIPR    R        B 12 30REFFLD(BEERF/STMIPR BIB17/BIER-     A                                      E)
     A  75                                  DSPATR(PR)                               A                                      CHECK(ME)
     A                                      CHANGE(70)                               A  43                                  ERRMSG('Stock mini obligatoire')
     A            PRSTPR    R        B 11 30REFFLD(BEERF/PRSTPR BIB17/BIER-     A                                      E)
     A  75                                  DSPATR(PR)                               A                                      CHECK(ME)
     A                                      CHANGE(70)                               A  42                                  ERRMSG('Stock obligatoire')
     A                                 14 21'+------------+---------------------     A                                      ----+'
     A                                      COLOR(WHT)                               A                                 15 21'|  P.U.  HT  |  Tx TVA   |  P.U. T-
     A                                      TC  |'                                   A                                      COLOR(WHT)
     A                                 16 21'+------------+-----------+---------     A                                      ----+'
     A                                      COLOR(WHT)                               A                                 17 21'|'
     A                                      COLOR(WHT)                               A                                 17 34'|'
     A                                      COLOR(WHT)                               A                                 17 46'|'
     A                                      COLOR(WHT)                               A                                 17 59'|'
     A                                      COLOR(WHT)                               A                                 18 21'+------------+-----------+---------
     A                                      ----+'                                   A                                      COLOR(WHT)
     A            TXTVAPR   R        B 17 37REFFLD(BEERF/TXTVAPR BIB17/BIE-     A                                      RE)
     A  75                                  DSPATR(PR)                               A                                      CHECK(ME)
     A                                      CHANGE(70)                               A  45                                  ERRMSG('Taux de tva obligatoire')
     A                                 17 44'%'                                      A                                      COLOR(WHT)
     A            PRUNVE    R        B 17 25REFFLD(BEERF/PRUNVE BIB17/BIER-     A                                      E)
     A                                      CHECK(ME)                                A                                      CHANGE(70)
     A  44                                  ERRMSG('Prix obligatoire')              A            PUTTC          6S 2O 17 50
     A                                 20 32'Entrer=Valider'                         A                                      COLOR(WHT)
     A                                 23  6'F3=Quitter'                             A                                      COLOR(BLU)
     A                                 23 35'F21=Imprimer'                           A                                      COLOR(BLU)
     A                                 23 68'F12=Annuler'                            A                                      COLOR(BLU)
     A  79                             11 41'ATTENTION STOCK'                        A                                      COLOR(RED)
```
