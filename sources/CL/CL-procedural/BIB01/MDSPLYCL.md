---
bibliotheque: BIB01
fichier_source: QILE
membre: MDSPLYCL
type: CL/CL-procedural
longueur_enregistrement: 100
lignes: 15
modifie: 2026-11-16
---

# BIB01/QILE/MDSPLYCL

```cl
             PGM        PARM(&TXT)
             DCL        Var(&TXT) TYPE(*CHAR) LEN(250)
             DCL        VAR(&LEN) TYPE(*INT) LEN(4)
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7) VALUE(' ')
             DCL        VAR(&MSGFN) TYPE(*CHAR) LEN(20) VALUE(' ')

             IF         COND(&TXT *EQ *BLANKS) THEN(CHGVAR VAR(&TXT) +
                          VALUE('Hello World !!!'))

             CHGVAR     VAR(&LEN) VALUE(%LEN(&TXT))

             CALL       PGM(QUILNGTX) PARM((&TXT) (&LEN) (&MSGID) +
                          (&MSGFN) (X'0000000000000000'))

             ENDPGM
```
