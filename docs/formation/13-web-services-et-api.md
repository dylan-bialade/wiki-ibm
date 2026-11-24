# Partie 13 : Web services et API (REST, SOAP, JSON, XML, IWS)

> Plan de formation, partie 13 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Généralités API, formats XML et JSON, consommer des API en SQL et RPG, créer un web service avec IWS, gérer des fichiers XML et JSON dans l'IFS.
>
> **Mots-clés** : API, REST, SOAP, URI, endpoint, GET, POST, PUT, DELETE, en-têtes HTTP, JSON, XML, HTTP_GET, JSON_TABLE, XMLTABLE, HTTPAPI, IWS, DATA-INTO, IFS, Base64, CCSID, UTF-8.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Pistes IBM](#pistes-ibm)
- [Cours détaillé](#cours-détaillé)
  - [1. Généralités : API, REST, méthodes et en-têtes HTTP](#1-généralités--api-rest-méthodes-et-en-têtes-http)
  - [2. Les formats d'échange : JSON et XML](#2-les-formats-déchange--json-et-xml)
  - [3. Consommer des API : en SQL puis en RPG](#3-consommer-des-api--en-sql-puis-en-rpg)
  - [4. IWS : créer et déployer un web service en RPG](#4-iws--créer-et-déployer-un-web-service-en-rpg)
  - [5. Fichiers JSON et XML dans l'IFS](#5-fichiers-json-et-xml-dans-lifs)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Introduction et généralités sur les Web Services / API](#introduction-et-généralités-sur-les-web-services--api)
  - [Les formats d'échanges XML et JSON](#les-formats-déchanges-xml-et-json)
  - [Consommer des API en SQL et en RPGLE](#consommer-des-api-en-sql-et-en-rpgle)
  - [IWS, créer un web service en RPGLE / SQLRPGLE et le déployer](#iws-créer-un-web-service-en-rpgle--sqlrpgle-et-le-déployer)
  - [Gérer des fichiers en XML et JSON](#gérer-des-fichiers-en-xml-et-json)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [SQL avancé : JSON, IFS_WRITE_UTF8](../SQL-AVANCE.md)
- [Architecture ILE et services REST (IWS)](../ILE-ET-SERVICES-WEB.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## L'essentiel (vérifié dans le wiki)

- **IWS REST (tutoriels IBM de 2015)** : serveur ≥ 2.6, assistant sur le port 2001, procédures exportées d'un programme de service, `PGMINFO(*PCML:*MODULE)`, paramètre entier désigné comme code HTTP, en-têtes en sortie, tableau de sortie avec compteur ([détails](../ILE-ET-SERVICES-WEB.md#partie-2--services-web-rest-avec-integrated-web-services-iws)).
- **Exemple compilé** : liste de bonbons en JSON exposée par `get_bonbon` (modules `NOMAIN` + programme de service) ([exemple](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)) ; reste à confirmer à l'exécution : JSON renvoyé tel quel ou échappé.
- **JSON en SQL** : `JSON_OBJECT`, `JSON_ARRAYAGG` ([SQL avancé](../SQL-AVANCE.md#partie-1--sql-json-db2-for-i-75)) ; fichiers IFS : `IFS_WRITE_UTF8`.

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Node.js sur IBM i : installation et 3 webservices REST testés (Db2, RPG, SQL)](https://job-i.fr/nodejs-ibm-i) | Node.js s'exécute dans PASE et accède à Db2 for i et aux programmes RPG : une façon de mettre une API REST ou un écran web devant une application existante. | En une phrase ; Node.js, vite fait ; Qui l'a mis sur IBM i ? ; À quoi ça sert sur IBM i ; Le cheminement d'une requête ; Installer le dernier Node.js par yum ; Les tables Db2 for i ; Un CRUD REST sur une table Db2 ; Un programme RPG existant devient un webservice ; Un mouvement de stock, tout ou rien ; Les bonnes pratiques appliquées ; Les tests : unitaires, IBM i, Chrome, Postman |
| [Services SQL IBM i et AS/400 (QSYS2, SYSTOOLS) : exemples et résultats réels](https://job-i.fr/services-sql-ibm-i) | Catalogue des services SQL (QSYS2, SYSTOOLS) avec exemples et résultats. | Gestion des travaux (35) ; Bibliothèques et objets (5) ; Sécurité (26) ; Messages (7) ; Fichiers spoule (8) ; IFS (13) ; Journaux et audit (56) ; PTF (8) ; Stockage (16) ; Communications (22) ; Configuration (5) ; Application (48) |
| [ILE sur IBM i : modules, programmes de service, liage, exemple RPG, C et CL](https://job-i.fr/ile-ibm-i) | ILE : le compilateur produit un module ; on lie des modules de langages différents en programme ou en programme de service partagé. | En une phrase ; L'ILE, c'est quoi ; Pourquoi l'ILE existe ; L'exemple : un programme RPG, un module C, un module CL ; Mettre en place 1 : trois modules, un programme ; Mettre en place 2 : un programme de service ; Par copie ou par référence : la preuve ; Déboguer d'un langage à l'autre ; Mettre l'ILE en place dans une application |

## Pistes IBM

Issues de recherches ibm.com du 2026-11-23 : les pages sans mention « lu » **ne sont pas lues** ; la version indiquée peut différer de la 7.5 (à vérifier avant de s'en servir).

- [HTTP functions overview (IBM i 7.5)](https://www.ibm.com/docs/en/ssw_ibm_i_75/sqlp/rbafyhttpoverview.htm)
- [JSON_TABLE : support IBM](https://www.ibm.com/support/pages/jsontable-table-function)
- [DATA-INTO (IBM i 7.4)](https://ibm.com/docs/da/ssw_ibm_i_74/rzasd/zzdatainto.htm)
- [%DATA et %XML pour DATA-GEN / DATA-INTO (IBM i 7.3)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzasd/xmlin1.htm)
- [IWS REST, tutoriels IBM (2015) : lus](https://developer.ibm.com/tutorials/i-rest-web-services-server2/)
- [JSON_OBJECT (IBM i 7.5) : lu](https://www.ibm.com/docs/fr/i/7.5?topic=functions-json-object)
- [IFS_WRITE_UTF8 (IBM i 7.5) : lu](https://www.ibm.com/docs/fr/i/7.5.0?topic=is-ifs-write-ifs-write-binary-ifs-write-utf8-procedures)

## Cours détaillé

> Sources : le wiki ([ILE-ET-SERVICES-WEB.md](../ILE-ET-SERVICES-WEB.md) parties 2 et 3 : tutoriels IBM IWS de **2015** lus en entier, exemple BONBON compilé ; [SQL-AVANCE.md](../SQL-AVANCE.md) parties 1 et 2 : `JSON_OBJECT`, `JSON_ARRAYAGG`, `IFS_WRITE_UTF8`), IBM Documentation **IBM i 7.5** (HTTP functions, `HTTP_GET`, `JSON_TABLE`, `XMLTABLE`, `BASE64_ENCODE` : pages lues en partie), IBM i **7.4** (`DATA-INTO`) et job-i.fr (Node.js, `IFS_READ`, `STRTCPSVR`). **job-i n'a aucune page** sur les généralités API/REST/SOAP, XML, JSON, ni sur les fonctions HTTP SQL. L'assistant n'a ni compilé ni exécuté quoi que ce soit.

### 1. Généralités : API, REST, méthodes et en-têtes HTTP

- **Définitions** (API, REST, SOAP, URI, endpoint, *stateless*) : **aucune source** lue dans le wiki, chez job-i ni chez IBM pour cette partie ; connaissance générale à ne pas citer comme acquise. Ce qui est vérifié concerne l'IBM i :
- **Méthodes HTTP** : l'IWS REST route `GET`, `POST`, `PUT`, `DELETE` vers des procédures exportées (chemin par défaut `/web/services/<ressource>`, modèle de chemin avec variable et expression régulière, entrée `*PATH_PARAM`) ; côté client, les fonctions SQL couvrent `GET`, `PUT`, `POST`, **`PATCH`** et `DELETE` (§ 3).
- **En-têtes HTTP** : en sortie d'IWS, paramètre `100a DIM(10)` (ex. `Cache-Control: no-cache, no-store`, `LOCATION: …`) ; en entrée, informations de transport par variables d'environnement `REMOTE_ADDR`, `HTTP_<EN-TÊTE>` en majuscules ; côté client SQL, option `headers` en JSON (§ 3). Codes de réponse cités par le tutoriel : 200, 201, 204, 404, 409, 500.
- **http / https** : l'URL des fonctions SQL accepte `http:` et `https:` ; `https` crée un canal sécurisé TLS ; **l'authentification HTTP n'est pas permise sur une URL `http:`** (IBM).

| Élément | Statut | Source |
|---|---|---|
| Méthodes GET/POST/PUT/DELETE, chemin `/web/services/…`, `*PATH_PARAM`, en-têtes, codes, variables d'environnement | vérifié (tutoriel 2015) ; **périmé possible pour 7.5** | [ILE-ET-SERVICES-WEB, partie 2](../ILE-ET-SERVICES-WEB.md#partie-2--services-web-rest-avec-integrated-web-services-iws) |
| http/https et authentification | vérifié | [IBM 7.5 : HTTP functions overview](https://www.ibm.com/docs/en/i/7.5.0?topic=programming-http-functions-overview) |
| API, REST, SOAP, URI, endpoint, stateless | **non vérifié** (aucune source lue) | à sourcer |

### 2. Les formats d'échange : JSON et XML

- **JSON (production)** : `JSON_OBJECT` (paires clé/valeur, `NULL ON NULL` par défaut, `FORMAT JSON` pour ne pas échapper un texte déjà JSON, résultat `CLOB(2G) CCSID 1208` par défaut) et `JSON_ARRAYAGG` (`ABSENT ON NULL` par défaut, `NULL` si l'ensemble est vide) : [SQL avancé, partie 1](../SQL-AVANCE.md#partie-1--sql-json-db2-for-i-75), pages IBM 7.5 **lues**.
- **JSON (lecture)** : **`JSON_TABLE`** (IBM i 7.5) renvoie un résultat à partir d'expressions de chemin SQL/JSON : `JSON_TABLE(json-expression [FORMAT JSON|BSON], chemin AS nom COLUMNS (…) [EMPTY ON ERROR | ERROR ON ERROR])` ; colonnes régulières (`type PATH '…'`, `NULL | ERROR | DEFAULT … ON EMPTY / ON ERROR`), formatées (`FORMAT JSON`, `WITH/WITHOUT ARRAY WRAPPER`, `KEEP/OMIT QUOTES`), d'ordinalité (`FOR ORDINALITY`), imbriquées (`NESTED PATH`) (page lue, syntaxe).
- **XML (lecture)** : **`XMLTABLE`** (IBM i 7.5) renvoie un résultat à partir d'**expressions XPath** : `XMLTABLE([déclaration de namespaces,] expression-XQuery-ligne PASSING … COLUMNS colonnes)` ; colonnes régulières (`type PATH '…'`, clause `DEFAULT`) ou d'ordinalité (`FOR ORDINALITY`) ; chaque élément de la séquence résultat = une ligne (page lue, syntaxe).
- **RPG : `DATA-INTO`** (page IBM i **7.4**, lue en partie) : importe un document **structuré quelconque** dans une variable RPG ; `DATA-INTO{(EH)} receiver %DATA(document {: options1}) %PARSER(parser {: options2});` ou avec `%HANDLER(procédure : commArea)` ; **nécessite un analyseur (parser)** capable de lire le document ; différence avec `XML-INTO` : celui-ci ne lit que du XML. Option `path=` pour atteindre la donnée dans le document (ex. `path=info/order`) ; si la variable est un tableau, l'analyse ne lit que ce qui tient dans le tableau ; si c'est une structure, certains sous-champs peuvent être renseignés même en cas d'erreur.
- **Hiérarchie, attributs, namespaces XML ; types JSON** : aucune source de définition lue.

| Élément | Statut | Source |
|---|---|---|
| JSON_OBJECT, JSON_ARRAYAGG, FORMAT JSON | vérifié (pages 7.5 lues) | [SQL avancé, partie 1](../SQL-AVANCE.md#partie-1--sql-json-db2-for-i-75) |
| JSON_TABLE : syntaxe, types de colonnes, ON ERROR | vérifié **partiellement** (début de page : syntaxe) | [IBM 7.5 : JSON_TABLE](https://www.ibm.com/docs/en/i/7.5.0?topic=functions-json-table) |
| XMLTABLE : syntaxe, colonnes, ordinalité | vérifié **partiellement** (début de page : syntaxe) | [IBM 7.5 : XMLTABLE](https://www.ibm.com/docs/en/i/7.5.0?topic=functions-xmltable) |
| DATA-INTO : syntaxe, parser obligatoire, `%HANDLER`, `path` | vérifié **partiellement** (page **7.4**) ; version 7.5 non lue | [IBM 7.4 : DATA-INTO](https://www.ibm.com/docs/da/i/7.4.0?topic=codes-data-into-parse-document-into-variable) |
| `%DATA`, `%PARSER`, `%XML`, parsers fournis (JSON), `XML-INTO` | **non lu** | [%DATA / %XML (7.3)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzasd/xmlin1.htm) |
| Structure du XML, types JSON | **non vérifié** | à sourcer |

### 3. Consommer des API : en SQL puis en RPG

**Fonctions HTTP SQL** (IBM i 7.5, schéma `QSYS2`) : elles permettent des requêtes REST depuis SQL, y compris embarqué ; mêmes capacités que les fonctions `SYSTOOLS` du même nom **sans créer de JVM** ; implémentées avec les API de transport HTTP du **client IWS** ; prérequis : **5770SS1 option 3** (*Extended Base Directory Support*) et **option 34** (*Digital Certificate Manager*) ; avantages cités : authentification HTTP, proxy, nombre de redirections configurable, options SSL.

| Dimension | Valeurs |
|---|---|
| Opération | `GET`, `PUT`, `POST`, `PATCH`, `DELETE` |
| Type de données | CLOB (par défaut) ou `_BLOB` |
| Version | non verbeuse = **fonction scalaire** ; `_VERBOSE` = **fonction de table** à une ligne qui renvoie aussi les **en-têtes de réponse en JSON** |

Exemples de noms : `HTTP_GET`, `HTTP_GET_BLOB`, `HTTP_GET_VERBOSE`, `HTTP_POST`, `HTTP_PATCH_BLOB_VERBOSE`. L'administrateur peut **interdire** toutes ces fonctions en retirant les droits sur le programme de service `QSYS/QSQAXISC`.

**`HTTP_GET(url [, options])`** : `url` en `http://` ou `https://` seulement ; l'authentification de base **ne se met pas dans l'URL** (`https://user:pwd@…` interdit) mais dans l'option `basicAuth` ; `options` = une chaîne **JSON** (`{"headers":{"User-Agent":"…"}}`) ; résultat `CLOB(2G) CCSID 1208` (`BLOB(2G)` pour `_BLOB`).

```sql
VALUES QSYS2.HTTP_GET(
  'https://www.ibm.com/support/pages/sites/default/files/inline-files/xmldoc.xml',
  '{"sslCertificateStoreFile":"/home/javaTrustStore/fromJava.KDB"}');
```
*(exemple de la page IBM 7.5, non exécuté par moi)*

Option vue : `axiscLogFilePath` (trace AXISC dans l'IFS, modificateurs `%j` et `%t`) ; la liste complète des options (dont `basicAuth` et `sslCertificateStoreFile`, vus dans la page) est dans « HTTP options », seule une partie est lue.

**Enchaîner avec le JSON** : lire la réponse avec `JSON_TABLE` ou `XMLTABLE` (§ 2) ; en RPG, passer par un `SELECT … INTO` ou un curseur ([partie 09](09-sql-embarque.md#cours-détaillé)).

**Helpers** (IBM 7.5) : `QSYS2.BASE64_ENCODE(chaîne binaire)` renvoie un `CLOB CCSID 1208` ; **attention au CCSID** : `BASE64_ENCODE('ABC')` d'une chaîne EBCDIC donne `wcLD`, tandis que `BASE64_ENCODE(CAST('ABC' AS VARCHAR(10) CCSID 1208))` donne `QUJD` ; `BASE64_DECODE` et `URL_ENCODE` existent aussi (pages non lues).

**En RPG** : `HTTPAPI`, `QHTTPSVR`, sockets : **non documentés** dans le wiki (aucune lecture) ; `DATA-INTO` (§ 2) pour analyser la réponse.

**Alternative : Node.js** (job-i, page lue en partie) : s'exécute dans PASE ; paquets `idb-pconnector` (Db2 local), `itoolkit` (appel de RPG/CL par XMLSERVICE), `odbc` ; installation par `yum -y install nodejs24 nodever` (paquets RPM, comme **Python, Git, Mapepire** : cela précise que **Git s'installe par yum**, d'après job-i, version 2026) ; job-i annonce trois services REST testés (CRUD Db2, programme RPG exposé en `POST /api/devis`, mouvement de stock « tout ou rien »). Comparaison de job-i : face à un service RPG (CGI ou IWS), Node.js apporte npm, validation des entrées, documentation OpenAPI, tests automatiques ; le RPG garde l'avantage si toute la logique est en RPG.

| Élément | Statut | Source |
|---|---|---|
| Fonctions HTTP : 5 opérations × CLOB/BLOB × verbose, QSQAXISC, prérequis options 3 et 34, https, JVM | vérifié (page overview 7.5 lue en partie) | [IBM 7.5 : HTTP functions overview](https://www.ibm.com/docs/en/i/7.5.0?topic=programming-http-functions-overview) |
| HTTP_GET : url, options JSON, `basicAuth`, résultat CLOB/BLOB, exemple | vérifié **partiellement** (début de page) | [IBM 7.5 : HTTP_GET](https://www.ibm.com/docs/en/i/7.5.0?topic=functions-http-get-http-get-blob) |
| HTTP_POST, PUT, PATCH, DELETE, formes VERBOSE (colonnes du résultat) | **non lu** | pages de la même documentation |
| BASE64_ENCODE : résultat CLOB 1208, exemples CCSID | vérifié (page lue, courte) | [IBM 7.5 : BASE64_ENCODE](https://www.ibm.com/docs/en/i/7.5.0?topic=functions-base64-encode) |
| Node.js sur IBM i : installation yum, paquets, 3 exemples | vérifié (début de page, annoncé exécuté par job-i) | [job-i : Node.js](https://job-i.fr/nodejs-ibm-i) |
| HTTPAPI, QHTTPSVR, sockets en RPG ; SYSTOOLS HTTP (comparatif) | **non vérifié** | à sourcer |

### 4. IWS : créer et déployer un web service en RPG

Le détail (tutoriels IBM de 2015, lus en entier, avec les points non vérifiés) est dans [ILE-ET-SERVICES-WEB, partie 2](../ILE-ET-SERVICES-WEB.md#partie-2--services-web-rest-avec-integrated-web-services-iws) et [partie 3](../ILE-ET-SERVICES-WEB.md#partie-3--droits-et-exploitation-dun-service-iws). Rappel :

- **Architecture** : un **programme de service** dont les procédures exportées sont exposées par le serveur de services web (version **2.6 minimum** pour REST) ; assistant d'administration sur `http://hôte:2001/HTTPAdmin` (`https://hôte:2010/HTTPAdmin` en SSL) ; autorités `*ALLOBJ` et `*IOSYSCFG` pour créer le serveur ; profil d'exécution par défaut `QWSERVICE` (activé, mot de passe ≠ `*NONE`, droits sur les objets utilisés).
- **Conception d'un endpoint** : `PGMINFO(*PCML:*MODULE)` (et `*DCLCASE` pour garder la casse des noms) ; un paramètre `int(10)` désigné comme **code HTTP** ; en-têtes en sortie `100a DIM(10)` ; tableau de sortie `DIM(n)` avec `OPTIONS(*VARSIZE)` **et** un paramètre de nombre d'éléments, sinon la réponse contient des éléments vides ; structure `QUALIFIED TEMPLATE` pour maîtriser la casse des noms JSON.
- **Exemple compilé** : liste de bonbons en JSON, `get_bonbon` (modules `NOMAIN` + programme de service `WSBONBON`) ; **à confirmer à l'exécution** : JSON renvoyé tel quel ou échappé comme chaîne ([exemple BONBON](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)).
- **Démarrage et exploitation** : `STRTCPSVR` démarre les serveurs d'application TCP/IP (paramètres `SERVER`, `RESTART`, `HTTPSVR`, `INSTANCE`…) ; `ENDTCPSVR` les arrête ; test depuis navigateur, Postman ou ACS ; mémo des commandes : [partie 4](../ILE-ET-SERVICES-WEB.md#partie-4--mémo-des-commandes-système-ile-iws-exploitation).
- **Sécurité, WSDL/OpenAPI** : **non vérifiés** ; l'IWS 3.0 (annonce d'octobre 2025) et le PDF du tutoriel ne sont pas lus (wiki).

| Élément | Statut | Source |
|---|---|---|
| IWS : serveur 2.6, port 2001, profil `QWSERVICE`, PGMINFO, code HTTP, en-têtes, tableau + compteur | vérifié (2015) ; périmé possible pour 7.5 | [ILE-ET-SERVICES-WEB](../ILE-ET-SERVICES-WEB.md) |
| STRTCPSVR : rôle et paramètres | vérifié (début de l'aide) | [job-i : STRTCPSVR](https://job-i.fr/commandes-ibm-i/strtcpsvr) |
| Cours PDF IWS (2026-11-24) : source de liage, `*V7`, `RNF0320`, `ZUI_54441`, wrapping, jobs `QZRCSRVS` réutilisés | **non vérifié** (document fourni) | [ILE-ET-SERVICES-WEB](../ILE-ET-SERVICES-WEB.md) |
| Droits `QWSERVICE` (`*USE` suffit ?), `GRTOBJAUT` après recréation, journal du serveur | **non vérifié** | [ILE-ET-SERVICES-WEB, partie 3](../ILE-ET-SERVICES-WEB.md#partie-3--droits-et-exploitation-dun-service-iws) |
| Sécurité, WSDL, OpenAPI, XML en sortie | **non vérifié** | à sourcer |
| IWS en 7.5 (documentation actuelle) | **non lue** | à chercher sur ibm.com |

### 5. Fichiers JSON et XML dans l'IFS

- **Écrire** : `QSYS2.IFS_WRITE_UTF8` (UTF-8 par défaut, `FILE_CCSID` 1208 ; `OVERWRITE` `APPEND` (défaut), `REPLACE`, `NONE` ; `END_OF_LINE` `CRLF` par défaut, passer `LF` pour un fichier Unix ; jusqu'à 2 Go ; droits `*X` sur chaque répertoire, `*WX` sur le parent pour créer) : [SQL avancé, partie 2](../SQL-AVANCE.md#partie-2--écrire-dans-lifs-depuis-sql-qsys2ifs_write_utf8).
- **Lire** : fonction de table **`QSYS2.IFS_READ(PATH_NAME => …, END_OF_LINE => …)`** : renvoie `LINE_NUMBER` et `LINE` ; découpage par `END_OF_LINE` (défaut `ANY`) et `MAXIMUM_LINE_LENGTH` ; **contenu converti dans le CCSID du travail** ; `IGNORE_ERRORS` vaut `YES` par défaut ; résultat annoncé exécuté sur IBM i 7.5 par job-i.
- **RPG** : `DATA-INTO` pour lire du JSON/XML avec un analyseur (§ 2) ; **sérialisation d'une structure RPG en JSON** : aucune source lue (les fonctions SQL `JSON_OBJECT` produisent le JSON côté SQL).
- **Base64, UTF-8, CCSID** : `BASE64_ENCODE` (§ 3) ; UTF-8 = CCSID **1208** ; un résultat JSON `CLOB CCSID 1208` converti vers une variable RPG est une étape à valider (le wiki n'a validé que la **compilation** du `CAST … AS VARCHAR`).

| Élément | Statut | Source |
|---|---|---|
| IFS_WRITE_UTF8 : paramètres, valeurs par défaut, droits, 2 Go | vérifié (page 7.5 lue) | [SQL avancé, partie 2](../SQL-AVANCE.md#partie-2--écrire-dans-lifs-depuis-sql-qsys2ifs_write_utf8) |
| IFS_READ : colonnes, END_OF_LINE, CCSID du travail, IGNORE_ERRORS | vérifié (début de page job-i, exemple exécuté 7.5) | [job-i : IFS_READ](https://job-i.fr/services-sql-ibm-i/qsys2.ifs_read) |
| IFS_WRITE (CCSID du travail, binaire) | existence vérifiée | [job-i : IFS_WRITE](https://job-i.fr/services-sql-ibm-i/qsys2.ifs_write) |
| Sérialisation RPG → JSON, flux binaires, conversions de CCSID de bout en bout | **non vérifié** | à sourcer |

### Ce qui reste à vérifier pour cette partie

HTTP : colonnes des fonctions `_VERBOSE`, liste complète des options (SSL, délais…), `HTTP_POST`/`PUT`/`PATCH`/`DELETE` ; `SYSTOOLS.HTTP*` (comparaison) ; `%DATA`/`%PARSER`/`XML-INTO` ; version **7.5** de `DATA-INTO` ; IWS en 7.5 (la source du wiki date de 2015 : points `QWSERVICE`, JSON échappé ou non à l'exécution, IWS 3.0) ; HTTPAPI, sockets ; sécurité, WSDL, OpenAPI ; définitions générales API/REST/SOAP/XML/JSON ; installation de Git par `yum` (citée par job-i, non lue en détail). Manques à signaler : aucune page job-i sur les fonctions HTTP SQL, `JSON_TABLE`, `XMLTABLE`, `DATA-INTO` ni les généralités API.

## Plan détaillé (index des sujets)

### Introduction et généralités sur les Web Services / API

- **Dans le wiki** : [IWS REST (tutoriels)](../ILE-ET-SERVICES-WEB.md#partie-2--services-web-rest-avec-integrated-web-services-iws)

#### API, REST, SOAP, URI, endpoints, stateless

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Web Services simples, RESTful, SOAP, HTTP / HTTPS

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les méthodes HTTP (GET, POST, PUT, DELETE)

- **Dans le wiki** : [IWS : méthodes et URI](../ILE-ET-SERVICES-WEB.md#partie-2--services-web-rest-avec-integrated-web-services-iws)
- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les en-têtes HTTP

- **Dans le wiki** : [IWS : en-têtes de réponse](../ILE-ET-SERVICES-WEB.md#partie-2--services-web-rest-avec-integrated-web-services-iws)
- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Les formats d'échanges XML et JSON

- **Dans le wiki** : [SQL JSON (JSON_OBJECT, JSON_ARRAYAGG)](../SQL-AVANCE.md#partie-1--sql-json-db2-for-i-75)

#### Le XML, hiérarchie, attributs, namespaces

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Le JSON, objets, tableaux, types

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les utilitaires

- **Dans le wiki** : [Mémo des commandes système (STRTCPSVR, WRKACTJOB, DSPJOBLOG…)](../ILE-ET-SERVICES-WEB.md#partie-4--mémo-des-commandes-système-ile-iws-exploitation)
- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Consommer des API en SQL et en RPGLE

- **Dans le wiki** : aucune page dédiée (à documenter).

#### En SQL, QSYS2.HTTP_GET / HTTP_POST / HTTP_PUT / HTTP_DELETE

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Extraction des données via JSON_TABLE et XMLTABLE

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### En RPGLE, HTTPAPI, utilitaires QHTTPSVR, sockets

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### IWS, créer un web service en RPGLE / SQLRPGLE et le déployer

- **Dans le wiki** : [IWS REST : tutoriels, exemple BONBON, droits](../ILE-ET-SERVICES-WEB.md#partie-2--services-web-rest-avec-integrated-web-services-iws) · [Exemple complet BONBON](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)

#### Architecture et composants d'IWS

- **Dans le wiki** : [IWS REST : tutoriels IBM de 2015](../ILE-ET-SERVICES-WEB.md#partie-2--services-web-rest-avec-integrated-web-services-iws)
- **job-i** : [Node.js sur IBM i](https://job-i.fr/nodejs-ibm-i)

#### Conception d'un Web Service RPGLE / SQLRPGLE et création d'un endpoint REST

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Structuration des données de sortie (JSON / XML)

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Gestion des erreurs, des logs et des codes HTTP

- **Dans le wiki** : [IWS : codes HTTP 200/201/204/404/409/500](../ILE-ET-SERVICES-WEB.md#partie-2--services-web-rest-avec-integrated-web-services-iws)
- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Déploiement, démarrage et test via navigateur, Postman ou ACS

- **job-i** : [STRTCPSVR](https://job-i.fr/commandes-ibm-i/strtcpsvr) · [ENDTCPSVR](https://job-i.fr/commandes-ibm-i/endtcpsvr)

#### Sécurité, endpoints et documentation automatique (WSDL / OpenAPI)

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Gérer des fichiers en XML et JSON

- **Dans le wiki** : [IFS_WRITE_UTF8](../SQL-AVANCE.md#partie-2--écrire-dans-lifs-depuis-sql-qsys2ifs_write_utf8)

#### Lire, écrire et modifier des fichiers dans l'IFS

- **Dans le wiki** : [SQL avancé : IFS_WRITE_UTF8](../SQL-AVANCE.md#partie-2--écrire-dans-lifs-depuis-sql-qsys2ifs_write_utf8)
- **job-i** : [IFS_READ](https://job-i.fr/services-sql-ibm-i/qsys2.ifs_read) · [IFS_WRITE](https://job-i.fr/services-sql-ibm-i/qsys2.ifs_write)

#### DATA-INTO pour lire JSON / XML en RPG Free

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Sérialisation de structures RPG en JSON

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Base64, UTF-8, CCSID et flux binaires

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).
