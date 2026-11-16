---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: BIERED
type: DDS
longueur_enregistrement: 80
lignes: 83
modifie: 2026-11-16
---

# BIB17/QDDSSRC/BIERED

```text
     A*%%TS  SD  20261016  134414  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R SFL1                      SFL
     A*%%TS  SD  20261016  134414  REMI        REL-V7R5M0  5770-WDS
     A            SFLOPT         1S 0B  9  2
     A            PRREPR    R        O  9  5REFFLD(BEERF/PRREPR BIB17/BIER-
     A                                      E)
     A            PRNOPR    R        O  9 12REFFLD(BEERF/PRNOPR BIB17/BIER-
     A                                      E)
     A            TXTVAPR   R        O  9 73REFFLD(BEERF/TXTVAPR BIB17/BIE-
     A                                      RE)
     A                                      EDTWRD('   ,  %')
     A            PRUNVE    R        O  9 65REFFLD(BEERF/PRUNVE BIB17/BIER-
     A                                      E)
     A                                      EDTWRD('   ,  €')
     A            PRSTPR    R        O  9 58REFFLD(BEERF/PRSTPR BIB17/BIER-
     A                                      E)
     A  40                                  COLOR(GRN)
     A N40                                  COLOR(RED)
     A                                      EDTCDE(Z)
     A            STMIPR    R        O  9 51REFFLD(BEERF/STMIPR BIB17/BIER-
     A                                      E)
     A                                      EDTCDE(Z)
     A            PRIDPR         6S 0H
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261016  133022  REMI        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0011)
     A                                      CF03(03)
     A                                      CF05(05)
     A                                      CF06(06)
     A                                      CF08(08)
     A                                      CF09(09)
     A                                      CF24(24)
     A                                      OVERLAY
     A  32                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A            NMPGM         10A  O  1  3
     A                                  2  3USER
     A                                  1 33'Liste des bieres'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  4  8'Afficher à partir de Ref . :'
     A            REFFLT    R        B  4 38REFFLD(BEERF/PRREPR BIB17/BIER-
     A                                      E)
     A                                      CHANGE(70)
     A                                  6  5'2=Modifier  4=Supprimer  6=Imprime-
     A                                      r'
     A                                      COLOR(BLU)
     A                                  8  2'O'
     A                                      COLOR(WHT)
     A                                  8  5'Ref.'
     A                                      COLOR(WHT)
     A                                  8 12'Produit'
     A                                      COLOR(WHT)
     A                                  8 51'Mini'
     A                                      COLOR(WHT)
     A                                  7 51'Stock'
     A                                      COLOR(BLU)
     A                                  7 58'Stock'
     A                                      COLOR(BLU)
     A                                  8 58'Actuel'
     A                                      COLOR(WHT)
     A                                  8 65'Unit'
     A                                      COLOR(WHT)
     A                                  7 65'Prix'
     A                                      COLOR(BLU)
     A                                  8 75'TVA'
     A                                      COLOR(WHT)
     A                                  7 74'Taux'
     A                                      COLOR(BLU)
     A          R FOOT
     A*%%TS  SD  20261016  102728  REMI        REL-V7R5M0  5770-WDS
     A                                 23  3'F24=Export CSV'
     A                                      COLOR(BLU)
     A                                 24  3'F3=Quitter  F5=Réafficher  F6=Créa-
     A                                      tion  F8=WRKSPLF  F9=DLTSPLF'
     A                                      COLOR(BLU)
```
