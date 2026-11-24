---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: SAVL
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 57
modifie: 2026-11-16
---

# BIB02/QCLLESRC/SAVL

```cl
             PGM        PARM(&LIB)
             COPYRIGHT  TEXT('(C) ORGFORM 2025.')
             DCLPRCOPT  DFTACTGRP(*NO) ACTGRP(*CALLER)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SAVF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SAVFLIB) TYPE(*CHAR) LEN(10)

             CHGVAR     VAR(&SAVF) VALUE(&LIB)
             CHGVAR     VAR(&SAVFLIB) VALUE('QGPL')

/* Vérifier si la bibliothèque existe */
             CHKOBJ     OBJ(QSYS/&LIB) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801) EXEC(DO)
                SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('La +
                             bibliothèque ' *BCAT &LIB *BCAT 'n''existe +
                             pas.') MSGTYPE(*ESCAPE)
                RETURN
             ENDDO

/* Vérifier si le fichier de sauvegarde existe */
             CHKOBJ     OBJ(QGPL/&SAVF) OBJTYPE(*FILE) MBR(*NONE)
             MONMSG     MSGID(CPF9801) EXEC(DO)
                CRTSAVF    FILE(QGPL/&SAVF) TEXT('Sauvegarde de la +
                             bibliothèque ' *CAT &LIB)
                MONMSG     MSGID(CPF0000) EXEC(DO)
                   SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Erreur +
                                lors de la création du fichier de +
                                sauvegarde') MSGTYPE(*ESCAPE)
                   RETURN
                ENDDO
             ENDDO

/* Sauvegarder la bibliothèque avec SAVACT(*SYNCLIB) */
             SAVLIB     LIB(&LIB) DEV(*SAVF) SAVF(QGPL/&SAVF) ACCPTH(*YES) +
                          DTACPR(*YES) SAVACT(*SYNCLIB)
             MONMSG     MSGID(CPF0000) EXEC(DO)
                SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Erreur +
                             lors de la sauvegarde de la bibliothèque') +
                             MSGTYPE(*ESCAPE)
                RETURN
             ENDDO

/* Supprimer la bibliothèque */
             DLTLIB     LIB(&LIB)
             MONMSG     MSGID(CPF0000) EXEC(DO)
                SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Erreur +
                             lors de la suppression de la bibliothèque') +
                             MSGTYPE(*ESCAPE)
                RETURN
             ENDDO

/* Message final */
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('La +
                          bibliothèque ' *CAT &LIB *CAT ' a été +
                          sauvegardée et supprimée avec succès') MSGTYPE(*COMP)

             ENDPGM
```
