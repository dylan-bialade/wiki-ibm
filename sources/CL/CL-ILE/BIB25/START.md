---
bibliotheque: BIB25
fichier_source: QCLLESRC
membre: START
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 6
modifie: 2026-11-25
---

# BIB25/QCLLESRC/START

```cl
             PGM
             /* COMMENTAIRES */
             DCL        VAR(&CURLIB) TYPE(*CHAR) LEN(10) +
                          VALUE('BIB27')
             CHGLIBL    LIBL(QTEMP QGPL BIB27) CURLIB(&CURLIB)
             ENDPGM
```
