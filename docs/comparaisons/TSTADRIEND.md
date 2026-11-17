# TSTADRIEND : 2 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB01 | QDDSSRC | DDS | 37 | 100 % | DDS (R/K/PFILE) | [TSTADRIEND.md](../../sources/DDS/BIB01/TSTADRIEND.md) |
| BIB01 | QDDSSRC92 | DDS | 37 | 43 % | DDS (R/K/PFILE) | [TSTADRIEND~QDDSSRC92.md](../../sources/DDS/BIB01/TSTADRIEND~QDDSSRC92.md) |
| BIB07 | QDDSSRC | DDS | 37 | 100 % | DDS (R/K/PFILE) | [TSTADRIEND.md](../../sources/DDS/BIB07/TSTADRIEND.md) |
| BIB16 | QDDSSRC | DDS | 37 | 100 % | DDS (R/K/PFILE) | [TSTADRIEND.md](../../sources/DDS/BIB16/TSTADRIEND.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)

## Codes

### BIB01 (DDS, 37 lignes)

```text
     A*%%TS  SD  20251009  123354  FADRIEN     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20251009  123354  FADRIEN     REL-V7R5M0  5770-WDS
     A            FIRSTBIB      10A  O  5 39
     A  90                                  COLOR(RED)
     A                                  5 17'1ere bibliothèque . :'
     A                                      COLOR(BLU)
     A            BIBSRCFILE    10A  O 15 39
     A  95                                  COLOR(RED)
     A            BIBSRCPGM     10A  O 17 39
     A  96                                  COLOR(RED)
     A                                 15 17'SRCFLIB ecran       :'
     A                                      COLOR(BLU)
     A                                 17 17'SRCFLIB PGM         :'
     A                                      COLOR(BLU)
     A                                  7 17'Fichier QDDSSRC     :'
     A                                      COLOR(BLU)
     A                                  9 17'Fichier QCLLESRC    :'
     A                                      COLOR(BLU)
     A                                 11 17'Membre TSTADRIEND   :'
     A                                      COLOR(BLU)
     A                                 13 17'Membre TSTADRIEN    :'
     A                                      COLOR(BLU)
     A N91                              7 39'OK'
     A  91                              7 39'NOK'
     A  91                                  COLOR(RED)
     A N92                              9 39'OK'
     A  92                              9 39'NOK'
     A  92                                  COLOR(RED)
     A N93                             11 39'OK'
     A  93                             11 39'NOK'
     A  93                                  COLOR(RED)
     A N94                             13 39'OK'
     A  94                             13 39'NOK'
     A  94                                  COLOR(RED)
```

### BIB01 (DDS, 37 lignes)

```text
     A*%%TS  SD  20251009  122652  FADRIEN     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20251009  122652  FADRIEN     REL-V7R5M0  5770-WDS
     A            FIRSTBIB      10A  O  5 42
     A  90                                  COLOR(RED)
     A                                  5 17'1ere bibliothèque . :'
     A                                      COLOR(BLU)
     A            BIBSRCFILE    10A  O 15 42
     A  95                                  COLOR(RED)
     A            BIBSRCPGM     10A  O 17 42
     A  96                                  COLOR(RED)
     A                                 15 17'SRCFLIB ecran       :'
     A                                      COLOR(BLU)
     A                                 17 17'SRCFLIB PGM         :'
     A                                      COLOR(BLU)
     A                                  7 17'Fichier QDDSSRC     :'
     A                                      COLOR(BLU)
     A                                  9 17'Fichier QCLLESRC    :'
     A                                      COLOR(BLU)
     A                                 11 17'Membre TSTADRIEND   :'
     A                                      COLOR(BLU)
     A                                 13 17'Membre TSTADRIEN    :'
     A                                      COLOR(BLU)
     A N91                              7 42'OK'
     A  91                              7 42'NOK'
     A  91                                  COLOR(RED)
     A N92                              9 42'OK'
     A  92                              9 42'NOK'
     A  92                                  COLOR(RED)
     A N93                             11 42'OK'
     A  93                             11 42'NOK'
     A  93                                  COLOR(RED)
     A N94                             13 42'OK'
     A  94                             13 42'NOK'
     A  94                                  COLOR(RED)
```

### BIB07 (DDS, 37 lignes)

```text
     A*%%TS  SD  20251009  123354  FADRIEN     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20251009  123354  FADRIEN     REL-V7R5M0  5770-WDS
     A            FIRSTBIB      10A  O  5 39
     A  90                                  COLOR(RED)
     A                                  5 17'1ere bibliothèque . :'
     A                                      COLOR(BLU)
     A            BIBSRCFILE    10A  O 15 39
     A  95                                  COLOR(RED)
     A            BIBSRCPGM     10A  O 17 39
     A  96                                  COLOR(RED)
     A                                 15 17'SRCFLIB ecran       :'
     A                                      COLOR(BLU)
     A                                 17 17'SRCFLIB PGM         :'
     A                                      COLOR(BLU)
     A                                  7 17'Fichier QDDSSRC     :'
     A                                      COLOR(BLU)
     A                                  9 17'Fichier QCLLESRC    :'
     A                                      COLOR(BLU)
     A                                 11 17'Membre TSTADRIEND   :'
     A                                      COLOR(BLU)
     A                                 13 17'Membre TSTADRIEN    :'
     A                                      COLOR(BLU)
     A N91                              7 39'OK'
     A  91                              7 39'NOK'
     A  91                                  COLOR(RED)
     A N92                              9 39'OK'
     A  92                              9 39'NOK'
     A  92                                  COLOR(RED)
     A N93                             11 39'OK'
     A  93                             11 39'NOK'
     A  93                                  COLOR(RED)
     A N94                             13 39'OK'
     A  94                             13 39'NOK'
     A  94                                  COLOR(RED)
```

### BIB16 (DDS, 37 lignes)

```text
     A*%%TS  SD  20251009  123354  FADRIEN     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20251009  123354  FADRIEN     REL-V7R5M0  5770-WDS
     A            FIRSTBIB      10A  O  5 39
     A  90                                  COLOR(RED)
     A                                  5 17'1ere bibliothèque . :'
     A                                      COLOR(BLU)
     A            BIBSRCFILE    10A  O 15 39
     A  95                                  COLOR(RED)
     A            BIBSRCPGM     10A  O 17 39
     A  96                                  COLOR(RED)
     A                                 15 17'SRCFLIB ecran       :'
     A                                      COLOR(BLU)
     A                                 17 17'SRCFLIB PGM         :'
     A                                      COLOR(BLU)
     A                                  7 17'Fichier QDDSSRC     :'
     A                                      COLOR(BLU)
     A                                  9 17'Fichier QCLLESRC    :'
     A                                      COLOR(BLU)
     A                                 11 17'Membre TSTADRIEND   :'
     A                                      COLOR(BLU)
     A                                 13 17'Membre TSTADRIEN    :'
     A                                      COLOR(BLU)
     A N91                              7 39'OK'
     A  91                              7 39'NOK'
     A  91                                  COLOR(RED)
     A N92                              9 39'OK'
     A  92                              9 39'NOK'
     A  92                                  COLOR(RED)
     A N93                             11 39'OK'
     A  93                             11 39'NOK'
     A  93                                  COLOR(RED)
     A N94                             13 39'OK'
     A  94                             13 39'NOK'
     A  94                                  COLOR(RED)
```
