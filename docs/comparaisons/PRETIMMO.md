# PRETIMMO : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB13 | QDDSSRC | DDS | 83 | 100 % | sous-fichier, DDS (R/K/PFILE) | [PRETIMMO.md](../../sources/DDS/BIB13/PRETIMMO.md) |
| BIB17 | QDDSSRC | DDS | 69 | 11 % | sous-fichier, DDS (R/K/PFILE) | [PRETIMMO.md](../../sources/DDS/BIB17/PRETIMMO.md) |
| BIB20 | QDDSSRC | DDS | 82 | 4 % | sous-fichier, DDS (R/K/PFILE) | [PRETIMMO.md](../../sources/DDS/BIB20/PRETIMMO.md) |

## Differences

- Techniques communes : sous-fichier, DDS (R/K/PFILE)

## Codes

### BIB13 (DDS, 83 lignes)

```text
     A*%%TS  SD  20261104  161332  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'exit')
     A          R FMT1
     A*%%TS  SD  20261104  112819  XUAN        REL-V7R5M0  5770-WDS
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  2TIME
     A                                  1 70USER
     A                                  2 70SYSNAME
     A                                  1 28'Calcul de pret immobilier'
     A                                      COLOR(WHT)
     A                                  9  4'Vous avez choisi les annuités cons-
     A                                      tantes :'
     A                                      COLOR(BLU)
     A                                 10  9'Montant :'
     A                                      COLOR(WHT)
     A                                 11  9'Durée   :'
     A                                      COLOR(WHT)
     A                                 12  9'Taux    :'
     A                                      COLOR(WHT)
     A            F_MONTANT     10  0B 10 20
     A                                 10 34'(€)'
     A                                      COLOR(WHT)
     A            F_DUREE        3  0B 11 20
     A                                 11 34'(année)'
     A                                      COLOR(WHT)
     A            F_TAUX         4  2B 12 20EDTWRD('  .  ')
     A                                 12 34'(%)'
     A                                      COLOR(WHT)
     A                                 23  4'F3=Exit'
     A                                      COLOR(BLU)
     A          R SFL1                      SFL
     A*%%TS  SD  20261104  161332  XUAN        REL-V7R5M0  5770-WDS
     A            S_MOIS         3Y 0O 10  5EDTCDE(4)
     A            S_CAP         12Y 2O 10 11EDTWRD(' .   .   .   ,  &€')
     A            S_INTR         6Y 2O 10 33EDTWRD(' .   ,  &€')
     A            S_CAPR         6Y 2O 10 47EDTWRD(' .   ,  &€')
     A            S_MENS         6Y 2O 10 62EDTWRD(' .   ,  &€')
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261104  161332  XUAN        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A                                      CA12(12 'retour')
     A                                      OVERLAY
     A  33                                  SFLDSP
     A  32                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  31                                  SFLEND(*MORE)
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  2TIME
     A                                  1 70USER
     A                                  2 70SYSNAME
     A                                  1 28'Calcul du prêt immobilier'
     A                                      COLOR(WHT)
     A                                  2 30'Tableau Amortissement'
     A                                      COLOR(WHT)
     A                                  4  4'Tableau des Amortissements :'
     A                                      COLOR(BLU)
     A                                  7  5'Coût total du prêt :'
     A                                  6  5'Coût des interets  :'
     A            C_TOTAL       12Y 2O  7 27EDTWRD(' .   .   .   ,  &€')
     A            C_INTERET     12  2O  6 27EDTWRD(' .   .   .   ,  &€')
     A                                  9  5'Mois'
     A                                      COLOR(WHT)
     A                                  9 11'Capital restant dû'
     A                                      COLOR(WHT)
     A                                  9 33'Intérêts'
     A                                      COLOR(WHT)
     A                                  9 45'Remb. Capital'
     A                                      COLOR(WHT)
     A                                  9 62'Mensualité'
     A                                      COLOR(WHT)
     A                                  5  5'Mensualité         :'
     A            C_MENS         6Y 2O  5 35EDTWRD(' .   ,  &€')
     A          R FOOT
     A*%%TS  SD  20261104  112819  XUAN        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 14'F12=Quitter'
     A                                      COLOR(BLU)
```

### BIB17 (DDS, 69 lignes)

```text
     A*%%TS  SD  20261104  163324  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20261104  163324  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                 23  2'F3=quitter'
     A                                      COLOR(BLU)
     A                                  1 33'Pret immobilier'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  5  5'Montant  :'
     A                                  7  5'Taux     :'
     A                                  9  5'Durée    :'
     A            MONTANT       10Y 0B  5 17EDTCDE(1)
     A            TAUX           5Y 2B  7 17EDTCDE(3)
     A            DUREE          2S 0B  9 17
     A                                 11  5'Méthode  :'
     A            METHODE        2Y 0B 11 17SNGCHCFLD((*NUMROW 2))
     A                                      CHOICE(1 '>Mensualités constantes')
     A                                      CHOICE(2 '>Amortissement constant')
     A          R SFL1                      SFL
     A*%%TS  SD  20261104  163324  REMI        REL-V7R5M0  5770-WDS
     A            MOIS           4S 0O 10  2
     A            CAPRESTDU     12Y 2O 10  9EDTCDE(1)
     A            INTERET        8Y 2O 10 30EDTCDE(2)
     A            REMBCAP        8Y 2O 10 46EDTCDE(2)
     A            MENSUALITE     8Y 2O 10 66EDTCDE(2)
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261104  163324  REMI        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0010)
     A                                      SFLPAG(0008)
     A                                      CF03(03)
     A                                      CF12(12)
     A  32                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 30'Tableau ammortissement'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  4  4'Tableau des Amortissements :'
     A                                      COLOR(BLU)
     A                                  6  8'Coût total du prêt  :'
     A                                  7  8'Coût des intérets   :'
     A            TOTPRET       13Y 2O  6 31EDTCDE(1)
     A            TOTINT        13Y 2O  7 31EDTCDE(1)
     A                                  9  2'Mois'
     A                                      COLOR(WHT)
     A                                  9  9'Capital restant dû'
     A                                      COLOR(WHT)
     A                                  9 31'Intérets'
     A                                      COLOR(WHT)
     A                                  9 44'Remb. Capital'
     A                                      COLOR(WHT)
     A                                  9 66'Mensualité'
     A                                      COLOR(WHT)
     A          R FOOT
     A*%%TS  SD  20261104  112949  REMI        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Quitter   F12=Retour'
     A                                      COLOR(BLU)
```

### BIB20 (DDS, 82 lignes)

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
