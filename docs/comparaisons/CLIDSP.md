# CLIDSP : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB10 | QDSPSRC | DDS | 153 | 100 % | sous-fichier, DDS (R/K/PFILE) | [CLIDSP.md](../../sources/DDS/BIB10/CLIDSP.md) |
| BIB17 | QDDSSRC | DDS | 38 | 0 % | sous-fichier, DDS (R/K/PFILE) | [CLIDSP.md](../../sources/DDS/BIB17/CLIDSP.md) |

## Differences

- Techniques communes : sous-fichier, DDS (R/K/PFILE)

## Codes

### BIB10 (DDS, 153 lignes)

_Long : voir [CLIDSP.md](../../sources/DDS/BIB10/CLIDSP.md)._

### BIB17 (DDS, 38 lignes)

```text
     A*%%TS  SD  20261014  145534  REMI        REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R FOOT
     A*%%TS  SD  20261014  091808  REMI        REL-V7R5M0  5770-WDS                  A                                 22  3'F5=Réafficher F6=Créer F10=WRKSPLF-
     A                                       F11=EMAIL F12=Quitter F15=Imprimer-     A                                       liste'
     A                                      COLOR(BLU)                               A          R SFL1                      SFL
     A*%%TS  SD  20261014  144057  REMI        REL-V7R5M0  5770-WDS                  A            SF1OPT         1S 0I  9  2
     A            CLNOCL    R        O  9  5REFFLD(CLIENTSF/CLNOCL BIB17/F-     A                                      ICCLI)
     A            CLCPCL    R        O  9 28REFFLD(CLIENTSF/CLCPCL BIB17/F-     A                                      ICCLI)
     A            CLVICL    R        O  9 34REFFLD(CLIENTSF/CLVICL BIB17/F-     A                                      ICCLI)
     A            TEL           11Y 0O  9 56EDTWRD('0  .  .  .  .  ')                A            DPT            2A  O  9 77
     A            CLMACL    R        O 10  4REFFLD(CLIENTSF/CLMACL BIB17/F-     A                                      ICCLI)
     A            CLIDCL         6  0H                                               A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261014  144950  REMI        REL-V7R5M0  5770-WDS                  A                                      TEXT('*')
     A                                      CF05(05)                                 A                                      CF06(06)
     A                                      CF10(10)                                 A                                      CF12(12)
     A                                      CF15(15)                                 A                                      CF03(03)
     A                                      OVERLAY                                  A  32                                  SFLDSP
     A  31                                  SFLDSPCTL                                A  30                                  SFLCLR
     A  33                                  SFLEND(*MORE)                            A                                      SFLDROP(CF11)
     A                                      SFLSIZ(0006)                             A                                      SFLPAG(0004)
     A                                  1  2USER                                     A            NMPGM         10A  O  2  2
     A                                  1 34'Liste clients'                          A                                      COLOR(WHT)
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2 72TIME                                     A                                  4  4'Filtre Dpt :'
     A                                      COLOR(BLU)                               A                                  6  3'2=Editer  4=Supprimer  5=Afficher -
     A                                       6=Imprimer'                             A                                      COLOR(BLU)
     A                                  8  2'o'                                      A                                      COLOR(WHT)
     A                                  8  5'Nom'                                    A                                      COLOR(WHT)
     A                                  8 28'CP'                                     A                                      COLOR(WHT)
     A                                  8 34'Ville'                                  A                                      COLOR(WHT)
     A                                  8 56'Téléphone'                              A                                      COLOR(WHT)
     A                                  8 77'Dpt'                                    A                                      COLOR(WHT)
     A            FLTDPT         2A  B  4 18CHANGE(70)                               A          R NOTIF
     A*%%TS  SD  20261014  145534  REMI        REL-V7R5M0  5770-WDS                  A                                      WINDOW(8 10 10 60)
     A                                  1 25'Notification'                           A                                      COLOR(PNK)
     A            NOTIF1        60   O  5  1                                         A            NOTIF2        60   O  6  1
     A          R BIDON                                                              A*%%TS  SD  20261014  145534  REMI        REL-V7R5M0  5770-WDS
     A                                      ASSUME                                   A                                  1  3' '
```
