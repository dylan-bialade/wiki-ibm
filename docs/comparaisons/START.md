# START : 2 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QCLPSRC | CL/CL-procedural | 64 | 0 % | DDS (R/K/PFILE) | [START.md](../../sources/CL/CL-procedural/BIB05/START.md) |
| BIB25 | QCLLESRC | CL/CL-ILE | 6 | 100 % |  | [START.md](../../sources/CL/CL-ILE/BIB25/START.md) |
| BIB27 | QCLSRC | CL/CL-procedural | 6 | 100 % |  | [START.md](../../sources/CL/CL-procedural/BIB27/START.md) |

## Differences

- **BIB05** en propre : DDS (R/K/PFILE)
- Langages / types differents : CL/CL-ILE, CL/CL-procedural

## Codes

### BIB05 (CL/CL-procedural, 64 lignes)

```text
     A* Menu de format libre : START
     A*%%TS  SD  20261006  162737  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R START
     A*%%TS  SD  20260921  145330  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP
     A                                      HOME
     A                                      HLPRTN
     A                                  1  2'START'
     A                                      COLOR(BLU)
     A                                  1 34'START Menu'
     A                                      DSPATR(HI)
     A                                  3  2'Choisir une des options suivantes -
     A                                      :'
     A                                      COLOR(BLU)
     A                                  5  7'1.'
     A                                  6  7'2.'
     A                                  6 10'strpda'
     A                                  8  7'4.'
     A                                  8 10'wrkobj'
     A                                 10  7'6.'
     A                                 10 10'crée une source pf'
     A                                 12  7'8.'
     A                                 12 10'dlt all sp'
     A                                 14  6'10.'
     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019  2'Option ou commande                -
     A                                          '
     A                                  5 10'strpdm'
     A                                  7  7'3.'
     A                                  7 10'wrksplf'
     A                                  9  7'5.'
     A                                  9 10'dsplib'
     A                                 11  7'7.'
     A                                 11 10'uppdta'
     A                                  6 28'²O²'
     A                                  7 28'/|\'
     A                                  8 28'/'
     A                                  8 30'\'
     A                                 13  7'9.'
     A                                 10 45'_______'
     A                                 11 39' _____//_||_\`--.__'
     A                                 12 39'[____|_¶__¶__|_¶___\'
     A                                 13 42' `-(_)----(_)-'
     A                                 13 10'send message'
     A                                 14 10'voir message'
     A                                 15  6'11.'
     A                                 15 10'travaux utilisateur'
     A                                  1 66DATE
     A                                      EDTCDE(Y)
     A                                  2 65TIME
     A                                  9 23'https://4613189023.digiforma.net/t-
     A                                      s/3054308/attendances'
```

### BIB25 (CL/CL-ILE, 6 lignes)

```text
             PGM
             /* COMMENTAIRES */
             DCL        VAR(&CURLIB) TYPE(*CHAR) LEN(10) +
                          VALUE('BIB27')
             CHGLIBL    LIBL(QTEMP QGPL BIB27) CURLIB(&CURLIB)
             ENDPGM
```

### BIB27 (CL/CL-procedural, 6 lignes)

```text
             PGM
             /* COMMENTAIRES */
             DCL        VAR(&CURLIB) TYPE(*CHAR) LEN(10) +
                          VALUE('BIB27')
             CHGLIBL    LIBL(QTEMP QGPL BIB27) CURLIB(&CURLIB)
             ENDPGM
```
