---
bibliotheque: BIB25
fichier_source: QTEST
membre: TSTCL1
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 4
modifie: 2026-11-25
---

# BIB25/QTEST/TSTCL1

```cl
             PGM
             DCL        VAR(&PARAM1) TYPE(*CHAR) LEN(25) VALUE(TEST)
             CALL       PGM(*LIBL/TSTPGM1) PARM(&PARAM1)
             ENDPGM
```
