---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: MBRLIST
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 22
modifie: 2026-11-16
---

# BIB17/QCLPSRC/MBRLIST

```cl
             PGM
             DCL        VAR(&LIBORIG) TYPE(*CHAR) LEN(10) +
                          VALUE(BIB17)
             DCL        VAR(&LIBDST) TYPE(*CHAR) LEN(10) +
                          VALUE(BIB17)
             DCL        VAR(&NMPF) TYPE(*CHAR) LEN(10) VALUE(LSTSRC)

             CALL       PGM(LSTMBRCL) PARM((&LIBORIG) (&LIBDST) +
                          (&NMPF))












             ENDPGM
```
