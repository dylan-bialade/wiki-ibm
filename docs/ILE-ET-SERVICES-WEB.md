# Architecture ILE et services web REST : modules, programme de service, IWS

> Fiche pédagogique. Sources lues en entier le 2026-11-23 : fiches `job-i.fr` des commandes (CRTSRVPGM : début de page seulement, voir le tableau) et deux tutoriels IBM de **2015** sur les services REST d'IBM i (à revalider pour 7.5). Rien n'a été compilé ni déployé. Les noms d'objets sont fictifs (`BIB01`, `ARTICLE…`) ; aucun nom réel de bibliothèque, de profil ou de personne n'est publié.

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](SOMMAIRE.md))

- [Partie 1 : modules, programme de service, source de liage](#partie-1--modules-programme-de-service-source-de-liage)
  - [Les quatre pièces](#les-quatre-pièces)
  - [Commandes de la chaîne (à tester)](#commandes-de-la-chaîne-à-tester)
  - [À fournir](#à-fournir)
- [Partie 2 : services web REST avec Integrated Web Services (IWS)](#partie-2--services-web-rest-avec-integrated-web-services-iws)
  - [Ce que montrent les deux exemples](#ce-que-montrent-les-deux-exemples)
  - [Retour d'expérience (hypothèse non confirmée)](#retour-dexpérience-hypothèse-non-confirmée)
- [Partie 3 : droits et exploitation d'un service IWS](#partie-3--droits-et-exploitation-dun-service-iws)
<!-- TOC:END -->

## Partie 1 : modules, programme de service, source de liage

| Élément | Statut | Source |
|---|---|---|
| `CRTSRVPGM` : crée un programme de service lié à partir de modules et de répertoires de liage | vérifié | [job-i CRTSRVPGM](https://job-i.fr/commandes-ibm-i/crtsrvpgm) |
| `MODULE` (jusqu'à 300), `EXPORT(*SRCFILE` ou `*ALL)`, `SRCFILE` (défaut `QSRVSRC`), `SRCMBR` (défaut `*SRVPGM`), `SRCSTMF` (pas avec `SRCFILE`/`SRCMBR`, pas avant V7R3M0), `BNDDIR`, `BNDSRVPGM`, `ACTGRP` (nom ou `*CALLER`), `REPLACE`, `AUT`, `TGTRLS` | vérifié (tableau des paramètres) | idem |
| `EXPORT(*ALL)` exporte aussi tout ce que les modules exportent ; `EXPORT(*SRCFILE)` lit les instructions d'export du membre | vérifié | idem |
| Un membre de liage peut être placé dans un fichier source **autre** que `QSRVSRC` (paramètre `SRCFILE`) | vérifié | idem |
| Droits requis : `*READ` + `*ADD` sur la bibliothèque, `*USE` sur modules / programmes de service / répertoires de liage | vérifié | idem (début de page) |
| `CRTSQLRPGI … OBJTYPE(*MODULE)` | vérifié (valeurs `*PGM`, `*SRVPGM`, `*MODULE`) | [fiche 07](cheatsheets/07-sql-embarque-en-rpg.md) |
| `RTVBNDSRC` : extrait les exportations de modules ou d'un programme de service dans un fichier, avec les instructions de langage de liage | vérifié | [job-i RTVBNDSRC](https://job-i.fr/commandes-ibm-i/rtvbndsrc) |
| `DSPSRVPGM DETAIL(*PROCEXP)` : liste les procédures exportées définies en langage de liage (signature courante seulement) | vérifié | [job-i DSPSRVPGM](https://job-i.fr/commandes-ibm-i/dspsrvpgm) |
| `GRTOBJAUT`, `DLTSRVPGM`, `DSPOBJD`, `DSPOBJAUT` : commandes existantes | vérifié (existence de la fiche) | job-i `/commandes-ibm-i/<commande>` |
| `STRPGMEXP`, `ENDPGMEXP`, `EXPORT SYMBOL` (langage de liage) | **non vérifié** : pas de fiche job-i (`STRPGMEXP` donne une page introuvable) ; référence IBM du langage de liage non lue | — |
| Nom de membre limité à 10 caractères | **non vérifié** (règle générale des noms d'objets IBM i) | — |
| Longueur d'enregistrement minimale du fichier source pour du `**FREE` ; syntaxe `/COPY bibliothèque/fichier,membre` | **non vérifié** | — |

### Les quatre pièces
1. **Modules `NOMAIN`** (un par responsabilité) : p. ex. un module d'accès aux données (`ARTICLEDAO`) et un module point d'entrée. Un module `NOMAIN` n'a pas de cycle : il exporte des procédures.
2. **Copybooks (`/COPY`)** : prototypes (`DCL-PR`) et constantes partagés entre les modules et les appelants (`ARTICLE_H`).
3. **Programme de service** (`WSARTICLE`) : regroupe les modules (`CRTSRVPGM MODULE(...)`). Avec `EXPORT(*ALL)`, tout ce qui est exporté par les modules l'est aussi ; avec `EXPORT(*SRCFILE)`, un **source de liage** liste précisément les procédures (et la signature).
4. **Source de liage** : membre contenant `STRPGMEXP`, `EXPORT SYMBOL(...)`, `ENDPGMEXP` (non vérifié, voir tableau) ; on peut le générer avec `RTVBNDSRC`. `DSPSRVPGM DETAIL(*PROCEXP)` contrôle ce qui est réellement exporté.

### Commandes de la chaîne (à tester)
```
CRTSQLRPGI OBJ(BIB01/ARTICLEDAO) SRCFILE(BIB01/QRPGLESRC) SRCMBR(ARTICLEDAO) OBJTYPE(*MODULE) COMMIT(*NONE)
CRTSRVPGM SRVPGM(BIB01/WSARTICLE) MODULE(BIB01/ARTICLEDAO BIB01/ARTICLE_API) EXPORT(*ALL) ACTGRP(*CALLER)
DSPSRVPGM SRVPGM(BIB01/WSARTICLE) DETAIL(*PROCEXP)
```
`CRTRPGMOD` (module sans SQL), `CRTBNDDIR` / `ADDBNDDIRE` (répertoire de liage) existent sur job-i. Pour la suppression et la recréation : `DLTSRVPGM` puis `CRTSRVPGM` (les droits sont à redonner, voir la partie 3).

### À fournir
L'exemple complet (code des modules, copybooks, source de liage) n'est **pas** dans ce dépôt : il faut le fournir pour qu'il soit publié, avec des noms anonymisés (aucun prénom, nom de profil ou nom de bibliothèque réel).

## Partie 2 : services web REST avec Integrated Web Services (IWS)

> Sources : [Part 2](https://developer.ibm.com/tutorials/i-rest-web-services-server2/) et [Part 3](https://developer.ibm.com/tutorials/i-rest-web-services-server3/) du tutoriel IBM « Building a REST service with integrated web services server for IBM i » (publiées le 7 mai 2015, lues en entier). **Âge du texte : 2015** (IBM i 7.1 / 7.2) : à revalider pour 7.5.

| Élément | Statut | Source |
|---|---|---|
| Serveur de services web **version 2.6 minimum** pour le REST ; assistant dans `http://hôte:2001/HTTPAdmin` (`https://hôte:2010/HTTPAdmin` si SSL) | vérifié (2015) | tutoriel Part 2 |
| Autorités `*ALLOBJ` et `*IOSYSCFG` pour créer le serveur (ou autorisation donnée, 6.1 et suivants) | vérifié (2015) | Part 2 |
| Profil d'exécution par défaut `QWSERVICE` ; tout profil indiqué doit être activé (`*ENABLED`) avec un mot de passe différent de `*NONE` ; il doit avoir les droits sur les objets utilisés | vérifié (2015) | Parts 2 et 3 |
| `PGMINFO(*PCML:*MODULE)` dans la spécification de contrôle du module (forme `h`), `*DCLCASE` pour garder la casse des noms (PTF SI55340 en 7.1, SI55442 en 7.2) | vérifié (2015) | Part 3 |
| Prérequis PTF : groupe HTTP SF99713 niveau 6 (7.2), SF99368 niveau 32 (7.1) | vérifié (2015), **périmé pour 7.5** | Parts 2 et 3 |
| Méthodes HTTP `GET`, `POST`, `PUT`, `DELETE` ; chemin par défaut `/web/services/<ressource>` ; modèle de chemin avec variable et expression régulière (ex. `\w{9}`) ; entrée `*PATH_PARAM` | vérifié (2015) | Parts 2 et 3 |
| Paramètre `int(10)` désigné dans l'assistant comme **code de réponse HTTP** (`httpStatus` dans l'exemple) ; codes cités : 200, 201, 204, 404, 409, 500 | vérifié (2015) | Part 3 |
| En-têtes HTTP en sortie : paramètre `100a DIM(10)` (ex. `Cache-Control: no-cache, no-store`, `LOCATION: …`) | vérifié (2015) | Part 3 |
| Tableau de sortie `DIM(n)` avec `OPTIONS(*VARSIZE)` : sans paramètre de **nombre d'éléments** (`10i 0`) désigné dans l'assistant, la réponse contient les éléments vides | vérifié (2015) | Part 3 |
| Informations de transport passées par variables d'environnement : `REMOTE_ADDR`, `HTTP_<EN-TÊTE>` en majuscules | vérifié (2015) | Parts 2 et 3 |
| Bibliothèques de la liste en début ou en fin de partie utilisateur | vérifié (2015) | Parts 2 et 3 |
| Paramètres `varchar`, packed et zoned ; `PGMINFO` en `CTL-OPT` (format libre) ; échappement d'une chaîne JSON dans un `varchar` de sortie ; texte du statut HTTP (reason phrase) | **non vérifié** (non couvert par les pages) | — |
| IWS 3.0 (annonce d'octobre 2025) | **non vérifié** (issu d'une recherche, page non lue) | — |
| PDF « IWS-Building-REST-Service-Part-2 » | **non lu** (texte non extrait) | à lire localement avant de le citer |

### Ce que montrent les deux exemples
- **Part 2** : une procédure exportée de programme de service (conversion de température) mappée sur `GET /web/services/ftoc/{temp}`, réponse JSON, aucun en-tête ni code de statut personnalisé.
- **Part 3** : un programme de service CRUD (5 procédures `getAll`, `getByID`, `create`, `update`, `remove`) avec une structure `QUALIFIED TEMPLATE` pour les zones de la table (pour contrôler la casse des noms JSON), un paramètre `httpStatus`, un tableau de sortie avec son compteur et des en-têtes HTTP.
- Dans les deux cas, l'assistant « Deploy New Service » permet de désigner chaque paramètre comme entrée, sortie, statut HTTP, en-têtes, chemin ou compteur.

### Retour d'expérience (hypothèse non confirmée)
Le message « Response data corresponding to field 'x' is not valid. The field may not be initialized. » apparaît avec un tableau de sortie non initialisé ou sans paramètre de nombre d'éléments, ou quand IWS garde l'ancienne description des paramètres après un changement de signature (supprimer le service, redémarrer le serveur, redéployer). **À vérifier** dans la documentation IBM avant de passer en « vérifié ».

## Partie 3 : droits et exploitation d'un service IWS

| Élément | Statut | Source |
|---|---|---|
| Le profil d'exécution doit avoir les droits sur les bibliothèques, bases de données et fichiers utilisés | vérifié (2015, formulation générale) | Parts 2 et 3 |
| `*USE` pour `QWSERVICE` sur la table, la bibliothèque et le programme de service suffit | **non vérifié** (constat à confirmer dans la documentation) | — |
| Après `DLTSRVPGM` puis `CRTSRVPGM`, les droits sont à redonner (`GRTOBJAUT`) | **non vérifié** (la commande existe sur job-i, le comportement n'est pas documenté ici) | [job-i GRTOBJAUT](https://job-i.fr/commandes-ibm-i/grtobjaut) |
| Journal du serveur : `WRKACTJOB SBS(QHTTPSVR)`, option 5 puis 10 | **non vérifié** | — |

Rien n'est à publier de plus tant que ces points ne sont pas confirmés dans la documentation IBM (référence IWS et droits).
