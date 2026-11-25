---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: PRTSRC
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 22
modifie: 2026-11-25
---

# BIB27/QCLSRC/PRTSRC

```cl
             PGM        PARM(&LIB &FILE)
             DCLF       FILE(QSYS/QAFDMBR) OPNID(F)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&FILE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CAT) TYPE(*CHAR) LEN(50)
             DSPFD      FILE(&LIB/&FILE) TYPE(*MBR) OUTPUT(*OUTFILE) +
                          OUTFILE(QTEMP/LISTMBR)
             OVRDBF     FILE(QAFDMBR) TOFILE(QTEMP/LISTMBR)
             CRTDIR     DIR('/home/leo2')
             MONMSG     MSGID(CPfa0a0)
             CRTDIR     DIR('/home/leo2/sources')
             MONMSG     MSGID(CPfa0a0)
 BOUCLE:     RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
             STRSEU     SRCFILE(&LIB/&FILE) SRCMBR(&F_MBNAME) OPTION(6)
             CHGVAR     VAR(&CAT) VALUE('/home/leo2/sources/' *TCAT +
                          &F_MBNAME  *TCAT '.pdf')
             CPYSPLF    FILE(QPSUPRTF) TOFILE(*TOSTMF) SPLNBR(*LAST) +
                          TOSTMF(&cat) WSCST(*PDF)
             DLTSPLF    FILE(*SELECT)
             GOTO       CMDLBL(BOUCLE)
 FIN:        ENDPGM
```
