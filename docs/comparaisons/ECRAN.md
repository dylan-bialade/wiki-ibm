# ECRAN : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QSRC | DDS | 332 | 0 % | sous-fichier, DDS (R/K/PFILE) | [ECRAN.md](../../sources/DDS/BIB02/ECRAN.md) |
| BIB20 | QDDSSRC | DDS | 37 | 0 % | DDS (R/K/PFILE) | [ECRAN.md](../../sources/DDS/BIB20/ECRAN.md) |
| BIB25 | QCLLESRC | CL/CL-ILE | 9 | 100 % |  | [ECRAN.md](../../sources/CL/CL-ILE/BIB25/ECRAN.md) |

## Differences

- **BIB02** en propre : sous-fichier, DDS (R/K/PFILE)
- **BIB20** en propre : DDS (R/K/PFILE)
- Langages / types differents : CL/CL-ILE, DDS

## Codes

### BIB02 (DDS, 332 lignes)

_Long : voir [ECRAN.md](../../sources/DDS/BIB02/ECRAN.md)._

### BIB20 (DDS, 37 lignes)

```text
     A* Menu de format libre : ECRAN
     A*%%TS  SD  20251003  131034  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R ECRAN
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP HOME
     A                                      HLPRTN
     A                                 01002'ECRAN'
     A                                      COLOR(BLU)
     A                                 01034'ECRAN Menu'
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

### BIB25 (CL/CL-ILE, 9 lignes)

```text
     A*%%TS  SD  20260305  100025  LEO2        REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R FMT1
     A*%%TS  SD  20260305  100025  LEO2        REL-V7R5M0  5770-WDS                  A                                      CA03(03)
     A                                  1 20'Listes des profils par classe util-     A                                      isateur'
     A                                      COLOR(BLU)                               A                                  3 65SYSNAME
     A                                  9 18'SECOFR .....:'                          A                                 10 18'PGMR .......:'
     A                                 11 18'USER .......:'                          A            NB_SECOFR     10Y 0O  9 34EDTCDE(Z)
     A            NB_PGMR       10Y 0O 10 34EDTCDE(Z)                                A            NB_USER       10Y 0O 11 34EDTCDE(Z)
     A                                 22  2'F3=Exit'                                A                                      COLOR(BLU)
```
