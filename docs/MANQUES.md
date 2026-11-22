# Ce qui manque dans les fiches (utilise dans le code, absent des fiches)

Genere le 2026-11-22 13:08 a partir de 1082 sources. Un terme est 'manquant' s'il n'apparait dans aucune fiche 01-05. Les comptes sont des occurrences dans le code ; voir 'Bibliotheques' pour la dispersion. Heuristique : verifier chaque terme sur job-i.fr avant d'ecrire la fiche.

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](SOMMAIRE.md))

- [Commandes CL : 60 manquants sur 104 utilises](#commandes-cl--60-manquants-sur-104-utilises)
- [Instructions / fonctions RPG (reconnues par job-i) : 39 manquants sur 102 utilises](#instructions--fonctions-rpg-reconnues-par-job-i--39-manquants-sur-102-utilises)
- [Messages (MONMSG, SQLCODE...) : 60 manquants sur 68 utilises](#messages-monmsg-sqlcode--60-manquants-sur-68-utilises)
- [Services SQL (QSYS2, SYSTOOLS) : 25 manquants sur 28 utilises](#services-sql-qsys2-systools--25-manquants-sur-28-utilises)
- [Mots-cles DDS / ecran : 84 manquants sur 102 utilises](#mots-cles-dds--ecran--84-manquants-sur-102-utilises)
- [Sources par type et bibliotheque](#sources-par-type-et-bibliotheque)
<!-- TOC:END -->

## Commandes CL : 60 manquants sur 104 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| CHGVAR | 310 | 13 |
| ENDPGM | 142 | 14 |
| GOTO | 94 | 9 |
| WHEN | 92 | 4 |
| SNDPGMMSG | 73 | 9 |
| SNDRCVF | 53 | 8 |
| DLTOVR | 44 | 6 |
| RCVF | 38 | 6 |
| DSPATR | 33 | 1 |
| LEAVE | 28 | 1 |
| ELSE | 22 | 7 |
| STRSEU | 14 | 2 |
| RTVJOBA | 13 | 9 |
| CHGCURLIB | 11 | 5 |
| CLOF | 10 | 4 |
| CLRPFM | 10 | 5 |
| RCVMSG | 10 | 6 |
| CPYSRCF | 9 | 3 |
| DCLPRCOPT | 9 | 1 |
| FTP | 9 | 5 |
| OPNQRYF | 8 | 4 |
| RTVOBJD | 8 | 4 |
| COPYRIGHT | 7 | 1 |
| RMVDIR | 7 | 6 |
| CPYTOSTMF | 6 | 5 |
| ENDMOD | 6 | 1 |
| RTVUSRPRF | 6 | 5 |
| CRTCLPGM | 5 | 3 |
| CRTDIR | 5 | 4 |
| DOUNTIL | 5 | 4 |
| RMVLIBLE | 5 | 4 |
| RTVMBRD | 5 | 2 |
| STRSBS | 5 | 3 |
| CALLSUBR | 4 | 3 |
| DLYJOB | 4 | 2 |
| ENDSUBR | 4 | 3 |
| ITERATE | 4 | 3 |
| RCLRSC | 4 | 3 |
| SUBR | 4 | 3 |
| CRTDSPF | 3 | 3 |
| STRPCCMD | 3 | 1 |
| ADDENVVAR | 2 | 1 |
| ADDJOBQE | 2 | 2 |
| ADDRTGE | 2 | 2 |
| CRTCLS | 2 | 2 |

## Instructions / fonctions RPG (reconnues par job-i) : 39 manquants sur 102 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| LEAVE | 475 | 12 |
| ELSE | 414 | 15 |
| %ADDR | 190 | 9 |
| DCL-C | 161 | 11 |
| WORKSTN | 158 | 13 |
| DELETE | 134 | 7 |
| ITER | 114 | 11 |
| PARM | 105 | 6 |
| %TRIMR | 85 | 5 |
| %ERROR | 43 | 2 |
| QUALIFIED | 41 | 8 |
| SND-MSG | 26 | 8 |
| OVERLAY | 24 | 5 |
| BASED | 21 | 9 |
| %SCANRPL | 16 | 3 |
| %XLATE | 14 | 1 |
| %DIV | 13 | 2 |
| %DECH | 10 | 4 |
| READP | 10 | 2 |
| %DAYS | 8 | 1 |
| UNLOCK | 8 | 1 |
| SETGT | 7 | 2 |
| %STR | 6 | 1 |
| %OPEN | 5 | 3 |
| %STATUS | 5 | 3 |
| %SUBARR | 5 | 3 |
| %TIMESTAMP | 4 | 1 |
| %XFOOT | 3 | 1 |
| READPE | 3 | 2 |
| %ALLOC | 2 | 1 |
| %EQUAL | 2 | 1 |
| %LIST | 2 | 2 |
| %TARGET | 2 | 1 |
| DCL-ENUM | 2 | 2 |
| %CHECKR | 1 | 1 |
| %FIELDS | 1 | 1 |
| %MIN | 1 | 1 |
| RESET | 1 | 1 |
| SORTA | 1 | 1 |

## Messages (MONMSG, SQLCODE...) : 60 manquants sur 68 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| CPF0000 | 82 | 11 |
| CPF0864 | 47 | 7 |
| CPF2103 | 20 | 7 |
| CPF9897 | 20 | 5 |
| CPF9898 | 16 | 5 |
| MCH0000 | 14 | 5 |
| EDT9007 | 13 | 2 |
| EDT0223 | 12 | 1 |
| CPD0071 | 10 | 2 |
| CPF9812 | 9 | 5 |
| CPF5813 | 8 | 2 |
| CPD0084 | 6 | 1 |
| CPF2551 | 6 | 2 |
| CPF2817 | 6 | 2 |
| CPF3CF2 | 6 | 2 |
| SQL0000 | 6 | 5 |
| CPD0000 | 5 | 4 |
| CPD0172 | 5 | 2 |
| CPF2111 | 5 | 3 |
| CPD9817 | 4 | 4 |
| CPF1697 | 4 | 2 |
| CPFA0A0 | 4 | 4 |
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
| CPF1621 | 2 | 2 |
| CPF1696 | 2 | 2 |
| CPF2104 | 2 | 2 |
| CPF2110 | 2 | 2 |
| CPF2292 | 2 | 2 |
| CPF2816 | 2 | 1 |
| CPF3323 | 2 | 2 |
| CPF3353 | 2 | 2 |
| CPF4520 | 2 | 2 |
| CPFA097 | 2 | 1 |
| SQL0952 | 2 | 1 |
| SQL7064 | 2 | 1 |
| CPF1008 | 1 | 1 |

## Services SQL (QSYS2, SYSTOOLS) : 25 manquants sur 28 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| QSYS2.BASE64_ENCODE | 5 | 2 |
| QSYS2.BOUND_MODULE_INFO | 5 | 3 |
| QSYS2.HTTP_GET | 5 | 2 |
| QSYS2.IFS_WRITE_UTF8 | 5 | 1 |
| QSYS2.SYSPARTITIONSTAT | 4 | 3 |
| SYSTOOLS.BASE64ENCODE | 4 | 1 |
| SYSTOOLS.HTTPPOSTCLOB | 4 | 2 |
| QSYS2.HTTP_POST_VERBOSE | 3 | 3 |
| SYSTOOLS.HTTPGETCLOB | 3 | 2 |
| QSYS2.BOUND_SRVPGM_INFO | 2 | 2 |
| QSYS2.HTTP_POST | 2 | 2 |
| QSYS2.HTTP_PUT | 2 | 2 |
| QSYS2.SEND_DATA_QUEUE | 2 | 1 |
| QSYS2.SEND_MESSAGE | 2 | 1 |
| QSYS2.STACK_INFO | 2 | 1 |
| SYSTOOLS.HTTPPUTCLOB | 2 | 2 |
| QSYS2.HTTP_DELETE | 1 | 1 |
| QSYS2.IFS_READ_BINARY | 1 | 1 |
| QSYS2.IFS_REMOVE_FILE | 1 | 1 |
| QSYS2.JOB_INFO | 1 | 1 |
| QSYS2.PROGRAM_EXPORT_IMPORT_INFO | 1 | 1 |
| QSYS2.RECEIVE_DATA_QUEUE | 1 | 1 |
| QSYS2.SYSROUTINES | 1 | 1 |
| SYSTOOLS.HTTPDELETECLOBVERBOSE | 1 | 1 |
| SYSTOOLS.HTTPDELETECLOB | 1 | 1 |

## Mots-cles DDS / ecran : 84 manquants sur 102 utilises

| Terme | Occurrences | Bibliotheques |
|---|---|---|
| COLOR | 2152 | 14 |
| DSPATR | 1017 | 11 |
| CHECK | 185 | 9 |
| DSPSIZ | 178 | 16 |
| CA03 | 102 | 12 |
| CF03 | 100 | 9 |
| OVERLAY | 84 | 13 |
| CA12 | 83 | 10 |
| CF23 | 71 | 8 |
| ERRMSG | 61 | 8 |
| SFLCOLUMN | 58 | 1 |
| CF12 | 52 | 7 |
| WINDOW | 40 | 10 |
| INDARA | 39 | 9 |
| CA06 | 37 | 6 |
| SFLCR | 37 | 2 |
| REFFLD | 30 | 4 |
| CF06 | 29 | 7 |
| CHGINPDFT | 26 | 8 |
| CA05 | 20 | 6 |
| CF05 | 19 | 7 |
| CF10 | 17 | 5 |
| CF11 | 17 | 5 |
| CF21 | 15 | 5 |
| SFLMAX | 14 | 2 |
| CF02 | 13 | 7 |
| CA08 | 12 | 2 |
| CF07 | 12 | 6 |
| CF24 | 12 | 5 |
| CA01 | 11 | 2 |
| EDTWRD | 11 | 3 |
| SFLDROP | 11 | 4 |
| SFLLIN | 11 | 2 |
| CF08 | 10 | 4 |
| CF09 | 10 | 5 |
| CF22 | 10 | 5 |
| SFLLCK | 10 | 1 |
| SFLOPT | 10 | 1 |
| CF04 | 9 | 4 |
| CF13 | 9 | 4 |
| CF15 | 9 | 4 |
| CF20 | 9 | 4 |
| CF14 | 8 | 3 |
| CF16 | 8 | 3 |
| CF17 | 8 | 3 |

## Sources par type et bibliotheque

| Type | Sources |
|---|---|
| DDS | 382 |
| RPG/RPG-ILE | 291 |
| CL/CL-procedural | 128 |
| RPG/RPG-III-400 | 124 |
| CL/CL-ILE | 50 |
| SQL | 31 |
| COBOL | 26 |
| Autres/Service-programs | 14 |
| Menus | 14 |
| RPG/Copy | 11 |
| Autres/Web | 5 |
| Autres/Commandes | 4 |
| Autres/Aide | 1 |
| Autres/Panneaux-UIM | 1 |
