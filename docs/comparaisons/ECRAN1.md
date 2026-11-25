# ECRAN1 : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB20 | QDDSSRC | DDS | 39 | 3 % | DDS (R/K/PFILE) | [ECRAN1.md](../../sources/DDS/BIB20/ECRAN1.md) |
| BIB27 | QCLSRC | CL/CL-procedural | 27 | 100 % | DDS (R/K/PFILE) | [ECRAN1.md](../../sources/CL/CL-procedural/BIB27/ECRAN1.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)
- Langages / types differents : CL/CL-procedural, DDS

## Codes

### BIB20 (DDS, 39 lignes)

```text
     A* Menu de format libre : ECRAN1
     A*%%TS  SD  20251003  131034  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R ECRAN1
     A*%%TS  SD  20251003  131034  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP
     A                                      HOME
     A                                      HLPRTN
     A                                  1  2'ECRAN1'
     A                                      COLOR(BLU)
     A                                  1 33'ECRAN1 Menu'
     A                                      DSPATR(HI)
     A                                  3  2'Choisir une des options suivantes -
     A                                      :'
     A                                      COLOR(BLU)
     A                                  5  7'1.'
     A                                  6  7'2.'
     A                                  7  7'3.'
     A                                  8  7'4.'
     A                                  9  7'5.'
     A                                 10  7'6.'
     A                                 11  7'7.'
     A                                 12  7'8.'
     A                                 13  7'9.'
     A                                 14  6'10.'
     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019  2'1ption ou commande                -
     A                                          '
```

### BIB27 (CL/CL-procedural, 27 lignes)

```text
     A*%%TS  SD  20231112  115312  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R FMT1
     A*%%TS  SD  20231106  131857  LEO2        REL-V7R4M0  5770-WDS
     A                                  1 35'mon ecran 1'
     A                                 10 13'saisie:'
     A                                      COLOR(BLU)
     A                                 19 36'f3=quiter '
     A                                      COLOR(BLU)
     A                                  2 62DATE
     A                                      EDTCDE(Y)
     A                                  6 10'1.  wrksplf'
     A                                  7 10'2.  strpdm'
     A                                  8 10'3.  quitter'
     A                                      COLOR(RED)
     A                                  1 62TIME
     A                                  1 10SYSNAME
     A                                  2 10USER
     A            SAISIE         1   B 10 21
     A                                 12 11'zone de 10 en both +b(10)'
     A            B10           10   B 12 38
     A                                 13 11'zone de 10 en output'
     A            O10           10   O 13 38
     A                                 14 11'zone de 10 en input'
     A            I10           10   I 14 38
```
