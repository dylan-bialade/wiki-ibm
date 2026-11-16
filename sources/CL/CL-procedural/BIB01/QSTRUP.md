---
bibliotheque: BIB01
fichier_source: QCLSRC
membre: QSTRUP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 54
modifie: 2026-11-16
---

# BIB01/QCLSRC/QSTRUP

```cl
/********************************************************************/
/*                                                                  */
/* 5770SS1 V7R5M0 220415 Sortie RTVCLSRC         09/11/26 11:19:09  */
/*                                                                  */
/* Nom du programme . . . . . . . . . . . . :   QSTRUP            PN*/
/* Nom de la bibliothèque . . . . . . . . . :   QSYS              PL*/
/* Fichier source initial . . . . . . . . . :   S000031500        SN*/
/* Nom de la bibliothèque . . . . . . . . . :   $BLDSS1           SL*/
/* Membre source initial  . . . . . . . . . :   S000031500        SM*/
/* Modification du fichier source                                   */
/*   date/heure . . . . . . . . . . . . . . :   03/10/21 06:58:16 SC*/
/* Option de modification . . . . . . . . . :   *NOPATCH          PO*/
/* Profil utilisateur . . . . . . . . . . . :   *USER             UP*/
/* Texte  . . :                                                   TX*/
/* Propriétaire . . . . . . . . . . . . . . :   QSYS              OW*/
/* Marquage modification utilisateur  . . . :   *NO               UM*/
/* Extraire source inclus   . . . . . . . . :   *NO               RI*/
/*                                                                ED*/
/********************************************************************/
     PGM
     DCL VAR(&STRWTRS) TYPE(*CHAR) LEN(1)
     DCL VAR(&CTLSBSD) TYPE(*CHAR) LEN(20)
     DCL VAR(&CPYR) TYPE(*CHAR) LEN(90) VALUE('5770-SS1 (C) COPYRIGHT-
 IBM CORP 1980, 2021. LICENSED MATERIAL - PROGRAM PROPERTY OF IBM')
     QSYS/STRSBS SBSD(QSERVER)
     MONMSG MSGID(CPF0000)
     QSYS/STRSBS SBSD(QUSRWRK)
     MONMSG MSGID(CPF0000)
     QSYS/RLSJOBQ JOBQ(QGPL/QS36MRT)
     MONMSG MSGID(CPF0000)
     QSYS/RLSJOBQ JOBQ(QGPL/QS36EVOKE)
     MONMSG MSGID(CPF0000)
     QSYS/STRCLNUP
     MONMSG MSGID(CPF0000)
     QSYS/RTVSYSVAL SYSVAL(QCTLSBSD) RTNVAR(&CTLSBSD)
     IF COND((&CTLSBSD *NE 'QCTL      QSYS      ') *AND (&CTLSBSD *NE-
 'QCTL      QGPL      ')) THEN(GOTO CMDLBL(DONE))
     QSYS/STRSBS SBSD(QINTER)
     MONMSG MSGID(CPF0000)
     QSYS/STRSBS SBSD(QBATCH)
     MONMSG MSGID(CPF0000)
     QSYS/STRSBS SBSD(QCMN)
     MONMSG MSGID(CPF0000)
DONE:
     QSYS/STRSBS SBSD(QSPL)
     MONMSG MSGID(CPF0000)
     QSYS/RTVSYSVAL SYSVAL(QSTRPRTWTR) RTNVAR(&STRWTRS)
     IF COND(&STRWTRS = '0') THEN(GOTO CMDLBL(NOWTRS))
     CALL PGM(QSYS/QWCSWTRS)
     MONMSG MSGID(CPF0000)
NOWTRS:
     RETURN
     CHGVAR VAR(&CPYR) VALUE(&CPYR)
     ENDPGM
```
