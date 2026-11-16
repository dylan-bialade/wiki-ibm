---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: SAVECL2
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 47
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/SAVECL2

```cl
             PGM        PARM(&LIB)
 /*Declaration des variables                                   */
             DCLF       FILE(OUT_FTP1) OPNID(O)
             DCLF       FILE(SAVEFTP) OPNID(I)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SAVEF) TYPE(*CHAR) LEN(10) +
                            VALUE('SAVE')

 /*Creation du fichier de sauvegarde                           */
             CRTSAVF    FILE(QTEMP/&SAVEF)
             MONMSG     MSGID(CPF7302) EXEC(CLRSAVF FILE(QTEMP/&SAVEF))
 /*Sauvegarde des Objets                                       */
             SAVOBJ     OBJ(*ALL) LIB(&LIB) DEV(*SAVF) +
                          SAVF(QTEMP/&SAVEF)
             CLRPFM     FILE(SAVEFTP) MBR(OUT_FTP)
  /*Dépot FTP                                                   */
             OVRDBF     FILE(INPUT) TOFILE(PHAN/SAVEFTP) MBR(IN_FTP)

             OVRDBF     FILE(OUTPUT) TOFILE(PHAN/SAVEFTP) MBR(OUT_FTP)
             FTP        RMTSYS(LOCALHOST)
             DLTOVR     FILE(*ALL)
 /*Test du depot FTP                                           */
 /*Ouverture et positionnement dans le fichier logs           */
             OVRDBF     FILE(OUT_FTP1) TOFILE(PHAN/SAVEFTP) +
                          MBR(OUT_FTP)
             OPNQRYF    FILE((OUT_FTP1)) QRYSLT('%SST(SAVE 1 3) *EQ +
                          "226"') OPNID(O)

 /*Lect*re du fichier si fin de fichier erreur FTP            */
             RCVF        OPNID(O)
              MONMSG     MSGID(CPF0864) EXEC(DO)
              SNDPGMMSG MSG('FTP EN ECHEC !!!!')
              GOTO       CMDLBL(FIN)
              ENDDO

             DLTOVR     FILE(*ALL)

 /*Envoi message utilisateur                                  */
           SNDPGMMSG MSG('FTP RÉUSSI   !!!!')
 /*Fin programme                                              */
 FIN:        DLTOVR     FILE(*ALL)
             CLOF      OPNID(O)
             DLTOVR     FILE(*ALL)
             CLOF      OPNID(I)
             MONMSG     MSGID(CPF4520)

             ENDPGM
```
