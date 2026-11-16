---
bibliotheque: BIB01
fichier_source: QCLSRC
membre: AMIMAUXCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 13
modifie: 2026-11-16
---

# BIB01/QCLSRC/AMIMAUXCL

```cl
             PGM        PARM(&MEMBRE)
             DCLF       FILE(ANIMAUX)
             DCL        VAR(&MEMBRE) TYPE(*CHAR) LEN(10)

             OVRDBF     FILE(ANIMAUX) MBR(&MEMBRE)
 BOUCLE:     RCVF
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))

             SNDPGMMSG  MSG(&NOM)
             GOTO       CMDLBL(BOUCLE)

 FIN:        DLTOVR     FILE(*ALL)
             ENDPGM
```
