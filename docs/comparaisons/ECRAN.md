# ECRAN : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QSRC | DDS | 332 | 100 % | sous-fichier, DDS (R/K/PFILE) | [ECRAN.md](../../sources/DDS/BIB02/ECRAN.md) |
| BIB20 | QDDSSRC | DDS | 37 | 1 % | DDS (R/K/PFILE) | [ECRAN.md](../../sources/DDS/BIB20/ECRAN.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)
- **BIB02** en propre : sous-fichier

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
