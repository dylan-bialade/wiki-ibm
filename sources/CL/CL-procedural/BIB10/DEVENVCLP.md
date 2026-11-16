---
bibliotheque: BIB10
fichier_source: QCLPSRC
membre: DEVENVCLP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 54
modifie: 2026-11-16
---

# BIB10/QCLPSRC/DEVENVCLP

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
             MONMSG     MSGID(CPF7302) EXEC(SNDPGMMSG MSG('Création +
                          de Qcllesrc impossible !'))

             CRTSRCPF   FILE(&LIB/QDDSSRC) RCDLEN(112)
             MONMSG     MSGID(CPF7302) EXEC(SNDPGMMSG MSG('Création +
                          de QDDSSRC impossible !'))

             CRTSRCPF   FILE(&LIB/QRPGSRC) RCDLEN(112)
             MONMSG     MSGID(CPF7302) EXEC(SNDPGMMSG MSG('Création +
                          de Qcllesrc impossible !'))

             SNDPGMMSG  MSG('Bib et fichiers sources créé avec succès')

           /* COPIE DE MEMBRES SOURCES                      */
             CPYSRCF    FROMFILE(BIB01/QCLLESRC) +
                          TOFILE(&LIB/QCLLESRC) FROMMBR(TSTADRIEN)
             MONMSG     MSGID(CPF2816) EXEC(SNDPGMMSG MSG('erreur +
                          lors de la copie de tstadrien'))

             CPYSRCF    FROMFILE(BIB01/QDDSSRC) +
                          TOFILE(&LIB/QDDSSRC) FROMMBR(TSTADRIEND)
             MONMSG     MSGID(CPF2816) EXEC(SNDPGMMSG MSG('Erreur +
                          lors de la création du membre tstadriend'))

           /* COMPLIATION DES FICHIERS SOURCE               */
             CRTCLPGM   PGM(&LIB/TSTADRIEN) SRCFILE(&LIB/QCLLESRC) +
                          REPLACE(*NO)
             MONMSG     MSGID(CPF0801) EXEC(DO)
             CRTCLPGM   PGM(&LIB/TSTADRIEN) SRCFILE(&LIB/QCLLESRC)
             ENDDO
             CRTDSPF    FILE(&LIB/TSTADRIEND) SRCFILE(&LIB/QDDSSRC) +
                          SRCMBR(TSTADRIEND)
             SNDPGMMSG  MSG('Ecran et cl compilé')
 FIN:        ENDPGM
```
