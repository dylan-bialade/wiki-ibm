---
bibliotheque: BIB05
fichier_source: QCLPSRC
membre: CHGLIBCURR
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-16
---

# BIB05/QCLPSRC/CHGLIBCURR

```cl
PGM
        /* DECLARATION DE FICHIER */
        /*   DCLF       FILE(MALIB/MONFICHIER) */
        /* DECLARATION VARIABLE */
 DEMARAGE:   QSYS/MONMSG MSGID(CPF0000)
 CHANGECURE:      CHGCURLIB CURLIB(BIB05)
             QSYS/GO    MENU(BIB05/START)
             QSYS/DCL   VAR(&VAR1) TYPE(*CHAR) VALUE(DYLAN)
             QSYS/WRKSPLF SELECT(&VAR1)
             /* CORP DU PROG */
         /*  SNDRCVF    RCDFMT(FMT1) RECEIVE ET SEND */
ENDPGM
```
