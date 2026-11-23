# Partie 09 : SQL embarqué en RPG

> Plan de formation, partie 09 sur 14. EXEC SQL, SQLRPGLE, variables hôtes, SQLCODE et SQLSTATE, curseurs, mises à jour positionnées et ensemblistes, SQL dynamique, accès natif contre SQL.
>
> **Mots-clés** : EXEC SQL, SQLRPGLE, CRTSQLRPGI, variable hôte, SQLCODE, SQLSTATE, GET DIAGNOSTICS, DECLARE CURSOR, OPEN, FETCH, CLOSE, PREPARE, EXECUTE, FOR n ROWS.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pistes IBM](#pistes-ibm)
- [Plan détaillé](#plan-détaillé)
  - [Le SQL embarqué](#le-sql-embarqué)
  - [De l'accès natif à l'accès SQL](#de-laccès-natif-à-laccès-sql)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 07 : SQL embarqué en RPG](../cheatsheets/07-sql-embarque-en-rpg.md)
- [SQL avancé : FETCH multi-lignes, JSON](../SQL-AVANCE.md#partie-3--sql-embarqué-en-rpg-fetch-multi-lignes-et-options)
- [Exemple SQL + impression (SQLIMPRIME)](../IMPRESSION-RPG.md)

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

## Plan détaillé

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
