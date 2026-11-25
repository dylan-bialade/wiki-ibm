# TESTCL : 3 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QCLLESRC | CL/CL-ILE | 12 | 100 % |  | [TESTCL.md](../../sources/CL/CL-ILE/BIB02/TESTCL.md) |
| BIB02 | QDDSRC | DDS | 6 | 7 % | CL : DCLF | [TESTCL.md](../../sources/DDS/BIB02/TESTCL.md) |
| BIB27 | QCLSRC | CL/CL-procedural | 11 | 5 % | boucle DOW/DOU/FOR, CL : DCLF | [TESTCL.md](../../sources/CL/CL-procedural/BIB27/TESTCL.md) |

## Differences

- **BIB02** en propre : CL : DCLF
- **BIB27** en propre : boucle DOW/DOU/FOR, CL : DCLF
- Langages / types differents : CL/CL-ILE, CL/CL-procedural, DDS

## Codes

### BIB02 (CL/CL-ILE, 12 lignes)

```text
/*----------------------------------------------------------------------------*//* Programme : TESTCL                                                   */
/* Libellé   : CLLE                                                           *//*----------------------------------------------------------------------------*/
/* Projet    : BIB02                                                         *//* Auteur    : Sylvain BIB02                                                 */
/* Date      : 09/04/2023                                                     *//*----------------------------------------------------------------------------*/
             PGM                                                                             COPYRIGHT  TEXT('(C) ORGFORM 2023.')
             DCL        VAR(&SAVF) TYPE(*CHAR) LEN(10) VALUE(SVENT)                          DCL        VAR(&BIB) TYPE(*CHAR) LEN(10) VALUE(BORG)
                                                                                             ADDLIBLE   LIB(&BIB) POSITION(*LAST)
             CPYF       FROMFILE(BIB02/ENTREPOT) TOFILE(BIB02/ENTREPOT2) +                              MBROPT(*ADD) CRTFILE(*YES)
             CRTSAVF    FILE(&BIB/&SAVF)                                                     SAVOBJ     OBJ(ENTREPOT2) LIB(BIB02) DEV(*SAVF) +
                          OBJTYPE(*FILE) SAVF(&BIB/&SAVF)                                    ADDLIBLE   LIB(&BIB) POSITION(*LAST)

             ENDPGM
```

### BIB02 (DDS, 6 lignes)

```text
             PGM
             DCLF       FILE(BIB02/AGENCEDSP)

             SNDRCVF    RCDFMT(FMT6)

             ENDPGM
```

### BIB27 (CL/CL-procedural, 11 lignes)

```text
             PGM
             DCLF       FILE(TEST_01)
             DOWHILE    COND(&IN03 *EQ '0')
 BOUCLE:     SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN50) THEN(DO)
             CHGVAR     VAR(&USRNAME) VALUE('léo')
             SNDRCVF    RCDFMT(FMT1)
             GOTO       CMDLBL(BOUCLE)
             ENDDO
             ENDDO
             ENDPGM
```
