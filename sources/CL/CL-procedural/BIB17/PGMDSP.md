---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: PGMDSP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-16
---

# BIB17/QCLPSRC/PGMDSP

```cl
             PGM
             DCLF FILE(MENUFM)
 DEBUT:      SNDRCVF    RCDFMT(FMT1)
             IF         COND(&OPT *EQ 9) THEN(GOTO CMDLBL(END))
             IF         COND(&OPT *EQ 1) THEN(WRKMBRPDM +
             GOTO       CMDLBL(START)
                          FILE(*CURLIB/QCLPSRC))

             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))


 END:        ENDPGM
```
