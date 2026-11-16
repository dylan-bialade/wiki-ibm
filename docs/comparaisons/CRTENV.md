# CRTENV : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QCLPSRC | CL/CL-procedural | 18 | 100 % | gestion d erreur | [CRTENV.md](../../sources/CL/CL-procedural/BIB05/CRTENV.md) |
| BIB10 | QCLPSRC | CL/CL-procedural | 5 | 0 % |  | [CRTENV.md](../../sources/CL/CL-procedural/BIB10/CRTENV.md) |

## Differences

- **BIB05** en propre : gestion d erreur

## Codes

### BIB05 (CL/CL-procedural, 18 lignes)

```text
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

### BIB10 (CL/CL-procedural, 5 lignes)

```text
             CMD        PROMPT('Création d''env de dev') +
                          TEXT('Création d''une lib et de fichiers +
                          source') MAXPOS(1)
             PARM       KWD(LIB) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Nom de la lib a créer')
```
