---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: LSTSF
type: RPG/RPG-III-400
longueur_enregistrement: 160
lignes: 28
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/LSTSF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20261015  120822  DYLAN2      REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A                                      CF03(03)
     A                                      CF05(05)                                 A                                      CF06(06)
     A                                      CF22(22)                                 A                                      CF24(24)
     A          R SFL1                      SFL                                      A*%%TS  SD  20261015  114017  DYLAN2      REL-V7R5M0  5770-WDS
     A            OPT            1A  B  9  5                                         A            ID             6S 0H
     A            LIB           10   O  9  8                                         A            FIL           10   O  9 19
     A            MBR           10   O  9 30                                         A            TYP           10   O  9 41
     A            NBL            6  0O  9 53                                         A            TXT           50   O 10  7
     A          R CTL1                      SFLCTL(SFL1)                             A*%%TS  SD  20261015  120822  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0007)                             A                                      SFLPAG(0006)
     A                                      OVERLAY                                  A  30                                  SFLDSP
     A  31                                  SFLDSPCTL                                A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)                            A                                      SFLDROP(CF11)
     A                                  1  2SYSNAME                                  A                                  2  2USER
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2 72TIME                                     A                                  1 32'exemple sfl'
     A                                  4  4'indiquer vos option, puis appuyer -     A                                      sur entrée.'
     A                                  5  4'2=editer    3=copier    4=supprime-     A                                      r  5=afficher '
     A                                  7  4'opt'                                    A                                  7  9'lib'
     A                                  3 33'search:'                                A            VAL6          10A  I  3 41CHECK(LC)
     A                                  7 21'fil'                                    A                                  7 28'     '
     A                                  5 53'6=imprimer'                             A                                  7 34'mbr'
     A                                  7 44'typ'                                    A                                  7 55'nbl'
     A          R FOOTER                                                             A*%%TS  SD  20261014  135111  DYLAN2      REL-V7R5M0  5770-WDS
     A                                 23  2'f3=exit'                                A                                 23 12'f6=crée'
     A                                 23 22'f5=refresh'                             A                                 23 34'f11=email'
     A                                 23 45'f22=print one'                          A                                 23 60'f24=print all'
```
