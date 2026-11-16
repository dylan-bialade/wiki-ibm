---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: DSPOBJDCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 22
modifie: 2026-11-16
---

# BIB17/QCLPSRC/DSPOBJDCL

```cl
             PGM        PARM(&LIBRARY)
             DCLF       FILE(QSYS/QADSPOBJ) OPNID(F)
             DCLF       FILE(DSPOBJDDSP)
             DCL        VAR(&COUNT) TYPE(*DEC) LEN(3 0) VALUE(0)
             DCL        VAR(&LIBRARY) TYPE(*CHAR) LEN(10)
             DSPOBJD    OBJ(&LIBRARY/*ALL) OBJTYPE(*ALL) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/DSPOBJD)
             OVRDBF     FILE(QADSPOBJ) TOFILE(QTEMP/DSPOBJD)
 LECTURE:    RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))
             CHGVAR     VAR(&ODOBNM) VALUE(&F_ODOBNM)
             CHGVAR     VAR(&ODOBSZ) VALUE(&F_ODOBSZ)
             CHGVAR     VAR(&ODOBAT) VALUE(&F_ODOBAT)
             CHGVAR     VAR(&ODOBTP) VALUE(&F_ODOBTP)
             CHGVAR     VAR(&ODLBNM) VALUE(&F_ODLBNM)
             SNDRCVF    RCDFMT(DSPOBJDFMT)
             GOTO       CMDLBL(LECTURE)

 FIN:        SNDPGMMSG  MSG(&LIBRARY *BCAT %CHAR(&COUNT))

 END:        ENDPGM
```
