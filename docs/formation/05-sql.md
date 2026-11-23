# Partie 05 : Le langage SQL sur IBM i

> Plan de formation, partie 05 sur 14. Présentation et interfaces SQL, interrogation (jointures, unions, sous-requêtes), manipulation, définition, performances, objets programmables (triggers, procédures, fonctions).
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
- [Plan détaillé](#plan-détaillé)
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

## Plan détaillé

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
