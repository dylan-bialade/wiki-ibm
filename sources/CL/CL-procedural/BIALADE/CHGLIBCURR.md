---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: CHGLIBCURR
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/CHGLIBCURR

```cl
PGM
        /* DECLARATION DE FICHIER */
        /*   DCLF       FILE(MALIB/MONFICHIER) */
        /* DECLARATION VARIABLE */
 DEMARAGE:   QSYS/MONMSG MSGID(CPF0000)
 CHANGECURE:      CHGCURLIB CURLIB(BIALADE)
             QSYS/GO    MENU(BIALADE/START)
             QSYS/DCL   VAR(&VAR1) TYPE(*CHAR) VALUE(DYLAN)
             QSYS/WRKSPLF SELECT(&VAR1)
             /* CORP DU PROG */
         /*  SNDRCVF    RCDFMT(FMT1) RECEIVE ET SEND */
ENDPGM
```
