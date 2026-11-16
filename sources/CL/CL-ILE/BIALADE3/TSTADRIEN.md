---
bibliotheque: BIALADE3
fichier_source: QCLLESRC
membre: TSTADRIEN
type: CL/CL-ILE
longueur_enregistrement: 100
lignes: 49
modifie: 2026-11-16
---

# BIALADE3/QCLLESRC/TSTADRIEN

```cl
             PGM        PARM(&PARM)
             DCLF       FILE(TSTADRIEND)
             DCL        VAR(&PARM) TYPE(*CHAR) LEN(10)
             DCL        VAR(&USRLIBL) TYPE(*CHAR) LEN(2750)

/* 1ere position de bibliotheque */
             RTVJOBA    USRLIBL(&USRLIBL)
             CHGVAR     VAR(&FIRSTBIB) VALUE(%SST(&USRLIBL 1 10))
             IF         COND(&PARM *NE &FIRSTBIB) THEN(CHGVAR +
                          VAR(&IN90) VALUE('1'))

/* controle QCLLESRC et QDDSSRC */
             CHKOBJ     OBJ(&PARM/QDDSSRC) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF0000) EXEC(CHGVAR VAR(&IN91) +
                          VALUE('1'))
             CHKOBJ     OBJ(&PARM/QCLLESRC) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF0000) EXEC(CHGVAR VAR(&IN92) +
                          VALUE('1'))

/* Controle des sources TSTADRIEN et TSTADRIEND */
             CHKOBJ     OBJ(&PARM/QDDSSRC) OBJTYPE(*FILE) +
                          MBR(TSTADRIEND)
             MONMSG     MSGID(CPF0000) EXEC(CHGVAR VAR(&IN93) +
                          VALUE('1'))
             CHKOBJ     OBJ(&PARM/QCLLESRC) OBJTYPE(*FILE) +
                          MBR(TSTADRIEN)
             MONMSG     MSGID(CPF0000) EXEC(CHGVAR VAR(&IN94) +
                          VALUE('1'))
/* Controle des compilations                    */
             RTVOBJD    OBJ(&PARM/TSTADRIEND) OBJTYPE(*FILE) +
                          SRCFLIB(&BIBSRCFILE)
             MONMSG     MSGID(CPF9812)

             IF         COND(&PARM *NE &BIBSRCFILE) THEN(DO)
             CHGVAR VAR(&IN95) VALUE('1')
             CHGVAR     VAR(&BIBSRCFILE) VALUE('XXXXXXXXXX')
             ENDDO

             RTVOBJD    OBJ(&PARM/TSTADRIEND) OBJTYPE(*FILE) +
                          SRCFLIB(&BIBSRCPGM)
             MONMSG     MSGID(CPF9812)

             IF         COND(&PARM *NE &BIBSRCPGM) THEN(DO)
             CHGVAR VAR(&IN96) VALUE('1')
             CHGVAR     VAR(&BIBSRCPGM) VALUE('XXXXXXXXXX')
             ENDDO

             SNDRCVF    RCDFMT(FMT1)
ENDPGM
```
