---
bibliotheque: BIB02
fichier_source: QSRC
membre: CL_RESTOR
type: CL/CL-procedural
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB02/QSRC/CL_RESTOR

```cl
             PGM
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(256)
             DCLF       FILE(BIB02/EXCELSYL)
             CLRPFM     FILE(BIB02/SAVERROR)
 READ:
             RCVF
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(END))

             CPYF       FROMFILE(KRATOS/&SRCDTA) TOFILE(BIB02/&SRCDTA) MBROPT(*REPLACE) +
                          FMTOPT(*MAP *DROP)
             MONMSG     MSGID(CPF0000) EXEC(DO)
                RCVMSG     MSGTYPE(*LAST) MSGID(&MSGID) MSG(&MSGDTA)
                RUNSQL     SQL('INSERT INTO BIB02/SAVERROR (NOMPF, MSGIDF) VALUES(''' *CAT +
                             &SRCDTA *CAT ''',''' *CAT &MSGID *CAT ''')') COMMIT(*NC)
                MONMSG     MSGID(SQL0000)  exec(goto cmdlbl(suit))
 SUIT:       ENDDO
             GOTO       CMDLBL(READ)

 END:
             SNDUSRMSG  MSG('CPYF de KRATOS vers BIB02 effectuée, vérifiez le fichier +
                          BIB02/SAVERROR pour les erreurs')

             ENDPGM
```
