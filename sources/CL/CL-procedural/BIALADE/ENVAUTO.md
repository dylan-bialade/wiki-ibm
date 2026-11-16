---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: ENVAUTO
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 134
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/ENVAUTO

```cl
          /*DEBUT PROGRAMME */

             PGM

          /*DECLRATION VARIABLE ET ECRAN */

             DCLF       FILE(PARLIER/ENVSRCE) RCDFMT(WIN1)

             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)

             DCL        VAR(&OUTQ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBQ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBD) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CLS) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SBS) TYPE(*CHAR) LEN(10)

             DCL        VAR(&SRC1) TYPE(*CHAR) LEN(10) VALUE('qrpgsrc')
             DCL        VAR(&SRC2) TYPE(*CHAR) LEN(10) VALUE('qddssrc')
             DCL        VAR(&SRC3) TYPE(*CHAR) LEN(10) VALUE('qclesrc')
             DCL        VAR(&SRC4) TYPE(*CHAR) LEN(10) VALUE('qclpsrc')

             DCL        VAR(&USRNAM) TYPE(*CHAR) LEN(10)

             DCL        VAR(&ERRMSG) TYPE(*CHAR) LEN(50) VALUE(' ')

             DCL        VAR(&IN03) TYPE(*LGL)

          /*AFFICHAGE BOUCLE */

 ECRAN:      SNDRCVF    DEV(*FILE) RCDFMT(WIN1)
             CHGVAR     VAR(&ERRMSG) VALUE(' ')
             IF         COND(&IN03) THEN(RETURN)

          /*NE PAS ECRASER BIBLIOTHEQUE DE REFERENCE */

             IF         COND(&LIB *EQ 'parlier') THEN(DO)
             CHGVAR     VAR(&ERRMSG) VALUE('bibliotheque parlier +
                          interdite')
             GOTO       CMDLBL(ECRAN)
             ENDDO

          /*CREE BIBLIOTHEQUE */

             CHKOBJ     OBJ(QSYS/&LIB) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801) EXEC(CRTLIB LIB(&LIB))

          /*BIBLIOTHEQUE EN PREMIERE POSITION  */

             RMVLIBLE   LIB(&LIB)
             MONMSG     MSGID(CPF2104) /* LA BIBLIOTHEQUE N'EST PAS + +
                          DANS LA LIBLIST */
             ADDLIBLE   LIB(&LIB)
             MONMSG     MSGID(CPF2103) /* BIBLIOTHEQUE DEJA DANS LA + +
                          LIBLIST */

          /*CREE OUTQ, JOBQ, JOBD, CLASSE, SOUS SYSTEM */

             CRTOUTQ    OUTQ(&LIB/&OUTQ)
             MONMSG     MSGID(CPF3353) /* OUTQ EXISTE DEJA */
             CRTJOBQ    JOBQ(&LIB/&JOBQ)
             MONMSG     MSGID(CPF3323) /* JOBQ EXISTE DEJA */
             CRTJOBD    JOBD(&LIB/&JOBD) JOBQ(&LIB/&JOBQ) +
                          OUTQ(&LIB/&OUTQ)
             MONMSG     MSGID(CPF0001) /* Erreur trouvée dans la +
                          commande */
             MONMSG     MSGID(CPF1621) /* JOBD NON CREE DANS &LIB */
             CRTCLS     CLS(&LIB/&CLS) RUNPTY(25)
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */
             MONMSG     MSGID(CPF1064) /* CLASSE EXISTE DEJA */
             CRTSBSD    SBSD(&LIB/&SBS) POOLS((1 *BASE))
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */
             MONMSG     MSGID(CPF1696) /* SOUS SYSTEM NON CREE */
             ADDJOBQE   SBSD(&LIB/&SBS) JOBQ(&LIB/&JOBQ) MAXACT(2) +
                          SEQNBR(10)
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */
             MONMSG     MSGID(CPF1697)  /* SOUS SYSTEM NON MODIFIER */
             ADDRTGE    SBSD(&LIB/&SBS) SEQNBR(10) CMPVAL(*ANY) +
                          PGM(QSYS/QCMD) CLS(&LIB/&CLS)
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */
             MONMSG     MSGID(CPF1697)  /* SOUS SYSTEM NON MODIFIER */
             STRSBS     SBSD(&LIB/&SBS)
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */

          /*CREE FICHIER SOURCE */

             CRTSRCPF   FILE(&LIB/&SRC1) RCDLEN(112)
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */
             MONMSG     MSGID(CPF7302) /* FICHIER NON CREE */
             MONMSG     MSGID(CPF5813) /* le fichier existe deja */
             CRTSRCPF   FILE(&LIB/&SRC2) RCDLEN(112)
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */
             MONMSG     MSGID(CPF7302) /* FICHIER NON CREE  */
             MONMSG     MSGID(CPF5813) /* LE FICHIER EXISTE DEJA */
             CRTSRCPF   FILE(&LIB/&SRC3) RCDLEN(112)
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */
             MONMSG     MSGID(CPF7302) /* FICHIER NON CREE */
             MONMSG     MSGID(CPF5813) /* LE FICHIER EXISTE DEJA */
             CRTSRCPF   FILE(&LIB/&SRC4) RCDLEN(112)
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */
             MONMSG     MSGID(CPF7302) /* FICHIER NON CREE */
             MONMSG     MSGID(CPF5813) /* LE FICHIER EXISTE DEJA */

          /*RATTACHEMENT A L'UTILISATEUR */

             CHGUSRPRF  USRPRF(&USRNAM) CURLIB(&LIB) +
                          JOBD(&LIB/&JOBD) OUTQ(&LIB/&OUTQ)
             MONMSG     MSGID(CPF0001) /* ERREUR TROUVÉE DANS LA +
                          COMMANDE */
             MONMSG     MSGID(CPF2292) /* DROIT INSUFISSANT */

          /*COPIER LES MEMBRE */

 /*          CPYSRCF    FROMFILE(ADRIEN/QCLLESRC) +                 */
 /*                       TOFILE(&LIB/QCLESRC)  FROMMBR(TSTADRIEN)  */
             MONMSG     MSGID(CPF2817) /* copie erreur */
 /*          CPYSRCF    FROMFILE(ADRIEN/QDDSSRC) +                  */
 /*                       TOFILE(&LIB/QDDSSRC) FROMMBR(TSTADRIEND)  */
             MONMSG     MSGID(CPF2817) /* copie erreur */

          /*FIN PROGRAMME */

             SNDPGMMSG  MSG('Environnement cree dans la +
                          bibliotheque *CAT &LIB')

             ENDPGM
```
