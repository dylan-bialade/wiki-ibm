---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: CLIENSF
type: RPG/RPG-III-400
longueur_enregistrement: 160
lignes: 57
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/CLIENSF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20261014  145100  DYLAN2      REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A                                      CF03(03)
     A                                      CF05(05)                                 A                                      CF06(06)
     A                                      CF22(22)                                 A                                      CF24(24)
     A          R SFL1                      SFL                                      A*%%TS  SD  20261014  111750  DYLAN2      REL-V7R5M0  5770-WDS
     A            OPT            1A  B  9  5                                         A            ID             6  0H
     A            VAL1          15A  O  9  7                                         A            VAL2           5A  O  9 27
     A            VAL3          10A  O  9 33                                         A            VAL5           2A  O  9 68
     A            VAL4          10Y 0O  9 51EDTWRD('0  .  .  .  .  ')                A            VAL50         50A  O 10  7
     A          R CTL1                      SFLCTL(SFL1)                             A*%%TS  SD  20261014  144202  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0007)                             A                                      SFLPAG(0006)
     A                                      OVERLAY                                  A  30                                  SFLDSP
     A  31                                  SFLDSPCTL                                A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)                            A                                      SFLDROP(CF11)
     A                                  1  2SYSNAME                                  A                                  2  2USER
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2 72TIME                                     A                                  1 32'exemple sfl'
     A                                  4  4'indiquer vos option, puis appuyer -     A                                      sur entrée.'
     A                                  5  4'2=editer    3=copier    4=supprime-     A                                      r  5=afficher '
     A                                  7  4'opt'                                    A                                  7  9'nom'
     A                                  3 33'search:'                                A            VAL6           2A  I  3 41CHECK(LC)
     A                                  7 21'cp'                                     A                                  7 28'ville'
     A                                  7 52'tel'                                    A                                  7 66'dpt'
     A                                  5 53'6=imprimer'                             A          R FOOTER
     A*%%TS  SD  20261014  135111  DYLAN2      REL-V7R5M0  5770-WDS                  A                                 23  2'f3=exit'
     A                                 23 12'f6=crée'                                A                                 23 22'f5=refresh'
     A                                 23 34'f11=email'                              A                                 23 45'f22=print one'
     A                                 23 60'f24=print all'                          A          R FMT1
     A*%%TS  SD  20261013  163943  DYLAN2      REL-V7R5M0  5770-WDS                  A                                      CF12(12)
     A                                      CF23(23)                                 A                                  1  3'SYS'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  1  8SYSNAME                                  A                                  1 66'DATE'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2  3'USR'                                    A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  2  8USER
     A                                  2 66'TIME'                                   A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  2 72TIME
     A                                  1 33'Données du bonbon'                      A                                      COLOR(BLU)
     A                                  7  4'opt'                                    A                                  7 11'   nom'
     A                                  7 26'marque'                                 A                                  7 65'number'
     A                                  7 52'prix'                                   A                                  7 39'couleur'
     A            VAL1          15A  B  9  7                                         A            VAL2           5A  B  9 27
     A            VAL3          10A  B  9 33                                         A            VAL5           2A  B  9 68
     A            VAL4          10Y 0B  9 51EDTWRD('0  .  .  .  .  ')                A            VAL50         50   B 10  7
     A                                 22 15'F3=Exit'                                A                                      COLOR(BLU)
     A                                 22 26'F12=Retour'                             A                                      COLOR(BLU)
     A                                 22 40'F23=Suprimer le livre '                 A                                      COLOR(BLU)
     A                                 13 14'Entre pour modifier '                   A                                      COLOR(BLU)
     A            MSG            6A  B 12 15                                         A                                 11 13' vous:'
     A            FLD001        10Y 0O  9 51EDTWRD('0  .  .  .  .  ')                A          R WIN1
     A*%%TS  SD  20261014  094349  DYLAN2      REL-V7R5M0  5770-WDS                  A                                      WINDOW(9 11 10 50)
     A                                  1 18'suppression'                            A                                  3  4'tes sur:'
     A            VALWIN        20A  O  3 14                                         A                                  7  6'vraiment?'
     A            VALOUI         3A  B  7 17                                         A                                  7 24'OUI/NON'
     A          R BIDON                                                              A*%%TS  SD  20261013  133356  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      ASSUME                                   A                                  1  3' '
```
