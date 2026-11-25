---
bibliotheque: BIB25
fichier_source: QCLLESRC
membre: DLTFILM
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 6
modifie: 2026-11-25
---

# BIB25/QCLLESRC/DLTFILM

```cl
             PGM        PARM(&ID)
             DCL        VAR(&ID) TYPE(*CHAR) LEN(3)
             RUNSQL     SQL('delete from BIB27.film where id = ' +
                          *CAT       &ID ) COMMIT(*NONE)
             SNDPGMMSG  MSG('film supprimé')
             ENDPGM
```
