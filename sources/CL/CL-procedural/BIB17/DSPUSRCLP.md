---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: DSPUSRCLP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 22
modifie: 2026-11-16
---

# BIB17/QCLPSRC/DSPUSRCLP

```cl
             PGM        PARM(&USER)
             DCLF       FILE(QSYS/QADSPUPB) OPNID(F)
             DCLF       FILE(DSPUSRDSP)
             DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
             DSPUSRPRF  USRPRF(&USER) OUTPUT(*OUTFILE) +
                          OUTFILE(QTEMP/DSPUPBD)
             OVRDBF     FILE(QADSPUPB) TOFILE(QTEMP/DSPUPBD)
 LECTURE:    RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))
             CHGVAR     VAR(&UPUSCL) VALUE(&F_UPUSCL)
             CHGVAR     VAR(&UPUPRF) VALUE(&F_UPUPRF)
             CHGVAR     VAR(&UPINPG) VALUE(&F_UPINPG)
             CHGVAR     VAR(&UPCRLB) VALUE(&F_UPCRLB)
             CHGVAR     VAR(&UPINMN) VALUE(&F_UPINMN)

             SNDRCVF    RCDFMT(DSPUSRFMT)
             GOTO       CMDLBL(LECTURE)
 FIN:        SNDPGMMSG  MSG('ZOB')

 END:        DLTOVR FILE(*ALL)
             ENDPGM
```
