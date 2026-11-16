---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: PARACL
type: DDS
longueur_enregistrement: 100
lignes: 6
modifie: 2026-11-16
---

# BIB02/QDDSRC/PARACL

```text
             PGM
             DCL        VAR(&MONPARAM) TYPE(*CHAR) LEN(10)
             CALL       PGM(PARAPGM) PARM(&MONPARAM)
             CHGDTAARA  DTAARA(*LDA) VALUE(&MONPARAM)

             ENDPGM
```
