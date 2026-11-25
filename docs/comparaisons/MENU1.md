# MENU1 : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB25 | QDDSSRC | DDS | 37 | 36 % | DDS (R/K/PFILE) | [MENU1.md](../../sources/DDS/BIB25/MENU1.md) |
| BIB27 | QCLSRC | CL/CL-procedural | 42 | 100 % | DDS (R/K/PFILE) | [MENU1.md](../../sources/CL/CL-procedural/BIB27/MENU1.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)
- Langages / types differents : CL/CL-procedural, DDS

## Codes

### BIB25 (DDS, 37 lignes)

```text
     A* Menu de format libre : MENU1
     A*%%TS  SD  20250217  161641  LEO2        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R MENU1
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP HOME
     A                                      HLPRTN
     A                                 01002'MENU1'
     A                                      COLOR(BLU)
     A                                 01034'MENU1 Menu'
     A                                      DSPATR(HI)
     A                                 03002'Choisir une des options suivantes -
     A                                      :'
     A                                      COLOR(BLU)
     A                                 05007'1.'
     A                                 06007'2.'
     A                                 07007'3.'
     A                                 08007'4.'
     A                                 09007'5.'
     A                                 10007'6.'
     A                                 11007'7.'
     A                                 12007'8.'
     A                                 13007'9.'
     A                                 14006'10.'
     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019002'Option ou commande                -
     A                                          '
```

### BIB27 (CL/CL-procedural, 42 lignes)

```text
     A* Menu de format libre : MENU1
     A*%%TS  SD  20231106  111529  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R MENU1
     A*%%TS  SD  20231106  111529  LEO2        REL-V7R4M0  5770-WDS
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP
     A                                      HOME
     A                                      HLPRTN
     A                                  1  2'MENU1'
     A                                      COLOR(BLU)
     A                                  1 34'MENU1 Menu'
     A                                      DSPATR(HI)
     A                                  3  2'Choisir une des options suivantes -
     A                                      :'
     A                                      COLOR(BLU)
     A                                  5  7'1.'
     A                                  6  7'2.'
     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019  2'Option ou commande                -
     A                                          '
     A                                  5 10'gestion des membres'
     A                                  6 10'gestion des objets'
     A                                      COLOR(YLW)
     A                                      DSPATR(HI)
     A                                 16  6'99.'
     A                                 16 10'sign off'
     A                                  1 61SYSNAME
     A                                  2 61USER
     A                                  3 61DATE
     A                                      EDTCDE(Y)
     A                                  4 61TIME
```
