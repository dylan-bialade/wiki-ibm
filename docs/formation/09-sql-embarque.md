# Partie 09 : SQL embarqué en RPG

> Plan de formation, partie 09 sur 14 (**partie rédigée** : cours détaillé ci-dessous). EXEC SQL, SQLRPGLE, variables hôtes, SQLCODE et SQLSTATE, curseurs, mises à jour positionnées et ensemblistes, SQL dynamique, accès natif contre SQL.
>
> **Mots-clés** : EXEC SQL, SQLRPGLE, CRTSQLRPGI, variable hôte, SQLCODE, SQLSTATE, GET DIAGNOSTICS, DECLARE CURSOR, OPEN, FETCH, CLOSE, PREPARE, EXECUTE, FOR n ROWS.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pistes IBM](#pistes-ibm)
- [Cours détaillé](#cours-détaillé)
  - [1. EXEC SQL et compilation](#1-exec-sql-et-compilation)
  - [2. Variables hôtes et structures d'accueil](#2-variables-hôtes-et-structures-daccueil)
  - [3. SQLCODE, SQLSTATE et GET DIAGNOSTICS](#3-sqlcode-sqlstate-et-get-diagnostics)
  - [4. Les curseurs : DECLARE, OPEN, FETCH, CLOSE](#4-les-curseurs--declare-open-fetch-close)
  - [5. Mises à jour positionnées et ensemblistes](#5-mises-à-jour-positionnées-et-ensemblistes)
  - [6. SQL dynamique : PREPARE, EXECUTE, EXECUTE IMMEDIATE](#6-sql-dynamique--prepare-execute-execute-immediate)
  - [7. Accès natif ou accès SQL](#7-accès-natif-ou-accès-sql)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Le SQL embarqué](#le-sql-embarqué)
  - [De l'accès natif à l'accès SQL](#de-laccès-natif-à-laccès-sql)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 07 : SQL embarqué en RPG](../cheatsheets/07-sql-embarque-en-rpg.md)
- [SQL avancé : FETCH multi-lignes, JSON](../SQL-AVANCE.md#partie-3--sql-embarqué-en-rpg-fetch-multi-lignes-et-options)
- [Exemple SQL + impression (SQLIMPRIME)](../IMPRESSION-RPG.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## L'essentiel (vérifié dans le wiki)

- **FETCH multi-lignes** : `FETCH … FOR n ROWS INTO tableau_de_structures` ; `SQLERRD(3)` = lignes lues ; interdit avec des LOB ou une connexion distante ; le nombre de lignes ≤ dimension du tableau (vérifié sur ibm.com 7.5, [SQL avancé](../SQL-AVANCE.md#partie-3--sql-embarqué-en-rpg-fetch-multi-lignes-et-options)).
- **FETCH INTO d'une structure** (une ligne) : valide, la structure équivaut à la liste de ses variables.
- **Exemples compilés** : liste JSON `bonbon_list_json` ([ILE-ET-SERVICES-WEB](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)) ; non compilé : [SQLIMPRIME](../IMPRESSION-RPG.md).

## Pistes IBM

Issues de recherches ibm.com du 2026-11-23 : les pages sans mention « lu » **ne sont pas lues** ; la version indiquée peut différer de la 7.5 (à vérifier avant de s'en servir).

- [Embedded SQL programming (IBM i 7.5, PDF)](https://www.ibm.com/docs/en/ssw_ibm_i_75/pdf/rzajppdf.pdf)
- [GET DIAGNOSTICS (IBM i 7.3)](https://www.ibm.com/docs/ca/ssw_ibm_i_73/db2/rbafzgetdiag.htm)
- [SQLCODEs and SQLSTATEs (IBM i 7.4)](https://www.ibm.com/docs/ssw_ibm_i_74/ddp/rbal1sqlc.htm)
- [Detecting and processing error and warning conditions (IBM i 7.3)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/db2/rbafzcksql2.htm)
- [FETCH (IBM i 7.5) : lu en entier, voir SQL avancé](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-fetch)

## Cours détaillé

> Synthèses personnelles à partir d'IBM Documentation **IBM i 7.5** (instructions SQL : pages lues en partie, début de la section Description), de la fiche 07 du wiki (aides `CRTSQLRPGI`, `RUNSQL`, `RUNSQLSTM` reproduites par job-i) et de [SQL avancé](../SQL-AVANCE.md). **job-i n'a aucune page sur `EXEC SQL`, les curseurs ni `SQLCODE`/`SQLSTATE`** (constat de la fiche 07). L'assistant ne compile rien : les exemples ci-dessous sont des *hypothèses non compilées* sauf mention contraire.

### 1. EXEC SQL et compilation

Une instruction SQL est écrite dans un source RPG entre `EXEC SQL` et `;` (en libre) ; le source est de type **`SQLRPGLE`** (type de membre à confirmer, voir « à vérifier »). Il se compile par **`CRTSQLRPGI`** (fiche 07) : le **précompilateur SQL** traite le source, crée un membre temporaire, puis appelle le compilateur ILE RPG ; si le précompilateur dépasse la gravité `GENLVL` (10 par défaut), le compilateur n'est pas appelé.

| Paramètre / piège (fiche 07, d'après l'aide de la commande) | Détail |
|---|---|
| `OBJ` (obligatoire), `SRCFILE`/`SRCMBR` (défaut `QRPGLESRC`), `SRCSTMF` | source en fichier source ou dans l'IFS |
| `OBJTYPE` | `*PGM`, `*SRVPGM`, `*MODULE` ; `*SRVPGM` exige un membre de même nom dans `QSRVSRC` |
| `COMMIT` | niveau de contrôle de validation ; `COMMIT(*NONE)` obligatoire si le programme contient `DROP SCHEMA` |
| `OUTPUT(*PRINT)`, `DBGVIEW`, `REPLACE(*YES)`, `COMPILEOPT`, `RPGPPOPT` | liste, débogage, options du compilateur et du préprocesseur |
| `SRCSTMF` | les `/COPY` ne sont pas développés sans `RPGPPOPT` |

**Exécuter du SQL hors programme** (fiche 07) : `RUNSQL` (une instruction, `SQL` jusqu'à 5 000 octets ; erreurs en message d'arrêt `SQLxxxx`) ; `RUNSQLSTM` (script d'un fichier source ou de l'IFS ; `ERRLVL` 10 par défaut, `MARGINS` 80, `COMMIT` défaut `*CHG` ; le fichier imprimante doit faire au moins 132 octets ; messages `SQL9006`, `SQL9010`, `SQL9014`).

**Option de programme** : `exec sql set option commit = *none;` (constat dans les sources de la fiche 07 ; la page `SET OPTION` n'est **pas lue**).

| Élément | Statut | Source |
|---|---|---|
| CRTSQLRPGI : précompilateur → compilateur, GENLVL, SRCSTMF, `*SRVPGM`/`QSRVSRC`, `COMMIT(*NONE)` et `DROP SCHEMA` | vérifié (aide reproduite par job-i, lue dans la fiche 07) | [fiche 07](../cheatsheets/07-sql-embarque-en-rpg.md) · [job-i : CRTSQLRPGI](https://job-i.fr/commandes-ibm-i/crtsqlrpgi) |
| RUNSQL, RUNSQLSTM : paramètres, messages | vérifié (fiche 07) | [RUNSQL](https://job-i.fr/commandes-ibm-i/runsql) · [RUNSQLSTM](https://job-i.fr/commandes-ibm-i/runsqlstm) |
| Type de membre `SQLRPGLE` | vérifié comme valeur de `TYPE` de `STRSEU` (liste lue : `SQLRPGLE`, `SQLRPG`…) ; convention d'usage non confirmée | [job-i : STRSEU](https://job-i.fr/commandes-ibm-i/strseu) |
| `SET OPTION` | **non vérifié** (page IBM non lue) | — |

### 2. Variables hôtes et structures d'accueil

Une **variable hôte** est une variable RPG utilisée dans l'instruction SQL, précédée de `:` (`:v1`). Elle est déclarée avec un type compatible avec la colonne (`zoned`, `packed`, `char`…, constat de la fiche 07). Règles vérifiées sur IBM 7.5 (page FETCH, voir [SQL avancé](../SQL-AVANCE.md#partie-3--sql-embarqué-en-rpg-fetch-multi-lignes-et-options)) :

- une **structure hôte** équivaut à la liste de ses variables (`FETCH c1 INTO :uneStructure`) ; l'ordre et les types suivent ceux des colonnes du `SELECT` ;
- une colonne qui peut être `NULL` exige une **variable indicateur** ; erreur de calcul ou de conversion = valeur nulle, indicateur à −2 ;
- chaîne trop courte : avertissement `SQLSTATE 01004`, `SQLWARN1 = 'W'` ;
- `EXECUTE IMMEDIATE` : la variable doit être de type chaîne de caractères (ou graphique Unicode), sans variable indicateur ; une variable de CCSID 65535 est refusée dans l'expression (page IBM 7.5).

| Élément | Statut | Source |
|---|---|---|
| Structure hôte = liste de variables, indicateurs, avertissement 01004 | vérifié | [SQL avancé, partie 3](../SQL-AVANCE.md#partie-3--sql-embarqué-en-rpg-fetch-multi-lignes-et-options) |
| Compatibilité de types RPG/SQL (table complète) | **non vérifié** (non lue) | [Embedded SQL programming 7.5 (PDF)](https://www.ibm.com/docs/en/ssw_ibm_i_75/pdf/rzajppdf.pdf) à lire |
| `:` devant la variable hôte ; types `zoned`/`char` | constat dans les sources du dépôt (fiche 07) | [fiche 07](../cheatsheets/07-sql-embarque-en-rpg.md) |

### 3. SQLCODE, SQLSTATE et GET DIAGNOSTICS

- **`SQLCODE`** : testé après chaque instruction ; `0` = succès dans les exemples du dépôt (`sqlcode` dans T3, `sqlcod` dans CURSEUR : le nom de la zone dépend de la déclaration de la SQLCA). La valeur `100` (plus de ligne) et `-501` (curseur non ouvert) viennent de sources non officielles : **non vérifiées**.
- **`GET DIAGNOSTICS`** (IBM 7.5) : obtient des informations sur la **dernière instruction SQL exécutée** (hors `GET DIAGNOSTICS`) ; utilisable dans un programme, une fonction, une procédure SQL ou un trigger, pas en interactif ni en SQL dynamique. `CURRENT` (défaut) ou `STACKED` (seulement dans un gestionnaire d'erreur) ; deux familles : *statement-information* et *condition-information* (`CONDITION 1` = condition correspondant au `SQLSTATE` retourné ; 2 à n = autres conditions, la 2 étant la plus ancienne) ; les variables de réception ne peuvent pas être des variables globales ; troncature = avertissement `01004` (statement) ou erreur (condition) ; élément absent = 0, chaîne vide ou blancs.

```
exec sql get diagnostics condition 1 :msg = message_text;
```
*(forme utilisée dans les sources du dépôt ERRSQL et CODPOS, d'après la fiche 07 ; non compilée par moi)*

| Élément | Statut | Source |
|---|---|---|
| GET DIAGNOSTICS : portée, CURRENT/STACKED, CONDITION n, valeurs par défaut, troncature | vérifié **partiellement** (début de la Description) | [IBM 7.5 : GET DIAGNOSTICS](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-get-diagnostics) |
| Liste des éléments (`MESSAGE_TEXT`, `RETURNED_SQLSTATE`, `ROW_COUNT`…) | **non vérifié** (tableau non lu) ; `MESSAGE_TEXT` vu dans un exemple du dépôt | idem |
| SQLCODE 100, −501, table des SQLSTATE | **non vérifié** | [SQLCODEs et SQLSTATEs (7.4)](https://www.ibm.com/docs/ssw_ibm_i_74/ddp/rbal1sqlc.htm) à lire |

### 4. Les curseurs : DECLARE, OPEN, FETCH, CLOSE

Cycle : `DECLARE CURSOR` (non exécutable, uniquement dans un programme) → `OPEN` → `FETCH` en boucle → `CLOSE`.

```
exec sql declare c1 cursor for select nom, ville from client order by nom;
exec sql open c1;
exec sql fetch c1 into :nom, :ville;
dow sqlcode = 0;
   // traiter
   exec sql fetch c1 into :nom, :ville;
enddo;
exec sql close c1;
```
*(squelette du dépôt, fiche 07 « Mes exemples » : constat dans le code ; non compilé par moi ; la table `client` est fictive)*

Points vérifiés sur IBM 7.5 :

- **`DECLARE CURSOR`** : le nom est unique dans le source ; `ASENSITIVE` (défaut), `SENSITIVE`, `INSENSITIVE` (lecture seule, résultat temporaire) ; `NO SCROLL` (défaut) ou `SCROLL` ; `WITHOUT HOLD` (défaut) ou **`WITH HOLD`** (le `COMMIT` ne ferme pas le curseur ; un `FETCH` est requis avant une mise à jour ou suppression positionnée) ; `WITH RETURN` (jeu de résultats d'une procédure) ; un `ROLLBACK` ou un `CONNECT` (type 1) ferme **tous** les curseurs.
- **`OPEN`** : le curseur doit être fermé ; le résultat est évalué avec les valeurs courantes des registres spéciaux et variables ; curseur positionné **avant la première ligne** ; `USING` fournit les valeurs des marqueurs de paramètres `?` d'une instruction préparée (obligatoire si l'instruction en contient).
- **`CLOSE`** : le curseur doit être ouvert ; **fermeture implicite** selon `CLOSQLCSR` (`*ENDPGM`, `*ENDSQL`, `*ENDJOB`, `*ENDMOD`, `*ENDACTGRP`) ; un `COMMIT` sans `HOLD` ferme aussi les curseurs ; IBM recommande de fermer **dès que possible** pour la performance.
- **`FETCH`** : lu en entier ([SQL avancé](../SQL-AVANCE.md#partie-3--sql-embarqué-en-rpg-fetch-multi-lignes-et-options)) ; **multi-lignes** `FETCH … FOR n ROWS INTO tableau_de_structures`, `n` ≤ dimension, `SQLERRD(3)` = lignes lues, interdit avec LOB ou connexion distante.
- Exemples du dépôt : [SQLIMPRIME](../IMPRESSION-RPG.md#9-variante-sql-embarqué--liste-par-univers-avec-rupture) (curseur + impression avec rupture, **non compilé**), `bonbon_list_json` (compilé, [ILE-ET-SERVICES-WEB](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)).

| Élément | Statut | Source |
|---|---|---|
| DECLARE CURSOR : sensibilité, SCROLL, HOLD, RETURN, fermetures implicites | vérifié **partiellement** (début de la Description) | [IBM 7.5 : DECLARE CURSOR](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-declare-cursor) |
| OPEN : état, positionnement, USING | vérifié **partiellement** | [IBM 7.5 : OPEN](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-open) |
| CLOSE : état, CLOSQLCSR, COMMIT, conseil de performance | vérifié **partiellement** | [IBM 7.5 : CLOSE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-close) |
| FETCH (multi-lignes, structure, indicateurs) | vérifié (lu en entier) | [IBM 7.5 : FETCH](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-fetch) |
| Boucle `dow sqlcode = 0` | constat dans le code du dépôt (T3, CURSEUR) ; hypothèse quant à son exactitude générale | [fiche 07](../cheatsheets/07-sql-embarque-en-rpg.md) |
| Variantes `FETCH FIRST/LAST/PRIOR/RELATIVE` pour un curseur `SCROLL` | **non vérifié** | page FETCH, non relue pour ce point |

### 5. Mises à jour positionnées et ensemblistes

- **Positionnée** : `UPDATE table SET colonne = … WHERE CURRENT OF curseur` (syntaxe *Positioned UPDATE* de la page UPDATE 7.5 : `WHERE CURRENT OF cursor-name`) ; si le `SELECT` du curseur a une clause `UPDATE`, chaque colonne du `SET` doit y figurer ; avec `WITH HOLD`, un `FETCH` est requis avant la mise à jour après un `COMMIT` (DECLARE CURSOR). Un curseur `INSENSITIVE` est en lecture seule.
- **Ensembliste** : une instruction `UPDATE … WHERE …`, `DELETE … WHERE …`, `INSERT … SELECT`, `MERGE` traite plusieurs lignes en une opération ([partie 05, § 3](05-sql.md#cours-détaillé)) ; sans boucle de lecture, elle est généralement plus simple qu'un curseur (hypothèse, voir § 7).
- **`SELECT INTO`** pour lire **une** ligne (page `SELECT INTO` non lue).

| Élément | Statut | Source |
|---|---|---|
| UPDATE positionné : syntaxe `WHERE CURRENT OF`, colonnes de la clause UPDATE | vérifié **partiellement** (syntaxe et début de la Description) | [IBM 7.5 : UPDATE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-update) |
| DELETE positionné, SELECT INTO | **non vérifié** | [DELETE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-delete) |
| Écrire plusieurs lignes en une instruction (INSERT SELECT, MERGE) | vérifié (partie 05) | [partie 05](05-sql.md#cours-détaillé) |

### 6. SQL dynamique : PREPARE, EXECUTE, EXECUTE IMMEDIATE

- **`PREPARE nom FROM :chaine`** : crée la forme exécutable d'une instruction écrite sous forme de **chaîne** ; un nom déjà préparé est détruit (sous conditions) ; ne peut pas nommer le SELECT d'un curseur ouvert ; `INTO :sqlda` ou `USING SQL DESCRIPTOR` équivalent à `PREPARE` + `DESCRIBE`. Les **marqueurs de paramètres** (`?`) remplacent les variables.
- **`EXECUTE nom [USING :v1, :v2]`** : exécute l'instruction préparée (qui ne peut pas être un `SELECT`) ; `USING` obligatoire si elle contient des `?` ; le *n*-ième variable correspond au *n*-ième `?` ; une structure hôte est remplacée par ses variables.
- **`EXECUTE IMMEDIATE :chaine`** : prépare **et** exécute ; la chaîne ne doit **pas** commencer par `EXEC SQL`, finir par `END-EXEC` ni `;`, ni contenir de variables ni de marqueurs de paramètres (les variables globales sont permises) ; la liste des instructions admises comprend `ALTER`, `CALL`, `COMMENT`, `COMMIT`, `CREATE`, `DELETE`, `DROP`, `GRANT`, `INSERT`, `MERGE`, `ROLLBACK`, `SET …`, `TRUNCATE`, `UPDATE`… (pas de `SELECT`) ; une erreur de syntaxe n'exécute rien et se lit dans `SQLSTATE`/`SQLCODE`.
- **Curseur dynamique** : `DECLARE c1 CURSOR FOR nomInstruction` après `PREPARE` d'un `SELECT` ; `OPEN c1 USING :v` fournit les valeurs.

```
exec sql prepare s1 from :stmt;
exec sql execute s1 using :valeur;
```
*(forme d'après la syntaxe IBM, non compilée)*

| Élément | Statut | Source |
|---|---|---|
| PREPARE : rôle, INTO/USING DESCRIPTOR, destruction du nom | vérifié **partiellement** | [IBM 7.5 : PREPARE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-prepare) |
| EXECUTE : USING, SELECT interdit, correspondance n-ième variable / ? | vérifié **partiellement** | [IBM 7.5 : EXECUTE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-execute) |
| EXECUTE IMMEDIATE : restrictions de la chaîne, liste d'instructions, erreurs | vérifié **partiellement** | [IBM 7.5 : EXECUTE IMMEDIATE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-execute-immediate) |
| Risques d'injection SQL, validation des saisies | **non vérifié** (aucune source lue) ; prudence : ne jamais concaténer une saisie brute | à sourcer |

### 7. Accès natif ou accès SQL

Deux façons d'accéder aux mêmes fichiers : **natif** (`dcl-f`, `chain`, `setll`, `read`, `update`… voir [partie 06, § 5](06-rpg-iii.md#cours-détaillé)) et **SQL** (`EXEC SQL`). Constats vérifiés : SQL lit et modifie **tous** les fichiers physiques, y compris ceux créés en DDS (job-i, [partie 02](02-db2-for-i.md#cours-détaillé)) ; un `SELECT` sur un LF à clé **n'est pas trié** et seul `ORDER BY` garantit l'ordre ; une table SQL vérifie les données à l'écriture, un PF DDS non. Les critères de choix (performance, volume, simplicité) **ne sont pas documentés dans le wiki** ; ce qui suit est une **hypothèse** à valider : l'accès natif par clé convient à un enregistrement ou une plage de clés (`chain`, `setll` + `reade`), le SQL aux traitements ensemblistes (agrégats, jointures, `INSERT … SELECT`, JSON). Bonnes pratiques d'écriture (hypothèses) : tester le résultat après **chaque** instruction SQL ; fermer les curseurs dès la fin ; nommer explicitement les colonnes plutôt que `SELECT *` ; centraliser les accès SQL dans des procédures.

| Élément | Statut | Source |
|---|---|---|
| SQL accède aux PF/LF DDS ; LF non trié sans ORDER BY ; vérification à l'écriture | vérifié (job-i) | [job-i : PF](https://job-i.fr/fichier-physique-pf-ibm-i) · [LF](https://job-i.fr/fichier-logique-lf-ibm-i) |
| Fermer les curseurs dès que possible (performance) | vérifié | [IBM 7.5 : CLOSE](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-close) |
| Critères natif vs SQL, performance, bonnes pratiques | **hypothèse** | à sourcer (Redbook SG24-8326, docs IBM) |

### Ce qui reste à vérifier pour cette partie

Embedded SQL programming 7.5 (PDF, non ouvert) : types hôtes, déclaration de la SQLCA en RPG, options de précompilation, `SET OPTION` ; table des `SQLCODE`/`SQLSTATE` (100, −501, −811, −803…) ; liste des éléments de `GET DIAGNOSTICS` ; `SELECT INTO`, DELETE positionné, curseurs défilables ; sécurité du SQL dynamique ; critères natif/SQL. Exemples non compilés : squelette de curseur, `SQLIMPRIME`. Manques à signaler : aucune page job-i sur `EXEC SQL`, curseurs, `SQLCODE`/`SQLSTATE`, SQL dynamique.

## Plan détaillé (index des sujets)

### Le SQL embarqué

- **Dans le wiki** : [Fiche 07](../cheatsheets/07-sql-embarque-en-rpg.md)

#### La syntaxe EXEC SQL et la compilation SQLRPGLE

- **Dans le wiki** : [Fiche 07 : CRTSQLRPGI](../cheatsheets/07-sql-embarque-en-rpg.md)
- **job-i** : [CRTSQLRPGI](https://job-i.fr/commandes-ibm-i/crtsqlrpgi)

#### Les variables hôtes et les structures d'accueil

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### SQLCODE, SQLSTATE et la gestion des diagnostics

- **Dans le wiki** : [Fiche 07 : code retour](../cheatsheets/07-sql-embarque-en-rpg.md)
- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les curseurs, DECLARE, OPEN, FETCH, CLOSE

- **Dans le wiki** : [SQL avancé : FETCH multi-lignes](../SQL-AVANCE.md#partie-3--sql-embarqué-en-rpg-fetch-multi-lignes-et-options) · [Exemple SQLIMPRIME (curseur + impression)](../IMPRESSION-RPG.md)
- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les mises à jour positionnées et ensemblistes

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Le SQL dynamique, PREPARE et EXECUTE

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### De l'accès natif à l'accès SQL

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Comparaison accès natif et accès SQL

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les cas où le SQL est plus performant

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les bonnes pratiques d'écriture

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).
