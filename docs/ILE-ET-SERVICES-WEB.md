# Architecture ILE et services web REST : modules, programme de service, IWS

> Fiche pédagogique. Sources lues en entier le 2026-11-23 : fiches `job-i.fr` des commandes (CRTSRVPGM : début de page seulement, voir le tableau) et deux tutoriels IBM de **2015** sur les services REST d'IBM i (à revalider pour 7.5). Rien n'a été compilé ni déployé. Les noms d'objets de la partie 1 sont fictifs (`BIB01`, `ARTICLE…`, `BONBON…`) ; aucun nom réel de bibliothèque, de profil ou de personne n'est publié.

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](SOMMAIRE.md))

- [Partie 1 : modules, programme de service, source de liage](#partie-1--modules-programme-de-service-source-de-liage)
  - [Les quatre pièces](#les-quatre-pièces)
  - [Commandes de la chaîne (à tester)](#commandes-de-la-chaîne-à-tester)
  - [Exemple complet : liste de bonbons en JSON, exposée en service REST](#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)
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

### Exemple complet : liste de bonbons en JSON, exposée en service REST
> Code fourni par l'utilisateur (4 membres, ordre de création : `BONBON_H`, `BONBONDAO`, `GETBON_H`, `GET_BONBON`), **anonymisé** : bibliothèque `BIB01`, point d'entrée et copybook renommés (`GET_BONBON`, `GETBON_H`). **Non compilé ici** ; la compilation par l'utilisateur n'est pas précisée. Table et colonnes (`BONBON` : `"NUMBER"`, `NOM`, `MARQUE`, `COULEUR`, `PRIX`) supposées d'après le code.

**1. `BONBON_H`** (copybook : codes retour et prototype de l'accès aux données)
```rpgle
**free
// Acces BONBON : constantes et prototype
dcl-c BONBON_OK     0;
dcl-c BONBON_VIDE   1;
dcl-c BONBON_ERREUR -1;

dcl-pr bonbon_list_json int(10);
  json      varchar(30000);
  p_sqlcode int(10);
end-pr;
```

**2. `BONBONDAO`** (module `NOMAIN`, accès aux données avec SQL)
```rpgle
**free

ctl-opt nomain option(*srcstmt);

exec sql set option commit = *none, closqlcsr = *endmod;

/copy BIB01/WEBSERVICE,BONBON_H

dcl-proc bonbon_list_json export;

  dcl-pi *n int(10);
    json      varchar(30000);
    p_sqlcode int(10);
  end-pi;

  dcl-s w_json   varchar(30000);
  dcl-s ind_json int(5);

  // Sorties toujours initialisees
  json = '[]';
  p_sqlcode = 0;
  w_json = '';
  ind_json = 0;

  exec sql
    select cast(
             json_arrayagg(
               json_object(
                 'number'  : "NUMBER",
                 'nom'     : trim(nom),
                 'marque'  : trim(marque),
                 'couleur' : trim(couleur),
                 'prix'    : prix
               )
               order by "NUMBER"
             ) as varchar(30000))
      into :w_json :ind_json
      from BIB01.bonbon;

  p_sqlcode = sqlcode;

  select;
    when p_sqlcode < 0;
      return BONBON_ERREUR;
    when ind_json < 0;
      return BONBON_VIDE;
    other;
      json = w_json;
      return BONBON_OK;
  endsl;

end-proc;
```

**3. `GETBON_H`** (copybook du point d'entrée du service)
```rpgle
**free
// Endpoint IWS GET_BONBON
dcl-c HTTP_OK        200;
dcl-c HTTP_NOT_FOUND 404;
dcl-c HTTP_ERROR     500;

dcl-pr get_bonbon;
  httpStatus int(10);
  json       varchar(30000);
end-pr;
```

**4. `GET_BONBON`** (module `NOMAIN`, point d'entrée REST, interface PCML dans le module)
```rpgle
**free

ctl-opt nomain option(*srcstmt) pgminfo(*pcml:*module:*dclcase);

/copy BIB01/WEBSERVICE,BONBON_H
/copy BIB01/WEBSERVICE,GETBON_H

dcl-proc get_bonbon export;

  dcl-pi *n;
    httpStatus int(10);
    json       varchar(30000);
  end-pi;

  dcl-s w_sqlcode int(10);
  dcl-s w_rc      int(10);

  // Sorties toujours initialisees
  httpStatus = HTTP_OK;
  json = '[]';

  w_rc = bonbon_list_json(json: w_sqlcode);

  select;
    when w_rc = BONBON_OK;
      httpStatus = HTTP_OK;
    when w_rc = BONBON_VIDE;
      httpStatus = HTTP_NOT_FOUND;
      json = '[]';
    other;
      httpStatus = HTTP_ERROR;
      json = '[]';
  endsl;

  return;

end-proc;
```

**Chaîne de création et de déploiement (à tester)**
```
CRTSQLRPGI OBJ(BIB01/BONBONDAO) SRCFILE(BIB01/WEBSERVICE) SRCMBR(BONBONDAO) OBJTYPE(*MODULE) COMMIT(*NONE)
CRTRPGMOD  MODULE(BIB01/GET_BONBON) SRCFILE(BIB01/WEBSERVICE) SRCMBR(GET_BONBON)
CRTSRVPGM  SRVPGM(BIB01/WSBONBON) MODULE(BIB01/BONBONDAO BIB01/GET_BONBON) EXPORT(*ALL) ACTGRP(*CALLER)
DSPSRVPGM  SRVPGM(BIB01/WSBONBON) DETAIL(*PROCEXP)
```
Puis déployer `WSBONBON` avec l'assistant IWS (partie 2) : `get_bonbon` en `GET`, `httpStatus` désigné comme code de réponse, sortie JSON.

| Élément | Statut | Source |
|---|---|---|
| Ordre : copybook `BONBON_H`, module `BONBONDAO`, copybook `GETBON_H`, module `GET_BONBON`, puis programme de service | constat (fourni par l'utilisateur) | — |
| `PGMINFO(*PCML:*MODULE:*DCLCASE)` : 1er paramètre `*PCML` + au moins un autre ; `*MODULE` place l'interface dans le module (lisible par l'API `QBNRPII`) ; `*DCLCASE` conserve la casse déclarée ; mot-clé de spécification de contrôle (donc valable en `CTL-OPT`) ; l'emporte sur les paramètres `PGMINFO` / `INFOSTMF` de `CRTRPGMOD` / `CRTBNDRPG` | vérifié (IBM i 7.2) | [PGMINFO, 7.2](https://www.ibm.com/docs/en/i/7.2.0?topic=keywords-pgminfopcml-no-dclcase-module-v6-v7) |
| PCML 6.0 par défaut pour une édition cible V7R2M0 / V7R3M0 (7.0 ensuite) ; en 7.0, les champs de **longueur variable** (`varchar`) sont traités autrement qu'en 6.0 (en 6.0, générés comme structures) ; variable `QIBM_RPG_PCML_VERSION` | vérifié (IBM i 7.2) | idem |
| Effet de cette version PCML sur un paramètre `varchar(30000)` vu par IWS | **non vérifié** | — |
| `json_arrayagg` avec `json_object` imbriqué, `order by` interne ; résultat `NULL` si aucune ligne (d'où `ind_json < 0` = `BONBON_VIDE`) | vérifié | [SQL-AVANCE, partie 1](SQL-AVANCE.md#partie-1--sql-json-db2-for-i-75) |
| `CAST(… AS VARCHAR(30000))` ; `"NUMBER"` entre guillemets ; `SELECT INTO :var :indicateur` | **non vérifié** | — |
| `SET OPTION COMMIT = *NONE, CLOSQLCSR = *ENDMOD` en tête d'un module `NOMAIN` | **non vérifié** | — |
| `**free` en première ligne d'un membre `/COPY` | **non vérifié** (à confirmer à la compilation) | — |
| Chaînes de 30000 caractères : le résultat JSON plus long serait tronqué ou en erreur | **non vérifié** | — |
| Le JSON placé dans un paramètre `varchar` de sortie est-il renvoyé tel quel ou comme chaîne échappée par IWS ? | **non vérifié** (point à tester en premier) | — |
| Codes HTTP 200 / 404 / 500 | vérifié (2015) | [tutoriel IWS Part 3](https://developer.ibm.com/tutorials/i-rest-web-services-server3/) |
| 404 pour une liste vide | **choix de conception** : le tutoriel IBM renvoie 200 avec un tableau vide pour « tous les étudiants » | tutoriel Part 3 |
| Sorties toujours initialisées (`json = '[]'`, `httpStatus` posé dès l'entrée) | bonne pratique cohérente avec l'hypothèse « champ non initialisé » de la partie 2 | partie 2 |

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
