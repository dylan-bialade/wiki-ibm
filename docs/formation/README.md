# Plan de la formation IBM i : index en 14 parties

> Le wiki suit l'architecture de la formation : **un fichier Markdown par grande partie** (ci-dessous). Chaque partie contient, dans l'ordre : où trouver quoi dans le wiki, rubriques des pages job-i de référence, pistes IBM, puis le plan détaillé (sections ###, sujets ####) avec les pages job-i qui les couvrent. Les sujets sans page job-i sont signalés pour être documentés. Retour au [sommaire général](../SOMMAIRE.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Les 14 parties](#les-14-parties)
- [Sections de chaque partie (accès direct)](#sections-de-chaque-partie-accès-direct)
  - [Partie 01 : Principes généraux et organisation de l'IBM i](#partie-01--principes-généraux-et-organisation-de-libm-i)
  - [Partie 02 : Architecture et concepts de DB2 for i](#partie-02--architecture-et-concepts-de-db2-for-i)
  - [Partie 03 : Outils de développement : traditionnels et modernes](#partie-03--outils-de-développement--traditionnels-et-modernes)
  - [Partie 04 : Le langage de contrôle (CL)](#partie-04--le-langage-de-contrôle-cl)
  - [Partie 05 : Le langage SQL sur IBM i](#partie-05--le-langage-sql-sur-ibm-i)
  - [Partie 06 : RPG III (RPG/400)](#partie-06--rpg-iii-rpg400)
  - [Partie 07 : RPG IV (ILE RPG, format fixe étendu)](#partie-07--rpg-iv-ile-rpg-format-fixe-étendu)
  - [Partie 08 : RPG full free](#partie-08--rpg-full-free)
  - [Partie 09 : SQL embarqué en RPG](#partie-09--sql-embarqué-en-rpg)
  - [Partie 10 : ILE : modules, programmes de service, tests et journalisation](#partie-10--ile--modules-programmes-de-service-tests-et-journalisation)
  - [Partie 11 : Modernisation d'application et maintenance de code existant](#partie-11--modernisation-dapplication-et-maintenance-de-code-existant)
  - [Partie 12 : Intelligence artificielle et assistants de développement](#partie-12--intelligence-artificielle-et-assistants-de-développement)
  - [Partie 13 : Web services et API (REST, SOAP, JSON, XML, IWS)](#partie-13--web-services-et-api-rest-soap-json-xml-iws)
  - [Partie 14 : Projet en immersion](#partie-14--projet-en-immersion)
- [Recherche par mot-clé](#recherche-par-mot-clé)
- [Sujets sans page job-i dédiée (0 sujets, dont 0 sans page wiki liée)](#sujets-sans-page-job-i-dédiée-0-sujets-dont-0-sans-page-wiki-liée)
<!-- TOC:END -->

## Les 14 parties

| # | Partie | Contenu | Sujets (avec page job-i / total) |
|---|---|---|---|
| 01 | [Principes généraux et organisation de l'IBM i](01-organisation-ibm-i.md) | Objets et bibliothèques, commandes et aide, messages, travaux et sous-systèmes, impressions, profils et sécurité, unités et incidents, sauvegardes et IPL. | 21 / 21 |
| 02 | [Architecture et concepts de DB2 for i](02-db2-for-i.md) | Base de données intégrée, DDS contre SQL, fichiers physiques et logiques, vues, contraintes, sécurité par ligne et colonne, journalisation. | 8 / 9 |
| 03 | [Outils de développement : traditionnels et modernes](03-outils-de-developpement.md) | QRY, QMQRY, SEU, PDM, SDA, RLU, PNLGRP, DFU, écrans et états (DSPF, PRTF), puis RDi, VS Code et Code for IBM i. | 3 / 5 |
| 04 | [Le langage de contrôle (CL)](04-langage-de-controle-cl.md) | Fondements du CL, fichiers et OVRDBF, structure d'un programme, boucles et conditions, chaînes, appels et paramètres, zones de données, sous-routines. | 10 / 10 |
| 05 | [Le langage SQL sur IBM i](05-sql.md) | Présentation et interfaces SQL, interrogation (jointures, unions, sous-requêtes), manipulation, définition, performances, objets programmables (triggers, procédures, fonctions). | 8 / 11 |
| 06 | [RPG III (RPG/400)](06-rpg-iii.md) | Historique, format colonné HFELICO, cycle RPG, codes opérations historiques, accès aux fichiers, sous-fichiers, maintenance du code existant. | 27 / 27 |
| 07 | [RPG IV (ILE RPG, format fixe étendu)](07-rpg-iv.md) | Du RPG III au RPG IV, spécifications H, F, D, C, P, types et structures de données, expressions et structures de contrôle, fonctions intégrées, gestion des erreurs, compilation. | 23 / 25 |
| 08 | [RPG full free](08-rpg-free.md) | Syntaxe full free, conversion depuis le format fixe, structures de données modernes, tableaux dynamiques, BIF récentes, FOR-EACH. | 11 / 12 |
| 09 | [SQL embarqué en RPG](09-sql-embarque.md) | EXEC SQL, SQLRPGLE, variables hôtes, SQLCODE et SQLSTATE, curseurs, mises à jour positionnées et ensemblistes, SQL dynamique, accès natif contre SQL. | 1 / 9 |
| 10 | [ILE : modules, programmes de service, tests et journalisation](10-ile.md) | OPM contre ILE, groupes d'activation, procédures et prototypes, modules et programmes de service, liage, signatures, conception modulaire, débogage, journalisation. | 21 / 23 |
| 11 | [Modernisation d'application et maintenance de code existant](11-modernisation-et-maintenance.md) | Limites du code historique, conversion vers le full free, décomposition en modules, standards modernes, nouvelle application (écrans, sous-fichiers, CRUD), mises en situation de maintenance. | 4 / 17 |
| 12 | [Intelligence artificielle et assistants de développement](12-ia-et-assistants.md) | Concepts de l'IA, LLM et tokens, prompting, modes d'utilisation, assistant BOB, cadre d'usage (confidentialité, RGPD), mise en situation IBM i. | 0 / 10 |
| 13 | [Web services et API (REST, SOAP, JSON, XML, IWS)](13-web-services-et-api.md) | Généralités API, formats XML et JSON, consommer des API en SQL et RPG, créer un web service avec IWS, gérer des fichiers XML et JSON dans l'IFS. | 3 / 20 |
| 14 | [Projet en immersion](14-projet-en-immersion.md) | Projet intégrant IBM i, DB2, CL, SQL, RPG, IA, PHL Web et Web Services. | 0 / 1 |

## Sections de chaque partie (accès direct)

### Partie 01 : Principes généraux et organisation de l'IBM i

- [Architecture et organisation du système](01-organisation-ibm-i.md#architecture-et-organisation-du-système) : Les objets (*FILE, *PGM, *JOB, *USRPRF, etc.) et les bibliothèques ; Les commandes, organisation, recherche, aide F1 / F10 ; Les commandes essentielles (WRKOBJ, WRKJOB, WRKSPLF, DSPSYSVAL)
- [Les messages](01-organisation-ibm-i.md#les-messages) : Principes généraux ; Les files d'attente de messages
- [La gestion des travaux](01-organisation-ibm-i.md#la-gestion-des-travaux) : Travaux interactifs et travaux batchs ; Travaux à démarrage automatique et à démarrages anticipés ; Les sous-systèmes ; Les files d'attente de travaux et les descriptions de travail ; La liste de bibliothèques
- [La gestion des impressions](01-organisation-ibm-i.md#la-gestion-des-impressions) : Les files d'attente de sortie ; La gestion des imprimantes
- [Les profils utilisateurs, la sécurité et les droits](01-organisation-ibm-i.md#les-profils-utilisateurs-la-sécurité-et-les-droits) : Les profils utilisateurs, création et maintenance ; La sécurité IBM i et les droits sur les objets ; Les droits sur l'IFS
- [La gestion des unités et des incidents](01-organisation-ibm-i.md#la-gestion-des-unités-et-des-incidents) : La gestion des unités (écrans, imprimantes, lecteurs de bandes) ; Les méthodes d'analyse d'incident ; Le log système et le log de l'opérateur système
- [Les sauvegardes, les restaurations et l'IPL](01-organisation-ibm-i.md#les-sauvegardes-les-restaurations-et-lipl) : Principes généraux des sauvegardes et restaurations ; Les supports ; Le principe de l'IPL

### Partie 02 : Architecture et concepts de DB2 for i

- [Architecture et concepts de DB2 for i](02-db2-for-i.md#architecture-et-concepts-de-db2-for-i) : Les concepts de la base de données intégrée ; Différences entre la version « historique » DDS et SQL
- [Les objets de données](02-db2-for-i.md#les-objets-de-données) : Les PF (tables) ; Les LF (index, vues) ; Les vues DDS et les vues SQL
- [Les contraintes et l'intégrité](02-db2-for-i.md#les-contraintes-et-lintégrité) : Clés primaires et clés étrangères ; Contraintes unique et check
- [Sécurité et journalisation](02-db2-for-i.md#sécurité-et-journalisation) : Les RCAC, sécurité sur les lignes et les colonnes ; La journalisation des tables

### Partie 03 : Outils de développement : traditionnels et modernes

- [Les outils traditionnels](03-outils-de-developpement.md#les-outils-traditionnels) : QRY, QMQRY, SEU, PDM ; SDA, RLU, PNLGRP, DFU ; Les écrans et les fichiers d'impression (DSPF et PRTF)
- [Le développement moderne](03-outils-de-developpement.md#le-développement-moderne) : RDi ; VS Code et Code for IBM i

### Partie 04 : Le langage de contrôle (CL)

- [Les fondements du langage de contrôle](04-langage-de-controle-cl.md#les-fondements-du-langage-de-contrôle) : Le langage et le DCLPROPT ; L'utilisation des fichiers (base de données, écrans) ; Les OVRDBF
- [Structurer un programme CL](04-langage-de-controle-cl.md#structurer-un-programme-cl) : Boucles et conditions ; Conditionnement d'invites ; Gestion des chaînes de caractères, switchs et indicateurs
- [Appels, données et sous-routines](04-langage-de-controle-cl.md#appels-données-et-sous-routines) : Appels de programmes et passage de paramètres ; Récupération d'informations externes du système ; Les zones de données (DTAARA) ; Les sous-routines

### Partie 05 : Le langage SQL sur IBM i

- [Introduction](05-sql.md#introduction) : Présentation du langage SQL ; Les interfaces SQL sur l'IBM i
- [Le langage et l'interrogation des données](05-sql.md#le-langage-et-linterrogation-des-données) : Les bases du langage ; Union et jointures ; Sous-requêtes
- [La manipulation des données](05-sql.md#la-manipulation-des-données) : Insertion, mises à jour, modifications
- [La définition des objets](05-sql.md#la-définition-des-objets) : Création et modification des objets
- [Les performances](05-sql.md#les-performances) : Analyse et optimisation des requêtes
- [Les objets programmables](05-sql.md#les-objets-programmables) : Les triggers ; Les procédures stockées ; Les fonctions

### Partie 06 : RPG III (RPG/400)

- [Historique et positionnement du RPG](06-rpg-iii.md#historique-et-positionnement-du-rpg) : Du RPG au RPG II puis au RPG III ; Le format colonné et les règles de saisie ; Les outils historiques, SEU et PDM
- [Les spécifications](06-rpg-iii.md#les-spécifications) : Les spécifications de contrôle et de fichiers, H et F ; Les spécifications d'extension et d'entrée, E et I ; Les spécifications de calcul et de sortie, C et O ; Fichiers décrits en externe et décrits en programme
- [Le cycle RPG](06-rpg-iii.md#le-cycle-rpg) : Le déroulement automatique du cycle ; Les indicateurs, LR, MR, indicateurs de niveau et de conditionnement ; Les ruptures de contrôle
- [Les codes opérations historiques](06-rpg-iii.md#les-codes-opérations-historiques) : MOVE, MOVEL, Z-ADD, ADD, SUB, MULT, DIV ; COMP, CABxx, GOTO et TAG ; SCAN, SUBST, CAT, LOOKUP, XFOOT ; Les sous-routines, BEGSR, ENDSR, EXSR ; Les zones de données et les appels CALL / PARM
- [L'accès aux fichiers](06-rpg-iii.md#laccès-aux-fichiers) : CHAIN, SETLL, SETGT, READ, READE, READP ; WRITE, UPDAT, DELET ; Les fichiers d'impression
- [Les sous-fichiers](06-rpg-iii.md#les-sous-fichiers) : Le DDS d'un sous-fichier, SFL et SFLCTL ; Les mots-clés de contrôle, SFLDSP, SFLDSPCTL, SFLCLR, SFLEND ; Les sous-fichiers statiques, chargement complet ; Les sous-fichiers dynamiques avec rechargement de pages ; Le sous-fichier message ; Un CRUD complet avec navigation et validations
- [Maintenance du code existant](06-rpg-iii.md#maintenance-du-code-existant) : Lecture et analyse d'un programme ancien ; Compilation et traitement des erreurs ; Modification sans régression

### Partie 07 : RPG IV (ILE RPG, format fixe étendu)

- [Du RPG III au RPG IV](07-rpg-iv.md#du-rpg-iii-au-rpg-iv) : Les apports du RPG IV ; La conversion CVTRPGSRC et ses limites ; Le format fixe étendu et la lisibilité du source
- [Les spécifications du RPG IV](07-rpg-iv.md#les-spécifications-du-rpg-iv) : La spécification de contrôle H et ses mots-clés ; La spécification F et les mots-clés de fichiers ; La spécification D, déclaration des données ; Les spécifications C et P
- [Les types et structures de données](07-rpg-iv.md#les-types-et-structures-de-données) : Types numériques, alphanumériques et varying ; Dates, heures et horodatages ; Structures de données et sous-zones ; Tableaux et tables ; Constantes nommées
- [Expressions et structures de contrôle](07-rpg-iv.md#expressions-et-structures-de-contrôle) : EVAL, EVALR et les opérateurs ; IF, DOW, DOU, FOR, SELECT ; La réduction progressive des indicateurs
- [Les fonctions intégrées](07-rpg-iv.md#les-fonctions-intégrées) : %TRIM, %SUBST, %SCAN, %REPLACE ; %CHAR, %DEC, %INT, %EDITC ; %FOUND, %EOF, %ERROR, %OPEN ; Les BIF de date, %DATE, %DIFF, %DAYS
- [La gestion des erreurs](07-rpg-iv.md#la-gestion-des-erreurs) : MONITOR, ON-ERROR, ENDMON ; L'extension E et %ERROR / %STATUS ; Les routines d'erreur
- [Compilation et mise au point](07-rpg-iv.md#compilation-et-mise-au-point) : CRTBNDRPG et CRTRPGMOD ; STRDBG, points d'arrêt et variables surveillées ; Lecture des erreurs de compilation

### Partie 08 : RPG full free

- [La syntaxe full free](08-rpg-free.md#la-syntaxe-full-free) : CTL-OPT et les options de contrôle ; DCL-F, DCL-S, DCL-C et DCL-DS ; DCL-PR, DCL-PI et DCL-PROC ; Les structures de contrôle en free ; Les règles de formatage et de lisibilité
- [La conversion vers le full free](08-rpg-free.md#la-conversion-vers-le-full-free) : CVTRPGFREE et ses limites ; Le traitement des opcodes historiques restants ; La suppression des GOTO et des indicateurs
- [Les données et les fonctions modernes](08-rpg-free.md#les-données-et-les-fonctions-modernes) : Les structures de données qualifiées, LIKEDS, LIKEREC, TEMPLATE ; Les tableaux DIM(*AUTO) et DIM(*CTDATA) ; Les BIF récentes, %SPLIT, %CONCAT, %LOOKUP, %MAXARR ; FOR-EACH et les listes

### Partie 09 : SQL embarqué en RPG

- [Le SQL embarqué](09-sql-embarque.md#le-sql-embarqué) : La syntaxe EXEC SQL et la compilation SQLRPGLE ; Les variables hôtes et les structures d'accueil ; SQLCODE, SQLSTATE et la gestion des diagnostics ; Les curseurs, DECLARE, OPEN, FETCH, CLOSE ; Les mises à jour positionnées et ensemblistes ; Le SQL dynamique, PREPARE et EXECUTE
- [De l'accès natif à l'accès SQL](09-sql-embarque.md#de-laccès-natif-à-laccès-sql) : Comparaison accès natif et accès SQL ; Les cas où le SQL est plus performant ; Les bonnes pratiques d'écriture

### Partie 10 : ILE : modules, programmes de service, tests et journalisation

- [Les principes de l'ILE](10-ile.md#les-principes-de-lile) : OPM et ILE, ce qui change ; Les groupes d'activation et leur portée ; La pile d'appels et la durée de vie des ressources
- [Procédures et prototypes](10-ile.md#procédures-et-prototypes) : La déclaration d'une procédure, DCL-PROC ; Prototypes et interfaces de procédure ; Le passage de paramètres, valeur, référence, CONST, OPTIONS ; Les procédures retournant une valeur ; Portée des variables, locales et globales
- [Modules et programmes de service](10-ile.md#modules-et-programmes-de-service) : La compilation en module, CRTRPGMOD ; Le liage par copie, CRTPGM ; Les programmes de service, CRTSRVPGM ; Les modules NOMAIN et les sources /COPY ; Les répertoires de liage (BNDDIR) ; Signature, fichier de liage et gestion des versions
- [Conception modulaire](10-ile.md#conception-modulaire) : Découpage fonctionnel d'une application ; Réutilisation et bibliothèques de procédures ; Centralisation des erreurs et des logs
- [Tests, débogage et dumps](10-ile.md#tests-débogage-et-dumps) : STRISDB et STRDBG, breakpoints et watch variables ; Le débogage d'un programme de service, service entry point ; Lecture et interprétation d'un dump ; Stratégie de tests unitaires et fonctionnels
- [La journalisation](10-ile.md#la-journalisation) : Journaux et récepteurs ; Analyse de l'activité via DSPJRN

### Partie 11 : Modernisation d'application et maintenance de code existant

- [Les principes de la modernisation d'application](11-modernisation-et-maintenance.md#les-principes-de-la-modernisation-dapplication) : Les limites du code historique et les enjeux de la modernisation ; La conversion vers RPG Free ; La décomposition d'un monolithe en modules et programmes de service ; Les standards modernes, SQL, erreurs centralisées, logs, constantes globales, validations ; Les outils modernes, RDi, VS Code, Git, JSON_TABLE, webservices REST
- [Développer une nouvelle application](11-modernisation-et-maintenance.md#développer-une-nouvelle-application) : L'architecture d'une application IBM i (PF/LF, DSPF, RPG Free, SQL, ILE) ; La séparation des traitements métier et du visuel ; Le SQL embarqué dans une application moderne
- [Les écrans standards](11-modernisation-et-maintenance.md#les-écrans-standards) : Menu, écrans de saisie, de consultation et d'erreur ; Validation des données et messages de contrôle
- [Les sous-fichiers](11-modernisation-et-maintenance.md#les-sous-fichiers) : Les sous-fichiers statiques et dynamiques ; L'intégration d'un CRUD complet en RPG et SQL
- [Mises en situation réelles de maintenance de code](11-modernisation-et-maintenance.md#mises-en-situation-réelles-de-maintenance-de-code) : Lecture et analyse d'un programme RPG ancienne génération ; Diagnostic de bug (SQL, logique métier, DSPF, data-area, journaux) ; Débogage, STRDBG et service entry point ; Modification d'un code existant sans dégrader la production ; Dette technique et élaboration de correctifs testés et documentés

### Partie 12 : Intelligence artificielle et assistants de développement

- [Les concepts fondamentaux](12-ia-et-assistants.md#les-concepts-fondamentaux) : Qu'est-ce que l'IA, les trois ères ; Les LLM, les tokens et les limites de contexte ; Glossaire essentiel, hallucination, température, prompt engineering, fine-tuning, RAG
- [Le prompting](12-ia-et-assistants.md#le-prompting) : Les règles du prompting efficace ; Construction d'un prompt complet
- [Les modes d'utilisation](12-ia-et-assistants.md#les-modes-dutilisation) : Discussions, Projets, Agents, Workflows ; L'utilisation de l'assistant BOB
- [Cadre d'usage et responsabilité](12-ia-et-assistants.md#cadre-dusage-et-responsabilité) : Confidentialité, RGPD, anonymisation des prompts ; Limitations de l'IA, éthique et responsabilité, débat
- [Mise en situation](12-ia-et-assistants.md#mise-en-situation) : Mise en situation sur un cas IBM i

### Partie 13 : Web services et API (REST, SOAP, JSON, XML, IWS)

- [Introduction et généralités sur les Web Services / API](13-web-services-et-api.md#introduction-et-généralités-sur-les-web-services--api) : API, REST, SOAP, URI, endpoints, stateless ; Web Services simples, RESTful, SOAP, HTTP / HTTPS ; Les méthodes HTTP (GET, POST, PUT, DELETE) ; Les en-têtes HTTP
- [Les formats d'échanges XML et JSON](13-web-services-et-api.md#les-formats-déchanges-xml-et-json) : Le XML, hiérarchie, attributs, namespaces ; Le JSON, objets, tableaux, types ; Les utilitaires
- [Consommer des API en SQL et en RPGLE](13-web-services-et-api.md#consommer-des-api-en-sql-et-en-rpgle) : En SQL, QSYS2.HTTP_GET / HTTP_POST / HTTP_PUT / HTTP_DELETE ; Extraction des données via JSON_TABLE et XMLTABLE ; En RPGLE, HTTPAPI, utilitaires QHTTPSVR, sockets
- [IWS, créer un web service en RPGLE / SQLRPGLE et le déployer](13-web-services-et-api.md#iws-créer-un-web-service-en-rpgle--sqlrpgle-et-le-déployer) : Architecture et composants d'IWS ; Conception d'un Web Service RPGLE / SQLRPGLE et création d'un endpoint REST ; Structuration des données de sortie (JSON / XML) ; Gestion des erreurs, des logs et des codes HTTP ; Déploiement, démarrage et test via navigateur, Postman ou ACS ; Sécurité, endpoints et documentation automatique (WSDL / OpenAPI)
- [Gérer des fichiers en XML et JSON](13-web-services-et-api.md#gérer-des-fichiers-en-xml-et-json) : Lire, écrire et modifier des fichiers dans l'IFS ; DATA-INTO pour lire JSON / XML en RPG Free ; Sérialisation de structures RPG en JSON ; Base64, UTF-8, CCSID et flux binaires

### Partie 14 : Projet en immersion

- [Projet](14-projet-en-immersion.md#projet) : Réalisation d'un projet en immersion, intégrant l'ensemble des notions vues durant les semaines précédentes (IBM i, DB2, CL, SQL, RPG, IA, PHL Web, Web Services)

## Recherche par mot-clé

| Partie | Mots-clés |
|---|---|
| [01](01-organisation-ibm-i.md) | objet, bibliothèque, *FILE, *PGM, *JOB, *USRPRF, WRKOBJ, WRKJOB, WRKSPLF, DSPSYSVAL, MSGQ, sous-système, JOBQ, JOBD, OUTQ, profil utilisateur, droits, IFS, QSYSOPR, SAVLIB, IPL |
| [02](02-db2-for-i.md) | Db2 for i, PF, LF, DDS, SQL, table, index, vue, clé primaire, clé étrangère, contrainte, RCAC, journal, QSYS2 |
| [03](03-outils-de-developpement.md) | QRY, QMQRY, SEU, PDM, SDA, RLU, PNLGRP, DFU, DSPF, PRTF, RDi, VS Code, Code for IBM i |
| [04](04-langage-de-controle-cl.md) | CL, CLP, CLLE, DCLPROPT, DCLF, OVRDBF, IF, DOWHILE, GOTO, CHGVAR, CALL, DTAARA, SUBR |
| [05](05-sql.md) | SQL, SELECT, JOIN, UNION, sous-requête, INSERT, UPDATE, DELETE, CREATE TABLE, ALTER, index, plan d'exécution, trigger, procédure stockée, fonction, QSYS2, services SQL, RUNSQLSTM, STRSQL, ACS |
| [06](06-rpg-iii.md) | RPG III, RPG/400, HFELICO, cycle, IP, LR, L1, MR, MOVE, MOVEL, Z-ADD, CHAIN, SETLL, READ, WRITE, UPDAT, DELET, EXCPT, BEGSR, SFL, SFLCTL, SEU, PDM |
| [07](07-rpg-iv.md) | RPG IV, ILE RPG, CVTRPGSRC, H, F, D, C, P, EVAL, IF, DOW, FOR, SELECT, %TRIM, %SUBST, %SCAN, MONITOR, CRTBNDRPG, CRTRPGMOD, STRDBG |
| [08](08-rpg-free.md) | **FREE, CTL-OPT, DCL-F, DCL-S, DCL-C, DCL-DS, DCL-PR, DCL-PI, DCL-PROC, LIKEDS, LIKEREC, TEMPLATE, DIM(*AUTO), %SPLIT, %CONCAT, %LOOKUP, FOR-EACH, CVTRPGFREE |
| [09](09-sql-embarque.md) | EXEC SQL, SQLRPGLE, CRTSQLRPGI, variable hôte, SQLCODE, SQLSTATE, GET DIAGNOSTICS, DECLARE CURSOR, OPEN, FETCH, CLOSE, PREPARE, EXECUTE, FOR n ROWS |
| [10](10-ile.md) | ILE, OPM, groupe d'activation, DCL-PROC, DCL-PR, DCL-PI, CONST, OPTIONS, CRTRPGMOD, CRTPGM, CRTSRVPGM, BNDDIR, NOMAIN, /COPY, signature, STRDBG, STRISDB, dump, journal, DSPJRN |
| [11](11-modernisation-et-maintenance.md) | modernisation, dette technique, full free, modules, programmes de service, RDi, VS Code, Git, JSON_TABLE, REST, DSPF, sous-fichier, CRUD, STRDBG, correctif |
| [12](12-ia-et-assistants.md) | IA, LLM, token, contexte, hallucination, température, prompt engineering, fine-tuning, RAG, agents, workflows, BOB, RGPD, anonymisation |
| [13](13-web-services-et-api.md) | API, REST, SOAP, URI, endpoint, GET, POST, PUT, DELETE, en-têtes HTTP, JSON, XML, HTTP_GET, JSON_TABLE, XMLTABLE, HTTPAPI, IWS, DATA-INTO, IFS, Base64, CCSID, UTF-8 |
| [14](14-projet-en-immersion.md) | projet, immersion, IBM i, DB2, CL, SQL, RPG, IA, web services |

## Sujets sans page job-i dédiée (0 sujets, dont 0 sans page wiki liée)

Ces sujets du plan n'ont pas de page job-i trouvée par la recherche du 2026-11-23 : la source est à chercher sur ibm.com (voir les « Pistes IBM » de chaque partie). La colonne « Page wiki liée » indique si le dépôt contient déjà du contenu pour la section concernée.
