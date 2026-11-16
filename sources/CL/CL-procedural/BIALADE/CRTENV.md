---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: CRTENV
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/CRTENV

```cl
PGM   PARM(&LIB)
            DCL        VAR(&LIB) TYPE(*CHAR) LEN(25)
            ADDLIBLE   LIB(&LIB)
            MONMSG     MSGID(CPF2110)
            MONMSG     MSGID(CPF2103)
            CRTLIB LIB(&LIB)
            MONMSG     MSGID(CPF2111)
            IF         COND(&LIB *NE ' ')
            SNDMSG     MSG('VEUILLEZ RESENSEIGNER UN LIB') +
                         TOUSR(*REQUESTER)

             CRTSRCPF   FILE(&LIB/QRPGSRC) RCDLEN(112)
             MONMSG     MSGID(CPF7302)
             CRTSRCPF   FILE(&LIB/QDDSSRC) RCDLEN(112)
             MONMSG     MSGID(CPF7302)
              CRTSRCPF   FILE(&LIB/QCLPSRC) RCDLEN(112)
              MONMSG     MSGID(CPF7302)
ENDPGM
```
