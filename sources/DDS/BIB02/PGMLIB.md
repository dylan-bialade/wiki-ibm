---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: PGMLIB
type: DDS
longueur_enregistrement: 100
lignes: 7
modifie: 2026-11-16
---

# BIB02/QDDSRC/PGMLIB

```text
             PGM
             DCL        VAR(&BIB) TYPE(*CHAR) LEN(20) VALUE(BIB02)
             DCL        VAR(&FIRST) TYPE(*CHAR) LEN(10) VALUE(*FIRST)

             ADDLIBLE   LIB(&BIB) POSITION(&FIRST)
             ADDLIBLE   LIB(ACMSLIB)
             ENDPGM
```
