---
bibliotheque: BIB20
fichier_source: QCLLESRC
membre: CLMSG
type: CL/CL-ILE
longueur_enregistrement: 100
lignes: 4
modifie: 2026-11-16
---

# BIB20/QCLLESRC/CLMSG

```cl
             PGM        PARM(&MSG)
             DCL        VAR(&MSG) TYPE(*CHAR) LEN(100)
             SNDPGMMSG  MSG(&MSG)
             ENDPGM
```
