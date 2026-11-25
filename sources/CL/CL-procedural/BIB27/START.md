---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: START
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 6
modifie: 2026-11-25
---

# BIB27/QCLSRC/START

```cl
             PGM
             /* COMMENTAIRES */
             DCL        VAR(&CURLIB) TYPE(*CHAR) LEN(10) +
                          VALUE('BIB27')
             CHGLIBL    LIBL(QTEMP QGPL BIB27) CURLIB(&CURLIB)
             ENDPGM
```
