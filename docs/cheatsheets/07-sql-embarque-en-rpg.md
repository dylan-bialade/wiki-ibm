# 07 - SQL embarqué en RPG et exécution de SQL

> Source : [job-i.fr](https://job-i.fr/). Blocs `AUTO` régénérés ; écrivez dans « Mes exemples ». **job-i.fr n'a aucune page sur `EXEC SQL`, les curseurs, `SQLCODE` / `SQLSTATE`** (vérifié dans le plan du site le 17/11/2026) : ces points viennent donc de vos propres sources (« constat dans le code »), à confirmer dans la documentation IBM.

<!-- AUTO:START -->

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Compiler un source RPG contenant du SQL : CRTSQLRPGI  (source)](#compiler-un-source-rpg-contenant-du-sql--crtsqlrpgi--source)
- [Exécuter une instruction SQL : RUNSQL  (source)](#exécuter-une-instruction-sql--runsql--source)
- [Exécuter un script SQL : RUNSQLSTM  (source)](#exécuter-un-script-sql--runsqlstm--source)
- [Mes exemples](#mes-exemples)
<!-- TOC:END -->

## Compiler un source RPG contenant du SQL : CRTSQLRPGI  ([source](https://job-i.fr/commandes-ibm-i/crtsqlrpgi))
- Lance le **précompilateur SQL** sur le source RPG, crée un membre temporaire, puis appelle le compilateur ILE RPG pour produire un programme, un module ou un programme de service.
- Paramètres : `OBJ` (obligatoire), `SRCFILE` / `SRCMBR` (défaut `QRPGLESRC`), `SRCSTMF` (source dans l'IFS), `COMMIT`, `OBJTYPE` (`*PGM`, `*SRVPGM`, `*MODULE`), `OUTPUT` (`*PRINT` pour la liste), `DBGVIEW`, `REPLACE` (`*YES` par défaut), `COMPILEOPT`, `RPGPPOPT`.
- Pièges : si le précompilateur dépasse la gravité `GENLVL` (10 par défaut), le compilateur n'est pas appelé ; avec `SRCSTMF`, les `/COPY` ne sont pas développés sans `RPGPPOPT` ; `*SRVPGM` exige un membre de même nom dans `QSRVSRC` ; `COMMIT(*NONE)` obligatoire si le programme contient `DROP SCHEMA`.

## Exécuter une instruction SQL : RUNSQL  ([source](https://job-i.fr/commandes-ibm-i/runsql))
- Exécute **une** instruction (paramètre `SQL`, 5 000 octets maximum) en session 5250 ou dans un CL. Paramètres utiles : `COMMIT`, `NAMING` (`*SYS` bibliothèque/fichier, `*SQL` schéma.table), formats de date et d'heure.
- Pièges : les erreurs remontent en message d'arrêt `SQLxxxx` (pas de spool) ; les erreurs de syntaxe ne sont vues qu'à l'exécution ; en CL, apostrophes doublées (`''`) et concaténation `!!` ; `DROP SCHEMA` impose `COMMIT(*NONE)` ; la page est ambiguë sur le contrôle de validation par défaut : vérifier avant de compter sur un `COMMIT` implicite.

## Exécuter un script SQL : RUNSQLSTM  ([source](https://job-i.fr/commandes-ibm-i/runsqlstm))
- Traite un **fichier source** (`SRCFILE` / `SRCMBR`) ou un fichier de l'IFS (`SRCSTMF`, marges ignorées). Paramètres : `COMMIT` (défaut `*CHG`), `NAMING`, `ERRLVL` (gravité maximale tolérée, 10 par défaut : au-delà, on s'arrête), `MARGINS` (80), `OUTPUT`, `DFTRDBCOL` (schéma par défaut, SQL statique seulement).
- Pièges : le fichier imprimante doit faire **au moins 132 octets** ; s'exécute dans le groupe d'activation par défaut ; messages à connaître : `SQL9006`, `SQL9010` (échec de RUNSQLSTM ou RUNSQL), `SQL9014`.
<!-- AUTO:END -->

## Mes exemples
- **Squelette d'un programme avec curseur** (constat dans le code, full free) : `ctl-opt dftactgrp(*no) actgrp(*caller);` puis `exec sql set option commit = *none;`, `exec sql declare c1 cursor for select … from …;`, `exec sql open c1;`, `exec sql fetch c1 into :v1, :v2;`, boucle `dow sqlcode = 0; … fetch … enddo;`, `exec sql close c1;`, `*inlr = *on;`. Variables hôtes précédées de `:` et déclarées avec un type compatible (`zoned`, `char`). Exemples : [T3](../../sources/RPG/RPG-ILE/BIB02/T3.md) (le plus court), [CURSEUR](../../sources/RPG/RPG-ILE/BIB05/CURSEUR.md) (avec `SET OPTION` complet et écriture dans la joblog), [ALLSTUDENT](../../sources/RPG/RPG-ILE/BIB02/ALLSTUDENT.md), [SFGPT](../../sources/RPG/RPG-ILE/BIB02/SFGPT.md).
- **Code retour** : `sqlcode` (T3) ou `sqlcod` (CURSEUR) testés après `fetch` ; `0` = succès, comme dans les exemples. Les valeurs et `SQLSTATE` ne sont documentés nulle part dans le wiki.
- **Message d'erreur SQL** : `exec sql get diagnostics condition 1 :msg = message_text;` ([ERRSQL](../../sources/RPG/RPG-ILE/BIB02/ERRSQL.md), [CODPOS](../../sources/RPG/RPG-ILE/BIB01/CODPOS.md)) ; **transactions** : `COMMIT` (133 occurrences dans vos sources) et `ROLLBACK` ([MOD_API](../../sources/RPG/RPG-ILE/BIB02/MOD_API.md)).
- **Où se trouve le plus de SQL embarqué** : 52 sources dans une seule bibliothèque (`BIB02`), 23 dans `BIB05`, 8 dans `BIB20`.
- **Énoncé qui l'exige** : [tp-le-chai](../enonces/tp-le-chai.md) (curseurs, transaction « tout ou rien », contrôle de validation).
- **Notions SQL présentes dans votre code et absentes des fiches** : `COALESCE`, `GROUP BY`, `DISTINCT`, `CURRENT DATE - n MONTHS`, jointures externes ; voir [MANQUES](../MANQUES.md) et [ANALYSE-ENONCES](../enonces/ANALYSE-ENONCES.md). Les services SQL et les recettes d'exploitation restent dans la [fiche 04](04-db2-for-i-et-sql.md).
- **À confirmer** : le type de membre source à utiliser (`SQLRPGLE`) et la commande exacte utilisée par votre éditeur pour compiler (CRTSQLRPGI ci-dessus) ; la page job-i ne parle pas de la convention de nommage du type.
