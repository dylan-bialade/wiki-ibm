---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: BEERSF
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 120
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/BEERSF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20261016  211907  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      CF05(05)
     A                                      CF06(06)
     A                                      CF22(22)
     A                                      CF24(24)
     A          R SFL1                      SFL
     A*%%TS  SD  20261016  133403  DYLAN2      REL-V7R5M0  5770-WDS
     A            OPT            1A  B  9  5
     A            ID             6A  H
     A            PROD          15A  O  9 21
     A            UNIT           3Y 0O  9 67EDTWRD(' ,  €')
     A            ACTU           3S 0O  9 60
     A  69                                  COLOR(RED)
     A            STOKMI         3S 0O  9 52
     A            REF            5S 0O  9  9
     A            TVA            4Y 0O  9 74EDTWRD('  ,  %')
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261016  115133  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0007)
     A                                      SFLPAG(0006)
     A                                      OVERLAY
     A  30                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                      SFLDROP(CF11)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 32'exemple sfl'
     A                                  4  4'indiquer vos option, puis appuyer -
     A                                      sur entrée.'
     A                                  5  4'2=editer    3=copier    4=supprime-
     A                                      r  5=afficher '
     A                                  7  4'opt'
     A                                  3 33'search:'
     A                                  5 53'6=imprimer'
     A                                  7 10'ref.'
     A                                  7 28'produit'
     A                                  7 51'stok.Mi'
     A                                  7 60'actu'
     A                                  7 67'unit'
     A                                  7 75'tva'
     A            SEARC          5A  B  3 41
     A          R FOOTER
     A*%%TS  SD  20261016  141651  DYLAN2      REL-V7R5M0  5770-WDS
     A                                 23  2'f3=exit'
     A                                 23 12'f6=crée'
     A                                 23 22'f5=refresh'
     A                                 22  2'f8=wrksplf'
     A                                 22 14'f9=dltsplf'
     A                                 23 35'f24=export csv'
     A                                 22 27'https://laberlue-boutique.fr/'
     A          R FMT1
     A*%%TS  SD  20261016  143311  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CF12(12)
     A                                      CF23(23)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 72TIME
     A                                  1 33'Données du bonbon'
     A                                      COLOR(BLU)
     A                                  7  4'opt'
     A                                  7 10'ref'
     A            OPT            1A  B  9  5
     A            ID             6A  H
     A            PROD          15A  B  9 21
     A            UNIT           3Y 0B  9 67
     A            ACTU           3S 0B  9 60
     A  69                                  COLOR(RED)
     A            STOKMI         3S 0B  9 49
     A            REF            5S 0B  9  9
     A            TVA            4Y 0B  9 74
     A                                 22 15'F3=Exit'
     A                                      COLOR(BLU)
     A                                 22 26'F12=Retour'
     A                                      COLOR(BLU)
     A                                 22 40'F23=Suprimer le livre '
     A                                      COLOR(BLU)
     A                                 13 14'Entre pour modifier '
     A                                      COLOR(BLU)
     A            MSG            6A  B 12 15
     A                                 11 13' vous:'
     A                                  7 22'produit'
     A                                  7 46'stok.min'
     A                                  7 58'actu'
     A                                  7 66'prix'
     A                                  7 74'tva'
     A          R WIN1
     A*%%TS  SD  20261014  094349  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      WINDOW(9 11 10 50)
     A                                  1 18'suppression'
     A                                  3  4'tes sur:'
     A            VALWIN        20A  O  3 14
     A                                  7  6'vraiment?'
     A            VALOUI         3A  B  7 17
     A                                  7 24'OUI/NON'
     A          R BIDON
     A*%%TS  SD  20261013  133356  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      ASSUME
     A                                  1  3' '
```
