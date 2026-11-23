# Partie 04 : Le langage de contrôle (CL)

> Plan de formation, partie 04 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Fondements du CL, fichiers et OVRDBF, structure d'un programme, boucles et conditions, chaînes, appels et paramètres, zones de données, sous-routines.
>
> **Mots-clés** : CL, CLP, CLLE, DCLPROPT, DCLF, OVRDBF, IF, DOWHILE, GOTO, CHGVAR, CALL, DTAARA, SUBR.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Cours détaillé](#cours-détaillé)
  - [Les fondements du langage de contrôle](#les-fondements-du-langage-de-contrôle)
  - [Structurer un programme CL](#structurer-un-programme-cl)
  - [Appels, données et sous-routines](#appels-données-et-sous-routines)
  - [Où voir des exemples dans le dépôt](#où-voir-des-exemples-dans-le-dépôt)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Les fondements du langage de contrôle](#les-fondements-du-langage-de-contrôle-1)
  - [Structurer un programme CL](#structurer-un-programme-cl-1)
  - [Appels, données et sous-routines](#appels-données-et-sous-routines-1)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 02 : commandes CL](../cheatsheets/02-reference-systeme.md)
- [Sources CL dans le dépôt](../INDEX-SOURCES.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Coder en CL (CLLE et CLP) : 3 programmes, MONMSG, écran, débogage](https://job-i.fr/coder-cl-ibm-i) | Un programme CL (PGM à ENDPGM) enchaîne des commandes avec variables, tests, boucles et MONMSG ; il pilote les travaux et les traitements. | En une phrase ; Préparer l'atelier ; HELLOCL : dire bonjour à l'utilisateur ; ETATSTK : lire un fichier et gérer les erreurs ; MENUCL : un menu qui affiche un écran ; Déboguer et tester ; CLP ou CLLE ? |
| [Zone de données (DTAARA) IBM i : CL, RPG, SQL et *LDA, exemples testés](https://job-i.fr/zone-de-donnees-dtaara-ibm-i) | Une zone de données *DTAARA contient une seule valeur (compteur, paramètre, état) partagée entre programmes et travaux. | En une phrase ; Une zone de données, c'est quoi ; Créer et afficher une zone de données ; Le numéro de facture suivant ; Le verrou, vu d'un autre travail ; Une zone de paramètres vue comme une structure ; La *LDA, propre à chaque travail ; Le piège du full free : les apostrophes ; Lire une zone de données en SQL ; Les erreurs, et ce qu'elles veulent dire |
| [API système IBM i : QSNDDTAQ, QUSROBJD, QCMDEXC, QsnWrtDta, exemples testés](https://job-i.fr/api-systeme-ibm-i) | Une API système est une procédure ou un programme livré par IBM pour ce qu'aucune instruction ne fait (files de données, description d'objet, exécution de commande, écran). | En une phrase ; Deux familles : les programmes et les procédures ; Le code erreur, commun aux API ; QSNDDTAQ et QRCVDTAQ : des commandes entre deux programmes ; La même file, vue et utilisée en SQL ; QCMDEXC : exécuter une commande CL ; QUSROBJD : la description d'un objet ; QsnWrtDta : écrire sur l'écran sans DSPF ; Les messages relevés |

## Cours détaillé

> Synthèse rédigée à partir de la page job-i « Coder en CL » (lue sur 9,5 Ko des 12,6 Ko, **partielle**) et des fiches de commandes job-i (résumé « En bref », syntaxe minimale, liste des paramètres et, pour quelques-unes, texte d'aide F1 IBM i 7.5), lues le 2026-11-23. Les exemples de code viennent de ces pages et **n'ont pas été compilés ici**. Statut « vérifié » = vu dans la partie lue.
> **Note sur le plan** : le plan de la formation écrit « DCLPROPT » ; la commande CL qui définit les options de traitement du compilateur s'appelle **`DCLPRCOPT`** (fiche job-i).

### Les fondements du langage de contrôle

**Le langage et `DCLPRCOPT`**
- Un programme CL enchaîne des **commandes du système** (les mêmes que sur la ligne de commande) entre `PGM` et `ENDPGM`, avec des variables (`&NOM`), des tests, des boucles et l'interception des messages d'erreur (`MONMSG`). C'est le langage qui pilote les travaux, appelle les programmes et lance les traitements. Source : [job-i, coder en CL](https://job-i.fr/coder-cl-ibm-i). *Vérifié.*
- **Format** : les colonnes ne comptent pas ; une ligne = une commande ; une ligne qui se termine par `+` continue sur la suivante ; commentaires `/* ... */`. Dans SEU, **F4** sur une ligne ouvre l'invite de la commande (avec zones étiquette et commentaire).
- **Ordre** : les déclarations (`DCL`, `DCLF`) viennent **en tête, juste après `PGM`**.
- **`DCL`** : `DCL VAR(&nom) TYPE(...) LEN(...) VALUE(...)`. Types : `*CHAR` (alphanumérique), `*DEC` (décimal condensé), `*LGL` (logique `'1'` / `'0'`), `*INT` et `*UINT` (entiers binaires signé / non signé), `*PTR` (pointeur de 16 octets, pas de `LEN`). `LEN` d'un décimal : `LEN(7 0)` = chiffres, décimales. Mémoire `STG` : `*AUTO` (défaut), `*BASED` (`BASPTR`), `*DEFINED` (`DEFVAR`). Source : [job-i DCL](https://job-i.fr/commandes-ibm-i/dcl) (*texte d'aide IBM i 7.5*).
- **`DCLPRCOPT`** : options de traitement du compilateur (`SUBRSTACK`, `LOG`, `ALWRTVSRC`, `TEXT`, `USRPRF`, `AUT`, `DFTACTGRP`, `ACTGRP`, `BNDSRVPGM`, `BNDDIR`, `STGMDL`, `DBGENCKEY`). Valeurs détaillées : F1 / fiche [job-i DCLPRCOPT](https://job-i.fr/commandes-ibm-i/dclprcopt) (*non lue en détail*).
- **CLP ou CLLE** (type de membre `CLP` ou `CLLE`) :

| Critère | CLP | CLLE |
|---|---|---|
| Compilation | `CRTCLPGM` | `CRTBNDCL` (ou `CRTCLMOD` puis `CRTPGM`) |
| Débogueur | `STRISDB` (ou `STRDBG OPMSRC(*YES)`) | `STRDBG`, avec `DBGVIEW(*SOURCE)` |
| Appeler une procédure liée (`CALLPRC`) | non | oui |
| Source dans l'IFS (`SRCSTMF`) | non | oui |
| `OPTIMIZE`, `ACTGRP`, `INCDIR` | non | oui |
| `DOWHILE`, `SELECT`, `%TRIM`, `%CHAR` (sur 7.5) | oui | oui |

  (job-i : les trois programmes de la page compilent sans changement en CLP.) Les sources du dépôt sont rangés en `CL-procedural` (CLP) et `CL-ILE` (CLLE) dans l'[index des sources](../INDEX-SOURCES.md).
- **Compiler** : [`CRTBNDCL`](https://job-i.fr/commandes-ibm-i/crtbndcl) (`PGM`, `SRCFILE`, `SRCMBR`, `SRCSTMF`, `DFTACTGRP`, `ACTGRP`, `OPTIMIZE`, `DBGVIEW`, `REPLACE`, `TGTRLS`, `INCDIR`…), [`CRTCLPGM`](https://job-i.fr/commandes-ibm-i/crtclpgm), [`CRTCLMOD`](https://job-i.fr/commandes-ibm-i/crtclmod). Atelier job-i : bibliothèque, fichier source `QCLSRC` (membres `CLLE`), `CRTSRCPF FILE(BIB01/QCLSRC) RCDLEN(92)`.
- **Déboguer** : `STRDBG PGM(BIB01/MONPGM)` puis `BREAK 22 WHEN &ARTCOD = 'A0005'` (point d'arrêt conditionnel), `EVAL &NB` ; `DMPCLPGM` clichera vers le spool `QPPGMDMP` les variables et les messages de la file du programme ([fiche](https://job-i.fr/commandes-ibm-i/dmpclpgm)).

**L'utilisation des fichiers (base de données, écrans)**

| Commande | Rôle | Paramètres |
|---|---|---|
| [`DCLF`](https://job-i.fr/commandes-ibm-i/dclf) | déclare un fichier : ses zones deviennent des variables (`&ARTCOD`…) ; le fichier doit **exister à la compilation** | `FILE`, `RCDFMT`, `OPNID`, `ALWVARLEN`, `ALWNULL`, `ALWGRAPHIC`, `DCLBINFLD` |
| [`RCVF`](https://job-i.fr/commandes-ibm-i/rcvf) | reçoit un enregistrement (fichier base de données ou écran) ; en **fin de fichier, message `CPF0864`** | `DEV`, `RCDFMT`, `OPNID`, `WAIT` |
| [`SNDF`](https://job-i.fr/commandes-ibm-i/sndf) | envoie un format vers un écran | `DEV`, `RCDFMT`, `OPNID` |
| [`SNDRCVF`](https://job-i.fr/commandes-ibm-i/sndrcvf) | envoie puis reçoit (dialogue avec l'écran) | `DEV`, `RCDFMT`, `OPNID`, `WAIT` |

- Pour un **écran** (DSPF) : les zones deviennent des variables et l'indicateur 03 devient `&IN03` ; la boucle de menu est `DOWHILE COND(*NOT &IN03)` + `SNDRCVF RCDFMT(MENU)`.
- **Forme de lecture d'un fichier** (d'après la page job-i, non compilée ici) :
```
DCLF FILE(BIB01/ARTICLE)
MONMSG MSGID(CPF0000) EXEC(GOTO CMDLBL(ERREUR))   /* global : après les déclarations */
DOWHILE COND('1')
  RCVF
  MONMSG MSGID(CPF0864) EXEC(LEAVE)               /* fin de fichier */
  /* traiter l'enregistrement */
ENDDO
```

**Les `OVRDBF`** (substitution de fichier base de données)
- [`OVRDBF`](https://job-i.fr/commandes-ibm-i/ovrdbf) permet (1) de remplacer le fichier désigné dans le programme (`FILE` = nom dans le programme, `TOFILE` = fichier traité), (2) de remplacer certains paramètres du fichier, ou (3) les deux. Il ne concerne que les fichiers physiques, logiques et DDM (*texte d'aide IBM i 7.5*).
- Paramètres : `FILE`, `TOFILE`, `MBR` (membre), `POSITION`, `WAITFILE`, `WAITRCD`, `REUSEDLT`, `NBRRCDS`, `LVLCHK`, `EXPCHK`, `INHWRT`, `SECURE`, **`OVRSCOPE`** (portée de la substitution), **`SHARE`** (partage du chemin d'ouverture), `OPNSCOPE`, `SEQONLY`, `DSTDTA`.
- **`DLTOVR FILE(...) LVL(...)`** supprime des substitutions, y compris de fichiers de messages, précédemment indiquées dans un niveau d'appel ([fiche](https://job-i.fr/commandes-ibm-i/dltovr)).
- Usage typique : choisir un **membre** d'un fichier multi-membre avant l'ouverture ([job-i multi-membre](https://job-i.fr/multi-membre-multi-format-ibm-i), *page non lue en détail*). Exemples dans le dépôt : `sources/CL/CL-procedural/BIB10/SAVECL2.md`, `sources/CL/CL-procedural/BIB02/RACEC.md`.

### Structurer un programme CL

**Boucles et conditions** (fiches de commandes, *vérifié*)

| Commande | Syntaxe minimale | Remarque |
|---|---|---|
| [`IF`](https://job-i.fr/commandes-ibm-i/if) | `IF COND(...) THEN(...)` | évalue une expression logique ; `THEN(DO)` ... `ENDDO` pour un groupe |
| [`ELSE`](https://job-i.fr/commandes-ibm-i/else) | `ELSE CMD(...)` | sinon, avec `IF` |
| [`DOWHILE`](https://job-i.fr/commandes-ibm-i/dowhile) / [`DOUNTIL`](https://job-i.fr/commandes-ibm-i/dountil) | `DOWHILE COND(...)` | `DOUNTIL` : le groupe est traité une ou plusieurs fois |
| [`DOFOR`](https://job-i.fr/commandes-ibm-i/dofor) | `DOFOR VAR(...) FROM(...) TO(...)` | `BY` pour le pas ; zéro fois ou plus |
| [`SELECT`](https://job-i.fr/commandes-ibm-i/select) / [`WHEN`](https://job-i.fr/commandes-ibm-i/when) / [`OTHERWISE`](https://job-i.fr/commandes-ibm-i/otherwise) / [`ENDSELECT`](https://job-i.fr/commandes-ibm-i/endselect) | `WHEN COND(...) THEN(...)` | un choix parmi plusieurs cas |
| [`LEAVE`](https://job-i.fr/commandes-ibm-i/leave) | `LEAVE [CMDLBL(...)]` | sort de la boucle `DOWHILE` / `DOUNTIL` / `DOFOR` et reprend après l'`ENDDO` |
| [`GOTO`](https://job-i.fr/commandes-ibm-i/goto) | `GOTO CMDLBL(...)` | branchement vers une étiquette |

- `ITER` : pas de fiche job-i trouvée (**non vérifié**).
- **Conditions** : comparaisons `*EQ`, `*LT`, `*NOT`, `*AND`… (`COND(&ARTSTK *LT &SEUIL)`, `COND(*NOT &IN03)`), constante logique `'1'`.
- **Un menu** (job-i) : `SELECT` / `WHEN COND(&OPTION *EQ '1') THEN(...)` / `OTHERWISE CMD(...)` / `ENDSELECT` ; les valeurs permises d'une zone peuvent être refusées dès les DDS (`VALUES`).

**Conditionnement d'invites** (commandes personnalisées)
- Une **commande** utilisateur se définit dans un source de commande (instructions `CMD`, `PARM`, `PMTCTL`…) compilé par [`CRTCMD`](https://job-i.fr/commandes-ibm-i/crtcmd) ; `PMTCTL` conditionne l'affichage d'un paramètre à l'invite. **Non vérifié** : `CMD`, `PARM` et `PMTCTL` n'ont pas de fiche job-i, et `CRTCMD` n'est pas lue. Exemples dans le dépôt : `sources/CL/CL-ILE/BIB05/LSTMBR.md` (4 occurrences de `CMD` / `PARM`), `sources/CL/CL-procedural/BIB10/CRTENV.md`.

**Chaînes, switchs et indicateurs**
- **`CHGVAR VAR(&x) VALUE(...)`** : change une variable CL (ou une partie d'une variable alphanumérique) ; la valeur peut être une constante, une variable, une **expression** ou une **fonction intégrée** ; conversion implicite décimal / caractère selon les règles du paramètre `VALUE` ([fiche](https://job-i.fr/commandes-ibm-i/chgvar), *texte d'aide IBM i 7.5, début lu*).
- **Fonctions intégrées citées** : `%SUBSTRING` / `%SST` (extraire ou remplacer une partie d'une variable alphanumérique, y compris de la zone de données locale `*LDA`), `%BINARY` / `%BIN` (entier binaire signé : 2 octets = décimal 5 0, 4 octets = 10 0), `%SWITCH` (fonction sur les 8 indicateurs de commutateurs du travail ; **description tronquée dans le texte lu**). job-i : `%TRIM` et `%CHAR` fonctionnent sur 7.5 (`%TRIM(&ARTLIB)`, `%CHAR(&NB)`).
- **Concaténation** : `*CAT` (tel quel), `*BCAT` (avec un blanc), `*TCAT` (en retirant les blancs de fin) : `MSG('Bonjour' *BCAT &USER *TCAT ' !')` (job-i).
- **Logiques** : une variable `*LGL` vaut `'1'` ou `'0'` ; les indicateurs d'un écran deviennent `&INnn`.

### Appels, données et sous-routines

**Appels de programmes et passage de paramètres**
- [`CALL PGM(...) PARM(...)`](https://job-i.fr/commandes-ibm-i/call) appelle un programme ; [`CALLPRC PRC(...) PARM(...) RTNVAL(...)`](https://job-i.fr/commandes-ibm-i/callprc) appelle une **procédure liée** (CLLE ; valeur de retour dans `RTNVAL`) ; `RETURN` termine le programme et rend le contrôle.
- **Piège du `15 5`** (job-i, *vérifié*) : une **constante décimale tapée sur `CALL`** est passée en décimal condensé de **15 chiffres dont 5 décimales**, quelle que soit la déclaration du programme appelé ; l'appelé lisant un `*DEC (7 0)` obtient « Erreur dans une donnée décimale » (MCH1202). Remèdes : déclarer `LEN(15 5)`, ou préciser le type à l'appel : `CALL PGM(ETATSTK) PARM((200 (*DEC 7 0)) ' ')`. Entre deux programmes, une variable passée **garde son type et sa longueur**.
- **Signaler une erreur à l'appelant** : `SNDPGMMSG MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('...') MSGTYPE(*ESCAPE)` ; sans destinataire, `SNDPGMMSG` envoie le message à l'appelant.
- **Intercepter les messages** : [`MONMSG MSGID(...) [CMPDTA(...)] [EXEC(...)]`](https://job-i.fr/commandes-ibm-i/monmsg) : jusqu'à **50** identifiants, génériques possibles (`CPF0000`) ; **admis seulement dans un programme CL**, après la dernière déclaration (valable pour tout le programme), après `PGM`, ou après une commande (alors valable pour elle seule), mais **pas** après `DO`, `DOWHILE`, `DOUNTIL`, `DOFOR`, `ELSE`, `ENDDO`, `SELECT`, `WHEN`, `OTHERWISE`, `ENDSELECT`, `ENDPGM`, `CALLSUBR`, `SUBR`, `RTNSUBR`, `ENDSUBR`, `GOTO`, `IF`, `RETURN`. Messages rencontrés : `CPF0864` (fin de fichier), `CPF9801` (objet absent, avec `CHKOBJ`), `CPF0000` (global).
- `CHKOBJ OBJ(...) OBJTYPE(...)` vérifie l'existence et les droits avant l'accès ([fiche](https://job-i.fr/commandes-ibm-i/chkobj)).

**Récupération d'informations du système**

| Commande | Rôle | Remarque |
|---|---|---|
| [`RTVJOBA`](https://job-i.fr/commandes-ibm-i/rtvjoba) | attributs du travail dans des variables | `JOB` (10), `USER` (10), `NBR` (6), `CURUSER`, `TYPE` (1), `CURLIB`, `SYSLIBL` (165), `USRLIBL` (2750), `OUTQ`, `OUTQLIB`, `PRTDEV`, `LOGLVL`, `INQMSGRPY`… : chaque paramètre est une variable de la longueur indiquée |
| [`RTVSYSVAL`](https://job-i.fr/commandes-ibm-i/rtvsysval) | une valeur système | `RTVSYSVAL SYSVAL(...) RTNVAR(...)` |
| [`RTVOBJD`](https://job-i.fr/commandes-ibm-i/rtvobjd) | description d'un objet | `RTVOBJD OBJ(...) OBJTYPE(...)` |
| [`RTVNETA`](https://job-i.fr/commandes-ibm-i/rtvneta) | attributs du réseau | |
| [`RTVDTAARA`](https://job-i.fr/commandes-ibm-i/rtvdtaara) | tout ou partie d'une zone de données | `RTVDTAARA DTAARA(...) RTNVAR(...)` |

Exemples dans le dépôt : `RTVJOBA` dans `sources/CL/CL-procedural/BIB17/EXPSRCIFS.md`, `RTVSYSVAL` dans `sources/CL/CL-procedural/BIB01/QSTRUP.md` (programme de démarrage, voir la [partie 01](01-organisation-ibm-i.md)).

**Les zones de données (`DTAARA`)** ([job-i zone de données](https://job-i.fr/zone-de-donnees-dtaara-ibm-i), *résumé de la page, non lue en détail*)
- Une zone de données (`*DTAARA`) contient **une seule valeur** (texte, nombre, indicateur) lue et modifiée par des programmes et des travaux différents : compteur, paramètre, état.

| Commande | Rôle |
|---|---|
| [`CRTDTAARA`](https://job-i.fr/commandes-ibm-i/crtdtaara) | crée une zone (`DTAARA`, `TYPE`, `LEN`, `VALUE`, `TEXT`, `AUT`…) |
| [`CHGDTAARA`](https://job-i.fr/commandes-ibm-i/chgdtaara) | change la valeur : zone d'une bibliothèque ou zones spéciales **`*LDA`** (locale au travail), `*GDA`, `*PDA` (*texte d'aide IBM i 7.5*) |
| [`RTVDTAARA`](https://job-i.fr/commandes-ibm-i/rtvdtaara) | extrait tout ou partie dans une variable |
| [`DSPDTAARA`](https://job-i.fr/commandes-ibm-i/dspdtaara) | affiche attributs et valeur (`OUTPUT`) |
| [`DLTDTAARA`](https://job-i.fr/commandes-ibm-i/dltdtaara) | supprime |

- Pièges du full free (apostrophes) et lecture SQL : voir la page job-i ; en RPG, `IN` / `OUT` ([partie 06](06-rpg-iii.md)).

**Les sous-routines**
- [`SUBR SUBR(nom)`](https://job-i.fr/commandes-ibm-i/subr) ... [`ENDSUBR`](https://job-i.fr/commandes-ibm-i/endsubr) délimitent un sous-programme ; [`CALLSUBR SUBR(nom) [RTNVAL(...)]`](https://job-i.fr/commandes-ibm-i/callsubr) transfère le contrôle (valeur de retour possible) ; `RTNSUBR` rend la main (cité par la restriction de `MONMSG`). Admis dans un programme CL ou une procédure CL ILE. Exemples dans le dépôt : `sources/CL/CL-ILE/BIB10/LSTMBRCL2.md` (2 occurrences de `SUBR`, 19 `CHGVAR`).
- Les sous-routines partagent les variables du programme (comme en RPG : voir [partie 06](06-rpg-iii.md) et la [fiche 06](../cheatsheets/06-cycle-rpg-et-sous-routines.md)) ; **non vérifié pour le CL** (page des sous-routines CL non lue).

### Où voir des exemples dans le dépôt

| Besoin | Fichiers (ordre : nombre d'occurrences) |
|---|---|
| `DCLF` (63 sources) | `sources/CL/CL-procedural/BIB17/ANIMAUXCLP.md`, `BIB10/ANIMALCL.md`, `BIB06/ANIMALCL.md` |
| `MONMSG` (100 sources) | `sources/CL/CL-procedural/BIB06/ENVAUTO.md` (32), `BIB05/ENVAUTO.md` (32), `sources/CL/CL-ILE/BIB02/OPNSRC.md` (12) |
| `SNDRCVF` (44 sources) | `sources/CL/CL-procedural/BIB20/TESTCO.md`, `BIB06/USERCL.md` |
| `DOWHILE`, `SELECT` / `WHEN`, zones de données | `sources/CL/CL-procedural/BIB20/TESTCO.md` (15 commandes de zones de données), `CLDESCPRF.md`, `CLPRF.md` |
| `DOFOR` / `DOUNTIL`, `SUBR` | `sources/CL/CL-ILE/BIB10/LSTMBRCL2.md`, `BIB17/LSTMBRCL.md`, `BIB05/LSTMBRCL.md` |
| `CALL PGM` | `sources/CL/CL-procedural/BIB19/STRIDBGC.md` (5), `ENDIDBGC.md` |
| Programme de démarrage | `sources/CL/CL-procedural/BIB01/QSTRUP.md` |

**À compléter** : syntaxe des expressions CL (opérateurs, `%SWITCH`), commande personnalisée (`CRTCMD`, `PMTCTL`), CL ILE (procédures, `CALLPRC`, `ACTGRP`), `RCVMSG`, files de données.

## Plan détaillé (index des sujets)

### Les fondements du langage de contrôle

- **Dans le wiki** : [Index des sources CL](../INDEX-SOURCES.md)

#### Le langage et le DCLPROPT

- **job-i** : [PGM](https://job-i.fr/commandes-ibm-i/pgm) · [DCL](https://job-i.fr/commandes-ibm-i/dcl)

#### L'utilisation des fichiers (base de données, écrans)

- **job-i** : [DCLF](https://job-i.fr/commandes-ibm-i/dclf) · [RCVF](https://job-i.fr/commandes-ibm-i/rcvf) · [SNDF](https://job-i.fr/commandes-ibm-i/sndf) · [SNDRCVF](https://job-i.fr/commandes-ibm-i/sndrcvf)

#### Les OVRDBF

- **job-i** : [OVRDBF](https://job-i.fr/commandes-ibm-i/ovrdbf) · [DLTOVR](https://job-i.fr/commandes-ibm-i/dltovr)

### Structurer un programme CL

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Boucles et conditions

- **job-i** : [IF](https://job-i.fr/commandes-ibm-i/if) · [DOWHILE](https://job-i.fr/commandes-ibm-i/dowhile) · [DOUNTIL](https://job-i.fr/commandes-ibm-i/dountil) · [DOFOR](https://job-i.fr/commandes-ibm-i/dofor) · [SELECT](https://job-i.fr/commandes-ibm-i/select) · [GOTO](https://job-i.fr/commandes-ibm-i/goto)

#### Conditionnement d'invites

- **job-i** : [PARM](https://job-i.fr/rpg-iii/parm)

#### Gestion des chaînes de caractères, switchs et indicateurs

- **job-i** : [CHGVAR](https://job-i.fr/commandes-ibm-i/chgvar)

### Appels, données et sous-routines

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Appels de programmes et passage de paramètres

- **job-i** : [CALL](https://job-i.fr/commandes-ibm-i/call) · [CALLPRC](https://job-i.fr/commandes-ibm-i/callprc) · [RETURN](https://job-i.fr/commandes-ibm-i/return) · [MONMSG](https://job-i.fr/commandes-ibm-i/monmsg)

#### Récupération d'informations externes du système

- **job-i** : [RTVJOBA](https://job-i.fr/commandes-ibm-i/rtvjoba) · [RTVSYSVAL](https://job-i.fr/commandes-ibm-i/rtvsysval) · [RTVOBJD](https://job-i.fr/commandes-ibm-i/rtvobjd) · [RTVDTAARA](https://job-i.fr/commandes-ibm-i/rtvdtaara) · [RTVNETA](https://job-i.fr/commandes-ibm-i/rtvneta)

#### Les zones de données (DTAARA)

- **job-i** : [DTAARA](https://job-i.fr/zone-de-donnees-dtaara-ibm-i) · [CRTDTAARA](https://job-i.fr/commandes-ibm-i/crtdtaara) · [CHGDTAARA](https://job-i.fr/commandes-ibm-i/chgdtaara) · [RTVDTAARA](https://job-i.fr/commandes-ibm-i/rtvdtaara) · [DSPDTAARA](https://job-i.fr/commandes-ibm-i/dspdtaara)

#### Les sous-routines

- **job-i** : [SUBR](https://job-i.fr/commandes-ibm-i/subr) · [ENDSUBR](https://job-i.fr/commandes-ibm-i/endsubr) · [CALLSUBR](https://job-i.fr/commandes-ibm-i/callsubr)
