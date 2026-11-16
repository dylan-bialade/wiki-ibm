# SAVECL : 3 versions differentes dans 4 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QCLPSRC | CL/CL-procedural | 35 | 100 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [SAVECL.md](../../sources/CL/CL-procedural/BIB05/SAVECL.md) |
| BIB06 | QCLPSRC | CL/CL-procedural | 36 | 67 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [SAVECL.md](../../sources/CL/CL-procedural/BIB06/SAVECL.md) |
| BIB10 | QCLPSRC | CL/CL-procedural | 36 | 67 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [SAVECL.md](../../sources/CL/CL-procedural/BIB10/SAVECL.md) |
| BIB17 | QCLPSRC | CL/CL-procedural | 35 | 88 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [SAVECL.md](../../sources/CL/CL-procedural/BIB17/SAVECL.md) |

## Differences

- Techniques communes : boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF

## Codes

### BIB05 (CL/CL-procedural, 35 lignes)

```text
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

### BIB06 (CL/CL-procedural, 36 lignes)

```text
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

### BIB10 (CL/CL-procedural, 36 lignes)

```text
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

### BIB17 (CL/CL-procedural, 35 lignes)

```text
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
             OVRDBF     FILE(INPUT) TOFILE(BIB17/IN_FTP)
             OVRDBF     FILE(OUTPUT) TOFILE(BIB17/OUT_FTP)
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
