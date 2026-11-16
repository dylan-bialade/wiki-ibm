---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: AFFSPOOL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 6
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/AFFSPOOL

```cl
             PGM        PARM(&VAR1)
             DCL        VAR(&VAR1) TYPE(*CHAR) LEN(10)
             WRKSPLF    SELECT(&VAR1)
             MONMSG     MSGID(CPF0000) EXEC(SNDMSG MSG('Utilisateur +
                          introuvable !!!!') TOUSR(*REQUESTER))
             ENDPGM
```
