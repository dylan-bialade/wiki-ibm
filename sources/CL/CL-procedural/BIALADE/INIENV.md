---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: INIENV
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/INIENV

```cl
PGM    PARM(&LIB)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(25)
             ADDLIBLE   LIB(&LIB)
             MONMSG     MSGID(CPF2103)
             CRTLIB LIB(&LIB)
             MONMSG     MSGID(CPF2111)
             IF         COND(&LIB *NE ' ')
             SNDMSG     MSG('veuillez resenseigner un lib') +
                          TOUSR(*REQUESTER)

             CRTSRCPF   FILE(&LIB/QCLLESRC) RCDLEN(112)
             MONMSG     MSGID(CPF7302)
             CRTSRCPF   FILE(&LIB/QDDSSRC) RCDLEN(112)
             MONMSG     MSGID(CPF7302)
             CPYSRCF    FROMFILE(ADRIEN/QCLLESRC) +
                          TOFILE(&LIB/QCLLESRC) FROMMBR(TSTADRIEN)
             MONMSG     MSGID(CPF2817)
             CPYSRCF    FROMFILE(ADRIEN/QDDSSRC) +
                          TOFILE(&LIB/QDDSSRC) FROMMBR(TSTADRIEND)
             MONMSG     MSGID(CPF2817)
             CRTDSPF    FILE(&LIB/TSTADRIEND) SRCFILE(&LIB/TSTADRIEND)
             MONMSG     MSGID(CPF7302)
             CRTCLPGM PGM(&LIB/TSTADRIEN) +
                          SRCFILE(&LIB/QCLLESRC) REPLACE(*NO)
             MONMSG     MSGID(CPF0801)
             CRTCLPGM PGM(&LIB/TSTADRIEN) +
                          SRCFILE(&LIB/QCLLESRC)
             MONMSG     MSGID(CPF0801)
ENDPGM
```
