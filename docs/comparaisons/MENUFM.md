# MENUFM : 3 versions differentes dans 4 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB06 | QCLPSRC | CL/CL-procedural | 76 | 100 % | DDS (R/K/PFILE) | [MENUFM.md](../../sources/CL/CL-procedural/BIB06/MENUFM.md) |
| BIB17 | QCLPSRC | CL/CL-procedural | 23 | 14 % | DDS (R/K/PFILE) | [MENUFM.md](../../sources/CL/CL-procedural/BIB17/MENUFM.md) |
| BIB05 | QCLPSRC | CL/CL-procedural | 36 | 7 % | DDS (R/K/PFILE) | [MENUFM.md](../../sources/CL/CL-procedural/BIB05/MENUFM.md) |
| BIB10 | QDSPSRC | DDS | 76 | 100 % | DDS (R/K/PFILE) | [MENUFM.md](../../sources/DDS/BIB10/MENUFM.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)
- Langages / types differents : CL/CL-procedural, DDS

## Codes

### BIB06 (CL/CL-procedural, 76 lignes)

```text
     A*%%TS  SD  20260922  133653  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260922  133653  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  8 62'/`.'
     A                                  9 60'o_/'
     A                                      COLOR(BLU)
     A                                  9 64'\ '
     A                                 10 61'\/\'
     A                                      COLOR(BLU)
     A                                 10 65'`.'
     A                                 11 62'|    \ '
     A                                 12 61'/      `\'
     A                                 13 60'._________.'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 14 60'|._______.|'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 15 60'||'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 15 63'>WRK#'
     A                                 15 69'||'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 16 60'||'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 16 69'||'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 17 60'| _______ |'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 18 58'._^_________^_.'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 19 58'| ___~   IBM i|'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                  1 30'_  _  ____  __ _  _  _'
     A                                      COLOR(RED)
     A                                  2 29'( \/ )(  __)(  ( \/ )( \'
     A                                      COLOR(RED)
     A                                  3 29'/ \/ \ ) _) /    /) \/ ('
     A                                      COLOR(RED)
     A                                  4 29'\_)(_/(____)\_)__)\____/'
     A                                      COLOR(RED)
     A                                  7 10'1. PDM avec *CURLIB/QDDSSRC'
     A                                      COLOR(BLU)
     A                                  8 10'2. PDM avec *CURLIB/QCLPSRC'
     A                                      COLOR(BLU)
     A                                  9 10'3. Démarrer SDA'
     A                                      COLOR(BLU)
     A                                 10 10'4. Démarrer PDM'
     A                                      COLOR(BLU)
     A                                 11 10'5. WRKUSRJOB   '
     A                                      COLOR(BLU)
     A                                 15  3'Option:'
     A                                      COLOR(BLU)
     A                                 20 58'"_____________"'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 23 36'F3 Quitter'
     A                                      COLOR(BLU)
     A            OPT            1S 0B 15 11
     A  99                             19 10'Option non définie !!!'
     A                                      COLOR(RED)
```

### BIB17 (CL/CL-procedural, 23 lignes)

```text
     A*%%TS  SD  20260922  113503  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260922  113503  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 70DATE
     A                                      EDTCDE(Y)
     A                                  2 70TIME
     A                                  1 36'Menu Rémy'
     A                                  5  3'1. PDM avec'
     A                                  6  3'2. PDM avec'
     A                                  7  3'3. Démarrer SDA'
     A                                  8  3'4. Démarrer PDM'
     A                                  9  3'5. WRKUSRJOB'
     A                                 12  3'Option:'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                 20 36'F3=Quitter'
     A                                      COLOR(BLU)
     A            OPT            1S 0B 12 12
```

### BIB05 (CL/CL-procedural, 36 lignes)

```text
     A*%%TS  SD  20260922  133250  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260922  133250  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF09(09)
     A                                  1 36'menu dylan'
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 69DATE
     A                                      EDTCDE(Y)
     A                                  2 68TIME
     A                                  4  5' 1. PDM avec  *curlib/qdssrc'
     A                                  5  5' 2. pdm avec  *curlib/qclpsrc'
     A                                  6  5' 3. start sda '
     A                                  7  5' 4. start pdm '
     A                                  8  5' 5. wrkusrjob '
     A                                 10  3'input'
     A                                 11  4'output'
     A            FLD002         2A  I 10 11
     A            FLD005         4A  O 11 12
     A                                 12  4'both'
     A            FLD006         1A  B 12 10
     A                                 13  4'input num'
     A            FLD007         1S 0I 13 15
     A                                 14  4'output num'
     A            FLD008         1S 0O 14 16
     A                                 15  4'both num'
     A            FLD009         1S 0B 15 16
     A                                  9  6'option:'
     A            OPT           10S 0B  9 16
     A                                 20 16'sort avec f3  '
     A                                 20 35'd all spool f9  '
     A  99                             17 18'spool dtl'
     A                                      COLOR(PNK)
```

### BIB10 (DDS, 76 lignes)

```text
     A*%%TS  SD  20260922  133653  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260922  133653  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  8 62'/`.'
     A                                  9 60'o_/'
     A                                      COLOR(BLU)
     A                                  9 64'\ '
     A                                 10 61'\/\'
     A                                      COLOR(BLU)
     A                                 10 65'`.'
     A                                 11 62'|    \ '
     A                                 12 61'/      `\'
     A                                 13 60'._________.'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 14 60'|._______.|'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 15 60'||'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 15 63'>WRK#'
     A                                 15 69'||'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 16 60'||'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 16 69'||'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 17 60'| _______ |'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 18 58'._^_________^_.'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 19 58'| ___~   IBM i|'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                  1 30'_  _  ____  __ _  _  _'
     A                                      COLOR(RED)
     A                                  2 29'( \/ )(  __)(  ( \/ )( \'
     A                                      COLOR(RED)
     A                                  3 29'/ \/ \ ) _) /    /) \/ ('
     A                                      COLOR(RED)
     A                                  4 29'\_)(_/(____)\_)__)\____/'
     A                                      COLOR(RED)
     A                                  7 10'1. PDM avec *CURLIB/QDDSSRC'
     A                                      COLOR(BLU)
     A                                  8 10'2. PDM avec *CURLIB/QCLPSRC'
     A                                      COLOR(BLU)
     A                                  9 10'3. Démarrer SDA'
     A                                      COLOR(BLU)
     A                                 10 10'4. Démarrer PDM'
     A                                      COLOR(BLU)
     A                                 11 10'5. WRKUSRJOB   '
     A                                      COLOR(BLU)
     A                                 15  3'Option:'
     A                                      COLOR(BLU)
     A                                 20 58'"_____________"'
     A                                      COLOR(WHT)
     A                                      DSPATR(RI)
     A                                 23 36'F3 Quitter'
     A                                      COLOR(BLU)
     A            OPT            1S 0B 15 11
     A  99                             19 10'Option non définie !!!'
     A                                      COLOR(RED)
```
