---
bibliotheque: BIB05
fichier_source: QCLPSRC
membre: SAVECL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 35
modifie: 2026-11-16
---

# BIB05/QCLPSRC/SAVECL

```cl
             PGM        PARM(&PLIB)
             DCLF       FILE(OUT_FTP) OPNID(C)
             DCL        VAR(&PLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SAVE) TYPE(*CHAR) LEN(10) +
                          VALUE('SAUVEGARDE')

 /*Creation du fichier de sauvegarde                           */
             CRTSAVF    FILE(QTEMP/&SAVE)
             MONMSG     MSGID(CPF7302) EXEC(CLRSAVF FILE(QTEMP/&SAVE))
 /*Sauvegarde des Objets                                       */
             SAVOBJ     OBJ(*ALL) LIB(&PLIB) DEV(*SAVF) +
                          SAVF(QTEMP/&SAVE)
             CLRPFM     FILE(OUT_FTP)
  /*Dépot FTP                                                   */
             OVRDBF     FILE(INPUT) TOFILE(BIB05/IN_FTP)
             OVRDBF     FILE(OUTPUT) TOFILE(BIB05/OUT_FTP)
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
