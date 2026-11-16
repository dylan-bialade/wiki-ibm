---
bibliotheque: BIALADE
fichier_source: QCLLESRC
membre: LSTMBRCL
type: CL/CL-ILE
longueur_enregistrement: 100
lignes: 140
modifie: 2026-11-16
---

# BIALADE/QCLLESRC/LSTMBRCL

```cl
/*-----------------------------------------------------------------*/
/*PROGRAMME : LSTMBR                                               */
/*LIBELLE   : LISTE DES MEMBRES SOURCES D UNE BIBLIOTHEQUE         */
/*-----------------------------------------------------------------*/
/*E/S Nom         Type    Lg. Dec. Description                     */
/* E  &PINLIB     *CHAR   10   -   Biblio. à lister                */
/* E  &POUTLIB    *CHAR   10   -   Biblio. où exporter             */
/* E  &POUTFILE   *CHAR   10   -   Nom du fichier exporter         */
/*-----------------------------------------------------------------*/
             PGM        PARM(&PINLIB &POUTLIB &POUTFILE)
/*-Déclaration Variables ------------------------------------------*/
             DCL        VAR(&PINLIB)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&POUTLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&POUTFILE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OUTFILE) TYPE(*CHAR) LEN(21)
             DCL        VAR(&REQ) TYPE(*CHAR) LEN(550)
             DCL        VAR(&CRTTBL) TYPE(*CHAR) LEN(550)

             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(512)
             DCL        VAR(&MSGFNM) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGFLB) TYPE(*CHAR) LEN(10)
/*-----------------------------------------------------------------*/
/*Initialisation                                                   */
/*-----------------------------------------------------------------*/
             MONMSG     MSGID(CPF0000 CPD0000 MCH0000 RNX0000 +
                          SQL0000 TCP0000 CAE0000) EXEC(GOTO +
                          CMDLBL(PSSR))
             CALLSUBR   SUBR(INZSR)

/*-----------------------------------------------------------------*/
/*TRAITEMENT                                                       */
/*-----------------------------------------------------------------*/

             CHGVAR     VAR(&OUTFILE) VALUE(&POUTLIB *TCAT '.' +
                          *TCAT &POUTFILE)
          /*Suppression du précédent fichier si existant      */
                         DLTF       FILE(BIALADE/LSTKF)
                         MONMSG     MSGID(CPF2105)
                         DLTF       FILE(&POUTLIB/&POUTFILE)
                         MONMSG     MSGID(CPF2105)



          /*Create Table                                      */
             CHGVAR     VAR(&CRTTBL) VALUE('CREATE TABLE' *BCAT +
                          &POUTLIB *TCAT '.' *TCAT &POUTFILE *BCAT +
                          '(DBXLIB CHAR(10) NOT NULL, DBXFIL +
                          CHAR(10) NOT NULL, DBXMBR CHAR(10) NOT +
                          NULL, DBXTYP CHAR(10) NOT NULL, DBXTXT +
                          CHAR(50) NOT NULL, DBXNBL DECIMAL(6, 0) +
                          NOT NULL )RCDFMT FMTDBX')
             RUNSQL     SQL(&CRTTBL) COMMIT(*NONE)

           CRTLF      FILE(BIALADE/LSTKF) SRCFILE(BIALADE/QLFSRC) +
                      SRCMBR(LSTKF) TEXT('CRÉATION DE MON +
                      FICHIER LOGIQUE')
          /*Insert into                                        */
             CHGVAR     VAR(&REQ) VALUE('INSERT INTO' *BCAT &OUTFILE +
                          *BCAT '(SELECT DBXLIB, IFNULL(DBXFIL, +
                          ''''), IFNULL(CAST(TABLE_PARTITION AS +
                          CHAR(10)), ''''),      +
                          IFNULL(SOURCE_TYPE, +
                          ''''),IFNULL(CAST(PARTITION_TEXT AS +
                          CHAR(50)), ''''),           +
                          IFNULL(CAST(NUMBER_ROWS AS DEC(6, 0)), 0) +
                          FROM QSYS.QADBXREF                    +
                          LEFT JOIN QSYS2.SYSPARTITIONSTAT ON +
                          DBXFIL = TABLE_NAME                       +
                          AND TABLE_SCHEMA = DBXLIB WHERE DBXTYP = +
                          ''S'' AND DBXLIB = ''' *TCAT &PINLIB +
                          *TCAT ''')')

             RUNSQL     SQL(&REQ) COMMIT(*NONE)

             OVRDBF     FILE(LSTMBR) TOFILE(&POUTLIB/&POUTFILE)
           /*OVRDBF     FILE(LSTSRC) TOFILE(QTEMP/LSTSRC)*/
             CALL       PGM(crtlstr)

             DLTOVR     FILE(*ALL)
/*******************************************************************/
/*FIN                                                              */
/*******************************************************************/
             RCLRSC
             RETURN

/*-----------------------------------------------------------------*/
/*Gestion des exceptions                                           */
/*-----------------------------------------------------------------*/
 PSSR:
             IF         COND(&MSGID *EQ ' ') THEN(DO)
             IF         COND(&MSGDTA *NE ' ') THEN(CHGVAR +
                          VAR(&MSGID) VALUE('CPF9897'))
             ELSE       CMD(DO)
             RCVMSG     PGMQ(*SAME (*)) MSGTYPE(*LAST) RMV(*YES) +
                          MSGDTA(&MSGDTA) MSGID(&MSGID) +
                          MSGF(&MSGFNM) SNDMSGFLIB(&MSGFLB)
             MONMSG     MSGID(CPF0000 MCH0000) EXEC(DO)
             CHGVAR     VAR(&MSGID) VALUE('CPF0001')
             CHGVAR     VAR(&MSGDTA) VALUE('RCVMSG')
             CHGVAR     VAR(&MSGFNM) VALUE('QCPFMSG')
             CHGVAR     VAR(&MSGFLB) VALUE('QSYS')
             ENDDO
             ENDDO
             ENDDO

             DOUNTIL    COND(&MSGID *EQ ' ')
             IF         COND(&MSGFNM *EQ ' ') THEN(DO)
             IF         COND(%SST(&MSGID 1 3) *EQ 'RNX' *OR +
                             %SST(&MSGID 1 3) *EQ 'SQL' *OR +
                             %SST(&MSGID 1 3) *EQ 'TCP') THEN( +
             CHGVAR    VAR(&MSGFNM) VALUE('Q' *CAT %SST(&MSGID 1 3) *CAT 'MSG'))
             ELSE       CMD(CHGVAR VAR(&MSGFNM) VALUE('QCPFMSG'))
             ENDDO
             IF         COND(&MSGFLB *EQ ' ') THEN(CHGVAR +
                          VAR(&MSGFLB) VALUE('*LIBL'))
             SNDPGMMSG  MSGID(&MSGID) MSGF(&MSGFLB/&MSGFNM) +
                          MSGDTA(&MSGDTA) TOPGMQ(*PRV (*)) +
                          MSGTYPE(*ESCAPE)
             MONMSG     MSGID(CPF0000 MCH0000) EXEC(DO)
             CHGVAR     VAR(&MSGID) VALUE('CPF0001')
             CHGVAR     VAR(&MSGDTA) VALUE('SNDPGMMSG')
             CHGVAR     VAR(&MSGFNM) VALUE('QCPFMSG')
             CHGVAR     VAR(&MSGFLB) VALUE('QSYS')
             ITERATE
             ENDDO
             CHGVAR     VAR(&MSGID) VALUE(' ')
             CHGVAR     VAR(&MSGDTA) VALUE(' ')
             CHGVAR     VAR(&MSGFNM) VALUE(' ')
             CHGVAR     VAR(&MSGFLB) VALUE(' ')
             ENDDO

/*------------------------------------------------------------------*/
/*Sous programme initial                                            */
/*------------------------------------------------------------------*/
             SUBR       SUBR(INZSR)

             ENDSUBR
/*------------------------------------------------------------------*/
             ENDPGM
```
