---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: TSTGPT4
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 32
modifie: 2026-11-16
---

# BIB02/QCLLESRC/TSTGPT4

```cl
             PGM        PARM(&BIBLIO)

             DCL        VAR(&BIBLIO) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SAVFBIB) TYPE(*CHAR) LEN(10) VALUE('QGPL')
             DCL        VAR(&SAVFILE) TYPE(*CHAR) LEN(10) VALUE('MYSAVF')
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(80)

             /* Créer la bibliothèque s'elle n'existe pas */
             CRTLIB     LIB(&BIBLIO) TEXT('Ma bibliothèque')
             MONMSG     MSGID(CPF2105) EXEC(DO)
                        /* Si la bibliothèque existe déjà, une erreur CPF2105 se
                        /* Dans ce cas, on ne fait rien et on continue le progra
             ENDDO

             /* Vérification de l'existence du SAVF dans QGPL */
             CHKOBJ     OBJ(&SAVFBIB/&SAVFILE) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9801) EXEC(DO)
                        /* Si le SAVF n'existe pas, on le crée */
                        CRTSAVF     FILE(&SAVFBIB/&SAVFILE) TEXT('Mon fichier de
             ENDDO

             /* Sauvegarder la bibliothèque dans le SAVF */
             SAVLIB     LIB(&BIBLIO) DEV(*SAVF) SAVF(&SAVFBIB/&SAVFILE)
             MONMSG     MSGID(CPF0000) EXEC(DO)
                        /* Gestion des erreurs pendant la sauvegarde */
                        RCVMSG      MSGTYPE(*EXCP) MSGDTA(&MSGDTA) MSGID(&MSGID)
                        SNDPGMMSG   MSGID(&MSGID) MSGF(QCPFMSG) MSGDTA(&MSGDTA)
                        RETURN
             ENDDO

             ENDPGM
```
