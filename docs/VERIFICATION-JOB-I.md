# Verification par rapport a job-i.fr

Genere le 2026-11-21 13:17. Reference : 1830 commandes CL, 196 termes RPG.

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
| ADDLIBLE | 27 | verifiee | [https://job-i.fr/commandes-ibm-i/addlible](https://job-i.fr/commandes-ibm-i/addlible) |
| ADDRTGE | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/addrtge](https://job-i.fr/commandes-ibm-i/addrtge) |
| CALL | 27 | verifiee | [https://job-i.fr/commandes-ibm-i/call](https://job-i.fr/commandes-ibm-i/call) |
| CHGCURLIB | 13 | verifiee | [https://job-i.fr/commandes-ibm-i/chgcurlib](https://job-i.fr/commandes-ibm-i/chgcurlib) |
| CHGDTAARA | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/chgdtaara](https://job-i.fr/commandes-ibm-i/chgdtaara) |
| CHGUSRPRF | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/chgusrprf](https://job-i.fr/commandes-ibm-i/chgusrprf) |
| CHKOBJ | 42 | verifiee | [https://job-i.fr/commandes-ibm-i/chkobj](https://job-i.fr/commandes-ibm-i/chkobj) |
| CLOF | 10 | verifiee | [https://job-i.fr/commandes-ibm-i/clof](https://job-i.fr/commandes-ibm-i/clof) |
| CLOSE | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/close](https://job-i.fr/commandes-ibm-i/close) |
| CLRPFM | 10 | verifiee | [https://job-i.fr/commandes-ibm-i/clrpfm](https://job-i.fr/commandes-ibm-i/clrpfm) |
| COMMIT | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/commit](https://job-i.fr/commandes-ibm-i/commit) |
| COPYRIGHT | 7 | verifiee | [https://job-i.fr/commandes-ibm-i/copyright](https://job-i.fr/commandes-ibm-i/copyright) |
| CPYF | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/cpyf](https://job-i.fr/commandes-ibm-i/cpyf) |
| CPYSPLF | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/cpysplf](https://job-i.fr/commandes-ibm-i/cpysplf) |
| CPYSRCF | 9 | verifiee | [https://job-i.fr/commandes-ibm-i/cpysrcf](https://job-i.fr/commandes-ibm-i/cpysrcf) |
| CPYTOIMPF | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/cpytoimpf](https://job-i.fr/commandes-ibm-i/cpytoimpf) |
| CPYTOSTMF | 6 | verifiee | [https://job-i.fr/commandes-ibm-i/cpytostmf](https://job-i.fr/commandes-ibm-i/cpytostmf) |
| CRTCLPGM | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/crtclpgm](https://job-i.fr/commandes-ibm-i/crtclpgm) |
| CRTCLS | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtcls](https://job-i.fr/commandes-ibm-i/crtcls) |
| CRTDIR | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/crtdir](https://job-i.fr/commandes-ibm-i/crtdir) |
| CRTDSPF | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/crtdspf](https://job-i.fr/commandes-ibm-i/crtdspf) |
| CRTDTAARA | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/crtdtaara](https://job-i.fr/commandes-ibm-i/crtdtaara) |
| CRTDUPOBJ | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/crtdupobj](https://job-i.fr/commandes-ibm-i/crtdupobj) |
| CRTJOBD | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtjobd](https://job-i.fr/commandes-ibm-i/crtjobd) |
| CRTJOBQ | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtjobq](https://job-i.fr/commandes-ibm-i/crtjobq) |
| CRTLF | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtlf](https://job-i.fr/commandes-ibm-i/crtlf) |
| CRTLIB | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/crtlib](https://job-i.fr/commandes-ibm-i/crtlib) |
| CRTOUTQ | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtoutq](https://job-i.fr/commandes-ibm-i/crtoutq) |
| CRTPF | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/crtpf](https://job-i.fr/commandes-ibm-i/crtpf) |
| CRTSAVF | 11 | verifiee | [https://job-i.fr/commandes-ibm-i/crtsavf](https://job-i.fr/commandes-ibm-i/crtsavf) |
| CRTSBSD | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/crtsbsd](https://job-i.fr/commandes-ibm-i/crtsbsd) |
| CRTSRCPF | 22 | verifiee | [https://job-i.fr/commandes-ibm-i/crtsrcpf](https://job-i.fr/commandes-ibm-i/crtsrcpf) |
| DCLPRCOPT | 9 | verifiee | [https://job-i.fr/commandes-ibm-i/dclprcopt](https://job-i.fr/commandes-ibm-i/dclprcopt) |
| DLTDTAARA | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/dltdtaara](https://job-i.fr/commandes-ibm-i/dltdtaara) |
| DLTF | 7 | verifiee | [https://job-i.fr/commandes-ibm-i/dltf](https://job-i.fr/commandes-ibm-i/dltf) |
| DLTJRN | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/dltjrn](https://job-i.fr/commandes-ibm-i/dltjrn) |
| DLTLIB | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/dltlib](https://job-i.fr/commandes-ibm-i/dltlib) |
| DLTOBJ | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/dltobj](https://job-i.fr/commandes-ibm-i/dltobj) |
| DLTOVR | 44 | verifiee | [https://job-i.fr/commandes-ibm-i/dltovr](https://job-i.fr/commandes-ibm-i/dltovr) |
| DLTSPLF | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/dltsplf](https://job-i.fr/commandes-ibm-i/dltsplf) |
| DLTUSRPRF | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/dltusrprf](https://job-i.fr/commandes-ibm-i/dltusrprf) |
| DLYJOB | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/dlyjob](https://job-i.fr/commandes-ibm-i/dlyjob) |
| DOUNTIL | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/dountil](https://job-i.fr/commandes-ibm-i/dountil) |
| DOWHILE | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/dowhile](https://job-i.fr/commandes-ibm-i/dowhile) |
| DSPFD | 10 | verifiee | [https://job-i.fr/commandes-ibm-i/dspfd](https://job-i.fr/commandes-ibm-i/dspfd) |
| DSPFFD | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/dspffd](https://job-i.fr/commandes-ibm-i/dspffd) |
| DSPOBJD | 7 | verifiee | [https://job-i.fr/commandes-ibm-i/dspobjd](https://job-i.fr/commandes-ibm-i/dspobjd) |
| DSPPGMREF | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/dsppgmref](https://job-i.fr/commandes-ibm-i/dsppgmref) |
| DSPUSRPRF | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/dspusrprf](https://job-i.fr/commandes-ibm-i/dspusrprf) |
| ENDJRNPF | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/endjrnpf](https://job-i.fr/commandes-ibm-i/endjrnpf) |
| FTP | 9 | verifiee | [https://job-i.fr/commandes-ibm-i/ftp](https://job-i.fr/commandes-ibm-i/ftp) |
| ITERATE | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/iterate](https://job-i.fr/commandes-ibm-i/iterate) |
| MKDIR | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/mkdir](https://job-i.fr/commandes-ibm-i/mkdir) |
| OPNQRYF | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/opnqryf](https://job-i.fr/commandes-ibm-i/opnqryf) |
| OVRDBF | 48 | verifiee | [https://job-i.fr/commandes-ibm-i/ovrdbf](https://job-i.fr/commandes-ibm-i/ovrdbf) |
| RCLRSC | 4 | verifiee | [https://job-i.fr/commandes-ibm-i/rclrsc](https://job-i.fr/commandes-ibm-i/rclrsc) |
| RCVF | 38 | verifiee | [https://job-i.fr/commandes-ibm-i/rcvf](https://job-i.fr/commandes-ibm-i/rcvf) |
| RCVMSG | 10 | verifiee | [https://job-i.fr/commandes-ibm-i/rcvmsg](https://job-i.fr/commandes-ibm-i/rcvmsg) |
| RMVDIR | 7 | verifiee | [https://job-i.fr/commandes-ibm-i/rmvdir](https://job-i.fr/commandes-ibm-i/rmvdir) |
| RMVLIBLE | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/rmvlible](https://job-i.fr/commandes-ibm-i/rmvlible) |
| RNMOBJ | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/rnmobj](https://job-i.fr/commandes-ibm-i/rnmobj) |
| RTVDTAARA | 11 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvdtaara](https://job-i.fr/commandes-ibm-i/rtvdtaara) |
| RTVJOBA | 13 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvjoba](https://job-i.fr/commandes-ibm-i/rtvjoba) |
| RTVMBRD | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvmbrd](https://job-i.fr/commandes-ibm-i/rtvmbrd) |
| RTVOBJD | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvobjd](https://job-i.fr/commandes-ibm-i/rtvobjd) |
| RTVSYSVAL | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvsysval](https://job-i.fr/commandes-ibm-i/rtvsysval) |
| RTVUSRPRF | 6 | verifiee | [https://job-i.fr/commandes-ibm-i/rtvusrprf](https://job-i.fr/commandes-ibm-i/rtvusrprf) |
| RUNSQL | 18 | verifiee | [https://job-i.fr/commandes-ibm-i/runsql](https://job-i.fr/commandes-ibm-i/runsql) |
| RUNSQLSTM | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/runsqlstm](https://job-i.fr/commandes-ibm-i/runsqlstm) |
| SAVLIB | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/savlib](https://job-i.fr/commandes-ibm-i/savlib) |
| SAVOBJ | 8 | verifiee | [https://job-i.fr/commandes-ibm-i/savobj](https://job-i.fr/commandes-ibm-i/savobj) |
| SBMJOB | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/sbmjob](https://job-i.fr/commandes-ibm-i/sbmjob) |
| SNDBRKMSG | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/sndbrkmsg](https://job-i.fr/commandes-ibm-i/sndbrkmsg) |
| SNDMSG | 2 | verifiee | [https://job-i.fr/commandes-ibm-i/sndmsg](https://job-i.fr/commandes-ibm-i/sndmsg) |
| SNDRCVF | 53 | verifiee | [https://job-i.fr/commandes-ibm-i/sndrcvf](https://job-i.fr/commandes-ibm-i/sndrcvf) |
| SNDUSRMSG | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/sndusrmsg](https://job-i.fr/commandes-ibm-i/sndusrmsg) |
| STRDFU | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/strdfu](https://job-i.fr/commandes-ibm-i/strdfu) |
| STRPCCMD | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/strpccmd](https://job-i.fr/commandes-ibm-i/strpccmd) |
| STRPCO | 1 | verifiee | [https://job-i.fr/commandes-ibm-i/strpco](https://job-i.fr/commandes-ibm-i/strpco) |
| STRSBS | 5 | verifiee | [https://job-i.fr/commandes-ibm-i/strsbs](https://job-i.fr/commandes-ibm-i/strsbs) |
| STRSEU | 14 | verifiee | [https://job-i.fr/commandes-ibm-i/strseu](https://job-i.fr/commandes-ibm-i/strseu) |
| WRKSPLF | 3 | verifiee | [https://job-i.fr/commandes-ibm-i/wrksplf](https://job-i.fr/commandes-ibm-i/wrksplf) |

### A controler manuellement (absentes de la liste job-i : variable, label, objet utilisateur ?)

AFFOBJDCL, AFFOBJDFM, AFFSPOOL, AFFTAPYCST, AFFUSRDCL, AFFUSRDFM, ALWAYS, AMIMAUXCL, AND, ANIMALCL, ANIMALFM, ANIMAU1, ANIMAUX, ANIMAUX9, ANIMAUXCLP, ANIMAUXDSP, ANNUAIRE, ANNUAIRE1, APPELTEST, BCLMSG, BIB01, BIB02, BIB05, BIB06, BIB07, BIB09, BIB10, BIB13, BIB14, BIB16, BIB17, BIB19, BIB20, BIB21, BIERCOUNT, BIEREDSP, BONBONCL, BONJOUR, CALCCL, CALCDSP, CALCFM, CALCIMPOT, CALCU, CALCULATRI, CFGLIBL, CHAR, CHATIZI, CHECKOBJ, CHECKSRV, CHGLIBCURR, CL2ECRAN, CLBONBON, CLDESCPRF, CLECRETPF, CLIENTCRL, CLIENTCRT, CLIENTINS, CLIENTLPA, CLMSG, CLOVRDBF, CLOVRDBFMB, CLP1, CLPRF, CLPTP, CLSQL, CLT, CLTP, CLV, CLVAR, CMD, CMDLBL, COMPILEPF, CRTENV, CRTENVCLP, CRTFILE, CURLIB, DBXFIL, DBXTXT, DEBUT, DECIMAL, DETAIL, DEVENVCLP, DIRCLN, DLTLME, DONE, DSPOBJDCL, DSPOBJDDSP, DSPUSRCLP, DSPUSRDSP, DSPUSRSLP, DTAARA, DTACPR, DTARAIMPOT, END, ENDIDBGC, ENDIF, ENVAUTO, EOF, EXPCSVPF, EXPSRCIFS, EXPSRCIFSC, EXPSRCIFSD, FILE, FIN, FMTOPT, FROM, FROMMBR, GENERATED, GETPTF, GPT, GPTQCM, HELLOWORLD, HINTSRC19, IBM, IDBGPYC, IDENTITY, IFNULL, IMPOCL, IMPOTCL, INFOL, INIENV, INLPGM, INTEGER, JEU1, JOBD, JOBDLIB, JOBQ, JUSTPRCLP, JUSTPRDSP, KTEPE, LANCEDEMO, LEFT, LEN, LIBLIST, LSTMBR, LSTMBRCL, LSTMBRCL2, MBR, MBRLIST, MBRLST, MBROPT, MDSPLYCL, MENUCL, MENUECL, MENUFM, MIN, MON1ERCLP, MSGDTA, MSGF, MSGID, MSGTYPE, MYFIRSTCL, NOT, NOWTRS, NULL, OBJ, OBJCHECK, OBJLSTC, OBJTYPE, ONDMI, OPNSRC, OPTION, OUTFILE, OUTPUT, OUTQ, PARM, PGMAMARI, PGMDSP, POINTEUR, PROMPT, PSSR, PWDEXP, QCLESRC, QCLLESRC, QCLPSRC, QCLSRC, QEXOSRC, QILE, QSOURCES, QSRC, QSRCRACE, QSTRUP, QSYS, QTESTSRC, RACEC, RCDDLM, READ, REDTA, REFPGCL, REPLACE, RICKROLL, RICKROLL2, RMV, RMVSYMLNK, RTNVAR, RTVINFOPGM, RTVUSR1, RTVUSRCLP, SAVACT, SAVECL, SAVECL2, SAVECLS, SAVELIB, SAVELIV, SAVF, SAVL, SELECTDFU, SEQNBR, SQL0000, SQLCLP1, SQLCLP2, SQLINSDSP, SRCFILE, SRCFLIB, SRCLST, SRCMBR, SRCPDFCL, START, STARTQQ, STMFOPT, STOPEDJOB, STRIDBGC, STRRDOI, SUITEIF, SUITEPW, TEST, TESTCL, TESTCO, TESTPARM, TESTSQLBAT, TEXT, THEN, TIMFMT, TOFILE, TOLIB, TOMBR, TOSTMF, TOUSR, TSTADRIEN, TSTGPT4, USERCL, USERFM, VALUE, VALUES, VAR, VARCHAR, VEUILLEZ, WHLNAM, absente, commande, condition, dans, erreurs, existe, fichier, https, installee, int, interdite, lignes, lors, membre, modifie, pas, patienter, plus, pour, printf, sauvegarde, session, source, sources, table, tools, type, utilisez, valeur

## Instructions / fonctions RPG reconnues

| Terme | Occurrences |
|---|---|
| %ABS | 41 |
| %ADDR | 191 |
| %ALLOC | 3 |
| %CHAR | 171 |
| %CHECK | 1 |
| %CHECKR | 1 |
| %DATE | 16 |
| %DAYS | 8 |
| %DEC | 2 |
| %DECH | 10 |
| %DIFF | 2 |
| %DIV | 13 |
| %EDITC | 62 |
| %EDITW | 10 |
| %ELEM | 20 |
| %EOF | 141 |
| %EQUAL | 2 |
| %ERROR | 43 |
| %FIELDS | 1 |
| %FOUND | 90 |
| %INT | 1 |
| %LEN | 216 |
| %LIST | 2 |
| %LOOKUP | 6 |
| %LOWER | 2 |
| %MIN | 1 |
| %OPEN | 5 |
| %PADDR | 1 |
| %PARMS | 3 |
| %REM | 30 |
| %SCAN | 19 |
| %SCANRPL | 16 |
| %SIZE | 276 |
| %STATUS | 5 |
| %STR | 6 |
| %SUBARR | 8 |
| %SUBST | 223 |
| %TARGET | 2 |
| %TIMESTAMP | 4 |
| %TRIM | 279 |
| %TRIML | 1 |
| %TRIMR | 86 |
| %UPPER | 5 |
| %XFOOT | 9 |
| %XLATE | 14 |
| BASED | 22 |
| BEGSR | 326 |
| CALLP | 77 |
| CHAIN | 225 |
| CLEAR | 763 |
| COMMIT | 92 |
| CONST | 625 |
| CRTPF | 1 |
| CRTRPGPGM | 2 |
| CTL-OPT | 185 |
| DCL-C | 143 |
| DCL-DS | 226 |
| DCL-ENUM | 2 |
| DCL-F | 163 |
| DCL-PI | 211 |
| DCL-PR | 210 |
| DCL-PROC | 504 |
| DCL-S | 926 |
| DELETE | 129 |
| DIM | 101 |
| DISK | 180 |
| DOU | 106 |
| DOW | 327 |
| DOWEQ | 136 |
| DSPLY | 279 |
| ELSE | 406 |
| ENDDO | 594 |
| ENDIF | 2214 |
| EVAL | 746 |
| EXFMT | 313 |
| F11 | 2 |
| F23 | 100 |
| FMT | 41 |
| FOR | 191 |
| FOR-EACH | 4 |
| INS | 9 |
| INZ | 536 |
| ITER | 103 |
| LEAVE | 452 |
| LIKE | 90 |
| MONITOR | 34 |
| MOVE | 478 |
| MOVEL | 301 |
| OPEN | 106 |
| OPTIONS | 120 |
| OVERLAY | 20 |
| PARM | 122 |
| PLIST | 55 |
| QRPGSRC | 189 |
| QUALIFIED | 44 |
| READ | 265 |
| READE | 81 |
| READP | 17 |
| READPE | 3 |
| RESET | 2 |
| RETURN | 324 |
| RPG | 687 |
| SELECT | 406 |
| SETGT | 8 |
| SETLL | 127 |
| SETOF | 153 |
| SETON | 401 |
| SND-MSG | 26 |
| SORTA | 5 |
| TEST | 29 |
| UNLOCK | 8 |
| UPDAT | 2 |
| UPDATE | 174 |
| WORKSTN | 153 |
| WRITE | 486 |
| WRKSPLF | 7 |
| Z-ADD | 221 |
