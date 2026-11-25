---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: DLTFILM
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 6
modifie: 2026-11-25
---

# BIB27/QCLSRC/DLTFILM

```cl
             PGM        PARM(&ID)
             DCL        VAR(&ID) TYPE(*CHAR) LEN(3)
             RUNSQL     SQL('delete from BIB27.film where id = ' +
                          *CAT       &ID ) COMMIT(*NONE)
             SNDPGMMSG  MSG('film supprimé')
             ENDPGM
```
