---
bibliotheque: BIB19
fichier_source: QCLSRC
membre: STRIDBGC
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 109
modifie: 2026-11-16
---

# BIB19/QCLSRC/STRIDBGC

```cl
/* ----------------------------------------------------------------------- */
/* STRIDBGC - programme de traitement de la commande BIB19               */
/* Lance le processus Python (travail IDBGPY), puis execute les actions    */
/* qu'il decide : appel du programme, ligne de commande, fin.              */
/* Licence MIT        */
/* ----------------------------------------------------------------------- */
             PGM        PARM(&QPGM &UPDPROD &INVPGM &PARMS &SRCMBR +
                          &SRCF &JOB)
             DCL        VAR(&QPGM)    TYPE(*CHAR) LEN(20)
             DCL        VAR(&UPDPROD) TYPE(*CHAR) LEN(4)
             DCL        VAR(&INVPGM)  TYPE(*CHAR) LEN(4)
             DCL        VAR(&PARMS)   TYPE(*CHAR) LEN(6402)
             DCL        VAR(&SRCMBR)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&SRCF)    TYPE(*CHAR) LEN(20)
             DCL        VAR(&JOB)     TYPE(*CHAR) LEN(10)
             DCL        VAR(&LIB)     TYPE(*CHAR) LEN(10) VALUE('BIB19')
             DCL        VAR(&PGM)     TYPE(*CHAR) LEN(10)
             DCL        VAR(&PLIB)    TYPE(*CHAR) LEN(10)
             DCL        VAR(&KEY)     TYPE(*CHAR) LEN(16)
             DCL        VAR(&JNAME)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&JUSER)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&NBR)     TYPE(*CHAR) LEN(6)
             DCL        VAR(&TIME)    TYPE(*CHAR) LEN(9)
             DCL        VAR(&CFG)     TYPE(*CHAR) LEN(512)
             DCL        VAR(&JOBQ)    TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBQL)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&MODE)    TYPE(*CHAR) LEN(10)
             DCL        VAR(&DATA)    TYPE(*CHAR) LEN(8192)
             DCL        VAR(&ACT)     TYPE(*CHAR) LEN(10)
             DCL        VAR(&CMD)     TYPE(*CHAR) LEN(3000)
             DCL        VAR(&MID)     TYPE(*CHAR) LEN(7)
             DCL        VAR(&MTXT)    TYPE(*CHAR) LEN(256)
             DCL        VAR(&MDTA)    TYPE(*CHAR) LEN(256)

             CHGVAR     VAR(&PGM)  VALUE(%SST(&QPGM 1 10))
             CHGVAR     VAR(&PLIB) VALUE(%SST(&QPGM 11 10))
             CHKOBJ     OBJ(&PLIB/&PGM) OBJTYPE(*PGM)
             MONMSG     MSGID(CPF9800) EXEC(DO)
               RCVMSG     MSGTYPE(*EXCP) MSGDTA(&MDTA) MSGID(&MID) +
                            RMV(*YES)
               SNDPGMMSG  MSGID(&MID) MSGF(QCPFMSG) MSGDTA(&MDTA) +
                            MSGTYPE(*ESCAPE)
             ENDDO
             CHKOBJ     OBJ(QTEMP/IDBGSES) OBJTYPE(*DTAARA)
             MONMSG     MSGID(CPF9801) EXEC(GOTO CMDLBL(NOSES))
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Une +
                          session BIB19 est déjà active : +
                          utilisez ENDIDBG.') MSGTYPE(*ESCAPE)

 NOSES:      RTVJOBA    JOB(&JNAME) USER(&JUSER) NBR(&NBR)
             RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&TIME)
             CHGVAR     VAR(&KEY) VALUE('S' *CAT &NBR *CAT &TIME)
             RTVDTAARA  DTAARA(&LIB/IDBGCFG) RTNVAR(&CFG)
             CHGVAR     VAR(&JOBQ)  VALUE(%SST(&CFG 257 10))
             CHGVAR     VAR(&JOBQL) VALUE(%SST(&CFG 267 10))
             SBMJOB     CMD(CALL PGM(&LIB/IDBGPYC) PARM(&KEY &JNAME +
                          &JUSER &NBR &LIB)) JOB(IDBGPY) +
                          JOBQ(&JOBQL/&JOBQ) MSGQ(*NONE)
             RCVMSG     MSGTYPE(*COMP) RMV(*YES)
             MONMSG     MSGID(CPF0000)

             CHGVAR     VAR(&DATA) VALUE(&QPGM *CAT &UPDPROD *CAT +
                          &INVPGM *CAT &PARMS)
             CHGVAR     VAR(&MODE) VALUE('INIT')

 BOUCLE:     CALL       PGM(&LIB/IDBGAGT) PARM(&MODE &KEY &DATA &ACT +
                          &CMD)
             IF         COND(&ACT *EQ 'CALL') THEN(DO)
               CHGVAR     VAR(&MID)  VALUE(' ')
               CHGVAR     VAR(&MTXT) VALUE(' ')
               CALL       PGM(QCMDEXC) PARM(&CMD 3000)
               MONMSG     MSGID(CPF0000 MCH0000 CEE0000 RNX0000 RNQ0000 +
                            SQL0000 CPD0000) EXEC(DO)
                 RCVMSG     MSGTYPE(*EXCP) RMV(*YES) MSG(&MTXT) +
                              MSGID(&MID)
                 MONMSG     MSGID(CPF0000)
               ENDDO
               CHGVAR     VAR(&DATA) VALUE(&MID *CAT &MTXT)
               CHGVAR     VAR(&MODE) VALUE('ENDPGM')
               GOTO       CMDLBL(BOUCLE)
             ENDDO
             IF         COND(&ACT *EQ 'CMDLINE') THEN(DO)
               CALL       PGM(QUSCMDLN)
               CHGVAR     VAR(&DATA) VALUE(' ')
               CHGVAR     VAR(&MODE) VALUE('ENDCMD')
               GOTO       CMDLBL(BOUCLE)
             ENDDO
             IF         COND(&ACT *EQ 'RETURN') THEN(DO)
               CRTDTAARA  DTAARA(QTEMP/IDBGSES) TYPE(*CHAR) LEN(16) +
                            VALUE(&KEY)
               MONMSG     MSGID(CPF0000)
               RETURN
             ENDDO
             IF         COND(&ACT *EQ 'ERROR') THEN(DO)
               SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA(&CMD) +
                            MSGTYPE(*ESCAPE)
             ENDDO
             IF         COND(&ACT *EQ '*PYEND') THEN(DO)
               CHGVAR     VAR(&MODE) VALUE('KILL')
               CALL       PGM(&LIB/IDBGAGT) PARM(&MODE &KEY &DATA &ACT +
                            &CMD)
               SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('BIB19 : +
                            le processus Python s''est arrêté ou n''a +
                            pas démarré (voir le travail IDBGPY).') +
                            MSGTYPE(*ESCAPE)
             ENDDO
             SNDPGMMSG  MSG('IDBG s''est arrêté. Le programme n''est +
                          plus en mode débogage.') MSGTYPE(*COMP)
             ENDPGM
```
