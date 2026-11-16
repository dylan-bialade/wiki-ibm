---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: QCLPSRC
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 20
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/QCLPSRC

```cl
             PGM        PARM(&LIBRARY)
             DCLF       FILE(QADSPOBJ) OPNID(D)
             DCLF       FILE(DSPOBJDCL1)
             DCL        VAR(&COUNT) TYPE(*DEC) LEN(3 0) VALUE(0)
             DCL        VAR(&LIBRARY) TYPE(*CHAR) LEN(10)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             DSPOBJD    OBJ(&LIBRARY/*ALL) OBJTYPE(*ALL) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/DSPOBJD)
             OVRDBF     FILE(QADSPOBJ) TOFILE(QTEMP/DSPOBJD)
 LECTURE:    RCVF       OPNID(D)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
             CHGVAR     VAR(&COUNT) VALUE(&COUNT + 1)
             CHGVAR     VAR(&ODOBNM) VALUE(&D_ODOBNM)
             CHGVAR     VAR(&ODDCEN)  VALUE(&D_ODDCEN)
             CHGVAR     VAR(&ODDDAT)  VALUE(&D_ODDDAT)
             CHGVAR     VAR(&ODDTIM)  VALUE(&D_ODDTIM)
             SNDRCVF    RCDFMT(FMT1)
             GOTO       CMDLBL(LECTURE)
             SNDPGMMSG  MSG(&LIBRARY *BCAT %CHAR(&COUNT))
 FIN:        ENDPGM
```
