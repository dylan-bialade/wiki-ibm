# SQL avancé : JSON, écriture dans l'IFS, SQL embarqué (FETCH multi-lignes)

> Pages **lues en entier sur ibm.com le 2026-11-23** (IBM Documentation, IBM i 7.5, versions françaises traduites automatiquement sauf FETCH, en anglais). Synthèse personnelle, pas de copie longue. Chaque partie commence par son tableau `Élément | Statut | Source`. **Aucun exemple n'a été exécuté** : ils sont à tester sur la machine.

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](SOMMAIRE.md))

- [Partie 1 : SQL JSON (Db2 for i 7.5)](#partie-1--sql-json-db2-for-i-75)
  - [Points à retenir](#points-à-retenir)
  - [Exemple (proposé, non exécuté)](#exemple-proposé-non-exécuté)
- [Partie 2 : écrire dans l'IFS depuis SQL (`QSYS2.IFS_WRITE_UTF8`)](#partie-2--écrire-dans-lifs-depuis-sql-qsys2ifs_write_utf8)
  - [Points à retenir](#points-à-retenir-1)
- [Partie 3 : SQL embarqué en RPG (FETCH multi-lignes et options)](#partie-3--sql-embarqué-en-rpg-fetch-multi-lignes-et-options)
  - [Forme (d'après la syntaxe officielle, non exécutée)](#forme-daprès-la-syntaxe-officielle-non-exécutée)
<!-- TOC:END -->

## Partie 1 : SQL JSON (Db2 for i 7.5)

| Élément | Statut | Source |
|---|---|---|
| `JSON_OBJECT` : paires `KEY … VALUE …` ou `'clé' : valeur`, `NULL ON NULL` (défaut) / `ABSENT ON NULL`, `WITH` / `WITHOUT UNIQUE KEYS` (défaut sans), `RETURNING` (défaut `CLOB(2G) CCSID 1208`) | vérifié | [JSON_OBJECT, 7.5](https://www.ibm.com/docs/fr/i/7.5?topic=functions-json-object) |
| `JSON_ARRAYAGG` : tableau JSON à partir d'un ensemble de valeurs, `ORDER BY` interne, `ABSENT ON NULL` (défaut) / `NULL ON NULL`, résultat `NULL` si l'ensemble est vide | vérifié | [JSON_ARRAYAGG, 7.5](https://www.ibm.com/docs/fr/i/7.5?topic=functions-json-arrayagg) |
| `FORMAT JSON` : sans lui, une chaîne est mise entre guillemets et ses caractères spéciaux sont échappés ; avec lui (ou si l'expression est elle-même un `JSON_OBJECT` / `JSON_ARRAYAGG`…), elle est traitée comme du JSON déjà formé | vérifié | pages `JSON_OBJECT` et `JSON_ARRAYAGG` |
| Exemple `JSON_ARRAYAGG(JSON_OBJECT(…) ORDER BY …)` avec `GROUP BY` | vérifié (existence de la forme) | exemple de la page `JSON_ARRAYAGG` |
| `CAST(… AS VARCHAR(30000))` d'un résultat `CLOB` | **compilé** (confirmé par l'utilisateur, exemple de la page ILE) ; résultat à l'exécution non confirmé ; page `CAST` non lue | [ILE-ET-SERVICES-WEB](ILE-ET-SERVICES-WEB.md) |
| Identifiant `"NUMBER"` entre guillemets | **compilé** (confirmé par l'utilisateur) ; règles des identifiants non lues | idem |
| Exemple ci-dessous | **non exécuté** | — |

### Points à retenir
- **`JSON_OBJECT`** : `JSON_OBJECT('prenom' : 'Jean', 'ville' : 'Lyon')` ou `JSON_OBJECT(KEY 'prenom' VALUE 'Jean', …)`. Avec la forme `:` (deux-points), le nom de clé doit être un **littéral** chaîne. Le nom de clé ne peut pas être `NULL`. La valeur peut être de tout type intégré sauf `XML`, `ROWID`, `DATALINK` (et pas de `CHAR`/`VARCHAR` binaire).
- **`NULL ON NULL`** (défaut de `JSON_OBJECT`) écrit `null` pour une valeur nulle ; `ABSENT ON NULL` omet la paire. Pour `JSON_ARRAYAGG` c'est l'inverse : **`ABSENT ON NULL` est le défaut**.
- **Taille du résultat** : `CLOB(2G) CCSID 1208` par défaut. Pour récupérer le texte dans une variable RPG, il faut un type compatible ; la conversion `CAST` n'est pas vérifiée ici.
- **Imbrication** : mettre un `JSON_OBJECT` dans un `JSON_ARRAYAGG` ne l'échappe pas (le format est celui de la clause `RETURNING` de la fonction interne). Pour y mettre un texte **déjà JSON**, ajouter `FORMAT JSON` ; sinon le texte est traité comme une simple chaîne (guillemets et caractères échappés).
- **Résultat nul** : `JSON_ARRAYAGG` renvoie `NULL` sur un ensemble vide : prévoir un indicateur de nullité en SQL embarqué.

### Exemple (proposé, non exécuté)
```sql
SELECT CAST(JSON_ARRAYAGG(JSON_OBJECT('nom' : TRIM(nom), 'prix' : prix)
                          ORDER BY "NUMBER") AS VARCHAR(30000))
  INTO :w_json :ind_json
  FROM BIBnn.bonbon;
```
Remplacer `BIBnn` par ta bibliothèque. Trois points à valider : la conversion `CAST` en `VARCHAR`, la longueur 30000 (un tableau plus long est tronqué ou provoque une erreur, non vérifié), et l'identifiant `"NUMBER"`.

## Partie 2 : écrire dans l'IFS depuis SQL (`QSYS2.IFS_WRITE_UTF8`)

| Élément | Statut | Source |
|---|---|---|
| Schéma `QSYS2` ; paramètres `PATH_NAME`, `LINE`, `FILE_CCSID`, `OVERWRITE`, `END_OF_LINE` | vérifié | [IFS_WRITE, IFS_WRITE_BINARY, IFS_WRITE_UTF8, 7.5](https://www.ibm.com/docs/fr/i/7.5.0?topic=is-ifs-write-ifs-write-binary-ifs-write-utf8-procedures) |
| `FILE_CCSID` : défaut **1208** pour `IFS_WRITE_UTF8` (0 = CCSID du travail pour `IFS_WRITE` et `IFS_WRITE_BINARY`) ; ignoré si on ajoute à un fichier existant | vérifié | idem |
| `OVERWRITE` : `APPEND` (défaut, crée le fichier s'il n'existe pas), `REPLACE` (supprime et recrée, le CCSID peut changer), `NONE` (échec si le fichier existe) | vérifié | idem |
| `END_OF_LINE` : `CR`, `CRLF` (défaut de `IFS_WRITE` et `IFS_WRITE_UTF8`), `LF`, `LFCR`, `NONE` (défaut de `IFS_WRITE_BINARY`) | vérifié | idem |
| Droits : `*X` sur chaque répertoire du chemin, `*W` sur le fichier existant, `*WX` sur le répertoire parent pour créer ou remplacer | vérifié (hors `QSYS.LIB`) | idem |
| Taille : jusqu'à 2 Go par appel | vérifié | idem |

### Points à retenir
- `IFS_WRITE_UTF8` reçoit une chaîne **UTF-8** ; si le fichier n'est pas en UTF-8, elle est convertie au CCSID du fichier.
- Les trois procédures s'appellent par `CALL QSYS2.IFS_WRITE_UTF8(PATH_NAME => '…', LINE => '…', OVERWRITE => 'REPLACE', END_OF_LINE => 'LF')`.
- **Piège** : le défaut est `APPEND` et la fin de ligne par défaut est **`CRLF`** : pour un fichier texte Unix, passer `END_OF_LINE => 'LF'`.
- Un fichier créé reprend les droits par défaut de son répertoire parent.
- `QSYS2.IFS_READ` relit le fichier généré (cité par l'exemple de la page).
- Le wiki ne citait ce service que comme « utilisé mais absent des fiches » (`docs/MANQUES.md`).

## Partie 3 : SQL embarqué en RPG (FETCH multi-lignes et options)

| Élément | Statut | Source |
|---|---|---|
| `FETCH … FOR n ROWS INTO tableau-de-structures-hôtes` (n entier ou variable numérique d'échelle zéro, sans indicateur) | vérifié | [FETCH, 7.5](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-fetch) |
| Le nombre de lignes demandé doit être inférieur ou égal à la dimension du tableau ; taille totale des lignes (hors LOB) < 16 M | vérifié | idem |
| `SQLERRD(3)` = nombre de lignes lues ; `SQLERRD(5)` = +100 si la dernière ligne a été lue (peut ne pas l'être quand le nombre de lignes lues égale le nombre demandé) | vérifié | idem |
| Multi-lignes interdit si une colonne est un LOB ou si la connexion est distante | vérifié | idem |
| `FETCH … INTO` d'une structure hôte (une ligne) : une structure équivaut à la liste de ses variables | vérifié | idem (single-fetch) |
| Colonne `NULL` : indicateur obligatoire ; erreur de calcul ou de conversion = valeur nulle et indicateur à -2 | vérifié | idem |
| Chaîne trop courte : avertissement SQLSTATE 01004 (`SQLWARN1` = `W`), longueur réelle dans l'indicateur s'il y en a un | vérifié | idem |
| Boucle `WHILE (SQLCODE == 0)` suivie d'un `FETCH` ; condition « not found » quand il n'y a plus de ligne | vérifié (forme de l'exemple 1) | idem |
| `SQLCODE` 100 et `-501` (curseur non ouvert) | **non vérifié** (seulement des sources non officielles) | — |
| `SET OPTION COMMIT = *NONE`, `CLOSQLCSR = *ENDMOD` dans un module `NOMAIN` | **non vérifié** | page `SET OPTION` non lue |
| `CLEAR` sur un tableau `*VARSIZE` ; `CLOSE` avant `OPEN` | **non vérifié** | — |

### Forme (d'après la syntaxe officielle, non exécutée)
```rpgle
DCL-DS article QUALIFIED TEMPLATE;
  nom  CHAR(30);
  prix PACKED(7:2);
END-DS;
DCL-DS lignes LIKEDS(article) DIM(100);
DCL-S nb INT(10);

EXEC SQL FETCH NEXT FROM c1 FOR 100 ROWS INTO :lignes;
nb = SQLERRD(3);        // nombre de lignes réellement lues (nom de la zone SQLCA en RPG : à confirmer à la compilation)
```
- L'ordre et les types des zones de la structure doivent suivre ceux des colonnes du `SELECT`.
- Utiliser `nb` (et non la dimension du tableau) pour parcourir le résultat.
- Le `FETCH` d'une structure simple (une ligne) suit la même règle : `FETCH c1 INTO :uneStructure`.
- Les points non vérifiés ci-dessus (voir le tableau) doivent être contrôlés avant d'être présentés comme acquis.
