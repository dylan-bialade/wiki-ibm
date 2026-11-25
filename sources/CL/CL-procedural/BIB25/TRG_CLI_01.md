---
bibliotheque: BIB25
fichier_source: QF_PFLF
membre: TRG_CLI_01
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 8
modifie: 2026-11-25
---

# BIB25/QF_PFLF/TRG_CLI_01

```cl
             PGM        PARM(&BUFFER &LENGTH)
             DCL        VAR(&BUFFER) TYPE(*CHAR) LEN(1000)
             DCL        VAR(&LENGTH) TYPE(*CHAR) LEN(4)
             DCL        VAR(&USERNAME) TYPE(*CHAR) LEN(10)
             RTVJOBA    CURUSER(&USERNAME)
             CALL       PGM(BIB25/TRG01R) PARM((&BUFFER) +
                          (&LENGTH) (&USERNAME))
             ENDPGM
```
