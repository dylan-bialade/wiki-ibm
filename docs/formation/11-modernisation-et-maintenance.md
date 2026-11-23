# Partie 11 : Modernisation d'application et maintenance de code existant

> Plan de formation, partie 11 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Limites du code historique, conversion vers le full free, décomposition en modules, standards modernes, nouvelle application (écrans, sous-fichiers, CRUD), mises en situation de maintenance.
>
> **Mots-clés** : modernisation, dette technique, full free, modules, programmes de service, RDi, VS Code, Git, JSON_TABLE, REST, DSPF, sous-fichier, CRUD, STRDBG, correctif.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Cours détaillé](#cours-détaillé)
  - [1. Principes de la modernisation](#1-principes-de-la-modernisation)
  - [2. Développer une nouvelle application](#2-développer-une-nouvelle-application)
  - [3. Les écrans standards](#3-les-écrans-standards)
  - [4. Les sous-fichiers et le CRUD](#4-les-sous-fichiers-et-le-crud)
  - [5. Maintenance de code existant](#5-maintenance-de-code-existant)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Les principes de la modernisation d'application](#les-principes-de-la-modernisation-dapplication)
  - [Développer une nouvelle application](#développer-une-nouvelle-application)
  - [Les écrans standards](#les-écrans-standards)
  - [Les sous-fichiers](#les-sous-fichiers)
  - [Mises en situation réelles de maintenance de code](#mises-en-situation-réelles-de-maintenance-de-code)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Cycle RPG III et conversion full free](../CYCLE-RPG.md)
- [Impression : réécrire un état à cycle](../IMPRESSION-RPG.md)
- [Exemples comparés (COMPARAISON)](../COMPARAISON-BIBLIOTHEQUES.md)
- [Énoncés de TP](../enonces/README.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Sous-fichier RPG (SFL, SFLCTL) : statique, en RPG III, RPG IV et full free](https://job-i.fr/sous-fichier-rpg) | Un sous-fichier est une liste d'enregistrements écrite ligne par ligne puis affichée en une fois ; l'utilisateur la fait défiler et le programme relit seulement les lignes modifiées. | En une phrase ; Le principe ; Trois façons de le charger, une seule à retenir ; L'écran : un gabarit, un seul DSPF pour les trois versions ; En RPG III ; En RPG IV colonné ; En RPG full free ; Le résultat, identique pour les trois ; Le piège : SFLMSG sur une liste vide |
| [Coder en RPG full free (**FREE) : 3 programmes, compilation, débogage STRDBG et tests](https://job-i.fr/coder-rpg-full-free) | Full free : première ligne **FREE, format libre sans spécification en colonnes ; même compilateur et même débogueur que le RPG IV. | En une phrase ; Préparer l'atelier ; Et SEU ? ; Hello world : quatre lignes ; Sortir du stock un article lu par sa clé ; Consulter un article par son code ou par son libellé ; Déboguer avec STRDBG ; Tester |
| [ILE sur IBM i : modules, programmes de service, liage, exemple RPG, C et CL](https://job-i.fr/ile-ibm-i) | ILE : le compilateur produit un module ; on lie des modules de langages différents en programme ou en programme de service partagé. | En une phrase ; L'ILE, c'est quoi ; Pourquoi l'ILE existe ; L'exemple : un programme RPG, un module C, un module CL ; Mettre en place 1 : trois modules, un programme ; Mettre en place 2 : un programme de service ; Par copie ou par référence : la preuve ; Déboguer d'un langage à l'autre ; Mettre l'ILE en place dans une application |

## Cours détaillé

> Cette partie est surtout une **mise en perspective des parties 01 à 10** : les briques techniques y sont déjà sourcées, on les renvoie. Sources propres à cette partie : le wiki (énoncés de TP, comparaisons, cycle), job-i.fr (pages lues en partie), IBM Documentation **IBM i 7.5** (`JSON_TABLE`, syntaxe lue) et la documentation du projet **Code for IBM i** (communautaire, **non IBM**). Il n'existe **aucune page job-i** ni **aucune source IBM lue** sur la *méthode* de modernisation (dette technique, standards d'équipe) : les passages de méthode sont des **hypothèses** signalées comme telles. L'assistant ne compile rien.

### 1. Principes de la modernisation

**Limites du code historique** (constats du wiki, à partir de l'énoncé *The Big One* et des parties précédentes) : logique pilotée par le cycle ; `GOTO`/`TAG`/`CABxx` (24 / 9 / 21 annoncés dans l'énoncé), indicateurs numériques réutilisés pour deux sens, code mort, `DIV` sans `(H)` qui **tronque** au lieu d'arrondir (889,56 au lieu de 889,57), fichiers décrits dans le programme, aucun prototype ni contrôle des paramètres (`CALL`/`PARM`), SEU limité à 80 colonnes ([partie 06](06-rpg-iii.md#cours-détaillé), [partie 08](08-rpg-free.md#cours-détaillé)).

**Chantiers de modernisation et où les trouver** :

| Chantier | Ce qui est documenté | Où |
|---|---|---|
| RPG III → RPG IV | `CVTRPGSRC` (vérifié) ; tableau « ce qui a changé » (job-i) | [partie 07, § 1](07-rpg-iv.md#cours-détaillé) |
| RPG IV → full free | `**FREE` (job-i), équivalences colonné/libre ; outil de conversion **non identifié** (`CVTRPGFREE` introuvable) | [partie 08, § 5](08-rpg-free.md#cours-détaillé) |
| Cycle → libre | table de correspondance, impression `QSYSPRT` + DS (**validée**) | [CYCLE-RPG.md, partie 2](../CYCLE-RPG.md#partie-2--du-cycle-rpg-iii-au-full-free-table-de-correspondance) · [IMPRESSION-RPG.md](../IMPRESSION-RPG.md) |
| Fichiers DDS → SQL | une table SQL vérifie les données à l'écriture, applique les `CHECK`, réutilise la place des supprimés ; SQL accède aussi aux PF DDS | [partie 02, § 2](02-db2-for-i.md#cours-détaillé) |
| Monolithe → modules/programmes de service | chaîne module → srvpgm → bnddir, source de liage, signature ; exemple BONBON (compilé) | [partie 10](10-ile.md#cours-détaillé) |
| Appels sûrs | `PR`/`PI`, `CONST`, `OPTIONS` | [partie 07, § 7](07-rpg-iv.md#cours-détaillé) · [partie 10, § 2](10-ile.md#cours-détaillé) |
| Erreurs | `MONITOR`/`ON-ERROR`, `%STATUS` | [partie 07, § 6](07-rpg-iv.md#cours-détaillé) |
| Outils | Code for IBM i, RDi | [partie 03, § 5](03-outils-de-developpement.md#cours-détaillé) |
| Web services | JSON SQL, IWS | [SQL avancé](../SQL-AVANCE.md) · [ILE-ET-SERVICES-WEB.md](../ILE-ET-SERVICES-WEB.md) · [partie 13](13-web-services-et-api.md) |

**Décomposition d'un monolithe** (hypothèse de méthode, appuyée sur les bonnes pratiques de job-i) : repérer les blocs réutilisables (sous-routines, accès à un fichier, contrôles), en faire des procédures dans des modules `NOMAIN` regroupés en **programmes de service par domaine**, un répertoire de liage et un groupe d'activation nommé par application, sans jamais réordonner les exports ([partie 10, § 3 et 4](10-ile.md#cours-détaillé)). `CRTSRVPGM` : [job-i](https://job-i.fr/commandes-ibm-i/crtsrvpgm).

**Standards modernes** (erreurs centralisées, logs, constantes globales, validations) : **aucune source** dans le wiki ; briques disponibles : constantes `dcl-c` ([partie 07, § 3](07-rpg-iv.md#cours-détaillé)), `snd-msg`/`SNDPGMMSG` ([partie 10, § 4](10-ile.md#cours-détaillé)), `MONITOR` ; une convention d'équipe reste à écrire (hypothèse).

**Outils modernes**
- **Code for IBM i** (doc du projet, communautaire) : prérequis lus : IBM i **7.4** (7.3 « may work but is not supported »), démon **SSH** démarré (`STRTCPSVR *SSHD`, produit 5733-SC1, utilisateur `QSSHD` activé), Java 8 minimum pour **Mapepire**, serveurs `*SIGNON` et `*DATABASE` actifs (ports 8471/8476, 9471/9476 en SSL). **Développement local + déploiement** : on édite dans un dossier local, un bouton *Deploy* envoie vers un répertoire IFS ; méthodes de déploiement : *Working Changes* (fichiers modifiés selon `git status`, non indexés et indexés), *Staged Changes*, *All*, *Changes* (modifiés depuis le dernier déploiement), *Compare* (sommes MD5, seule méthode qui supprime côté serveur) ; `.gitignore` respecté, `.deployignore` le supplante.
- **Git** : cette documentation décrit l'usage avec un dossier local versionné ; l'installation de Git **sur** l'IBM i n'est pas lue.
- **JSON_TABLE** (IBM i 7.5) : fonction de table qui renvoie un résultat à partir d'**expressions de chemin SQL/JSON** : `JSON_TABLE(json-expression [FORMAT JSON | BSON], chemin AS nom COLUMNS (colonnes) [EMPTY ON ERROR | ERROR ON ERROR])` ; types de colonnes : régulières (`type PATH '…'` avec `NULL | ERROR | DEFAULT … ON EMPTY / ON ERROR`), formatées (`FORMAT JSON`, `WITH/WITHOUT ARRAY WRAPPER`, `KEEP/OMIT QUOTES`), ordinalité (`FOR ORDINALITY`) et imbriquées (`NESTED PATH`).
- **REST** : voir [partie 13](13-web-services-et-api.md) et [ILE-ET-SERVICES-WEB](../ILE-ET-SERVICES-WEB.md) (IWS).

| Élément | Statut | Source |
|---|---|---|
| Limites du code historique (GOTO, indicateurs, troncature, etc.) | vérifié dans le wiki (énoncé) | [tp-the-big-one](../enonces/tp-the-big-one.md) |
| Chantiers et renvois (tableau) | vérifié (renvois vers parties sourcées) | parties 02, 03, 07, 08, 10, 13 |
| JSON_TABLE : syntaxe, types de colonnes | vérifié **partiellement** (début de page : syntaxe) | [IBM 7.5 : JSON_TABLE](https://www.ibm.com/docs/en/i/7.5.0?topic=functions-json-table) |
| Code for IBM i : prérequis, déploiement, méthodes, `.deployignore` | vérifié (pages *Installation* et *Getting started* lues en partie) ; **source non officielle IBM** | [Installation](https://codefori.github.io/docs/install/) · [Getting started](https://codefori.github.io/docs/developing/local/getting-started/) |
| Git sur IBM i (installation, RPM/yum) | **non lu** | à chercher sur ibm.com / docs Open Source |
| Méthode de décomposition, standards d'équipe, dette technique | **hypothèse** | à sourcer |
| Conversion RPG IV → libre | **non vérifié** (`CVTRPGFREE` introuvable) | [apport du 2026-11-23](../apports/2026-11-23-cvtrpgfree-introuvable-job-i-ibm-7-5.md) |

### 2. Développer une nouvelle application

**Architecture type** (assemblage de briques sourcées, hypothèse de découpage) :

| Couche | Technique | Source |
|---|---|---|
| Données | tables SQL (`CREATE TABLE`, contraintes), index/vues, journalisation (automatique en schéma SQL) | [partie 02](02-db2-for-i.md#cours-détaillé) · [partie 05](05-sql.md#cours-détaillé) |
| Écrans | DSPF (DDS), fichier écran `workstn`, `EXFMT` | [partie 03, § 4](03-outils-de-developpement.md#cours-détaillé) |
| Métier | procédures dans des modules `NOMAIN` / programmes de service, prototypes en `/COPY` | [partie 10](10-ile.md#cours-détaillé) |
| Accès SQL | SQL embarqué, curseurs, `GET DIAGNOSTICS` | [partie 09](09-sql-embarque.md#cours-détaillé) |
| Services | JSON, REST (IWS) | [partie 13](13-web-services-et-api.md) |

**Séparer le métier du visuel** : le programme d'écran (dialogue : `EXFMT`, indicateurs de touche et de message) n'appelle que des procédures du programme de service (accès aux données, calculs, contrôles) ; ainsi la même logique sert aussi un service web (hypothèse de conception ; l'exemple BONBON du wiki illustre cette séparation côté service : [ILE-ET-SERVICES-WEB](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)).

**Mettre en pratique** : énoncés de TP du wiki ([enonces/README](../enonces/README.md)) : `tp-logistock` (sous-fichier : créer F6, modifier option 2, supprimer option 4, afficher option 5 en fenêtre, confirmations par F23), `tp-livres`, `tp-le-chai` (SQLRPGLE full free, curseurs, transaction « tout ou rien »). **Rappel** : les épreuves interdisent l'IA pendant l'épreuve ; ces résumés servent à la révision.

| Élément | Statut | Source |
|---|---|---|
| Énoncés et compétences visées | vérifié dans le wiki (résumés anonymisés) | [enonces/README](../enonces/README.md) |
| Architecture en couches | **hypothèse** (assemblage des parties sourcées) | — |
| Aucun exemple d'application complète compilée dans le wiki (hors BONBON, côté service) | constat | [INDEX-SOURCES](../INDEX-SOURCES.md) |

### 3. Les écrans standards

- **`EXFMT format`** (RPG III, job-i) : envoie un format d'un fichier écran au poste, **attend** Entrée ou une touche de fonction, charge la saisie ; équivaut à un `WRITE` suivi d'un `READ` du même format ; ne s'emploie qu'avec un fichier écran décrit en externe ; les indicateurs des touches (`CAxx`/`CFxx` du DSPF ou `*INKA` à `*INKY`) disent la touche utilisée ; indicateur d'erreur en 56-57, sans lui une erreur arrête le programme. job-i précise que son exemple **n'a pas été exécuté** (compilé seulement, pas d'écran en traitement par lots) ; l'exemple exécuté est ARTCON ([partie 03, § 4](03-outils-de-developpement.md#cours-détaillé)).
- **Menu, saisie, consultation, erreur** : les écrans suivent le gabarit des exemples job-i (ligne 1 nom/titre/date, ligne 2 heure, ligne 23 touches, ligne 24 messages) ; les messages d'erreur ne s'affichent que si le programme allume les indicateurs de condition du DSPF (41/42 dans ARTCON) ; `CHECK(LC)` accepte les minuscules.
- **Validation des données** : côté écran, le DDS ne vérifie que ce qu'il sait (`VALUES`, `RANGE` ne jouent que sur écran, ce n'est **pas** une contrainte de la base : [partie 02, § 2](02-db2-for-i.md#cours-détaillé)) ; la contrainte durable est `CHECK`/`PRIMARY KEY` côté table.
- **Fenêtre (`WINDOW`), `OVERLAY`, `CHGINPDFT`** : mots-clés DDS non documentés dans le wiki ([MANQUES](../MANQUES.md)).

| Élément | Statut | Source |
|---|---|---|
| EXFMT : rôle, équivalence WRITE+READ, touches, indicateur d'erreur | vérifié (début de page) | [job-i : EXFMT](https://job-i.fr/rpg-iii/exfmt) |
| Gabarit d'écran et indicateurs 41/42 | vérifié (page job-i) | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |
| VALUES/RANGE = saisie écran seulement | vérifié (job-i, IBM cité) | [job-i : PF](https://job-i.fr/fichier-physique-pf-ibm-i) |
| WINDOW, OVERLAY, CHGINPDFT | **non vérifié** (manque connu) | [MANQUES](../MANQUES.md) |

### 4. Les sous-fichiers et le CRUD

Mots-clés DDS, opérations RPG (`SFILE`, `WRITE`, `EXFMT`, `READC`) et méthodes de chargement (**statique** conseillée par job-i, extensible, page à page) : [partie 06, § 6](06-rpg-iii.md#cours-détaillé) ; même écran en RPG III, IV colonné et full free : [job-i : sous-fichier](https://job-i.fr/sous-fichier-rpg). **CRUD** : *créer* `WRITE` ou `INSERT`, *lire* `CHAIN`/`READ` ou `SELECT`, *modifier* `UPDATE` (après lecture sans `N`), *supprimer* `DELETE`/`DELET` ([partie 06, § 5](06-rpg-iii.md#cours-détaillé), [partie 05, § 3](05-sql.md#cours-détaillé)) ; l'énoncé `tp-logistock` en est le cas d'école (SFL + format distinct par option + confirmation F23 + positionnement par `SETLL`). Un CRUD complet « RPG et SQL » (mêmes écrans, accès SQL) n'a **pas** d'exemple dans le wiki.

| Élément | Statut | Source |
|---|---|---|
| Sous-fichier statique, mots-clés, opérations | vérifié (partie 06) | [job-i : sous-fichier](https://job-i.fr/sous-fichier-rpg) |
| Énoncé du CRUD en sous-fichier | vérifié dans le wiki | [tp-logistock](../enonces/tp-logistock.md) |
| Code RPG III/IV/libre du sous-fichier ; CRUD RPG + SQL | **non lu / absent** | à documenter |

### 5. Maintenance de code existant

Le scénario type de l'énoncé *The Big One* (RPG III hérité, deux équipes, relecture croisée) donne la **démarche** :

1. **Mettre en place** : environnement d'équipe (profil de groupe, bibliothèque partagée en `*ALL` pour le groupe et `*USE` pour le public), copie des sources (`CPYSRCF`, longueur 112), des fichiers (`CRTPF`, `CRTLF`, `CPYF`), création des data areas ; **bibliothèque de référence en lecture seule**, une bibliothèque par équipe, **un seul membre à la fois** par source, journal de bord et commentaire daté à chaque modification.
2. **Comprendre** : plan de câblage (qui appelle qui, qui lit quoi), inventaire des `GOTO`/`TAG`/`CABxx`, enquête sur les bugs.
3. **Diagnostiquer** : `DSPJOBLOG` (historique du travail : chaque commande et chaque message, y compris l'erreur d'origine ; **F10** affiche les messages détaillés, **F1** sur un message ouvre « Cause / Que faire » ; ne fonctionne que sur un travail actif ou en file d'attente : un travail terminé laisse un spool `QPJOBLOG`, absent si la description de travail indique `LOG(4 0 *NOLIST)` ; fonction SQL `QSYS2.JOBLOG_INFO`), `DUMP`/`DMPJOB`, débogueur ([partie 10, § 5](10-ile.md#cours-détaillé)). Quand le programme s'arrête avec « Erreur dans le programme », la vraie cause est un `CPF` ou `MCH` dans l'historique (job-i).
4. **Modifier sans dégrader la production** : travailler sur copie, débogueur avec `UPDPROD(*NO)` (défaut : refuse la mise à jour des fichiers d'une bibliothèque de production, CPF4203), tester sur **copie des données**, cas de test écrits **avant** ([partie 06, § 7](06-rpg-iii.md#cours-détaillé)) ; un changement à la fois ; pour un module d'un programme de service, `UPDSRVPGM` ne touche pas aux programmes liés par copie (`UPDPGM` pour eux, [partie 10](10-ile.md#cours-détaillé)).
5. **Moderniser en sortie** : critères de l'énoncé (plus de `GOTO`/`TAG`/`CABxx`/`COMP`, plus d'indicateur numérique hors touches de fonction, zones en spécification D, `DOW`, `SELECT`/`WHEN`, `DCL-PR`/`DCL-PI`) puis **revue croisée** par recherche (`FNDSTRPDM`).
6. **Dette technique et correctifs documentés** : consigner chaque point (code mort, indicateur réutilisé, troncature sans arrondi `H`) avec le correctif et le cas de test ; **aucune source** sur un modèle de fiche de correctif : hypothèse.

**Lecture d'un programme ancien** : [partie 06, § 7](06-rpg-iii.md#cours-détaillé) ; exemples réels : [INDEX-SOURCES](../INDEX-SOURCES.md), [COMPARAISON-BIBLIOTHEQUES](../COMPARAISON-BIBLIOTHEQUES.md) (97 membres présents dans plusieurs bibliothèques, 58 en versions différentes : utile pour voir plusieurs façons d'écrire le même exercice).

| Élément | Statut | Source |
|---|---|---|
| Démarche *The Big One* (étapes 1, 2, 4 de l'énoncé), pièges documentés | vérifié dans le wiki | [tp-the-big-one](../enonces/tp-the-big-one.md) |
| DSPJOBLOG : contenu, F10/F1, travail terminé, `QPJOBLOG`, `LOG(4 0 *NOLIST)`, `JOBLOG_INFO` | vérifié (début de page, « cas concret » et « piège classique ») | [job-i : DSPJOBLOG](https://job-i.fr/commandes-ibm-i/dspjoblog) |
| UPDPROD(*NO) par défaut et CPF4203 ; debug sur copie | vérifié (job-i) | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |
| Étapes 3 et 4 de la démarche dans une équipe réelle (gestion de versions, procédure de livraison) | **hypothèse** | à sourcer |
| Modèle de fiche de correctif, indicateurs de dette technique | **hypothèse** | à sourcer |
| Comparaison de code existant | vérifié (document généré du dépôt) | [COMPARAISON-BIBLIOTHEQUES](../COMPARAISON-BIBLIOTHEQUES.md) |

### Ce qui reste à vérifier pour cette partie

Aucune source de méthode : modernisation, dette technique, standards d'équipe (à chercher dans les Redbooks IBM i modernisation, par exemple) ; installation de **Git sur IBM i** ; outil de conversion RPG IV colonné → libre (RDi ?) ; mots-clés DDS `WINDOW`, `OVERLAY`, `CHGINPDFT` ; suite des pages job-i EXFMT et sous-fichier ; exemple CRUD complet RPG + SQL. Manques à signaler : aucune page job-i sur la modernisation, les standards de code, Git sur IBM i ni le CRUD.

## Plan détaillé (index des sujets)

### Les principes de la modernisation d'application

- **Dans le wiki** : [Cycle vers full free](../CYCLE-RPG.md#partie-2--du-cycle-rpg-iii-au-full-free-table-de-correspondance)

#### Les limites du code historique et les enjeux de la modernisation

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### La conversion vers RPG Free

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### La décomposition d'un monolithe en modules et programmes de service

- **job-i** : [CRTSRVPGM](https://job-i.fr/commandes-ibm-i/crtsrvpgm)

#### Les standards modernes, SQL, erreurs centralisées, logs, constantes globales, validations

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les outils modernes, RDi, VS Code, Git, JSON_TABLE, webservices REST

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Développer une nouvelle application

- **Dans le wiki** : [Énoncés de TP](../enonces/README.md)

#### L'architecture d'une application IBM i (PF/LF, DSPF, RPG Free, SQL, ILE)

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### La séparation des traitements métier et du visuel

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Le SQL embarqué dans une application moderne

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Les écrans standards

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Menu, écrans de saisie, de consultation et d'erreur

- **job-i** : [EXFMT](https://job-i.fr/rpg-iii/exfmt)

#### Validation des données et messages de contrôle

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Les sous-fichiers

- **Dans le wiki** : [Fiche 03](../cheatsheets/03-rpg-par-version.md)

#### Les sous-fichiers statiques et dynamiques

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### L'intégration d'un CRUD complet en RPG et SQL

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Mises en situation réelles de maintenance de code

- **Dans le wiki** : [Index des sources](../INDEX-SOURCES.md)

#### Lecture et analyse d'un programme RPG ancienne génération

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Diagnostic de bug (SQL, logique métier, DSPF, data-area, journaux)

- **job-i** : [DSPJOBLOG](https://job-i.fr/commandes-ibm-i/dspjoblog)

#### Débogage, STRDBG et service entry point

- **job-i** : [STRDBG](https://job-i.fr/commandes-ibm-i/strdbg)

#### Modification d'un code existant sans dégrader la production

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Dette technique et élaboration de correctifs testés et documentés

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).
