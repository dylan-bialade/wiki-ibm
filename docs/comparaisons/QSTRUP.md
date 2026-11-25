# QSTRUP : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB01 | QCLSRC | CL/CL-procedural | 54 | 100 % | gestion d erreur | [QSTRUP.md](../../sources/CL/CL-procedural/BIB01/QSTRUP.md) |
| BIB27 | QCLSRC | CL/CL-procedural | 73 | 56 % | gestion d erreur | [QSTRUP.md](../../sources/CL/CL-procedural/BIB27/QSTRUP.md) |

## Differences

- Techniques communes : gestion d erreur

## Codes

### BIB01 (CL/CL-procedural, 54 lignes)

```text
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

### BIB27 (CL/CL-procedural, 73 lignes)

```text
/********************************************************************/
/*                                                                  */
/* 5770SS1 V7R4M0 190621 Sortie RTVCLSRC         05/08/24 13:30:45  */
/*                                                                  */
/* Nom du programme . . . . . . . . . . . . :   QSTRUP            PN*/
/* Nom de la bibliothèque . . . . . . . . . :   QSYS              PL*/
/* Fichier source initial . . . . . . . . . :   QCLLESRC          SN*/
/* Nom de la bibliothèque . . . . . . . . . :   XAVIER            SL*/
/* Membre source initial  . . . . . . . . . :   QSTRUP            SM*/
/* Modification du fichier source                                   */
/*   date/heure . . . . . . . . . . . . . . :   12/06/23 22:45:46 SC*/
/* Option de modification . . . . . . . . . :   *NOPATCH          PO*/
/* Profil utilisateur . . . . . . . . . . . :   *USER             UP*/
/* Texte  . . : SSH, Debug (VSCode)/ WebServices /SCHTROUMPF (SBS)TX*/
/* Propriétaire . . . . . . . . . . . . . . :   QSYS              OW*/
/* Marquage modification utilisateur  . . . :   *YES              UM*/
/* Extraire source inclus   . . . . . . . . :   *NO               RI*/
/*                                                                ED*/
/********************************************************************/
     PGM
     DCL VAR(&STRWTRS) TYPE(*CHAR) LEN(1)
     DCL VAR(&CTLSBSD) TYPE(*CHAR) LEN(20)
     DCL VAR(&CPYR) TYPE(*CHAR) LEN(90) VALUE('5770-SS1 (C) COPYRIGHT-
 IBM CORP 1980, 2018. LICENSED MATERIAL - PROGRAM PROPERTY OF IBM')
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
     QSYS/SBMJOB CMD(STRTCPSVR SERVER(*ALL)) JOB(STRTCPSVR) -
JOBQ(QUSRNOMAX) USER(*CURRENT) SYSLIBL(*CURRENT) CURLIB(*CURRENT) -
INLLIBL(*CURRENT) LOGCLPGM(*NO) HOLD(*NO) DSPSBMJOB(*YES) -
CPYENVVAR(*YES)
     MONMSG MSGID(CPF0000)
     QSYS/SBMJOB CMD(STRHOSTSVR SERVER(*ALL)) JOB(STRHOSTSVR) -
JOBQ(QUSRNOMAX) USER(*CURRENT) SYSLIBL(*CURRENT) CURLIB(*CURRENT) -
INLLIBL(*CURRENT) LOGCLPGM(*NO) HOLD(*NO) DSPSBMJOB(*YES) -
CPYENVVAR(*YES)
     MONMSG MSGID(CPF0000)
     QSYS/SBMJOB CMD(QGPL/STRWEBSVR SERVER(FORMATIONS)) -
JOB(STRWEBSVR) JOBQ(QUSRNOMAX) USER(*CURRENT) SYSLIBL(*CURRENT) -
CURLIB(*CURRENT) INLLIBL(*CURRENT) LOGCLPGM(*NO) HOLD(*NO) -
DSPSBMJOB(*YES) CPYENVVAR(*YES)
     MONMSG MSGID(CPF0000)
     QSYS/STRDBGSVR
     MONMSG MSGID(CPF0000)
     QSYS/STRSBS SBSD(QGPL/SCHTROUMPF)
     MONMSG MSGID(CPF0000)
     RETURN
     CHGVAR VAR(&CPYR) VALUE(&CPYR)
     ENDPGM
```
