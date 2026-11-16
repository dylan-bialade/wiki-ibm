# AFFOBJDCL : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB06 | QCLPSRC | CL/CL-procedural | 34 | 100 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [AFFOBJDCL.md](../../sources/CL/CL-procedural/BIB06/AFFOBJDCL.md) |
| BIB10 | QCLPSRC | CL/CL-procedural | 34 | 94 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [AFFOBJDCL.md](../../sources/CL/CL-procedural/BIB10/AFFOBJDCL.md) |

## Differences

- Techniques communes : boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF

## Codes

### BIB06 (CL/CL-procedural, 34 lignes)

```text
             PGM        PARM(&LIB)
/* Traitemet de fichier */
 /*  EXECUTER LA COMMANDE :                                        */
 /*    DSPOBJD OBJ(*CURLIB/*ALL) OBJTYPE(*ALL) OUTPUT(*OUTFILE)    */
 /*                OUTFILE(*CURLIB/DSPOBJD)                        */

/*declaration de fichier */
             DCLF       FILE(QADSPOBJ) OPNID(FDB)
             DCLF       FILE(AFFOBJDFM)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&COUNT) TYPE(*DEC) LEN(3 0)
             DSPOBJD    OBJ(&LIB/*ALL) OBJTYPE(*ALL) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/DSPOBJD)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             SNDPGMMSG  MSG('Lib' *BCAT &LIB *TCAT ' non trouvée')
             GOTO       CMDLBL(END)
             ENDDO
             OVRDBF     FILE(QADSPOBJ) TOFILE(QTEMP/DSPOBJD)
/* DECLARATION VARIABLES */
 LOOP:       RCVF       OPNID(FDB)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(END))
             CHGVAR     VAR(&COUNT) VALUE(&COUNT +1)
             CHGVAR     VAR(&ODLBNM) VALUE(&FDB_ODLBNM)
             CHGVAR     VAR(&ODOBNM) VALUE(&FDB_ODOBNM)
             CHGVAR     VAR(&ODOBTP) VALUE(&FDB_ODOBTP)
             CHGVAR     VAR(&ODOBAT) VALUE(&FDB_ODOBAT)
             CHGVAR     VAR(&ODOBSZ) VALUE(&FDB_ODOBSZ)
             SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))
             GOTO       CMDLBL(LOOP)
 END:        SNDPGMMSG  MSG('lib' *BCAT &lib *TCAT ':' *BCAT +
                          %CHAR(&COUNT) *BCAT 'Objects')
             DLTOVR     FILE(*ALL)
             ENDPGM
```

### BIB10 (CL/CL-procedural, 34 lignes)

```text
             PGM        PARM(&LIB)
/* Traitemet de fichier */
 /* EXECUTER LA COMMANDE :                                        */
 /*    DSPOBJD OBJ(*CURLIB/*ALL) OBJTYPE(*ALL) OUTPUT(*OUTFILE)    */
 /*                OUTFILE(*CURLIB/DSPOBJD)                        */

/*declaration de fichier */
             DCLF       FILE(QADSPOBJ) OPNID(FDB)
             DCLF       FILE(AFFOBJDFM)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&COUNT) TYPE(*DEC) LEN(3 0)
             DSPOBJD    OBJ(&LIB/*ALL) OBJTYPE(*ALL) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/DSPOBJD)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             SNDPGMMSG  MSG('Lib' *BCAT &LIB *TCAT ' non trouvée')
             GOTO       CMDLBL(END)
             ENDDO
             OVRDBF     FILE(QADSPOBJ) TOFILE(QTEMP/DSPOBJD)
/* DECLARATION VARIABLES */
 LOOP:       RCVF       OPNID(FDB)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(END))
             CHGVAR     VAR(&COUNT) VALUE(&COUNT +1)
             CHGVAR     VAR(&ODLBNM) VALUE(&FDB_ODLBNM)
             CHGVAR     VAR(&ODOBNM) VALUE(&FDB_ODOBNM)
             CHGVAR     VAR(&ODOBTP) VALUE(&FDB_ODOBTP)
             CHGVAR     VAR(&ODOBAT) VALUE(&FDB_ODOBAT)
             CHGVAR     VAR(&ODOBSZ) VALUE(&FDB_ODOBSZ)
             SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))
             GOTO       CMDLBL(LOOP)
 END:        SNDPGMMSG  MSG('lib' *BCAT &lib *TCAT ':' *BCAT +
                          %CHAR(&COUNT) *BCAT 'Objects')
             DLTOVR     FILE(*ALL)
             ENDPGM
```
