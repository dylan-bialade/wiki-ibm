---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: EXPSRCIFS
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 68
modifie: 2026-11-16
---

# BIB17/QCLPSRC/EXPSRCIFS

```cl
             PGM
             DCLF       FILE(EXPSRCIFSD)
             DCLF       FILE(QSYS/QAFDMBR) RCDFMT(QWHFDMBR) OPNID(W)
             DCL        VAR(&PROFIL) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CHMIFS) TYPE(*CHAR) LEN(40)
             DCL        VAR(&FICIFS) TYPE(*CHAR) LEN(100)
             RTVJOBA    USER(&PROFIL)

 STRFMT1:    SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FINLECT))
             IF         COND((&PBIB *EQ '          ') *OR (&PFIC *EQ +
                          '          ')) THEN(GOTO CMDLBL(STRFMT1))

             CHGVAR     VAR(&IN90) VALUE('0')
             CHKOBJ     OBJ(&PBIB) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9810 CPF9801) EXEC(DO)
             CHGVAR     VAR(&IN90) VALUE('1')
             GOTO       CMDLBL(STRFMT1)
             ENDDO


             CHGVAR     VAR(&IN91) VALUE('0')
             CHKOBJ     OBJ(&PBIB/&PFIC) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9812 CPF9801) EXEC(CHGVAR VAR(&IN91) +
                          VALUE('1'))


             IF         COND(&IN90 *EQ '1' *OR &IN91 *EQ '1') +
                          THEN(GOTO CMDLBL(STRFMT1))

 /**********  ETAPE 4 ************************/

             CHGVAR     VAR(&CHMIFS) VALUE('/home/' *TCAT &PROFIL +
                          *TCAT '/' *TCAT &PFIC)
             RMVDIR     DIR(&CHMIFS) SUBTREE(*ALL)
             MONMSG     MSGID(CPFA0A9 CPFA0B7)
             MKDIR      DIR(&CHMIFS)

             SNDPGMMSG  MSG(&CHMIFS)

 /******  ETAPE 5  *********/

             DSPFD      FILE(&PBIB/&PFIC) TYPE(*MBR) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/TEMPFILE)
             OVRDBF     FILE(QAFDMBR) TOFILE(QTEMP/TEMPFILE) MBR(*ALL)

/***************  ETAPE6     *****/

 LECTMBR:    RCVF       OPNID(W)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FINLECT))
             CHGVAR     VAR(&COUNT) VALUE(&COUNT +1)
             IF         COND(&W_MBSEU2 *EQ '          ') THEN(CHGVAR +
                          VAR(&W_MBSEU2) VALUE('txt'))
             CHGVAR     VAR(&FICIFS) VALUE(&chmifs *tcat '/' +
                          *TCAT &w_MBNAME *TCAT '.' *tcat &w_MBSEU2)

         /*COPIE  */
             CPYTOSTMF  FROMMBR('/QSYS.LIB/' *TCAT &PBIB *TCAT +
                          '.LIB/' *TCAT &PFIC *TCAT '.FILE/' *TCAT +
                          &W_MBNAME *TCAT '.MBR') TOSTMF(&FICIFS) +
                          STMFOPT(*REPLACE) STMFCCSID(1208)

             GOTO       CMDLBL(LECTMBR)
 FINLECT:    SNDRCVF    RCDFMT(FMT2)
             DLTOVR     FILE(QAFDMBR)
             MONMSG     MSGID(CPF9841)

 ENDPGM:     ENDPGM
```
