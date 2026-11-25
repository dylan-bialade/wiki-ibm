---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: TEST
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 26
modifie: 2026-11-25
---

# BIB27/QCLSRC/TEST

```cl
             PGM        PARM(&LIB)

             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&NAME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&REPO) TYPE(*CHAR) LEN(50)

             DCLF       FILE(QSYS/QAFDPHY) OPNID(F)
             DLTOBJ     OBJ(QTEMP/*ALL) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF2125)
             DSPFD      FILE(&LIB/*ALL) TYPE(*ATR) OUTPUT(*OUTFILE) +
                          FILEATR(*PF) OUTFILE(QTEMP/LISTPF)

             OVRDBF     FILE(QAFDPHY) TOFILE(QTEMP/LISTPF)
 BOUCLE:     RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
             CHGVAR     VAR(&REPO) +
                          VALUE('/home/leo2/sauvegarde2023/' +
                          *TCAT &F_PHFILE *TCAT '.csv')
             IF         COND(%SST(&F_PHFCDT 1 2) *EQ '23') THEN(DO)
             CPYTOIMPF  FROMFILE(&F_PHLIB/&F_PHFILE) TOSTMF(&REPO) +
                          MBROPT(*REPLACE) STMFCODPAG(1252) +
                          RCDDLM(*CRLF) STRDLM(*NONE) FLDDLM(';')
             MONMSG     MSGID(CPF2817)
             ENDDO
             GOTO       CMDLBL(BOUCLE)
 FIN:        ENDPGM
```
