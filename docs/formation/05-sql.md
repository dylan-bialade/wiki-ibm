# Partie 05 : Le langage SQL sur IBM i

> Plan de formation, partie 05 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Présentation et interfaces SQL, interrogation (jointures, unions, sous-requêtes), manipulation, définition, performances, objets programmables (triggers, procédures, fonctions).
>
> **Mots-clés** : SQL, SELECT, JOIN, UNION, sous-requête, INSERT, UPDATE, DELETE, CREATE TABLE, ALTER, index, plan d'exécution, trigger, procédure stockée, fonction, QSYS2, services SQL, RUNSQLSTM, STRSQL, ACS.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Pistes IBM](#pistes-ibm)
- [Cours détaillé](#cours-détaillé)
  - [1. Interroger : SELECT (subselect)](#1-interroger--select-subselect)
  - [2. Unions, jointures et sous-requêtes](#2-unions-jointures-et-sous-requêtes)
  - [3. Manipuler : INSERT, UPDATE, DELETE, MERGE](#3-manipuler--insert-update-delete-merge)
  - [4. Définir : CREATE TABLE, INDEX, VIEW](#4-définir--create-table-index-view)
  - [5. Performances](#5-performances)
  - [6. Objets programmables : triggers, procédures, fonctions](#6-objets-programmables--triggers-procédures-fonctions)
  - [7. Interfaces SQL sur IBM i](#7-interfaces-sql-sur-ibm-i)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Introduction](#introduction)
  - [Le langage et l'interrogation des données](#le-langage-et-linterrogation-des-données)
  - [La manipulation des données](#la-manipulation-des-données)
  - [La définition des objets](#la-définition-des-objets)
  - [Les performances](#les-performances)
  - [Les objets programmables](#les-objets-programmables)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 04 : Db2 for i et SQL](../cheatsheets/04-db2-for-i-et-sql.md)
- [Fiche 07 : SQL embarqué](../cheatsheets/07-sql-embarque-en-rpg.md)
- [SQL avancé (JSON, IFS)](../SQL-AVANCE.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## L'essentiel (vérifié dans le wiki)

- **JSON** : `JSON_OBJECT` (défaut `NULL ON NULL`) et `JSON_ARRAYAGG` (défaut `ABSENT ON NULL`, `NULL` si l'ensemble est vide) ; `FORMAT JSON` évite l'échappement d'un texte déjà JSON ([SQL avancé, partie 1](../SQL-AVANCE.md#partie-1--sql-json-db2-for-i-75)).
- **IFS** : `QSYS2.IFS_WRITE_UTF8` écrit en UTF-8 (CCSID 1208), `OVERWRITE` vaut `APPEND` par défaut et la fin de ligne `CRLF` ([partie 2](../SQL-AVANCE.md#partie-2--écrire-dans-lifs-depuis-sql-qsys2ifs_write_utf8)).
- **Services SQL et recettes** : catalogue sur job-i (voir tableau) et recettes de la [fiche 04](../cheatsheets/04-db2-for-i-et-sql.md).

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Services SQL IBM i et AS/400 (QSYS2, SYSTOOLS) : exemples et résultats réels](https://job-i.fr/services-sql-ibm-i) | Catalogue des services SQL (QSYS2, SYSTOOLS) avec exemples et résultats. | Gestion des travaux (35) ; Bibliothèques et objets (5) ; Sécurité (26) ; Messages (7) ; Fichiers spoule (8) ; IFS (13) ; Journaux et audit (56) ; PTF (8) ; Stockage (16) ; Communications (22) ; Configuration (5) ; Application (48) |
| [Recettes SQL d'exploitation IBM i et AS/400 : requêtes testées](https://job-i.fr/recettes-sql-ibm-i) | Requêtes SQL d'exploitation testées. | Travaux (7) ; Messages (4) ; Sécurité (6) ; Spoule (2) ; Stockage (6) ; Journaux (3) ; PTF et licences (4) ; Sauvegarde (1) ; Base de données (3) |
| [Fichier physique (PF) IBM i : DDS, CRTPF, UPDDTA et comparaison avec SQL](https://job-i.fr/fichier-physique-pf-ibm-i) | Un PF est l'objet *FILE qui contient les données d'une table (format, enregistrements, clé) ; créé en DDS ou en SQL, lisible en RPG comme en SQL. | En une phrase ; Pourquoi les DDS ont été inventées ; Ce qu'est un PF ; Créer un PF en DDS ; Ajouter, modifier, supprimer avec UPDDTA ; Voir le contenu, et la place des supprimés ; La même table en SQL ; PF DDS et table SQL : les différences démontrées |
| [Fichier logique (LF) IBM i : à quoi ça sert, clé, sélection et jointure](https://job-i.fr/fichier-logique-lf-ibm-i) | Un LF présente les données d'un ou plusieurs PF (ordre, sélection, zones, jointure) sans en contenir ; vu de SQL, équivalent d'une vue ou d'un index. | En une phrase ; Pourquoi les LF existent ; Un autre ordre : la clé ; Une sélection : seulement le type Feu ; La jointure : le Pokémon et ses attaques ; Les équivalents SQL : index et vues |

## Pistes IBM

Issues de recherches ibm.com du 2026-11-23 : les pages sans mention « lu » **ne sont pas lues** ; la version indiquée peut différer de la 7.5 (à vérifier avant de s'en servir).

- [CREATE TRIGGER (IBM i 7.6)](https://www.ibm.com/docs/ssw_ibm_i_76/db2/rbafzhctrigger.htm)
- [SQL procedural language, SQL PL (IBM i 7.6)](https://www.ibm.com/docs/en/ssw_ibm_i_76/db2/rbafzsqlpl.htm)
- [Redbook SQL procedures, triggers and functions (SG24-8326, 2016)](https://redbooks.ibm.com/abstracts/sg248326.html)
- [Optimizing query performance (IBM i 7.1)](https://www.ibm.com/docs/ssw_ibm_i_71/rzajq/queryopt.htm)
- [Index advisor (IBM i 7.4)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzajq/idxadvisor.htm)
- [HTTP functions overview (IBM i 7.5)](https://www.ibm.com/docs/en/ssw_ibm_i_75/sqlp/rbafyhttpoverview.htm)

## Cours détaillé

> Synthèses personnelles (pas de copie) à partir d'IBM Documentation **IBM i 7.5** et de job-i.fr. Les exemples SQL sont **illustratifs, non compilés ni testés** par l'assistant (statut *hypothèse* tant que tu ne les as pas exécutés). Noms de tables fictifs (`CLIENT`, `COMMANDE`).

### 1. Interroger : SELECT (subselect)

Une requête simple est un *subselect* : clauses `SELECT`, `FROM`, `WHERE`, (hiérarchique `CONNECT BY`), `GROUP BY`, `HAVING`, `ORDER BY`, `OFFSET`, `FETCH`. L'ordre **logique** d'évaluation est : FROM, (hiérarchique), WHERE, GROUP BY, HAVING, SELECT, ORDER BY, OFFSET, FETCH. Conséquence : un alias défini dans le SELECT n'est pas utilisable dans le WHERE.

```sql
SELECT cli.num, cli.nom, COUNT(*) AS nb_cmd
  FROM client cli
  JOIN commande cmd ON cmd.num_cli = cli.num
 WHERE cmd.dt_cmd >= '2026-01-01'
 GROUP BY cli.num, cli.nom
HAVING COUNT(*) > 3
 ORDER BY nb_cmd DESC
 FETCH FIRST 10 ROWS ONLY;
```

| Élément | Statut | Source |
|---|---|---|
| Liste des clauses du subselect et ordre logique d'évaluation | vérifié (page lue en entier) | [IBM 7.5 : subselect](https://www.ibm.com/docs/en/i/7.5.0?topic=queries-subselect) |
| Sous-requête scalaire : une ligne et une colonne (NULL si aucune ligne, erreur si plusieurs) | vérifié | idem |
| Les règles RCAC (permissions, masques) modifient le résultat vu | vérifié | idem |
| Syntaxe de l'exemple (JOIN, GROUP BY, HAVING, FETCH FIRST) | hypothèse (non exécuté) | à tester dans ACS / STRSQL |
| Détail des clauses FROM (types de jointures), WHERE, GROUP BY | non vérifié (pages IBM non chargées dans le navigateur de l'assistant) | à lire sur ibm.com 7.5 |
| Page job-i dédiée SELECT | `/commandes-ibm-i/select` existe (rubriques non relues pour ce cours) | [job-i](https://job-i.fr/commandes-ibm-i/select) |

### 2. Unions, jointures et sous-requêtes

**Opérateurs ensemblistes (fullselect)** : `UNION [DISTINCT|ALL]`, `EXCEPT`, `INTERSECT`. Les requêtes doivent avoir le même nombre de colonnes, de types compatibles. `INTERSECT` est évalué avant `UNION` et `EXCEPT`. Les doublons : deux lignes sont dupliquées si leurs colonnes sont égales (deux NULL sont considérés égaux). `VALUES (...), (...)` équivaut à un `UNION ALL` de lignes.

```sql
SELECT num FROM client_actif
UNION
SELECT num FROM client_archive;     -- sans doublon ; UNION ALL les conserve
```

Jointures : `INNER JOIN`, `LEFT/RIGHT [OUTER] JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`. Sous-requêtes : scalaire (une valeur), `IN (subselect)`, `EXISTS`, ou table imbriquée dans le FROM. Vu de l'IBM i, un LF de jointure DDS est l'équivalent d'une vue SQL ([job-i : fichier logique](https://job-i.fr/fichier-logique-lf-ibm-i), rubrique « Les équivalents SQL : index et vues »).

| Élément | Statut | Source |
|---|---|---|
| UNION / EXCEPT / INTERSECT, priorité d'INTERSECT, colonnes compatibles, doublons, VALUES | vérifié (page lue en entier) | [IBM 7.5 : fullselect](https://www.ibm.com/docs/en/i/7.5.0?topic=queries-fullselect) |
| Restrictions : EXCEPT/INTERSECT/VALUES refusés avec table distribuée, trigger de lecture, LF multi-membres | vérifié | idem |
| Liste des types de jointures et exemples | non vérifié (page FROM non lue) ; connaissance générale SQL | à lire sur ibm.com |
| LF de jointure vs vue SQL | vérifié (titre de rubrique lu) | [job-i LF](https://job-i.fr/fichier-logique-lf-ibm-i) |

### 3. Manipuler : INSERT, UPDATE, DELETE, MERGE

```sql
INSERT INTO client (num, nom) VALUES (101, 'DUPONT');
INSERT INTO client_archive SELECT * FROM client WHERE actif = 'N';

UPDATE client SET nom = UPPER(nom) WHERE num = 101;

DELETE FROM client WHERE actif = 'N';

MERGE INTO client c
USING (VALUES (101, 'DUPONT')) AS s (num, nom)
   ON c.num = s.num
 WHEN MATCHED THEN UPDATE SET c.nom = s.nom
 WHEN NOT MATCHED THEN INSERT (num, nom) VALUES (s.num, s.nom);
```

Points retenus de la documentation :

- **UPDATE** : la cible ne peut pas être une table d'historique, une table du catalogue ni une vue en lecture seule ; une colonne ne peut figurer qu'une fois dans le SET ; `OVERRIDING SYSTEM VALUE / USER VALUE` règle le sort des colonnes identity / ROWID / row change timestamp `GENERATED ALWAYS`.
- **MERGE** : jointure logique cible/source sur `ON` ; `WHEN MATCHED` n'accepte que UPDATE, DELETE ou SIGNAL ; `WHEN NOT MATCHED` n'accepte que INSERT ou SIGNAL ; les conditions `WHEN` sont évaluées dans l'ordre et une ligne traitée par l'une n'est plus considérée par les suivantes ; source vide = avertissement ; la recherche `ON` n'accepte ni IN avec sous-sélection, ni EXISTS, ni fonction non déterministe.
- Équivalent RPG : `UPDATE` et `DELETE` (job-i, `/instructions-rpg/update` et `/instructions-rpg/delete`) agissent sur des fichiers, pas en SQL (à ne pas confondre).

| Élément | Statut | Source |
|---|---|---|
| UPDATE : cibles interdites, OVERRIDING, colonne unique dans le SET | vérifié **partiellement** (début de la section Description seulement) | [IBM 7.5 : UPDATE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-update) |
| MERGE : ON, MATCHED / NOT MATCHED, ordre des WHEN, restrictions de ON | vérifié **partiellement** (début de la section Description seulement) | [IBM 7.5 : MERGE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-merge) |
| INSERT, DELETE (syntaxe) | non vérifié (pages IBM existantes, non lues pour ce cours) | [INSERT](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-insert) · [DELETE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-delete) |
| Exemples ci-dessus | hypothèse (non exécutés) | à tester |
| Instructions RPG UPDATE / DELETE | pages job-i existantes (non relues ici) | [UPDATE](https://job-i.fr/instructions-rpg/update) · [DELETE](https://job-i.fr/instructions-rpg/delete) |

### 4. Définir : CREATE TABLE, INDEX, VIEW

```sql
CREATE OR REPLACE TABLE client (
  num INTEGER NOT NULL PRIMARY KEY,
  nom VARCHAR(40) NOT NULL,
  actif CHAR(1) DEFAULT 'O'
) RCDFMT CLIENTR;

CREATE INDEX client_nom_ix ON client (nom);

CREATE OR REPLACE VIEW client_actif AS
  SELECT num, nom FROM client WHERE actif = 'O';
```

**CREATE INDEX** (lu) : `UNIQUE` refuse les doublons (tous les NULL sont égaux), `UNIQUE WHERE NOT NULL` accepte plusieurs NULL ; `ENCODED VECTOR` crée un EVI (index d'aide à l'optimiseur, qui ne garantit aucun ordre) ; au plus **120 clés** et 32766 octets cumulés (moins 1 par clé nullable) ; les clés peuvent être des **expressions** (liste d'exclusions : sous-requêtes, fonctions non déterministes, plusieurs fonctions comme `REPLACE`, `RPAD`, `HASH`…) ; `ASC`/`DESC` ; `WHERE` crée un index **partiel** ; `FOR SYSTEM NAME` donne le nom système (sinon un nom est généré si le nom long est invalide) ; pas de colonne LOB/XML/DATALINK.

**CREATE VIEW** (lu) : `OR REPLACE` remplace sans perdre les droits (mais pas un LF DDS) ; `RECURSIVE` pour les vues récursives (nomenclatures) avec `UNION ALL` obligatoire et liste de colonnes si les noms ne sont pas déjà définis ; **ORDER BY, FETCH et OFFSET interdits** dans le fullselect externe de la vue ; max **8000 colonnes** et **256 tables** de base ; `WITH CASCADED | LOCAL CHECK OPTION` oblige les lignes insérées/modifiées à rester visibles par la vue (interdit sur vue en lecture seule).

| Élément | Statut | Source |
|---|---|---|
| CREATE INDEX : UNIQUE, WHERE NOT NULL, EVI, limites 120 clés / 32766 octets, expressions, WHERE partiel | vérifié **partiellement** (début de la Description, jusqu'au WHERE) | [IBM 7.5 : CREATE INDEX](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-create-index) |
| CREATE VIEW : OR REPLACE, RECURSIVE, ORDER BY interdit, limites 8000 / 256, CHECK OPTION | vérifié **partiellement** (début de la Description) | [IBM 7.5 : CREATE VIEW](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-create-view) |
| CREATE TABLE : clause `RCDFMT`, `PRIMARY KEY`, `OR REPLACE` | non vérifié (page existante, non lue ; exemple = hypothèse) | [IBM 7.5 : CREATE TABLE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-create-table) |
| ALTER TABLE | non vérifié | [IBM 7.5 : ALTER TABLE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-alter-table) |
| PF DDS vs table SQL, LF vs index/vue | vérifié (rubriques lues) | [job-i PF](https://job-i.fr/fichier-physique-pf-ibm-i) · [job-i LF](https://job-i.fr/fichier-logique-lf-ibm-i) |

### 5. Performances

Les outils à connaître (liste issue du plan, contenu **non relu** pour ce cours) : conseiller d'index (index advisor), plan de requête, `STRDBMON` (moniteur de base de données, [job-i](https://job-i.fr/commandes-ibm-i/strdbmon)), index (y compris EVI, voir section 4). Règle pratique : un index se justifie par les requêtes réelles ; la documentation IBM précise qu'un EVI ne sert qu'à l'optimiseur.

| Élément | Statut | Source |
|---|---|---|
| EVI sans ordre garanti, aide à l'optimiseur | vérifié | page CREATE INDEX ci-dessus |
| STRDBMON, index advisor, plan d'exécution | non vérifié (pages non lues) | pistes IBM : [Index advisor 7.4](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzajq/idxadvisor.htm) · [Optimisation 7.1](https://www.ibm.com/docs/ssw_ibm_i_71/rzajq/queryopt.htm) |

### 6. Objets programmables : triggers, procédures, fonctions

**CREATE TRIGGER** (lu partiellement) :

```sql
CREATE OR REPLACE TRIGGER client_maj
  AFTER UPDATE OF nom ON client
  REFERENCING OLD ROW AS o NEW ROW AS n
  FOR EACH ROW MODE DB2ROW
  WHEN (o.nom <> n.nom)
  BEGIN
    INSERT INTO client_histo VALUES (n.num, o.nom, n.nom, CURRENT TIMESTAMP);
  END;
```

- Moments : `BEFORE` (avant l'écriture, peut modifier `NEW` avec SET, sans mise à jour d'autre table), `AFTER`, `INSTEAD OF` (sur **vue** uniquement, pas de WHEN, un seul par opération).
- Événements : `INSERT`, `DELETE`, `UPDATE [OF colonnes]` (chacun une seule fois).
- `FOR EACH ROW` (une exécution par ligne) ou `FOR EACH STATEMENT` (jamais pour BEFORE ni INSTEAD OF).
- Variables de transition : `OLD ROW` (NULL à l'insertion), `NEW ROW` (NULL à la suppression), `OLD TABLE` / `NEW TABLE` (tables temporaires en lecture seule) ; `OLD`/`NEW` modifiables seulement en BEFORE.
- Restrictions : pas de trigger DELETE sur table avec `ON DELETE CASCADE`, pas d'UPDATE sur table avec `ON DELETE SET NULL/DEFAULT` ; table QTEMP interdite ; `OR REPLACE` conserve les droits.
- Droits : créer dans le schéma, ALTER et SELECT sur la table, et *USE sur `ADDPFTRG` et `CRTPGM`.
- Alternative « système » : commande `ADDPFTRG` avec un programme ([job-i](https://job-i.fr/commandes-ibm-i/addpftrg)).

**Procédures et fonctions SQL (SQL PL)** : `CREATE PROCEDURE` / `CREATE FUNCTION` en langage SQL (variables, `IF`, `WHILE`, curseurs, gestionnaires). Contenu **non lu** : voir les pistes IBM de cette page et le Redbook SG24-8326.

| Élément | Statut | Source |
|---|---|---|
| BEFORE/AFTER/INSTEAD OF, événements, FOR EACH ROW/STATEMENT, REFERENCING, restrictions, droits | vérifié **partiellement** (premiers ~15 000 caractères de la page) | [IBM 7.5 : CREATE TRIGGER](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-create-trigger) |
| Corps du trigger (instructions autorisées, MODE, SET OPTION, programme externe) | liste des instructions lue ; descriptions non lues | idem |
| Exemple de trigger | hypothèse (non compilé) | à tester |
| ADDPFTRG | page job-i existante, non relue | [job-i](https://job-i.fr/commandes-ibm-i/addpftrg) |
| CREATE PROCEDURE / FUNCTION, SQL PL | non vérifié | [SQL PL 7.6](https://www.ibm.com/docs/en/ssw_ibm_i_76/db2/rbafzsqlpl.htm) · [Redbook SG24-8326](https://redbooks.ibm.com/abstracts/sg248326.html) |

### 7. Interfaces SQL sur IBM i

`STRSQL` (session interactive), `RUNSQLSTM` (script source), `RUNSQL` (une instruction), ACS « Exécuter des scripts SQL » et le SQL embarqué en RPG ([fiche 07](../cheatsheets/07-sql-embarque-en-rpg.md), [partie 09](09-sql-embarque.md)). Pages job-i : [STRSQL](https://job-i.fr/commandes-ibm-i/strsql) · [RUNSQLSTM](https://job-i.fr/commandes-ibm-i/runsqlstm) · [RUNSQL](https://job-i.fr/commandes-ibm-i/runsql). Statut : existence vérifiée le 2026-11-23, contenu non relu pour ce cours. Les **services SQL** (`QSYS2.*`) se consultent dans le [catalogue job-i](https://job-i.fr/services-sql-ibm-i) et la [fiche 04](../cheatsheets/04-db2-for-i-et-sql.md).

### Ce qui reste à vérifier pour cette partie

FROM/jointures, WHERE, GROUP BY, INSERT, DELETE, CREATE TABLE, ALTER TABLE (pages IBM non lues) ; fin des pages UPDATE, MERGE, CREATE INDEX, CREATE VIEW, CREATE TRIGGER ; procédures/fonctions SQL ; outils de performance ; tous les exemples SQL à exécuter. Aucune page job-i dédiée aux jointures, sous-requêtes, INSERT/MERGE, CREATE TRIGGER/PROCEDURE/FUNCTION : manques à signaler.

## Plan détaillé (index des sujets)

### Introduction

- **Dans le wiki** : [Fiche 04](../cheatsheets/04-db2-for-i-et-sql.md)

#### Présentation du langage SQL

- **Dans le wiki** : [Fiche 04](../cheatsheets/04-db2-for-i-et-sql.md)
- **job-i** : [Recettes SQL d'exploitation IBM i et AS/400](https://job-i.fr/recettes-sql-ibm-i) · [Services SQL IBM i et AS/400 (QSYS2, SYSTOOLS)](https://job-i.fr/services-sql-ibm-i)

#### Les interfaces SQL sur l'IBM i

- **job-i** : [STRSQL](https://job-i.fr/commandes-ibm-i/strsql) · [RUNSQLSTM](https://job-i.fr/commandes-ibm-i/runsqlstm) · [RUNSQL](https://job-i.fr/commandes-ibm-i/runsql)

### Le langage et l'interrogation des données

- **Dans le wiki** : [Recettes SQL (fiche 04)](../cheatsheets/04-db2-for-i-et-sql.md)

#### Les bases du langage

- **job-i** : [SELECT](https://job-i.fr/commandes-ibm-i/select) · [Recettes SQL d'exploitation IBM i et AS/400](https://job-i.fr/recettes-sql-ibm-i)

#### Union et jointures

- **job-i** : [Recettes SQL d'exploitation IBM i et AS/400](https://job-i.fr/recettes-sql-ibm-i)

#### Sous-requêtes

- **job-i** : [IN](https://job-i.fr/instructions-rpg/in) · [Recettes SQL d'exploitation IBM i et AS/400](https://job-i.fr/recettes-sql-ibm-i)

### La manipulation des données

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Insertion, mises à jour, modifications

- **job-i** : [UPDATE](https://job-i.fr/instructions-rpg/update) · [DELETE](https://job-i.fr/instructions-rpg/delete)

### La définition des objets

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Création et modification des objets

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Les performances

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Analyse et optimisation des requêtes

- **job-i** : [STRDBMON](https://job-i.fr/commandes-ibm-i/strdbmon)

### Les objets programmables

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Les triggers

- **job-i** : [ADDPFTRG](https://job-i.fr/commandes-ibm-i/addpftrg)

#### Les procédures stockées

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les fonctions

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).
