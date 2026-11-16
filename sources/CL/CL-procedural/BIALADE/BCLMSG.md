---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: BCLMSG
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/BCLMSG

```cl
PGM /*PARM(&USR)*/
           /*DCL VAR(&USR) TYPE(*CHAR) LEN(25)*/
 DEBUT:      GOTO       CMDLBL(BOUCLE)
 BOUCLE:     SNDBRKMSG  MSG('tes bloquE') TOMSGQ(QPADEV006J)
             GOTO       CMDLBL(DEBUT)









ENDPGM
```
