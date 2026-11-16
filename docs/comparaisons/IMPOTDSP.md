# IMPOTDSP : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB10 | QDSPSRC | DDS | 43 | 100 % | DDS (R/K/PFILE) | [IMPOTDSP.md](../../sources/DDS/BIB10/IMPOTDSP.md) |
| BIB17 | QDDSSRC | DDS | 47 | 15 % | DDS (R/K/PFILE) | [IMPOTDSP.md](../../sources/DDS/BIB17/IMPOTDSP.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)

## Codes

### BIB10 (DDS, 43 lignes)

```text
     A*%%TS  SD  20261020  153758  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20261020  153758  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  1 70USER
     A                                  2 23'Calculateur d''impots sur le reven-
     A                                      ue'
     A                                      COLOR(WHT)
     A                                  5  7'Indiquez vos choix puis appuyez su-
     A                                      r ENTREE'
     A                                      COLOR(BLU)
     A                                  7  7'Votre revenue net imposable sur un-
     A                                      e année ......:'
     A                                  9 39'Pacsé / Marié ..:'
     A                                 11 36'Nombre d''enfant ...:'
     A            NBENF          3S 0B 11 58
     A            MARIE          2Y 0B  9 58SNGCHCFLD((*NUMCOL 2))
     A                                      CHOICE(1 'NON')
     A                                      CHOICE(2 'OUI')
     A                                 23  5'F3=Exit'
     A                                      COLOR(BLU)
     A            NETIMPOT      10Y 2B  7 58EDTWRD('  &   & 0 ,  &€')
     A          R FMT2
     A*%%TS  SD  20261020  144650  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  1 70USER
     A                                  2 33'Votre estimation'
     A                                      COLOR(WHT)
     A                                 23  5'F3=Exit'
     A                                      COLOR(BLU)
     A                                  6  5'Pour un salaire imposable de .....-
     A                                      .......:'
     A                                  7  5'L''impôt sur le revenu s''élèvera -
     A                                      à .......:'
     A                                  8  5'Il vous restera ..................-
     A                                      .......:'
     A            NETIMPOT      10Y 2O  6 49EDTWRD('  &   &  0,  &€')
     A            IMPOTD        10Y 2O  7 49EDTWRD('  &   &  0,  &€')
     A            REST          10Y 2O  8 49EDTWRD('  &   &  0,  &€')
```

### BIB17 (DDS, 47 lignes)

```text
     A*%%TS  SD  20261020  140536  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20261020  140536  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 24'Calculateur d''impot sur le revenu'
     A                                      COLOR(WHT)
     A                                  5  6'Indiquez vos choix, puis appuyez s-
     A                                      ur ENTREE'
     A                                      COLOR(BLU)
     A                                  7  6'Votre revenus net imposable sur un-
     A                                      e année . . .'
     A                                 23  4'F3=Quitter'
     A                                      COLOR(BLU)
     A                                  9 34'Pacsé / Marié'
     A            CHOIX          2Y 0B  9 57SNGCHCFLD((*NUMCOL 2))
     A                                      CHOICE(1 '>OUI')
     A                                      CHOICE(2 '>NON')
     A                                 11 32'Nombre d''enfant . . .'
     A            NBENF          2  0B 11 57
     A            REVNET         8  2B  7 57
     A                                      EDTWRD('      ,  ')
     A          R FMT2
     A*%%TS  SD  20261020  140536  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF12(12)
     A                                  1  2SYSNAME
     A                                  1 70USER
     A                                  1 33'Votre estimation'
     A                                      COLOR(WHT)
     A                                  5  6'Pour un salaire net imposable de .-
     A                                       . .'
     A                                  7  6'L''impot sur le revenu s''élèvera -
     A                                      à . . .'
     A                                  9  6'Il vous restera . . . . . . . . . -
     A                                      . . .'
     A            REVNET         8Y 2O  5 49COLOR(WHT)
     A                                      EDTWRD('      ,  ')
     A            IMPOT          8Y 2O  7 49COLOR(WHT)
     A                                      EDTWRD('      ,  ')
     A            RESTE          8Y 2O  9 49COLOR(WHT)
     A                                      EDTWRD('      ,  ')
     A                                 23  5'F3=Exit     F12=Retour'
     A                                      COLOR(BLU)
```
