---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: GPTQCM
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 21
modifie: 2026-11-16
---

# BIB02/QCLLESRC/GPTQCM

```cl
             PGM
             CRTLIB     LIB(TESTLIB) TEXT('Bibliothèque de test')
             MONMSG     MSGID(CPF2105 CPF2111) /* Ignore si la +
                          bibliothèque existe déjà */

             CHKOBJ     OBJ(TESTLIB/MYTABLE) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9801) EXEC(DO)
                CRTPF      FILE(TESTLIB/MYTABLE) RCDLEN(100)
                MONMSG     MSGID(CPF0000) EXEC(DO)
                   SNDPGMMSG  MSG('Erreur lors de la création de la +
                                table') TOUSR(*REQUESTER)
                ENDDO
                GOTO       CMDLBL(RENAME)
             ENDDO

 RENAME:     RNMOBJ     OBJ(TESTLIB/MYTABLE) OBJTYPE(*FILE) NEWOBJ(MYTABLE_)
             MONMSG     MSGID(CPF0000) EXEC(DO)
                SNDPGMMSG  MSG('Erreur lors du renommage de la table') +
                             TOUSR(*REQUESTER)
             ENDDO
             ENDPGM
```
