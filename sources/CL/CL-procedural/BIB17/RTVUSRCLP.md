---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: RTVUSRCLP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-16
---

# BIB17/QCLPSRC/RTVUSRCLP

```cl
             PGM
             DCLF       FILE(BIB17/RTVUSR1)
             DCL        VAR(&PROFILD) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CURLIBD) TYPE(*CHAR) LEN(10)
             DCL        VAR(&INLPGMD) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CCSIDD) TYPE(*DEC) LEN(5)
             DCL        VAR(&OUTQD) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SYSCCSIDN) TYPE(*DEC) LEN(5 0)
 START:      SNDRCVF RCDFMT(RTVUSRFMT1)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))
             RTVUSRPRF  USRPRF(&INPUTNM) INLPGM(&INLPGMD) +
                          OUTQ(&OUTQD) CURLIB(&CURLIBD) CCSID(&CCSIDD)

             IF         COND(&CCSIDD *EQ -2) THEN(DO)
             RTVSYSVAL  SYSVAL(QCCSID) RTNVAR(&SYSCCSIDN)
             CHGVAR     VAR(&CCSIDD) VALUE(&SYSCCSIDN)
             ENDDO

          /*GOTO CMDLBL(START)   */

             CHGVAR VAR(&CURLIB) VALUE(&CURLIBD)
             CHGVAR VAR(&INLPGM) VALUE(&INLPGMD)
             CHGVAR     VAR(&CCSID) VALUE(%CHAR(&CCSIDD))
             CHGVAR VAR(&OUTQ) VALUE(&OUTQD)
             CHGVAR VAR(&PROFIL) VALUE(&PROFILD)
 ZOB:        SNDRCVF    RCDFMT(RTVUSRFMT2)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))
             GOTO CMDLBL(ZOB)
 END:        ENDPGM
```
