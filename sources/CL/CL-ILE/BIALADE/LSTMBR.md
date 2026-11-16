---
bibliotheque: BIALADE
fichier_source: QCLLESRC
membre: LSTMBR
type: CL/CL-ILE
longueur_enregistrement: 100
lignes: 7
modifie: 2026-11-16
---

# BIALADE/QCLLESRC/LSTMBR

```cl
            CMD        PROMPT('SAUVEGARDE MBR SRC')
            PARM       KWD(LIBLIST) TYPE(*CHAR) LEN(10) MIN(1) +
                         PROMPT('BIBLIOTHÈQUE')
            PARM       KWD(LIBDEST) TYPE(*CHAR) LEN(10) MIN(1) +
                         PROMPT('LIB DE DESTINATION')
            PARM       KWD(FILENAME) TYPE(*CHAR) LEN(10) MIN(1) +
                         PROMPT('NOM DU FICHIER')
```
