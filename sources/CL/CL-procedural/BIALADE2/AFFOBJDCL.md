---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: AFFOBJDCL
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 34
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/AFFOBJDCL

```cl
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
