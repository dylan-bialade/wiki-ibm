---
bibliotheque: BIB19
fichier_source: QCLSRC
membre: ENDIDBGC
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-16
---

# BIB19/QCLSRC/ENDIDBGC

```cl
/* ----------------------------------------------------------------------- */
/* ENDIDBGC - programme de traitement de la commande ENDIDBG               */
/* Licence MIT        */
/* ----------------------------------------------------------------------- */
             PGM
             DCL        VAR(&LIB)  TYPE(*CHAR) LEN(10) VALUE('BIB19')
             DCL        VAR(&KEY)  TYPE(*CHAR) LEN(16)
             DCL        VAR(&MODE) TYPE(*CHAR) LEN(10) VALUE('END')
             DCL        VAR(&DATA) TYPE(*CHAR) LEN(8192)
             DCL        VAR(&ACT)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&CMD)  TYPE(*CHAR) LEN(3000)

             RTVDTAARA  DTAARA(QTEMP/IDBGSES) RTNVAR(&KEY)
             MONMSG     MSGID(CPF1015 CPF1016 CPF1021) EXEC(DO)
               SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Aucune +
                            session BIB19 active.') MSGTYPE(*ESCAPE)
             ENDDO
             CALL       PGM(&LIB/IDBGAGT) PARM(&MODE &KEY &DATA &ACT +
                          &CMD)
             IF         COND(&ACT *NE 'END') THEN(DO)
               CHGVAR     VAR(&MODE) VALUE('KILL')
               CALL       PGM(&LIB/IDBGAGT) PARM(&MODE &KEY &DATA &ACT +
                            &CMD)
             ENDDO
             DLTDTAARA  DTAARA(QTEMP/IDBGSES)
             MONMSG     MSGID(CPF0000)
             SNDPGMMSG  MSG('IDBG s''est arrêté. Le programme n''est +
                          plus en mode débogage.') MSGTYPE(*COMP)
             ENDPGM
```
