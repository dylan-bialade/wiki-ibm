# Partie 10 : ILE : modules, programmes de service, tests et journalisation

> Plan de formation, partie 10 sur 14 (**partie rédigée** : cours détaillé ci-dessous). OPM contre ILE, groupes d'activation, procédures et prototypes, modules et programmes de service, liage, signatures, conception modulaire, débogage, journalisation.
>
> **Mots-clés** : ILE, OPM, groupe d'activation, DCL-PROC, DCL-PR, DCL-PI, CONST, OPTIONS, CRTRPGMOD, CRTPGM, CRTSRVPGM, BNDDIR, NOMAIN, /COPY, signature, STRDBG, STRISDB, dump, journal, DSPJRN.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Pistes IBM](#pistes-ibm)
- [Cours détaillé](#cours-détaillé)
  - [1. Les principes de l'ILE](#1-les-principes-de-lile)
  - [2. Procédures et prototypes](#2-procédures-et-prototypes)
  - [3. Modules, programmes de service, liage](#3-modules-programmes-de-service-liage)
  - [4. Conception modulaire](#4-conception-modulaire)
  - [5. Tests, débogage et dumps](#5-tests-débogage-et-dumps)
  - [6. La journalisation](#6-la-journalisation)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Les principes de l'ILE](#les-principes-de-lile)
  - [Procédures et prototypes](#procédures-et-prototypes)
  - [Modules et programmes de service](#modules-et-programmes-de-service)
  - [Conception modulaire](#conception-modulaire)
  - [Tests, débogage et dumps](#tests-débogage-et-dumps)
  - [La journalisation](#la-journalisation)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Architecture ILE et services REST : concepts, exemple complet, mémo des commandes](../ILE-ET-SERVICES-WEB.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## L'essentiel (vérifié dans le wiki)

- **Objets ILE** : `*MODULE` (sortie du compilateur), `*PGM` (modules liés + `ENTMOD`), `*SRVPGM` (sans entrée, partagé), `*BNDDIR` (liste où le binder cherche) ([concepts](../ILE-ET-SERVICES-WEB.md#concepts-ile-job-i-et-ibm)).
- **Par copie ou par référence** : `UPDPGM` pour un programme lié par copie, `UPDSRVPGM` une fois pour tous les programmes liés par référence.
- **Source de liage** : ne jamais retirer ni réordonner les exports, ajouter à la fin ; sans signature explicite, ajouter un bloc `PGMLVL(*CURRENT)` et passer l'ancien en `*PRV`.
- **Groupes d'activation** : `*CALLER` (partage fichiers, validation, pas de frontière de contrôle) ou groupe nommé (isolation) ; `DFTACTGRP(*NO)` obligatoire pour `ACTGRP` et `BNDDIR`.
- **Mémo des commandes** : CRTRPGMOD, CRTSRVPGM, UPDSRVPGM, DSPSRVPGM `DETAIL(*PROCEXP)`, etc. ([partie 4](../ILE-ET-SERVICES-WEB.md#partie-4--mémo-des-commandes-système-ile-iws-exploitation)).

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [ILE sur IBM i : modules, programmes de service, liage, exemple RPG, C et CL](https://job-i.fr/ile-ibm-i) | ILE : le compilateur produit un module ; on lie des modules de langages différents en programme ou en programme de service partagé. | En une phrase ; L'ILE, c'est quoi ; Pourquoi l'ILE existe ; L'exemple : un programme RPG, un module C, un module CL ; Mettre en place 1 : trois modules, un programme ; Mettre en place 2 : un programme de service ; Par copie ou par référence : la preuve ; Déboguer d'un langage à l'autre ; Mettre l'ILE en place dans une application |
| [PR et PI en RPG : prototype et interface de procédure, colonné et full free](https://job-i.fr/prototypes-rpg-pr-pi) | Le prototype PR décrit l'appel, l'interface PI déclare les paramètres reçus ; le compilateur contrôle leur cohérence dans un même source. | En une phrase ; PR et PI, c'est quoi ; Où ça s'écrit en RPG IV colonné ; Un PI à la place de *ENTRY PLIST ; Appeler un programme par son prototype ; Pourquoi le prototype dans un /COPY ; Des procédures internes, avec ou sans PR ; Les modes de passage des paramètres ; Voir les paramètres reçus dans le débogueur ; Les erreurs, et ce qu'elles veulent dire |
| [API système IBM i : QSNDDTAQ, QUSROBJD, QCMDEXC, QsnWrtDta, exemples testés](https://job-i.fr/api-systeme-ibm-i) | Une API système est une procédure ou un programme livré par IBM pour ce qu'aucune instruction ne fait (files de données, description d'objet, exécution de commande, écran). | En une phrase ; Deux familles : les programmes et les procédures ; Le code erreur, commun aux API ; QSNDDTAQ et QRCVDTAQ : des commandes entre deux programmes ; La même file, vue et utilisée en SQL ; QCMDEXC : exécuter une commande CL ; QUSROBJD : la description d'un objet ; QsnWrtDta : écrire sur l'écran sans DSPF ; Les messages relevés |

## Pistes IBM

Issues de recherches ibm.com du 2026-11-23 : les pages sans mention « lu » **ne sont pas lues** ; la version indiquée peut différer de la 7.5 (à vérifier avant de s'en servir).

- [Binder Language (IBM i 7.4) : lu](https://www.ibm.com/docs/en/i/7.4.0?topic=concepts-binder-language)
- [Signature (IBM i 7.3) : lu](https://www.ibm.com/docs/en/i/7.3.0?topic=language-signature)
- [Journal management (IBM i 7.4)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzaki/rzakikickoff.htm)

## Cours détaillé

> Cette partie s'appuie d'abord sur ce que le wiki contient déjà et a vérifié : [ILE-ET-SERVICES-WEB.md](../ILE-ET-SERVICES-WEB.md) (concepts ILE lus sur job-i **en entier** et sur IBM 7.2 à 7.4, exemple BONBON compilé, mémo des commandes). S'y ajoutent des synthèses des pages job-i **lues en partie** (début de page) : CRTPGM, CRTBNDDIR, ADDBNDDIRE, RCLRSC, RCLACTGRP, STRISDB, DMPJOB, SNDPGMMSG, RCVJRNE, DUMP, OPTIONS, CONST. L'assistant ne compile rien. Les pages IBM citées par le wiki sont d'éditions 7.2 à 7.4 : à revalider pour la 7.5.

### 1. Les principes de l'ILE

**OPM puis ILE.** Dans le modèle OPM (*Original Program Model*), on compile un source en programme et un programme en appelle un autre par un **appel dynamique**, coûteux : les applications étaient de gros programmes. IBM a ajouté en V1R2 un modèle étendu (EPM) pour C et Pascal, puis annoncé l'**ILE le 16 février 1993** (V2R3 d'OS/400). Apports selon IBM (via job-i) : appel **lié** plus rapide qu'un appel dynamique, modularité (on recompile un petit module), mélange de langages (RPG, COBOL, C, C++, CL), composants réutilisables en programmes de service, coexistence avec l'OPM, débogueur source commun, meilleur contrôle des ressources par les groupes d'activation.

**Les objets** : `*MODULE` (sortie d'un compilateur ILE : `CRTRPGMOD`, `CRTCMOD`, `CRTCLMOD`), `*PGM` (modules liés, dont un porte la procédure d'entrée `ENTMOD`), `*SRVPGM` (modules liés sans procédure d'entrée), `*BNDDIR` (liste de modules/programmes de service où le binder cherche). Le **groupe d'activation** n'est pas un objet : c'est la partie du travail où s'exécute un programme ILE (variables statiques, mémoire dynamique, fichiers ouverts, curseurs SQL locaux, définitions de validation).

**Groupes d'activation** (wiki, IBM 7.2 et job-i) : `ACTGRP(*CALLER)` = partage (fichiers ouverts, validation, appels liés optimisés) mais **pas de frontière de contrôle** ; `ACTGRP(nom)` = isolation ; avec `ACTGRP(*ENTMOD)` (défaut de `CRTPGM`), un module d'entrée RPGLE tourne dans le groupe **`QILE`** ; privilégier un groupe **nommé par application** plutôt que `*NEW`. En RPG : `ctl-opt dftactgrp(*no) actgrp('NOM') bnddir('MONREP');` ; `DFTACTGRP(*YES)` (compatibilité OPM) interdit `ACTGRP` et `BNDDIR`.

**Récupération des ressources** :

- **`RCLACTGRP ACTGRP(nom)`** supprime un groupe d'activation défini et libère ses ressources ; elle ne s'applique ni aux ressources propres au travail ni au groupe par défaut ; conditions : le groupe n'est pas le groupe par défaut, **n'est pas actif** (aucun de ses programmes ou procédures en cours), ne fait pas partie des groupes de débogage ; normalement utilisée dans le **programme de contrôle** de l'application ; en mode débogage, les groupes utilisés ne sont pas signalés actifs dans les listes d'appels/groupes.
- **`RCLRSC`** libère les ressources allouées par des programmes terminés (OPM : mémoire statique ; ILE : voir l'aide) ; elle ne traite que le **groupe d'activation par défaut** (selon `LVL`) et ni les ressources du travail ni celles des autres groupes.

| Élément | Statut | Source |
|---|---|---|
| Concepts ILE (objets, OPM→ILE, 1993, avantages, groupes) | vérifié (job-i lue en entier ; IBM 7.2) | [ILE-ET-SERVICES-WEB, concepts](../ILE-ET-SERVICES-WEB.md#concepts-ile-job-i-et-ibm) · [job-i : ILE](https://job-i.fr/ile-ibm-i) |
| Groupes d'activation (`*CALLER`, nommé, `*ENTMOD` → `QILE`, `DFTACTGRP`) | vérifié | idem |
| RCLACTGRP : conditions, groupe par défaut, programme de contrôle | vérifié (début de l'aide) | [job-i : RCLACTGRP](https://job-i.fr/commandes-ibm-i/rclactgrp) |
| RCLRSC : groupe par défaut seulement, ne traite pas les autres groupes | vérifié (début de l'aide) ; détail ILE de `LVL`/`OPTION` **non lu** | [job-i : RCLRSC](https://job-i.fr/commandes-ibm-i/rclrsc) |
| Pile d'appels, durée de vie des ressources (pages IBM *ILE Concepts*) | **non lu** | [ILE Concepts (7.5), cité par job-i](https://www.ibm.com/docs/en/i/7.5.0) |

### 2. Procédures et prototypes

Le détail de `dcl-proc`, `dcl-pr` et `dcl-pi` est dans la [partie 08, § 3](08-rpg-free.md#cours-détaillé) et les PR/PI colonnés dans la [partie 07, § 7](07-rpg-iv.md#cours-détaillé). À retenir ici : un prototype par procédure appelée ; `EXTPROC('nom')` impose la **casse** du nom de procédure (indispensable pour une fonction C : `EXTPROC('cleControle')`), sans lui le nom du prototype en majuscules est cherché ; un appel de procédure **sans `CALL`** est un appel lié.

**Passage de paramètres** (job-i) :

| Mot-clé | Effet |
|---|---|
| (rien) | par **référence** ; refuse un littéral (erreur RNF7542) |
| `CONST` | référence en **lecture seule** : l'appelant peut passer variable, littéral ou expression ; la modifier = erreur de compilation RNF5346 |
| `VALUE` | **par valeur** : copie que la procédure peut modifier sans effet sur l'appelant |
| `OPTIONS(*NOPASS)` | paramètre facultatif ; `%PARMS` donne le nombre reçu |
| `OPTIONS(*OMIT)` | on peut passer `*OMIT` ; tester `%ADDR(param) <> *NULL` avant usage |
| `OPTIONS(*VARSIZE)` | reçu plus court que déclaré ; la procédure doit connaître sa vraie longueur |
| `OPTIONS(*STRING : *TRIM)` | pointeur passé par valeur : la procédure reçoit l'adresse d'une copie terminée par `x'00'` (chaîne C), `*TRIM` retire les blancs |

Programmes : paramètres toujours par référence, `CONST` interdit leur modification. Valeur de retour : type après le nom du prototype/de l'interface, instruction `return valeur;` (RPG ; **ne pas confondre avec la commande CL `RETURN`**, voir ci-dessous). Variables : **locales** à la procédure (réinitialisées à chaque appel, sauf `static`), **globales** celles du programme ou du module.

| Élément | Statut | Source |
|---|---|---|
| CONST, VALUE, RNF5346, RNF7542, DCL-C | vérifié (début de page) | [job-i : CONST](https://job-i.fr/instructions-rpg/const) |
| OPTIONS : `*NOPASS`, `*OMIT`, `*VARSIZE`, `*STRING`, `*TRIM` | vérifié (début de page) | [job-i : OPTIONS](https://job-i.fr/instructions-rpg/options) |
| EXTPROC et casse ; PR/PI, `/COPY` du prototype | vérifié | [job-i : ILE](https://job-i.fr/ile-ibm-i) · [PR et PI](https://job-i.fr/prototypes-rpg-pr-pi) |
| Lien du plan « RETURN » (`/commandes-ibm-i/return`) | **erreur du plan** : c'est la commande **CL** RETURN (« transmet le contrôle au poste de liste d'appel supérieur »), pas l'instruction RPG `return` | [job-i : RETURN (CL)](https://job-i.fr/commandes-ibm-i/return) |

### 3. Modules, programmes de service, liage

La chaîne et ses règles sont déjà vérifiées dans [ILE-ET-SERVICES-WEB.md, partie 1](../ILE-ET-SERVICES-WEB.md#partie-1--modules-programme-de-service-source-de-liage) (tableaux `CRTSRVPGM`, `RTVBNDSRC`, `DSPSRVPGM DETAIL(*PROCEXP)`, source de liage). Rappel condensé, avec l'exemple job-i (programme RPG + module C + module CL, annoncé exécuté sur IBM i 7.5) :

```
CRTRPGMOD MODULE(JOBIILE/STKCLE) SRCFILE(JOBIILE/QRPGLESRC) DBGVIEW(*SOURCE)
CRTCMOD   MODULE(JOBIILE/CLECTL) SRCFILE(JOBIILE/QCSRC)     DBGVIEW(*SOURCE)
CRTCLMOD  MODULE(JOBIILE/CLUSER) SRCFILE(JOBIILE/QCLSRC)    DBGVIEW(*SOURCE)
CRTPGM    PGM(JOBIILE/STKCLE) MODULE(JOBIILE/STKCLE JOBIILE/CLECTL JOBIILE/CLUSER) ENTMOD(JOBIILE/STKCLE)
```
*(liage **par copie** : le code des modules est recopié dans le programme)*

```
STRPGMEXP PGMLVL(*CURRENT)
  EXPORT SYMBOL('cleControle')
  EXPORT SYMBOL(CLUSER)
ENDPGMEXP
CRTSRVPGM SRVPGM(JOBIILE/OUTILS) MODULE(JOBIILE/CLECTL JOBIILE/CLUSER) SRCFILE(JOBIILE/QSRVSRC) SRCMBR(OUTILS)
CRTBNDDIR BNDDIR(JOBIILE/OUTILS)
ADDBNDDIRE BNDDIR(JOBIILE/OUTILS) OBJ((JOBIILE/OUTILS *SRVPGM))
```
*(liage **par référence** : un programme `ctl-opt dftactgrp(*no) actgrp('JOBIILE') bnddir('OUTILS')` se lie au programme de service par le répertoire de liage)*

Mettre à jour : `UPDSRVPGM SRVPGM(…) MODULE(…)` une fois pour tous les programmes liés par référence ; `UPDPGM PGM(…) MODULE(…)` pour chaque programme lié par copie (preuve de job-i : après `UPDSRVPGM`, `STKCLE2` voit le nouveau calcul, `STKCLE` garde l'ancien jusqu'à `UPDPGM`).

**Commandes de liage** (aides IBM i 7.5, début) :

- **`CRTPGM`** : crée un programme lié à partir de modules et de répertoires de liage ; paramètres `PGM`, `MODULE`, `ENTMOD`, `BNDSRVPGM`, `BNDDIR`, `ACTGRP`, `OPTION`, `DETAIL`, `ALWUPD`, `ALWLIBUPD`, `USRPRF`, `REPLACE`, `AUT`, `TGTRLS`, `STGMDL`, `IPA`… ; droits : `*READ` + `*ADD` sur la bibliothèque, `*USE` sur modules, programmes de service et répertoires.
- **`CRTBNDDIR`** : crée un répertoire de liage (`BNDDIR`, `AUT`, `TEXT`) ; **`ADDBNDDIRE BNDDIR(…) OBJ((biblio/objet *SRVPGM|*MODULE))`** ajoute un poste (jusqu'à 50 spécifications d'objet, `POSITION` possible) ; droits : `*USE` sur la bibliothèque, `*OBJOPR` + `*ADD` sur le répertoire.
- **Signature et gestion de versions** : ne jamais retirer ni réordonner les exports, ajouter à la fin ; sans signature explicite, nouveau bloc `PGMLVL(*CURRENT)` et ancien bloc en `*PRV` ; la signature **ne valide pas** les paramètres d'une procédure (recompiler les appelants si les paramètres changent) (wiki, IBM 7.3/7.4 lues en entier). `RTVBNDSRC` génère le source de liage de départ.
- **Modules `NOMAIN`** : pas de cycle RPG, exportent des procédures (exemple BONBON : `ARTICLEDAO`).
- **`/COPY`** : directive du **compilateur RPG** qui inclut un membre source (prototypes, constantes) : `/COPY QRPGLESRC,TVAPR4` ; elle cherche le fichier par `*LIBL`. **Le lien du plan (`/commandes-ibm-i/copy`) est la commande IFS `COPY` (copier un objet), pas la directive RPG.**

| Élément | Statut | Source |
|---|---|---|
| Chaîne module → srvpgm → bnddir, source de liage, signature, UPDSRVPGM/UPDPGM, exemple BONBON | vérifié (wiki) | [ILE-ET-SERVICES-WEB.md](../ILE-ET-SERVICES-WEB.md) |
| Exemple STKCLE / STKCLE2 / OUTILS (RPG + C + CL) et preuve copie/référence | vérifié (page lue en entier, annoncé exécuté) | [job-i : ILE](https://job-i.fr/ile-ibm-i) |
| CRTPGM : rôle, paramètres, droits | vérifié (début de l'aide) | [job-i : CRTPGM](https://job-i.fr/commandes-ibm-i/crtpgm) |
| CRTBNDDIR, ADDBNDDIRE : paramètres, droits, 50 postes | vérifié (début des aides) | [CRTBNDDIR](https://job-i.fr/commandes-ibm-i/crtbnddir) · [ADDBNDDIRE](https://job-i.fr/commandes-ibm-i/addbnddire) |
| Lien du plan `/COPY` | **erreur du plan** (commande IFS COPY) ; la directive RPG `/COPY` n'a pas de page job-i trouvée | [job-i : COPY (IFS)](https://job-i.fr/commandes-ibm-i/copy) |
| Syntaxe exacte `/COPY biblio/fichier,membre` ; longueur minimale du fichier source pour `**FREE` | **non vérifié** (déjà noté par le wiki) | à chercher sur ibm.com |

### 4. Conception modulaire

L'exemple BONBON du wiki (4 membres, ordre de création : `BONBON_H` prototypes, `BONBONDAO` accès aux données en `NOMAIN`, `GETBON_H`, `GET_BONBON` module d'entrée, `WSBONBON` programme de service ; **compilé par toi**) illustre un découpage fonctionnel : une responsabilité par module, prototypes partagés par `/COPY`, un programme de service par domaine ([ILE-ET-SERVICES-WEB.md](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)). Conseils de job-i : un répertoire de liage et un groupe d'activation nommé par application, noms exacts, procédures partagées en programmes de service **par domaine** (dates, contrôles, accès à un fichier), source de liage dont on ne change jamais l'ordre.

**Centraliser les erreurs et les messages** : `SNDPGMMSG` envoie un message à une file de messages ou au poste de liste d'appels (paramètres `MSG`/`MSGID`+`MSGF`+`MSGDTA`, `TOPGMQ`, `TOMSGQ`, `TOUSR`, `MSGTYPE`, `RPYMSGQ`…) ; utilisable seulement dans un **programme CL compilé** ou REXX (aide) : en RPG on utilise `snd-msg` (vu dans les exemples job-i) ou l'API ; **centraliser** = une procédure unique qui formate et envoie le message (hypothèse de conception, sans source).

| Élément | Statut | Source |
|---|---|---|
| Exemple BONBON (modules, copybook, srvpgm, source de liage) | vérifié, compilé par l'utilisateur | [ILE-ET-SERVICES-WEB.md](../ILE-ET-SERVICES-WEB.md) |
| Bonnes pratiques ILE (job-i) | vérifié | [job-i : ILE](https://job-i.fr/ile-ibm-i) |
| SNDPGMMSG : paramètres, restriction d'environnement (CL compilé) | vérifié (début de l'aide) | [job-i : SNDPGMMSG](https://job-i.fr/commandes-ibm-i/sndpgmmsg) |
| Procédure de journalisation/log centralisée | **hypothèse** (conception) | à sourcer |

### 5. Tests, débogage et dumps

- **`STRDBG`** (ILE) : voir [partie 07, § 8](07-rpg-iv.md#cours-détaillé). **`STRISDB`** (QPDA) : « environnement de débogage interactif des programmes CL, COBOL et RPG » (RPG III/OPM) ; paramètres `PGM`, `UPDPROD`, `INVPGM` (appeler le programme), `PARM`, `CMD`, `SRCMBR`, `SRCF`, `SRVJOB` ; **QTEMP requise** (ISDB y accède à son fichier de consignation) ; refuse un programme ILE (« Type de programme non valide », job-i). `ENDDBG` termine la session ; `CLEAR PGM` enlève tous les points d'arrêt.
- **Débogage d'un langage à l'autre** (job-i) : `STRDBG PGM(JOBIILE/STKCLE)`, `BREAK 22`, `CALL STKCLE`, puis **`F22` = *Step into*** (entrer dans la procédure appelée) ; chaque module doit être compilé avec `DBGVIEW(*SOURCE)` ; dans un module C, `EVAL somme` et `EVAL *code :c 5`.
- **Programme de service** : pas de page dédiée trouvée ; ce que le wiki établit : le débogueur suit le programme **de module en module** tant que chaque module a sa vue de débogage ; le point d'arrêt sur un service entry point n'est **pas documenté** dans le wiki.
- **Dump** : en RPG III, l'opération **`DUMP`** écrit dans un spoule `QPPGMDMP` l'état du programme et la valeur de toutes ses zones (la spécification H doit avoir `1` en colonne 15, sinon le `DUMP` est ignoré) ; le programme continue ensuite ([job-i : DUMP](https://job-i.fr/rpg-iii/dump)). **`DMPJOB`** vide les structures de base du travail en cours ou en service (`STRSRVJOB`) ; paramètres `PGM`, `JOBARA`, `ADROBJ`, `JOBTHD`, `SLTTHD`. `DSPJOBLOG` : voir [partie 01](01-organisation-ibm-i.md#cours-détaillé).
- **Stratégie de tests** : job-i écrit les cas **avant** (programme SORTIE : 3 cas OK / INC / INS, via un CL de test compilé par `CRTBNDCL`, les trois versions RPG III, IV, libre donnant le même résultat et le même stock) ; **aucune source de méthode** de tests unitaires dans le wiki : à construire (hypothèse).

| Élément | Statut | Source |
|---|---|---|
| STRISDB : paramètres, QTEMP, ISDB pour CL/COBOL/RPG | vérifié (début de l'aide) | [job-i : STRISDB](https://job-i.fr/commandes-ibm-i/strisdb) |
| Débogage multi-langage, `F22`, `BREAK`, `EVAL`, `CLEAR PGM`, `ENDDBG` | vérifié (page lue en entier) | [job-i : ILE](https://job-i.fr/ile-ibm-i) |
| DUMP RPG III (spoule QPPGMDMP, H col. 15) | vérifié (début de page) | [job-i : DUMP](https://job-i.fr/rpg-iii/dump) |
| DMPJOB : rôle et paramètres | vérifié (début de l'aide) ; lecture d'un dump **non lue** | [job-i : DMPJOB](https://job-i.fr/commandes-ibm-i/dmpjob) |
| Cas de test écrits avant (SORTIE, CL de test) | vérifié (page job-i RPG full free) | [job-i : coder en RPG full free](https://job-i.fr/coder-rpg-full-free) |
| Débogage d'un programme de service (service entry point), watch variables, tests unitaires | **non vérifié** | à sourcer |

### 6. La journalisation

Le cours complet est dans la [partie 02, § 7](02-db2-for-i.md#cours-détaillé) : récepteur puis journal (`CRTJRNRCV`, `CRTJRN`), démarrage (`STRJRNPF`), `SAVCHGOBJ … OBJJRN(*YES)`, lecture par `DSPJRN`, limites. Complément : **`RCVJRNE JRN(…) EXITPGM(…)`** reçoit **en continu** les postes de journal et les transmet à un programme d'exit utilisateur (mêmes filtres que `DSPJRN`, plus `DELAY`, `BLKLEN`, `ENTFMT`) : base d'une réplication ou d'un traitement en temps réel.

| Élément | Statut | Source |
|---|---|---|
| Journaux, récepteurs, STRJRNPF, DSPJRN | vérifié (partie 02) | [partie 02](02-db2-for-i.md#cours-détaillé) |
| RCVJRNE : programme d'exit, réception continue, paramètres | vérifié (début de l'aide, ~140 Ko de page non lus en entier) | [job-i : RCVJRNE](https://job-i.fr/commandes-ibm-i/rcvjrne) |
| Gestion et reprise des journaux (IBM *Journal management*) | **non lu** | [Journal management (7.4)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzaki/rzakikickoff.htm) |

### Ce qui reste à vérifier pour cette partie

Pages IBM *ILE Concepts*, *Binder Language* et *Signature* en **7.5** (le wiki les a lues en 7.2 à 7.4) ; détail de `RCLRSC` (`LVL`, `OPTION`) ; débogage d'un programme de service ; lecture d'un dump ; méthode de tests unitaires ; reprise de journal. **Corrections à apporter au plan** : liens `RETURN` et `/COPY` (voir les tableaux). Manques à signaler : pas de page job-i sur la directive `/COPY`, le débogage d'un programme de service, ni les tests unitaires.

## Plan détaillé (index des sujets)

### Les principes de l'ILE

- **Dans le wiki** : [ILE : concepts (job-i et IBM)](../ILE-ET-SERVICES-WEB.md#concepts-ile-job-i-et-ibm)

#### OPM et ILE, ce qui change

- **job-i** : [ILE](https://job-i.fr/ile-ibm-i)

#### Les groupes d'activation et leur portée

- **job-i** : [groupe d'activation](https://job-i.fr/ile-ibm-i)

#### La pile d'appels et la durée de vie des ressources

- **job-i** : [RCLRSC](https://job-i.fr/commandes-ibm-i/rclrsc) · [RCLACTGRP](https://job-i.fr/commandes-ibm-i/rclactgrp)

### Procédures et prototypes

- **Dans le wiki** : [Fiche 03 (PR/PI)](../cheatsheets/03-rpg-par-version.md)

#### La déclaration d'une procédure, DCL-PROC

- **job-i** : [DCL-PROC](https://job-i.fr/instructions-rpg/dcl-proc)

#### Prototypes et interfaces de procédure

- **job-i** : [DCL-PR](https://job-i.fr/instructions-rpg/dcl-pr) · [DCL-PI](https://job-i.fr/instructions-rpg/dcl-pi) · [PR et PI en RPG](https://job-i.fr/prototypes-rpg-pr-pi)

#### Le passage de paramètres, valeur, référence, CONST, OPTIONS

- **job-i** : [CONST](https://job-i.fr/instructions-rpg/const) · [OPTIONS](https://job-i.fr/instructions-rpg/options) · [PR et PI en RPG](https://job-i.fr/prototypes-rpg-pr-pi)

#### Les procédures retournant une valeur

- **job-i** : [PR et PI en RPG](https://job-i.fr/prototypes-rpg-pr-pi) (le lien RETURN du plan visait la commande CL, pas l'instruction RPG ; retiré)

#### Portée des variables, locales et globales

- **job-i** : [PR et PI en RPG](https://job-i.fr/prototypes-rpg-pr-pi)

### Modules et programmes de service

- **Dans le wiki** : [Architecture ILE : modules, srvpgm, source de liage](../ILE-ET-SERVICES-WEB.md#partie-1--modules-programme-de-service-source-de-liage)

#### La compilation en module, CRTRPGMOD

- **job-i** : [CRTRPGMOD](https://job-i.fr/commandes-ibm-i/crtrpgmod)

#### Le liage par copie, CRTPGM

- **job-i** : [CRTPGM](https://job-i.fr/commandes-ibm-i/crtpgm)

#### Les programmes de service, CRTSRVPGM

- **job-i** : [CRTSRVPGM](https://job-i.fr/commandes-ibm-i/crtsrvpgm) · [UPDSRVPGM](https://job-i.fr/commandes-ibm-i/updsrvpgm)

#### Les modules NOMAIN et les sources /COPY

- **job-i** : pas de page dédiée à la directive RPG /COPY (la page /commandes-ibm-i/copy est la commande IFS COPY, retirée du plan)

#### Les répertoires de liage (BNDDIR)

- **job-i** : [BNDDIR](https://job-i.fr/ile-ibm-i) · [CRTBNDDIR](https://job-i.fr/commandes-ibm-i/crtbnddir) · [ADDBNDDIRE](https://job-i.fr/commandes-ibm-i/addbnddire)

#### Signature, fichier de liage et gestion des versions

- **job-i** : [RTVBNDSRC](https://job-i.fr/commandes-ibm-i/rtvbndsrc)

### Conception modulaire

- **Dans le wiki** : [Exemple complet BONBON](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)

#### Découpage fonctionnel d'une application

- **Dans le wiki** : [Exemple BONBON : 4 membres, ordre de création](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)
- **job-i** : [ILE sur IBM i](https://job-i.fr/ile-ibm-i)

#### Réutilisation et bibliothèques de procédures

- **job-i** : [ILE sur IBM i](https://job-i.fr/ile-ibm-i)

#### Centralisation des erreurs et des logs

- **job-i** : [SNDPGMMSG](https://job-i.fr/commandes-ibm-i/sndpgmmsg)

### Tests, débogage et dumps

- **Dans le wiki** : aucune page dédiée (à documenter).

#### STRISDB et STRDBG, breakpoints et watch variables

- **job-i** : [STRDBG](https://job-i.fr/commandes-ibm-i/strdbg) · [STRISDB](https://job-i.fr/commandes-ibm-i/strisdb) · [ENDDBG](https://job-i.fr/commandes-ibm-i/enddbg)

#### Le débogage d'un programme de service, service entry point

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Lecture et interprétation d'un dump

- **job-i** : [DMPJOB](https://job-i.fr/commandes-ibm-i/dmpjob) · [DSPJOBLOG](https://job-i.fr/commandes-ibm-i/dspjoblog) · [dump](https://job-i.fr/rpg-iii/dump)

#### Stratégie de tests unitaires et fonctionnels

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### La journalisation

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Journaux et récepteurs

- **job-i** : [CRTJRN](https://job-i.fr/commandes-ibm-i/crtjrn) · [CRTJRNRCV](https://job-i.fr/commandes-ibm-i/crtjrnrcv) · [STRJRNPF](https://job-i.fr/commandes-ibm-i/strjrnpf)

#### Analyse de l'activité via DSPJRN

- **job-i** : [DSPJRN](https://job-i.fr/commandes-ibm-i/dspjrn) · [RCVJRNE](https://job-i.fr/commandes-ibm-i/rcvjrne)
