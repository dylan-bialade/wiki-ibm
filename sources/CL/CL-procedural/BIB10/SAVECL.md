---
bibliotheque: BIB10
fichier_source: QCLPSRC
membre: SAVECL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 36
modifie: 2026-11-16
---

# BIB10/QCLPSRC/SAVECL

```cl
             PGM        PARM(&LIB)
 /*Declaration des variables                                   */
             DCLF       FILE(OUT_FTP) OPNID(C)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SAVE) TYPE(*CHAR) LEN(10) +
                            VALUE('SAVE')

 /*Creation du fichier de sauvegarde                           */
             CRTSAVF    FILE(QTEMP/&SAVE)
             MONMSG     MSGID(CPF7302) EXEC(CLRSAVF FILE(QTEMP/&SAVE))
 /*Sauvegarde des Objets                                       */
             SAVOBJ     OBJ(*ALL) LIB(&LIB) DEV(*SAVF) +
                          SAVF(QTEMP/&SAVE)
             CLRPFM     FILE(OUT_FTP)
  /*Dépot FTP                                                   */
             OVRDBF     FILE(INPUT) TOFILE(BIB10/IN_FTP)
             OVRDBF     FILE(OUTPUT) TOFILE(BIB10/OUT_FTP)
             FTP        RMTSYS(LOCALHOST)
             DLTOVR     FILE(*ALL)
 /*Test du depot FTP                                           */
 /*Ouverture et positionnement dans le fichier logs           */
             OPNQRYF    FILE((OUT_FTP)) QRYSLT('%SST(OUT_FTP 1 3) +
                          *EQ "226"') OPNID(C)
 /*Lect*re du fichier si fin de fichier erreur FTP            */
              RCVF       OPNID(C)
              MONMSG     MSGID(CPF0864) EXEC(DO)
              SNDPGMMSG MSG('FTP EN ECHEC !!!!')
              GOTO       CMDLBL(FIN)
              ENDDO

 /*Envoi message utilisateur                                  */
           SNDPGMMSG MSG('FTP RÉUSSI   !!!!')
 /*Fin programme                                              */
 FIN:        DLTOVR     FILE(*ALL)
             CLOF       OPNID(C)
             ENDPGM
```
