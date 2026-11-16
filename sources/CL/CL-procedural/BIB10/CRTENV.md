---
bibliotheque: BIB10
fichier_source: QCLPSRC
membre: CRTENV
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 5
modifie: 2026-11-16
---

# BIB10/QCLPSRC/CRTENV

```cl
             CMD        PROMPT('Création d''env de dev') +
                          TEXT('Création d''une lib et de fichiers +
                          source') MAXPOS(1)
             PARM       KWD(LIB) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Nom de la lib a créer')
```
