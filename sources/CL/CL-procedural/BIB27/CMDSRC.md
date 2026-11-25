---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: CMDSRC
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 5
modifie: 2026-11-25
---

# BIB27/QCLSRC/CMDSRC

```cl
             CMD        PROMPT('export source en pdf')
             PARM       KWD(BIB) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Bibliothèque')
             PARM       KWD(FILE) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('fichier')
```
