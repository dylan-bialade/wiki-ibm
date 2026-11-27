# Ce qui manque dans les fiches (utilise dans le code, absent des fiches)

Genere le 2026-11-26 14:48 a partir de 1519 sources. Un terme est 'manquant' s'il n'apparait dans aucune fiche 01-05. Les comptes sont des occurrences dans le code ; voir 'Bibliotheques' pour la dispersion. Heuristique : verifier chaque terme sur job-i.fr avant d'ecrire la fiche.

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](SOMMAIRE.md))

- [Commandes CL : 70 manquants sur 115 utilises](#commandes-cl--70-manquants-sur-115-utilises)
- [Instructions / fonctions RPG (reconnues par job-i) : 45 manquants sur 113 utilises](#instructions--fonctions-rpg-reconnues-par-job-i--45-manquants-sur-113-utilises)
- [Messages (MONMSG, SQLCODE...) : 66 manquants sur 82 utilises](#messages-monmsg-sqlcode--66-manquants-sur-82-utilises)
- [Services SQL (QSYS2, SYSTOOLS) : 80 manquants sur 91 utilises](#services-sql-qsys2-systools--80-manquants-sur-91-utilises)
- [Mots-cles DDS / ecran : 87 manquants sur 105 utilises](#mots-cles-dds--ecran--87-manquants-sur-105-utilises)
- [Sources par type et bibliotheque](#sources-par-type-et-bibliotheque)
<!-- TOC:END -->

## Commandes CL : 70 manquants sur 115 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| CHGVAR | 400 | 15 |
| ENDPGM | 190 | 16 |
| GOTO | 135 | 11 |
| WHEN | 92 | 4 |
| SNDPGMMSG | 85 | 11 |
| SNDRCVF | 77 | 10 |
| RCVF | 52 | 8 |
| DLTOVR | 44 | 6 |
| DSPATR | 33 | 1 |
| LEAVE | 28 | 1 |
| ELSE | 24 | 8 |
| STRSEU | 15 | 3 |
| RTVJOBA | 14 | 10 |
| CLRPFM | 13 | 7 |
| CHGCURLIB | 12 | 6 |
| CLOF | 10 | 4 |
| RCVMSG | 10 | 6 |
| CPYSRCF | 9 | 3 |
| DCLPRCOPT | 9 | 1 |
| DOWHILE | 9 | 3 |
| FTP | 9 | 5 |
| OPNQRYF | 8 | 4 |
| RTVOBJD | 8 | 4 |
| RTVUSRPRF | 8 | 7 |
| COPYRIGHT | 7 | 1 |
| CRTDIR | 7 | 5 |
| RMVDIR | 7 | 6 |
| CPYTOSTMF | 6 | 5 |
| ENDMOD | 6 | 1 |
| CRTCLPGM | 5 | 3 |
| DOUNTIL | 5 | 4 |
| RMVLIBLE | 5 | 4 |
| RTVMBRD | 5 | 2 |
| STRSBS | 5 | 3 |
| CALLPRC | 4 | 1 |
| CALLSUBR | 4 | 3 |
| DLYJOB | 4 | 2 |
| ENDSUBR | 4 | 3 |
| ITERATE | 4 | 3 |
| RCLRSC | 4 | 3 |
| RTVSYSVAL | 4 | 3 |
| SUBR | 4 | 3 |
| CRTDSPF | 3 | 3 |
| SNDMSG | 3 | 2 |
| STRPCCMD | 3 | 1 |

## Instructions / fonctions RPG (reconnues par job-i) : 45 manquants sur 113 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| LEAVE | 617 | 14 |
| ELSE | 566 | 17 |
| WORKSTN | 218 | 15 |
| %ADDR | 214 | 10 |
| DCL-C | 208 | 13 |
| DELETE | 191 | 9 |
| ITER | 180 | 13 |
| PARM | 146 | 8 |
| %TRIMR | 99 | 7 |
| %ERROR | 89 | 4 |
| QUALIFIED | 57 | 9 |
| OVERLAY | 46 | 7 |
| %XLATE | 40 | 3 |
| SND-MSG | 28 | 9 |
| %SCANRPL | 21 | 6 |
| BASED | 21 | 9 |
| %DIV | 15 | 3 |
| %DAYS | 13 | 4 |
| READP | 13 | 4 |
| %DECH | 11 | 5 |
| SETGT | 11 | 4 |
| UNLOCK | 10 | 3 |
| %TIMESTAMP | 7 | 3 |
| %EQUAL | 6 | 1 |
| %OPEN | 6 | 4 |
| %STATUS | 6 | 4 |
| %STR | 6 | 1 |
| %MIN | 5 | 2 |
| %SUBARR | 5 | 3 |
| %TARGET | 4 | 2 |
| READPE | 4 | 3 |
| SORTA | 4 | 1 |
| %TRIML | 3 | 1 |
| %XFOOT | 3 | 1 |
| %ALLOC | 2 | 1 |
| %LIST | 2 | 2 |
| %PASSED | 2 | 1 |
| DCL-ENUM | 2 | 2 |
| ON-EXIT | 2 | 1 |
| %CHECKR | 1 | 1 |
| %FIELDS | 1 | 1 |
| %PARMNUM | 1 | 1 |
| %SUBDT | 1 | 1 |
| %TIME | 1 | 1 |
| RESET | 1 | 1 |

## Messages (MONMSG, SQLCODE...) : 66 manquants sur 82 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| CPF0000 | 102 | 13 |
| CPF0864 | 61 | 9 |
| CPF9897 | 36 | 7 |
| CPD0084 | 26 | 3 |
| CPF2103 | 22 | 7 |
| CPF2551 | 22 | 4 |
| CPD0071 | 18 | 4 |
| CPF9898 | 18 | 6 |
| CPD0172 | 17 | 4 |
| MCH0000 | 14 | 5 |
| EDT9007 | 13 | 2 |
| EDT0223 | 12 | 1 |
| CPF9812 | 9 | 5 |
| CPF2111 | 8 | 5 |
| CPF5813 | 8 | 2 |
| CPF2817 | 7 | 3 |
| CPF3CF2 | 6 | 2 |
| CPFA0A0 | 6 | 5 |
| SQL0000 | 6 | 5 |
| CPD0000 | 5 | 4 |
| SQL0901 | 5 | 3 |
| CPD9817 | 4 | 4 |
| CPF1697 | 4 | 2 |
| CPF2110 | 4 | 4 |
| CPFA0A9 | 4 | 2 |
| CPF0801 | 3 | 2 |
| CPF3012 | 3 | 3 |
| CPF3064 | 3 | 3 |
| CPF4174 | 3 | 1 |
| CPF7602 | 3 | 1 |
| CPFA0B7 | 3 | 2 |
| IWS4010 | 3 | 1 |
| CPC1221 | 2 | 1 |
| CPF1064 | 2 | 2 |
| CPF1164 | 2 | 1 |
| CPF1621 | 2 | 2 |
| CPF1696 | 2 | 2 |
| CPF2104 | 2 | 2 |
| CPF2292 | 2 | 2 |
| CPF2816 | 2 | 1 |
| CPF3323 | 2 | 2 |
| CPF3353 | 2 | 2 |
| CPF4520 | 2 | 2 |
| CPFA097 | 2 | 1 |
| RNF5409 | 2 | 1 |

## Services SQL (QSYS2, SYSTOOLS) : 80 manquants sur 91 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| QSYS2.BASE64_ENCODE | 21 | 4 |
| SYSTOOLS.BASE64ENCODE | 20 | 3 |
| SYSTOOLS.HTTPGETCLOB | 15 | 4 |
| QSYS2.HTTP_GET | 11 | 4 |
| SYSTOOLS.HTTPPOSTCLOB | 9 | 4 |
| QSYS2.HTTP_POST_VERBOSE | 6 | 4 |
| QSYS2.HTTP_POST | 6 | 4 |
| QSYS2.HTTP_PUT | 6 | 4 |
| SYSTOOLS.HTTPDELETECLOB | 6 | 3 |
| SYSTOOLS.HTTPPUTCLOB | 6 | 4 |
| QSYS2.BOUND_MODULE_INFO | 5 | 3 |
| QSYS2.HTTP_DELETE | 5 | 3 |
| QSYS2.HTTP_GET_VERBOSE | 4 | 1 |
| QSYS2.SYSPARTITIONSTAT | 4 | 3 |
| QSYS2.BOUND_SRVPGM_INFO | 2 | 2 |
| QSYS2.SEND_DATA_QUEUE | 2 | 1 |
| QSYS2.SEND_MESSAGE | 2 | 1 |
| QSYS2.STACK_INFO | 2 | 1 |
| SYSTOOLS.PING | 2 | 1 |
| SYSTOOLS.SQLCODE_INFO | 2 | 1 |
| QSYS2.DISPLAY_JOURNAL | 1 | 1 |
| QSYS2.DNS_LOOKUP | 1 | 1 |
| QSYS2.DSPLIBL | 1 | 1 |
| QSYS2.DSPOBJD | 1 | 1 |
| QSYS2.ERRORS | 1 | 1 |
| QSYS2.EXEC_CMD | 1 | 1 |
| QSYS2.FE | 1 | 1 |
| QSYS2.FI | 1 | 1 |
| QSYS2.GET_LOG | 1 | 1 |
| QSYS2.HOST_IP | 1 | 1 |
| QSYS2.HTTP_DELETE_VERBOSE | 1 | 1 |
| QSYS2.HTTP_PUT_VERBOSE | 1 | 1 |
| QSYS2.IFS_READ_BINARY | 1 | 1 |
| QSYS2.IFS_REMOVE_FILE | 1 | 1 |
| QSYS2.JOB_INFO | 1 | 1 |
| QSYS2.JOB_LOG | 1 | 1 |
| QSYS2.JOB_QUEUE | 1 | 1 |
| QSYS2.JRN_INFO | 1 | 1 |
| QSYS2.LIBL | 1 | 1 |
| QSYS2.LIBRARY_LIST_INFO | 1 | 1 |
| QSYS2.NETS | 1 | 1 |
| QSYS2.OUTQ_ENTRIES | 1 | 1 |
| QSYS2.PASSWORD_INFO | 1 | 1 |
| QSYS2.PROGRAM_EXPORT_IMPORT_INFO | 1 | 1 |
| QSYS2.PTF_LIST | 1 | 1 |

## Mots-cles DDS / ecran : 87 manquants sur 105 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| COLOR | 2994 | 16 |
| DSPATR | 1280 | 13 |
| DSPSIZ | 253 | 18 |
| CHECK | 234 | 12 |
| CA03 | 142 | 14 |
| OVERLAY | 139 | 15 |
| CF03 | 137 | 11 |
| CA12 | 111 | 12 |
| CF23 | 100 | 10 |
| ERRMSG | 76 | 10 |
| WINDOW | 59 | 12 |
| SFLCOLUMN | 58 | 1 |
| CF12 | 57 | 9 |
| INDARA | 49 | 11 |
| CF06 | 47 | 9 |
| CA06 | 45 | 8 |
| SFLCR | 39 | 3 |
| REFFLD | 37 | 5 |
| CHGINPDFT | 34 | 10 |
| CA05 | 33 | 8 |
| CF05 | 33 | 9 |
| CF08 | 22 | 6 |
| CF10 | 20 | 7 |
| CF02 | 19 | 9 |
| CF21 | 19 | 7 |
| CF11 | 17 | 5 |
| CF07 | 16 | 8 |
| CF22 | 16 | 7 |
| CA01 | 15 | 4 |
| SFLMAX | 14 | 2 |
| CA08 | 13 | 3 |
| CF04 | 12 | 6 |
| CF24 | 12 | 5 |
| EDTWRD | 11 | 3 |
| SFLDROP | 11 | 4 |
| SFLLIN | 11 | 2 |
| CF09 | 10 | 5 |
| CF15 | 10 | 5 |
| SFLLCK | 10 | 1 |
| SFLOPT | 10 | 1 |
| CF13 | 9 | 4 |
| CF20 | 9 | 4 |
| CF14 | 8 | 3 |
| CF16 | 8 | 3 |
| CF17 | 8 | 3 |

## Sources par type et bibliotheque

| Type | Sources |
|---|---|
| DDS | 499 |
| RPG/RPG-ILE | 437 |
| RPG/RPG-III-400 | 184 |
| CL/CL-procedural | 172 |
| CL/CL-ILE | 70 |
| SQL | 46 |
| COBOL | 38 |
| Autres/Service-programs | 25 |
| Menus | 16 |
| Autres/Web | 12 |
| RPG/Copy | 11 |
| Autres/Commandes | 5 |
| Autres/Aide | 3 |
| Autres/Panneaux-UIM | 1 |
