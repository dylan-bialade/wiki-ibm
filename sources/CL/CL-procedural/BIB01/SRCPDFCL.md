---
bibliotheque: BIB01
fichier_source: QCLSRC
membre: SRCPDFCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 60
modifie: 2026-11-16
---

# BIB01/QCLSRC/SRCPDFCL

```cl
             PGM        PARM(&PLIBL &PSOURCES)
 /*Declaration de Fichier                                     */
             DCLF       FILE(QSYS/QAFDMBR)
 /*Declaration de Variables                                   */
             DCL        VAR(&PLIBL) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PSOURCES) TYPE(*CHAR) LEN(10)
             DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CHEMIN) TYPE(*CHAR) LEN(30)
             DCL        VAR(&CHEMINIFS) TYPE(*CHAR) LEN(80)
             DCL        VAR(&MESSAGE) TYPE(*CHAR) LEN(100)
             DCL        VAR(&TXT) TYPE(*CHAR) LEN(100)
             DCL        VAR(&LEN) TYPE(*UINT) LEN(4)
 /*Recuperer le user                                          */
             RTVJOBA    USER(&USER)
 /*Creation du repertoire dans l'IFS                          */
     /*Chemin repertoire ex : /HOME/BIB01/QSOURCES           */
             CHGVAR     VAR(&CHEMIN) VALUE('/HOME/' *TCAT &USER +
                          *TCAT '/' *TCAT &PSOURCES)
     /*Suppression du dossier si présent                      */
             RMVDIR     DIR(&CHEMIN) SUBTREE(*ALL)
             MONMSG     MSGID(CPFA0A9 CPFA0B7)
     /*Création du dossier                                    */
             CRTDIR     DIR(&CHEMIN)
             MONMSG     MSGID(CPFA0A0 CPFA0A9)
 /*Creation du Fichier liste des membres         */
             DSPFD      FILE(&PLIBL/&PSOURCES) TYPE(*MBR) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/LISTE_MBR)
             OVRDBF     FILE(QAFDMBR) TOFILE(QTEMP/LISTE_MBR)
BOUCLE:      RCVF       RCDFMT(QWHFDMBR)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
 /*Envoi d'un message programme d'attente                        */
             SNDPGMMSG  MSGID(CPF9897) MSGF(QSYS/QCPFMSG) +
                          MSGDTA('EXTRACTION DES DONNÉES EN COURS, +
                          VEUILLEZ PATIENTER...') TOPGMQ(*EXT) +
                          MSGTYPE(*STATUS)
 /*Impression des sources avec STRSEU OPTION 6                   */
             STRSEU     SRCFILE(&MBLIB/&MBFILE) SRCMBR(&MBNAME) +
                          OPTION(6)
             MONMSG     MSGID(EDT9007) EXEC(GOTO CMDLBL(BOUCLE))
             CHGVAR     VAR(&CHEMINIFS) VALUE(&CHEMIN *TCAT '/' +
                          *TCAT &MBNAME *TCAT '.PDF')
 /*Copie du Spool sur l'IFS                                      */
    /*&CHEMINIFS exemple : /HOME/BIB01/QSOURCES/NOMduMEMBRE.PDF */
             CPYSPLF    FILE(QPSUPRTF) TOFILE(*TOSTMF) SPLNBR(*LAST) +
                          TOSTMF(&CHEMINIFS) WSCST(*PDF) +
                          STMFOPT(*REPLACE)
             DLTSPLF    FILE(QPSUPRTF) SPLNBR(*LAST)
             GOTO       CMDLBL(BOUCLE)
   /*Fin programme                                      */
   /*  Suppression du fichier de travail               */
 FIN:        DLTOBJ     OBJ(QTEMP/LISTE_MBR) OBJTYPE(*FILE)
             CHGVAR     VAR(&TXT) VALUE('La copie est terminée les +
                          sources ont été copiés dans' *BCAT &CHEMIN)
             CHGVAR     VAR(&LEN) VALUE(%LEN(&TXT))
   /*   Envoyer un message à l'utilisateur              */
             CALL       PGM(QUILNGTX) PARM((&TXT) (&LEN) +
                          ('CPF9798') (' Export terminé') +
                          (X'0000000000000000'))
             SNDPGMMSG  MSG('Transfert réussi Bravo !!!!')
             ENDPGM
```
