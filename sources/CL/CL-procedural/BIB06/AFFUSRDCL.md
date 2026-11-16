---
bibliotheque: BIB06
fichier_source: QCLPSRC
membre: AFFUSRDCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 27
modifie: 2026-11-16
---

# BIB06/QCLPSRC/AFFUSRDCL

```cl
             PGM        PARM(&USER)
/*declaration de fichier */
             DCLF       FILE(QADSPUPB) OPNID(FDB)
             DCLF       FILE(AFFUSRDFM)
             DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MAX) TYPE(*DEC) LEN(10 0)
             DCL        VAR(&COUNT) TYPE(*DEC) LEN(10 0)
             DSPUSRPRF  USRPRF(&USER) OUTPUT(*OUTFILE) +
                          OUTFILE(QTEMP/DSPUSR)
             OVRDBF     FILE(QADSPUPB) TOFILE(QTEMP/DSPUSR)
             RTVMBRD    FILE(QTEMP/DSPUSR) NBRCURRCD(&MAX)

/* DECLARATION VARIABLES */
 LOOP:       RCVF       OPNID(FDB)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(END))
             CHGVAR     VAR(&COUNT) VALUE(&COUNT +1)
             CHGVAR     VAR(&UPUPRF) VALUE(&FDB_UPUPRF)
             CHGVAR     VAR(&UPPWCD) VALUE(&FDB_UPPWCD)
             CHGVAR     VAR(&UPINPG) VALUE(&FDB_UPINPG)
             CHGVAR     VAR(&UPINPL) VALUE(&FDB_UPINPL)
             CHGVAR     VAR(&NBUSR) VALUE( %CHAR(&COUNT) *TCAT '/' +
                          *CAT %CHAR(&MAX))
             SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))
             GOTO       CMDLBL(LOOP)
  END:       DLTOVR     FILE(*ALL)
             ENDPGM
```
