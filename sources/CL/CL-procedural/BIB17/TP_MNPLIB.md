---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: TP_MNPLIB
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 34
modifie: 2026-11-16
---

# BIB17/QCLPSRC/TP_MNPLIB

```cl
             PGM        PARM(&LIB)

             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
    /*AJOUT DE LA LIB EN HAUT DE LA LIBL        */
             MONMSG     MSGID(CPF2103)
             ADDLIBLE   LIB(&LIB)

  /*<CRÉER SOURCE QCLLESRC, ET COPIE DU MEMBRE     */
             CRTSRCPF   FILE(&LIB/QCLLESRC) RCDLEN(112)
             MONMSG     MSGID(CPF7302)

             CPYF       FROMFILE(BIB01/QCLLESRC) +
                          TOFILE(&LIB/QCLLESRC) FROMMBR(TSTADRIEN) +
                          TOMBR(TSTADRIEN) MBROPT(*REPLACE) +
                          CRTFILE(*YES)


  /*<CRÉER SOURCE QDDSSRC, ET COPIE DU MEMBRE     */

             CRTSRCPF   FILE(&LIB/QDDSSRC) RCDLEN(112)
             MONMSG     MSGID(CPF7302)

             CPYF       FROMFILE(BIB01/QDDSSRC) +
                          TOFILE(&LIB/QDDSSRC) FROMMBR(TSTADRIEND) +
                          TOMBR(TSTADRIEND) MBROPT(*REPLACE) +
                          CRTFILE(*YES)

  /*COMPILATION ECRAN PUIS COMPIL DU PGM  */
             CRTDSPF    FILE(&LIB/TSTADRIEND) SRCFILE(&LIB/QDDSSRC) +
                          SRCMBR(TSTADRIEND)

             CRTCLPGM   PGM(&LIB/TSTADRIEN) SRCFILE(&LIB/QCLLESRC) +
                          SRCMBR(TSTADRIEN)
             ENDPGM
```
