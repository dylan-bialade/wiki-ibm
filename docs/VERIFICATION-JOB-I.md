# Verification par rapport a job-i.fr

Genere le 2026-11-26 14:48. Reference : 1830 commandes CL, 196 termes RPG.

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](SOMMAIRE.md))

- [Commandes CL utilisees](#commandes-cl-utilisees)
  - [A controler manuellement (absentes de la liste job-i : variable, label, objet utilisateur ?)](#a-controler-manuellement-absentes-de-la-liste-job-i--variable-label-objet-utilisateur-)
- [Instructions / fonctions RPG reconnues](#instructions--fonctions-rpg-reconnues)
<!-- TOC:END -->

## Commandes CL utilisees

| Commande | Occurrences | Statut | Fiche job-i |
|---|---|---|---|
| ADDENVVAR | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/addenvvar](https://job-i.fr/commandes-ibm-i/addenvvar) |
| ADDJOBQE | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/addjobqe](https://job-i.fr/commandes-ibm-i/addjobqe) |
| ADDLIBLE | 29 | verifiee | [https://job-i.fr/commandes-ibm-i/addlible](https://job-i.fr/commandes-ibm-i/addlible) |
| ADDPFM | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/addpfm](https://job-i.fr/commandes-ibm-i/addpfm) |
| ADDRTGE | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/addrtge](https://job-i.fr/commandes-ibm-i/addrtge) |
| CALL | 36 | verifiee | [https://job-i.fr/commandes-ibm-i/call](https://job-i.fr/commandes-ibm-i/call) |
| CALLPRC | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/callprc](https://job-i.fr/commandes-ibm-i/callprc) |
| CHGCURLIB | 14 | verifiee | [https://job-i.fr/commandes-ibm-i/chgcurlib](https://job-i.fr/commandes-ibm-i/chgcurlib) |
| CHGDTAARA | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/chgdtaara](https://job-i.fr/commandes-ibm-i/chgdtaara) |
| CHGJOB | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/chgjob](https://job-i.fr/commandes-ibm-i/chgjob) |
| CHGLIBL | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/chglibl](https://job-i.fr/commandes-ibm-i/chglibl) |
| CHGPFM | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/chgpfm](https://job-i.fr/commandes-ibm-i/chgpfm) |
| CHGUSRPRF | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/chgusrprf](https://job-i.fr/commandes-ibm-i/chgusrprf) |
| CHKOBJ | 44 | verifiee | [https://job-i.fr/commandes-ibm-i/chkobj](https://job-i.fr/commandes-ibm-i/chkobj) |
| CLOF | 10 | verifiee | [https://job-i.fr/commandes-ibm-i/clof](https://job-i.fr/commandes-ibm-i/clof) |
| CLOSE | 14 | verifiee | [https://job-i.fr/commandes-ibm-i/close](https://job-i.fr/commandes-ibm-i/close) |
| CLRLIB | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/clrlib](https://job-i.fr/commandes-ibm-i/clrlib) |
| CLRPFM | 13 | verifiee | [https://job-i.fr/commandes-ibm-i/clrpfm](https://job-i.fr/commandes-ibm-i/clrpfm) |
| COMMIT | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/commit](https://job-i.fr/commandes-ibm-i/commit) |
| COPYRIGHT | 7 | verifiee | [https://job-i.fr/commandes-ibm-i/copyright](https://job-i.fr/commandes-ibm-i/copyright) |
| CPYF | 7 | verifiee | [https://job-i.fr/commandes-ibm-i/cpyf](https://job-i.fr/commandes-ibm-i/cpyf) |
| CPYSPLF | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/cpysplf](https://job-i.fr/commandes-ibm-i/cpysplf) |
| CPYSRCF | 9 | verifiee | [https://job-i.fr/commandes-ibm-i/cpysrcf](https://job-i.fr/commandes-ibm-i/cpysrcf) |
| CPYTOIMPF | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/cpytoimpf](https://job-i.fr/commandes-ibm-i/cpytoimpf) |
| CPYTOSTMF | 6 | verifiee | [https://job-i.fr/commandes-ibm-i/cpytostmf](https://job-i.fr/commandes-ibm-i/cpytostmf) |
| CRTBNDCL | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/crtbndcl](https://job-i.fr/commandes-ibm-i/crtbndcl) |
| CRTCLPGM | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/crtclpgm](https://job-i.fr/commandes-ibm-i/crtclpgm) |
| CRTCLS | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtcls](https://job-i.fr/commandes-ibm-i/crtcls) |
| CRTDIR | 7 | verifiee | [https://job-i.fr/commandes-ibm-i/crtdir](https://job-i.fr/commandes-ibm-i/crtdir) |
| CRTDSPF | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/crtdspf](https://job-i.fr/commandes-ibm-i/crtdspf) |
| CRTDTAARA | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/crtdtaara](https://job-i.fr/commandes-ibm-i/crtdtaara) |
| CRTDUPOBJ | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/crtdupobj](https://job-i.fr/commandes-ibm-i/crtdupobj) |
| CRTJOBD | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtjobd](https://job-i.fr/commandes-ibm-i/crtjobd) |
| CRTJOBQ | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtjobq](https://job-i.fr/commandes-ibm-i/crtjobq) |
| CRTLF | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtlf](https://job-i.fr/commandes-ibm-i/crtlf) |
| CRTLIB | 13 | verifiee | [https://job-i.fr/commandes-ibm-i/crtlib](https://job-i.fr/commandes-ibm-i/crtlib) |
| CRTOUTQ | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtoutq](https://job-i.fr/commandes-ibm-i/crtoutq) |
| CRTPF | 6 | verifiee | [https://job-i.fr/commandes-ibm-i/crtpf](https://job-i.fr/commandes-ibm-i/crtpf) |
| CRTSAVF | 11 | verifiee | [https://job-i.fr/commandes-ibm-i/crtsavf](https://job-i.fr/commandes-ibm-i/crtsavf) |
| CRTSBSD | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtsbsd](https://job-i.fr/commandes-ibm-i/crtsbsd) |
| CRTSRCPF | 23 | verifiee | [https://job-i.fr/commandes-ibm-i/crtsrcpf](https://job-i.fr/commandes-ibm-i/crtsrcpf) |
| DATA | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/data](https://job-i.fr/commandes-ibm-i/data) |
| DCLPRCOPT | 9 | verifiee | [https://job-i.fr/commandes-ibm-i/dclprcopt](https://job-i.fr/commandes-ibm-i/dclprcopt) |
| DLTDTAARA | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/dltdtaara](https://job-i.fr/commandes-ibm-i/dltdtaara) |
| DLTF | 7 | verifiee | [https://job-i.fr/commandes-ibm-i/dltf](https://job-i.fr/commandes-ibm-i/dltf) |
| DLTJRN | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/dltjrn](https://job-i.fr/commandes-ibm-i/dltjrn) |
| DLTLIB | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/dltlib](https://job-i.fr/commandes-ibm-i/dltlib) |
| DLTOBJ | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/dltobj](https://job-i.fr/commandes-ibm-i/dltobj) |
| DLTOVR | 44 | verifiee | [https://job-i.fr/commandes-ibm-i/dltovr](https://job-i.fr/commandes-ibm-i/dltovr) |
| DLTSPLF | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/dltsplf](https://job-i.fr/commandes-ibm-i/dltsplf) |
| DLTUSRPRF | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/dltusrprf](https://job-i.fr/commandes-ibm-i/dltusrprf) |
| DLYJOB | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/dlyjob](https://job-i.fr/commandes-ibm-i/dlyjob) |
| DOUNTIL | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/dountil](https://job-i.fr/commandes-ibm-i/dountil) |
| DOWHILE | 9 | verifiee | [https://job-i.fr/commandes-ibm-i/dowhile](https://job-i.fr/commandes-ibm-i/dowhile) |
| DSPFD | 13 | verifiee | [https://job-i.fr/commandes-ibm-i/dspfd](https://job-i.fr/commandes-ibm-i/dspfd) |
| DSPFFD | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/dspffd](https://job-i.fr/commandes-ibm-i/dspffd) |
| DSPOBJD | 12 | verifiee | [https://job-i.fr/commandes-ibm-i/dspobjd](https://job-i.fr/commandes-ibm-i/dspobjd) |
| DSPPGMREF | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/dsppgmref](https://job-i.fr/commandes-ibm-i/dsppgmref) |
| DSPUSRPRF | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/dspusrprf](https://job-i.fr/commandes-ibm-i/dspusrprf) |
| ENDCMTCTL | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/endcmtctl](https://job-i.fr/commandes-ibm-i/endcmtctl) |
| ENDJRNPF | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/endjrnpf](https://job-i.fr/commandes-ibm-i/endjrnpf) |
| FTP | 9 | verifiee | [https://job-i.fr/commandes-ibm-i/ftp](https://job-i.fr/commandes-ibm-i/ftp) |
| ITERATE | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/iterate](https://job-i.fr/commandes-ibm-i/iterate) |
| MKDIR | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/mkdir](https://job-i.fr/commandes-ibm-i/mkdir) |
| OPNQRYF | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/opnqryf](https://job-i.fr/commandes-ibm-i/opnqryf) |
| OVRDBF | 57 | verifiee | [https://job-i.fr/commandes-ibm-i/ovrdbf](https://job-i.fr/commandes-ibm-i/ovrdbf) |
| RCLRSC | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/rclrsc](https://job-i.fr/commandes-ibm-i/rclrsc) |
| RCVF | 52 | verifiee | [https://job-i.fr/commandes-ibm-i/rcvf](https://job-i.fr/commandes-ibm-i/rcvf) |
| RCVMSG | 10 | verifiee | [https://job-i.fr/commandes-ibm-i/rcvmsg](https://job-i.fr/commandes-ibm-i/rcvmsg) |
| RMVDIR | 7 | verifiee | [https://job-i.fr/commandes-ibm-i/rmvdir](https://job-i.fr/commandes-ibm-i/rmvdir) |
| RMVLIBLE | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/rmvlible](https://job-i.fr/commandes-ibm-i/rmvlible) |
| RNMOBJ | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/rnmobj](https://job-i.fr/commandes-ibm-i/rnmobj) |
| RTVDTAARA | 11 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvdtaara](https://job-i.fr/commandes-ibm-i/rtvdtaara) |
| RTVJOBA | 14 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvjoba](https://job-i.fr/commandes-ibm-i/rtvjoba) |
| RTVMBRD | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvmbrd](https://job-i.fr/commandes-ibm-i/rtvmbrd) |
| RTVOBJD | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvobjd](https://job-i.fr/commandes-ibm-i/rtvobjd) |
| RTVSYSVAL | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvsysval](https://job-i.fr/commandes-ibm-i/rtvsysval) |
| RTVUSRPRF | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvusrprf](https://job-i.fr/commandes-ibm-i/rtvusrprf) |
| RUNSQL | 37 | verifiee | [https://job-i.fr/commandes-ibm-i/runsql](https://job-i.fr/commandes-ibm-i/runsql) |
| RUNSQLSTM | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/runsqlstm](https://job-i.fr/commandes-ibm-i/runsqlstm) |
| SAVLIB | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/savlib](https://job-i.fr/commandes-ibm-i/savlib) |
| SAVOBJ | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/savobj](https://job-i.fr/commandes-ibm-i/savobj) |
| SBMJOB | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/sbmjob](https://job-i.fr/commandes-ibm-i/sbmjob) |
| SNDBRKMSG | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/sndbrkmsg](https://job-i.fr/commandes-ibm-i/sndbrkmsg) |
| SNDMSG | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/sndmsg](https://job-i.fr/commandes-ibm-i/sndmsg) |
| SNDRCVF | 77 | verifiee | [https://job-i.fr/commandes-ibm-i/sndrcvf](https://job-i.fr/commandes-ibm-i/sndrcvf) |
| SNDSMTPEMM | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/sndsmtpemm](https://job-i.fr/commandes-ibm-i/sndsmtpemm) |
| SNDUSRMSG | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/sndusrmsg](https://job-i.fr/commandes-ibm-i/sndusrmsg) |
| STRCMTCTL | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/strcmtctl](https://job-i.fr/commandes-ibm-i/strcmtctl) |
| STRDFU | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/strdfu](https://job-i.fr/commandes-ibm-i/strdfu) |
| STRPCCMD | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/strpccmd](https://job-i.fr/commandes-ibm-i/strpccmd) |
| STRPCO | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/strpco](https://job-i.fr/commandes-ibm-i/strpco) |
| STRSBS | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/strsbs](https://job-i.fr/commandes-ibm-i/strsbs) |
| STRSEU | 15 | verifiee | [https://job-i.fr/commandes-ibm-i/strseu](https://job-i.fr/commandes-ibm-i/strseu) |
| WRKSPLF | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/wrksplf](https://job-i.fr/commandes-ibm-i/wrksplf) |

### A controler manuellement (absentes de la liste job-i : variable, label, objet utilisateur ?)

ADDFILM, AFFOBJDCL, AFFOBJDFM, AFFSPOOL, AFFTAPYCST, AFFUSRDCL, AFFUSRDFM, ALERT, ALERTLOG, ALWAYS, ALWVARLEN, AMIMAUXCL, ANALYSE, AND, ANIMALCL, ANIMALFM, ANIMAU1, ANIMAUX, ANIMAUX9, ANIMAUXCLP, ANIMAUXDSP, ANNUAIRE, ANNUAIRE1, APPELTEST, BCLMSG, BIB01, BIB02, BIB05, BIB06, BIB07, BIB09, BIB10, BIB13, BIB14, BIB16, BIB17, BIB19, BIB20, BIB21, BIB25, BIB27, BIBOBJ, BIERCOUNT, BIEREDSP, BONBONCL, BONJOUR, CALCCL, CALCDSP, CALCFM, CALCIMPOT, CALCU, CALCUL, CALCULATRI, CAPTUREPOK, CFGLIBL, CHAR, CHATIZI, CHECKOBJ, CHECKSRV, CHGLIBCURR, CL2, CL2ECRAN, CLBONBON, CLDATE, CLDESCPRF, CLECRETPF, CLFACT, CLIENTCRL, CLIENTCRT, CLIENTINS, CLIENTLPA, CLMSG, CLOVRDBF, CLOVRDBFMB, CLP1, CLPRF, CLPTP, CLSQL, CLT, CLTP, CLV, CLVAR, CMD, CMDBIBINFO, CMDLBL, CMDSRC, CMTSCOPE, CODER, COMPILEPF, CPYENVVAR, CRTENV, CRTENVCLP, CRTFILE, CRTTABLE, CURLIB, CV1, DBXFIL, DBXTXT, DEBUT, DECIMAL, DESC, DETAIL, DEVENVCLP, DIRCLN, DLTFILM, DLTLME, DLTPOKE, DONE, DSPOBJDCL, DSPOBJDDSP, DSPSBMJOB, DSPUSRCLP, DSPUSRDSP, DSPUSRSLP, DTAARA, DTACPR, DTARAIMPOT, ECRAN, ECRAN1, ECRAN2, EFILM, END, ENDIDBGC, ENDIF, ENVAUTO, EOF, EXPCSVPF, EXPSRCIFS, EXPSRCIFSC, EXPSRCIFSD, FILE, FILEATR, FIN, FMTOPT, FROM, FROMMBR, GENERATED, GETPTF, GPT, GPTQCM, HELLOWORLD, HINTSRC19, IBM, IDBGPYC, IDENTITY, IFNULL, IMPOCL, IMPOTCL, INFOL, INFOUSER, INFOUSERCL, INIENV, INLLIBL, INLPGM, INTEGER, IZI7SQL, JEU1, JOB, JOBD, JOBDLIB, JOBQ, JUSTPRCLP, JUSTPRDSP, KTEPE, LANCEDEMO, LEFT, LEN, LIBINFO, LIBLIST, LSTMBR, LSTMBRCL, LSTMBRCL2, MBR, MBRLIST, MBRLST, MBROPT, MDSPLYCL, MENU1, MENU1QQ, MENUCL, MENUECL, MENUFM, MIN, MON1ERCLP, MSGDTA, MSGF, MSGID, MSGTYPE, MYFIRSTCL, NOT, NOWTRS, NULL, OBJ, OBJCHECK, OBJDCL, OBJLSTC, OBJTYPE, ONDMI, OPNSRC, OPTION, OUTFILE, OUTPUT, OUTQ, PARM, PGMAMARI, PGMCL, PGMDSP, POINTEUR, POKEMON, POKEMONSQL, POKETP, PRODUCTS, PROMPT, PRTSRC, PSSR, PWDEXP, QCLESRC, QCLLESRC, QCLPSRC, QCLSRC, QEXOSRC, QFACTURE, QFALTER, QILE, QILETP, QMEP, QMODSRC, QSOURCES, QSRC, QSRCRACE, QSTRUP, QSYS, QTEST, QTESTSRC, RACEC, RAPPSVADD, RCDDLM, READ, REDTA, REFPGCL, REPLACE, RICKROLL, RICKROLL2, RMV, RMVSYMLNK, RTNVAR, RTVINFOPGM, RTVUSR1, RTVUSRCLP, SAVACT, SAVECL, SAVECL2, SAVECLS, SAVELIB, SAVELIV, SAVF, SAVL, SELECTDFU, SEQNBR, SQL0000, SQLCLP1, SQLCLP2, SQLINSDSP, SRCFILE, SRCFLIB, SRCLST, SRCMBR, SRCPDFCL, SRCTYPE, START, STARTQQ, STMFOPT, STOPEDJOB, STRIDBGC, STRRDOI, SUBJECT, SUITEIF, SUITEPW, TEST, TESTCL, TESTCO, TESTPARM, TESTSQLBAT, TEXT, THEN, TIMFMT, TOFILE, TOLIB, TOMBR, TOSTMF, TOUSR, TPFINAL, TPFINALSQL, TRG, TSTADRIEN, TSTCL1, TSTGPT4, USERCL, USERFM, VALUE, VALUES, VAR, VARCHAR, VEUILLEZ, WHLNAM, absente, commande, condition, dans, date, erreurs, existe, fichier, https, installee, int, interdite, lignes, lors, membre, modifie, nom, note, pas, patienter, plus, pour, printf, sauvegarde, session, source, sources, table, tools, type, utilisez, valeur, where

## Instructions / fonctions RPG reconnues

| Terme | Occurrences |
|---|---|
| %ABS | 70 |
| %ADDR | 216 |
| %ALLOC | 3 |
| %CHAR | 255 |
| %CHECK | 13 |
| %CHECKR | 1 |
| %DATE | 22 |
| %DAYS | 13 |
| %DEC | 18 |
| %DECH | 11 |
| %DIFF | 5 |
| %DIV | 15 |
| %EDITC | 95 |
| %EDITW | 10 |
| %ELEM | 24 |
| %EOF | 169 |
| %EQUAL | 6 |
| %ERROR | 89 |
| %FIELDS | 1 |
| %FOUND | 103 |
| %INT | 17 |
| %LEN | 327 |
| %LIST | 2 |
| %LOOKUP | 6 |
| %LOWER | 4 |
| %MIN | 5 |
| %OPEN | 6 |
| %PADDR | 2 |
| %PARMNUM | 1 |
| %PARMS | 8 |
| %PASSED | 2 |
| %REM | 38 |
| %REPLACE | 1 |
| %SCAN | 35 |
| %SCANRPL | 21 |
| %SIZE | 334 |
| %STATUS | 6 |
| %STR | 6 |
| %SUBARR | 8 |
| %SUBDT | 1 |
| %SUBST | 364 |
| %TARGET | 5 |
| %TIME | 1 |
| %TIMESTAMP | 7 |
| %TRIM | 391 |
| %TRIML | 5 |
| %TRIMR | 101 |
| %UPPER | 5 |
| %XFOOT | 9 |
| %XLATE | 43 |
| BASED | 22 |
| BEGSR | 481 |
| CALLP | 122 |
| CHAIN | 262 |
| CLEAR | 976 |
| COMMIT | 144 |
| CONST | 813 |
| CRTLF | 1 |
| CRTLIB | 3 |
| CRTPF | 3 |
| CRTRPGPGM | 3 |
| CTL-OPT | 270 |
| DCL-C | 190 |
| DCL-DS | 288 |
| DCL-ENUM | 2 |
| DCL-F | 228 |
| DCL-PI | 322 |
| DCL-PR | 291 |
| DCL-PROC | 628 |
| DCL-S | 1360 |
| DELETE | 207 |
| DIM | 127 |
| DISK | 218 |
| DOU | 141 |
| DOW | 474 |
| DOWEQ | 143 |
| DSPLY | 426 |
| ELSE | 554 |
| ENDDO | 778 |
| ENDIF | 2907 |
| EVAL | 805 |
| EXFMT | 464 |
| F11 | 2 |
| F23 | 121 |
| FMT | 78 |
| FOR | 249 |
| FOR-EACH | 6 |
| INS | 10 |
| INZ | 641 |
| ITER | 169 |
| LEAVE | 595 |
| LIKE | 130 |
| MONITOR | 41 |
| MOVE | 644 |
| MOVEL | 344 |
| ON-EXIT | 2 |
| OPEN | 134 |
| OPTIONS | 164 |
| OVERLAY | 43 |
| PARM | 163 |
| PLIST | 59 |
| QRPGSRC | 295 |
| QUALIFIED | 60 |
| READ | 336 |
| READE | 82 |
| READP | 20 |
| READPE | 4 |
| RESET | 2 |
| RETURN | 503 |
| RPG | 1062 |
| SELECT | 567 |
| SETGT | 12 |
| SETLL | 157 |
| SETOF | 154 |
| SETON | 532 |
| SEU | 1 |
| SND-MSG | 30 |
| SORTA | 8 |
| TEST | 59 |
| UNLOCK | 10 |
| UPDAT | 2 |
| UPDATE | 250 |
| WORKSTN | 213 |
| WRITE | 642 |
| WRKSPLF | 10 |
| Z-ADD | 239 |
