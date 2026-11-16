---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: MENUCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 23
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/MENUCL

```cl
             PGM
/* DECLARATION DE FICHIER                     */
             DCLF       FILE(MENUFM)
/* TRAITEMENT PRINCIPAL                       */
 DEBUT:      SNDRCVF    RCDFMT(FMT1)
             CHGVAR     VAR(&IN99) VALUE('0')
             IF         COND(&OPT *EQ 1) THEN(WRKMBRPDM +
                          FILE(*CURLIB/QDDSSRC))
             IF         COND(&OPT *EQ 2) THEN(WRKMBRPDM +
                          FILE(*CURLIB/QCLPSRC))
             IF         COND(&OPT *EQ 3) THEN(STRSDA)
             IF         COND(&OPT *EQ 4) THEN(STRPDM)
             IF         COND(&OPT *EQ 5) THEN(WRKUSRJOB)
             IF         COND(&OPT *GT 5) THEN(CHGVAR VAR(&IN99) +
                          VALUE('1'))



             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             GOTO       CMDLBL(DEBUT)

/* FIN DE TRAITEMENT                          */
 FIN:        ENDPGM
```
