# Partie 02 : Architecture et concepts de DB2 for i

> Plan de formation, partie 02 sur 14. Base de données intégrée, DDS contre SQL, fichiers physiques et logiques, vues, contraintes, sécurité par ligne et colonne, journalisation.
>
> **Mots-clés** : Db2 for i, PF, LF, DDS, SQL, table, index, vue, clé primaire, clé étrangère, contrainte, RCAC, journal, QSYS2.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Pistes IBM](#pistes-ibm)
- [Plan détaillé](#plan-détaillé)
  - [Architecture et concepts de DB2 for i](#architecture-et-concepts-de-db2-for-i)
  - [Les objets de données](#les-objets-de-données)
  - [Les contraintes et l'intégrité](#les-contraintes-et-lintégrité)
  - [Sécurité et journalisation](#sécurité-et-journalisation)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 04 : Db2 for i et SQL](../cheatsheets/04-db2-for-i-et-sql.md)
- [SQL avancé](../SQL-AVANCE.md)

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Fichier physique (PF) IBM i : DDS, CRTPF, UPDDTA et comparaison avec SQL](https://job-i.fr/fichier-physique-pf-ibm-i) | Un PF est l'objet *FILE qui contient les données d'une table (format, enregistrements, clé) ; créé en DDS ou en SQL, lisible en RPG comme en SQL. | En une phrase ; Pourquoi les DDS ont été inventées ; Ce qu'est un PF ; Créer un PF en DDS ; Ajouter, modifier, supprimer avec UPDDTA ; Voir le contenu, et la place des supprimés ; La même table en SQL ; PF DDS et table SQL : les différences démontrées |
| [Fichier logique (LF) IBM i : à quoi ça sert, clé, sélection et jointure](https://job-i.fr/fichier-logique-lf-ibm-i) | Un LF présente les données d'un ou plusieurs PF (ordre, sélection, zones, jointure) sans en contenir ; vu de SQL, équivalent d'une vue ou d'un index. | En une phrase ; Pourquoi les LF existent ; Un autre ordre : la clé ; Une sélection : seulement le type Feu ; La jointure : le Pokémon et ses attaques ; Les équivalents SQL : index et vues |
| [Fichier source IBM i : CRTSRCPF, longueur d'enregistrement et différence avec un PF](https://job-i.fr/fichier-source-ibm-i) | Un fichier source est un PF de type *SRC (séquence, date, texte) ; chaque membre contient un source (RPG, CL, DDS). | En une phrase ; Créer un fichier source ; La longueur d'enregistrement ; Fichier source ou PF de données ? |
| [Membre d'un fichier IBM i : objet, membre et fichier sans membre](https://job-i.fr/membre-fichier-ibm-i) | Un fichier est un objet qui décrit les données et contient zéro à plusieurs membres ; on gère l'objet (création, droits) et le membre (remplir, vider, lire). | En une phrase ; L'objet et ses membres ; Des commandes pour l'objet, d'autres pour le membre ; Un fichier peut vivre sans membre |
| [Multi-membre et multi-format IBM i : OVRDBF, ALIAS et pourquoi les éviter](https://job-i.fr/multi-membre-multi-format-ibm-i) | Multi-membre : plusieurs membres de même format à choisir à chaque accès ; LF multi-format : plusieurs PF dans un seul ordre de clé ; SQL et la plupart des outils les gèrent mal. | En une phrase ; Le multi-membre : un Pokédex par génération ; Pourquoi on évite le multi-membre ; Le multi-format : chaque Pokémon suivi de ses attaques ; Pourquoi on évite le multi-format |
| [Services SQL IBM i et AS/400 (QSYS2, SYSTOOLS) : exemples et résultats réels](https://job-i.fr/services-sql-ibm-i) | Catalogue des services SQL (QSYS2, SYSTOOLS) avec exemples et résultats. | Gestion des travaux (35) ; Bibliothèques et objets (5) ; Sécurité (26) ; Messages (7) ; Fichiers spoule (8) ; IFS (13) ; Journaux et audit (56) ; PTF (8) ; Stockage (16) ; Communications (22) ; Configuration (5) ; Application (48) |

## Pistes IBM

Issues de recherches ibm.com du 2026-11-23 : les pages sans mention « lu » **ne sont pas lues** ; la version indiquée peut différer de la 7.5 (à vérifier avant de s'en servir).

- [Row and column access control, RCAC (IBM i 7.2)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzahf/rzahfrcactitle.htm)
- [Journal management (IBM i 7.4)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzaki/rzakikickoff.htm)
- [How journal management works (IBM i 7.2)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzaki/rzakihowwrks.htm)
- [Setting up journaling (IBM i 7.2)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzaki/rzakisetupjrngs.htm)
- [DSPJRN (IBM i 7.6)](https://www.ibm.com/docs/en/ssw_ibm_i_76/cl/dspjrn.htm)
- [Redpaper RCAC (IBM i 7.2)](https://redbooks.ibm.com/abstracts/redp5110.html)

## Plan détaillé

### Architecture et concepts de DB2 for i

- **Dans le wiki** : [Fiche 04](../cheatsheets/04-db2-for-i-et-sql.md)

#### Les concepts de la base de données intégrée

- **job-i** : [Fichier physique (PF) IBM i](https://job-i.fr/fichier-physique-pf-ibm-i) · [Fichier logique (LF) IBM i](https://job-i.fr/fichier-logique-lf-ibm-i) · [AS/400 et IBM i](https://job-i.fr/as400-vs-ibm-i)

#### Différences entre la version « historique » DDS et SQL

- **job-i** : [DDS](https://job-i.fr/fichier-physique-pf-ibm-i) · [Fichier logique (LF) IBM i](https://job-i.fr/fichier-logique-lf-ibm-i)

### Les objets de données

- **Dans le wiki** : [Fiche 04](../cheatsheets/04-db2-for-i-et-sql.md) · [Exemples DDS dans le dépôt](../INDEX-SOURCES.md)

#### Les PF (tables)

- **job-i** : [fichier physique](https://job-i.fr/fichier-physique-pf-ibm-i) · [CRTPF](https://job-i.fr/commandes-ibm-i/crtpf)

#### Les LF (index, vues)

- **job-i** : [fichier logique](https://job-i.fr/fichier-logique-lf-ibm-i) · [CRTLF](https://job-i.fr/commandes-ibm-i/crtlf)

#### Les vues DDS et les vues SQL

- **job-i** : [Fichier logique (LF) IBM i](https://job-i.fr/fichier-logique-lf-ibm-i)

### Les contraintes et l'intégrité

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Clés primaires et clés étrangères

- **job-i** : [ADDPFCST](https://job-i.fr/commandes-ibm-i/addpfcst)

#### Contraintes unique et check

- **job-i** : [WRKPFCST](https://job-i.fr/commandes-ibm-i/wrkpfcst)

### Sécurité et journalisation

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Les RCAC, sécurité sur les lignes et les colonnes

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### La journalisation des tables

- **job-i** : [STRJRNPF](https://job-i.fr/commandes-ibm-i/strjrnpf) · [CRTJRN](https://job-i.fr/commandes-ibm-i/crtjrn) · [CRTJRNRCV](https://job-i.fr/commandes-ibm-i/crtjrnrcv) · [DSPJRN](https://job-i.fr/commandes-ibm-i/dspjrn)
