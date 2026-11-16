---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: EXPCSVPF
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-16
---

# BIB17/QCLPSRC/EXPCSVPF

```cl
             PGM        PARM(&FICHIER)
             DCL        VAR(&FICHIER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CHEMIN)  TYPE(*CHAR) LEN(128)

             CHGVAR     VAR(&CHEMIN) VALUE('/home/REMI/' *TCAT +
                          &FICHIER *TCAT '.csv')
             CPYTOIMPF  FROMFILE(&FICHIER) TOSTMF(&CHEMIN) +
                          MBROPT(*REPLACE) STMFCCSID(1208) +
                          RCDDLM(*CRLF) FLDDLM(';') DATFMT(*EUR) +
                          TIMFMT(*EUR)

             ENDPGM
```
