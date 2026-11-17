# CALCCL : 2 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB10 | QCLPSRC | CL/CL-procedural | 39 | 100 % | boucle DOW/DOU/FOR, CL : DCLF | [CALCCL.md](../../sources/CL/CL-procedural/BIB10/CALCCL.md) |
| BIB06 | QCLPSRC | CL/CL-procedural | 39 | 100 % | boucle DOW/DOU/FOR, CL : DCLF | [CALCCL.md](../../sources/CL/CL-procedural/BIB06/CALCCL.md) |
| BIB17 | QCLPSRC | CL/CL-procedural | 29 | 4 % | boucle DOW/DOU/FOR, CL : DCLF | [CALCCL.md](../../sources/CL/CL-procedural/BIB17/CALCCL.md) |

## Differences

- Techniques communes : boucle DOW/DOU/FOR, CL : DCLF

## Codes

### BIB10 (CL/CL-procedural, 39 lignes)

```text
             PGM
/* DECLARATION DE FICHIER                     */
             DCLF       FILE(CALCFM)
/* DECLARATION DE VARIABLE                    */
             DCL        VAR(&ERR) TYPE(*LGL) VALUE('0')
/* NETOYAGE DES VARIABLES                     */
 CLEAR:      CHGVAR     VAR(&FAC1) VALUE(0)
             CHGVAR     VAR(&FAC2) VALUE(0)
             CHGVAR     VAR(&COP) VALUE(' ')
             CHGVAR     VAR(&RESULT) VALUE(0)
             CHGVAR     VAR(&ERR) VALUE('0')
/* AFFICHAGE DE L'ECRAN                       */
 DEBUT:      SNDRCVF    RCDFMT(CALCFM1)
/* FUNCTION KEYS                              */
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             IF         COND(&IN06 *EQ '1') THEN(GOTO CMDLBL(CLEAR))
/* GESTION D'ERREURS                          */
             IF         COND(&FAC2 = 0) THEN(CHGVAR VAR(&ERR) VALUE('1'))
             IF         COND(&FAC2 *EQ 0) THEN(GOTO CMDLBL(DEBUT))
             IF         COND(&ERR = '1') THEN(DO)
             CHGVAR     VAR(&ERR) VALUE('0')
             GOTO       CMDLBL(DEBUT)
             ENDDO
/* TRAITEMENT PRINCIPAL                       */
             IF         COND(&COP *EQ '+') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 + &FAC2))
             IF         COND(&COP *EQ '-') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 - &FAC2))
             IF         COND(&COP *EQ '*') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 * &FAC2))
             IF         COND(&COP *EQ '/') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 / &FAC2))



             GOTO       CMDLBL(DEBUT)

/* FIN DE TRAITEMENT                          */
 FIN:        ENDPGM
```

### BIB06 (CL/CL-procedural, 39 lignes)

```text
             PGM
/* DECLARATION DE FICHIER                     */
             DCLF       FILE(CALCFM)
/* DECLARATION DE VARIABLE                    */
             DCL        VAR(&ERR) TYPE(*LGL) VALUE('0')
/* NETOYAGE DES VARIABLES                     */
 CLEAR:      CHGVAR     VAR(&FAC1) VALUE(0)
             CHGVAR     VAR(&FAC2) VALUE(0)
             CHGVAR     VAR(&COP) VALUE(' ')
             CHGVAR     VAR(&RESULT) VALUE(0)
             CHGVAR     VAR(&ERR) VALUE('0')
/* AFFICHAGE DE L'ECRAN                       */
 DEBUT:      SNDRCVF    RCDFMT(CALCFM1)
/* FUNCTION KEYS                              */
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             IF         COND(&IN06 *EQ '1') THEN(GOTO CMDLBL(CLEAR))
/* GESTION D'ERREURS                          */
             IF         COND(&FAC2 = 0) THEN(CHGVAR VAR(&ERR) VALUE('1'))
             IF         COND(&FAC2 *EQ 0) THEN(GOTO CMDLBL(DEBUT))
             IF         COND(&ERR = '1') THEN(DO)
             CHGVAR     VAR(&ERR) VALUE('0')
             GOTO       CMDLBL(DEBUT)
             ENDDO
/* TRAITEMENT PRINCIPAL                       */
             IF         COND(&COP *EQ '+') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 + &FAC2))
             IF         COND(&COP *EQ '-') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 - &FAC2))
             IF         COND(&COP *EQ '*') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 * &FAC2))
             IF         COND(&COP *EQ '/') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 / &FAC2))



             GOTO       CMDLBL(DEBUT)

/* FIN DE TRAITEMENT                          */
 FIN:        ENDPGM
```

### BIB17 (CL/CL-procedural, 29 lignes)

```text
             PGM
             DCLF       FILE(CALCDSP)
 START:      SNDRCVF    RCDFMT(CALCFMT)
             IF COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))

             /*VOIR F6 */

             IF COND(&COP *EQ '+') THEN(DO)
               CHGVAR VAR(&RESULT) VALUE(&FAC01 + &FAC02)
             ENDDO

             IF COND(&COP *EQ '-') THEN(DO)
               CHGVAR VAR(&RESULT) VALUE(&FAC01 - &FAC02)
             ENDDO

             IF COND(&COP *EQ '*') THEN(DO)
               CHGVAR VAR(&RESULT) VALUE(&FAC01 * &FAC02)
             ENDDO

             IF COND(&COP *EQ '/') THEN(DO)
               IF COND(&FAC02 *EQ 0) THEN(CHGVAR VAR(&RESULT) +
                          VALUE(0))
             ELSE       CMD(DO)
             CHGVAR VAR(&RESULT) VALUE(&FAC01 / &FAC02)
             ENDDO
             ENDDO
             GOTO CMDLBL(START)

 END:        ENDPGM
```
