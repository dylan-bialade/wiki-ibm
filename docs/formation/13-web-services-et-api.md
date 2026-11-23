# Partie 13 : Web services et API (REST, SOAP, JSON, XML, IWS)

> Plan de formation, partie 13 sur 14. Généralités API, formats XML et JSON, consommer des API en SQL et RPG, créer un web service avec IWS, gérer des fichiers XML et JSON dans l'IFS.
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
- [Plan détaillé](#plan-détaillé)
  - [Introduction et généralités sur les Web Services / API](#introduction-et-généralités-sur-les-web-services--api)
  - [Les formats d'échanges XML et JSON](#les-formats-déchanges-xml-et-json)
  - [Consommer des API en SQL et en RPGLE](#consommer-des-api-en-sql-et-en-rpgle)
  - [IWS, créer un web service en RPGLE / SQLRPGLE et le déployer](#iws-créer-un-web-service-en-rpgle--sqlrpgle-et-le-déployer)
  - [Gérer des fichiers en XML et JSON](#gérer-des-fichiers-en-xml-et-json)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [SQL avancé : JSON, IFS_WRITE_UTF8](../SQL-AVANCE.md)
- [Architecture ILE et services REST (IWS)](../ILE-ET-SERVICES-WEB.md)

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

## Plan détaillé

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
