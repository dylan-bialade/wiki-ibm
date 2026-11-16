---
bibliotheque: BIB10
fichier_source: QCLPSRC
membre: CRTENVCLP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 34
modifie: 2026-11-16
---

# BIB10/QCLPSRC/CRTENVCLP

```cl
             PGM        PARM(&LIB)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)

          /* VALIDATION PARAM ENTRÉE                        */
             IF         COND(&LIB *EQ ' ') THEN(DO)
             SNDPGMMSG  MSG('Nom de Bib obligatoire !!')
             GOTO       CMDLBL(FIN)
             ENDDO

          /* CREATION DE LA LIB                             */
             CRTLIB     LIB(&LIB)
             MONMSG     MSGID(CPF2111) EXEC(SNDPGMMSG MSG('La Lib +
                          existe deja création skip!'))

          /* AJOUT EN LIBL POSITION 1                       */
             ADDLIBLE   LIB(&LIB)
             MONMSG     MSGID(CPF2103)

          /* CRÉATION DES FICHIERS SOURCES                  */
             CRTSRCPF   FILE(&LIB/QCLLESRC) RCDLEN(112)
             MONMSG     MSGID(CPF7602) EXEC(SNDPGMMSG MSG('Création +
                          de Qcllesrc impossible !'))

             CRTSRCPF   FILE(&LIB/QDDSSRC) RCDLEN(112)
             MONMSG     MSGID(CPF7602) EXEC(SNDPGMMSG MSG('Création +
                          de QDDSSRC impossible !'))

             CRTSRCPF   FILE(&LIB/QRPGLESRC) RCDLEN(112)
             MONMSG     MSGID(CPF7602) EXEC(SNDPGMMSG MSG('Création +
                          de Qcllesrc impossible !'))

             SNDPGMMSG  MSG('Bib et fichiers sources créé avec succès')

 FIN:        ENDPGM
```
