---
bibliotheque: BIB20
fichier_source: QEXOSRC
membre: CLDESCPRF
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 88
modifie: 2026-11-16
---

# BIB20/QEXOSRC/CLDESCPRF

```cl
             PGM

             DCL        VAR(&PROFIL) TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBD) TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBDLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CURLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PWEXP) TYPE(*CHAR) LEN(10)
             DCL        VAR(&ASSIST) TYPE(*CHAR)

             DCLF       FILE(BIB20/ECRDESCPRF) OPNID(D)

             RTVDTAARA  DTAARA(*LDA (120 10)) RTNVAR(&PROFIL)

             MONMSG     MSGID(CPF0001)
             MONMSG     MSGID(CPF9810)

 DEBUT:
             RTVUSRPRF  USRPRF(&PROFIL) JOBD(&JOBD) +
                          JOBDLIB(&JOBDLIB) CURLIB(&CURLIB) +
                          PWDEXP(&PWEXP)

             CHGVAR     VAR(&D_PROFIL) VALUE(&PROFIL)
             CHGVAR     VAR(&D_JOBD) VALUE(&JOBD)
             CHGVAR     VAR(&D_BIB) VALUE(&JOBDLIB)
             CHGVAR     VAR(&D_CURLIB) VALUE(&CURLIB)
             CHGVAR     VAR(&D_PWEXP) VALUE(&PWEXP)

             RTVDTAARA  DTAARA(BIB20/DTNASS *ALL) RTNVAR(&ASSIST)

             IF         COND(&ASSIST *EQ '*BASIC') THEN(CHGVAR +
                          VAR(&D_IN60) VALUE('1'))

             SNDRCVF    OPNID(D)

             CHGVAR     VAR(&D_IN95) VALUE('0')
             CHGVAR     VAR(&D_IN96) VALUE('0')
             CHGVAR     VAR(&D_IN97) VALUE('0')



             IF         COND(&D_IN21 *AND &ASSIST *NE '*BASIC') +
                          THEN(DO)

             CHKOBJ     OBJ(QSYS/&D_BIB) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801) EXEC(DO)
               CHGVAR     VAR(&D_MESSAGE) VALUE('Veuillez corriger vos +
                          erreurs')
               CHGVAR     VAR(&D_IN95) VALUE('1')
             ENDDO

             CHKOBJ     OBJ(&D_BIB/&D_JOBD) OBJTYPE(*JOBD)
             MONMSG     MSGID(CPF9801) EXEC(DO)
               CHGVAR     VAR(&D_MESSAGE) VALUE('Veuillez corriger vos +
                          erreurs')
               CHGVAR     VAR(&D_IN95) VALUE('1')
             ENDDO

             CHKOBJ     OBJ(QSYS/&D_CURLIB) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801) EXEC(DO)
               CHGVAR     VAR(&D_MESSAGE) VALUE('Veuillez corriger vos +
                          erreurs')
               CHGVAR     VAR(&D_IN96) VALUE('1')
             ENDDO

             IF         COND(&D_PWEXP *EQ '*YES' *OR &D_PWEXP *EQ +
                          '*NO') THEN(GOTO CMDLBL(SUITEPW))
               CHGVAR     VAR(&D_MESSAGE) VALUE('Veuillez corriger vos +
                          erreurs')
               CHGVAR     VAR(&D_IN97) VALUE('1')
 SUITEPW:

             IF         COND(&D_IN95 *OR &D_IN96 *OR &D_IN97) +
                          THEN(GOTO CMDLBL(SUITEIF))

             CHGUSRPRF  USRPRF(&PROFIL) PWDEXP(&D_PWEXP) +
                          CURLIB(&D_CURLIB) JOBD(&D_BIB/&D_JOBD)
             CHGVAR     VAR(&D_MESSAGE) VALUE('Réussite !')
 SUITEIF:

             ENDDO

             IF         COND(&D_IN12 *OR &D_IN03) THEN(GOTO +
                          CMDLBL(FIN))


             GOTO       CMDLBL(DEBUT)
 FIN:        CHGDTAARA  DTAARA(*LDA (130 1)) VALUE(&D_IN03)
             ENDPGM
```
