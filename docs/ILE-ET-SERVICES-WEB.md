# Architecture ILE et services web REST : modules, programme de service, IWS

> Fiche pédagogique. Sources lues en entier le 2026-11-23 : la page job-i « ILE » (exemple testé sur IBM i 7.5), les fiches job-i des commandes (CRTSRVPGM : début de page seulement), les pages IBM sur le langage de liage, la signature et les groupes d'activation (IBM i 7.2 à 7.4) et deux tutoriels IBM de **2015** sur les services REST. **L'exemple de la partie 1 a été compilé par l'utilisateur** ; rien n'a été déployé ni exécuté à notre connaissance. Les noms d'objets de la partie 1 sont fictifs (`BIB01`, `ARTICLE…`, `BONBON…`) ; aucun nom réel de bibliothèque, de profil ou de personne n'est publié.

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](SOMMAIRE.md))

- [Partie 1 : modules, programme de service, source de liage](#partie-1--modules-programme-de-service-source-de-liage)
  - [Concepts ILE (job-i et IBM)](#concepts-ile-job-i-et-ibm)
  - [Les quatre pièces](#les-quatre-pièces)
  - [Commandes de la chaîne (à tester)](#commandes-de-la-chaîne-à-tester)
  - [Exemple complet : liste de bonbons en JSON, exposée en service REST](#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)
- [Partie 2 : services web REST avec Integrated Web Services (IWS)](#partie-2--services-web-rest-avec-integrated-web-services-iws)
  - [Ce que montrent les deux exemples](#ce-que-montrent-les-deux-exemples)
  - [Retour d'expérience (hypothèse non confirmée)](#retour-dexpérience-hypothèse-non-confirmée)
- [Partie 3 : droits et exploitation d'un service IWS](#partie-3--droits-et-exploitation-dun-service-iws)
- [Partie 4 : mémo des commandes système (ILE, IWS, exploitation)](#partie-4--mémo-des-commandes-système-ile-iws-exploitation)
  - [Compiler et lier](#compiler-et-lier)
  - [Inspecter](#inspecter)
  - [Droits et nettoyage](#droits-et-nettoyage)
  - [Environnement et sources](#environnement-et-sources)
  - [Serveur IWS et exploitation](#serveur-iws-et-exploitation)
  - [Enchaînements à retenir](#enchaînements-à-retenir)
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
| `STRPGMEXP PGMLVL(*CURRENT)`, `EXPORT SYMBOL(...)`, `ENDPGMEXP` (langage de liage) : liste d'export d'un programme de service ; `RTVBNDSRC` génère ce source ; `LVLCHK`, `PGMLVL(*PRV)` pour garder les anciennes interfaces | vérifié | [job-i ILE](https://job-i.fr/ile-ibm-i) (exemple testé en 7.5), [Binder Language, IBM i 7.4](https://www.ibm.com/docs/en/i/7.4.0?topic=concepts-binder-language) |
| Nom de membre limité à 10 caractères | **non vérifié** (règle générale des noms d'objets IBM i) | — |
| Longueur d'enregistrement minimale du fichier source pour du `**FREE` ; syntaxe `/COPY bibliothèque/fichier,membre` | **non vérifié** | — |

### Concepts ILE (job-i et IBM)
Sources : [job-i « ILE »](https://job-i.fr/ile-ibm-i) (lue en entier ; exemple construit et exécuté sur IBM i 7.5), [Binder Language, 7.4](https://www.ibm.com/docs/en/i/7.4.0?topic=concepts-binder-language), [Signature, 7.3](https://www.ibm.com/docs/en/i/7.3.0?topic=language-signature), [Service Programs and Activation Groups, 7.2](https://www.ibm.com/docs/en/i/7.2.0?topic=management-service-programs-activation-groups), [Activation Group, 7.2](https://www.ibm.com/docs/en/i/7.2.0?topic=concepts-activation-group) (toutes lues en entier). Les pages IBM sont d'éditions 7.2 à 7.4 : à revalider pour 7.5.

| Objet | Rôle | Statut |
|---|---|---|
| `*MODULE` | résultat d'un compilateur ILE (`CRTRPGMOD`, `CRTCMOD`, `CRTCLMOD`) ; contient des procédures, ne s'exécute pas seul | vérifié (job-i) |
| `*PGM` | modules liés dont un porte la procédure d'entrée (`ENTMOD`) ; s'appelle par `CALL` | vérifié (job-i) |
| `*SRVPGM` | modules liés **sans** procédure d'entrée : boîte à outils de procédures partagée | vérifié (job-i) |
| `*BNDDIR` | répertoire de liage : liste de modules et de programmes de service où le binder cherche les procédures appelées | vérifié (job-i) |
| groupe d'activation | partie du travail où s'exécute un programme ILE (variables statiques, mémoire dynamique, fichiers ouverts, curseurs SQL locaux, définitions de validation) ; pas un objet | vérifié (job-i, IBM 7.2) |

**Liage par copie ou par référence**

| | Par copie (`CRTPGM MODULE(...)`) | Par référence (programme de service) |
|---|---|---|
| Où est le code | recopié dans chaque programme | une seule fois, dans le `*SRVPGM` |
| Changer une procédure | recompiler le module puis `UPDPGM` pour chaque programme | `UPDSRVPGM` une fois pour tous |
| À livrer | le programme | le programme et le programme de service |
| Pour quoi | modules propres à un programme | procédures partagées |

(job-i : dans l'exemple, après `UPDSRVPGM` le programme lié par référence voit le nouveau code, celui lié par copie garde l'ancien jusqu'à `UPDPGM`.)

**Source de liage et signature** (IBM)
- Le langage de liage est un petit jeu de commandes non exécutables : `STRPGMEXP` (début de la liste d'exports), `EXPORT SYMBOL(...)` (un symbole), `ENDPGMEXP` (fin). Les symboles du bloc `PGMLVL(*CURRENT)` définissent l'interface publique, représentée par une **signature**.
- **Ne jamais retirer ni réordonner** les noms existants ; les nouveaux symboles s'ajoutent **à la fin** de la liste. Un retrait n'est pas compatible avec les programmes déjà liés.
- Sans signature explicite, le binder en génère une à partir des noms et de leur ordre : il faut alors **ajouter un nouveau bloc** d'export à chaque ajout (l'ancien bloc passe en `PGMLVL(*PRV)`). Avec une signature explicite, un seul bloc suffit.
- La signature ne valide **pas** l'interface d'une procédure : si les paramètres d'une procédure changent, recompiler tous les modules appelants et recréer les programmes et programmes de service qui les contiennent (`CRTPGM` / `CRTSRVPGM`).
- `CRTSRVPGM` utilise ce source avec `EXPORT(*SRCFILE)` (et non le défaut `*ALL`) ; `RTVBNDSRC` génère un source de départ.

**Groupes d'activation et programmes de service** (IBM 7.2 ; job-i)
- `ACTGRP(*CALLER)` : le programme de service s'active dans le groupe de l'appelant ; appels liés optimisés, données externes et fichiers ouverts partagés, validation / annulation qui touche les autres programmes du groupe ; **pas de frontière de contrôle** (une exception non traitée remonte au client, un verbe de fin peut supprimer le groupe du client).
- `ACTGRP(nom)` : espace séparé pour les variables, fichiers ouverts et définitions de validation séparés, partage accidentel évité ; il faut gérer l'état pour plusieurs clients.
- Tous les programmes d'un même groupe forment « une seule application coopérative » ; à la suppression d'un groupe, les ressources sont rendues (fichiers fermés, mémoire libérée).
- job-i : avec `ACTGRP(*ENTMOD)` (défaut de `CRTPGM`), un module d'entrée RPGLE fait tourner le programme dans le groupe `QILE` ; à privilégier, un groupe **nommé** par application plutôt que `*NEW`.
- RPG : `ctl-opt dftactgrp(*no) actgrp('NOM') bnddir('MONREP');` ; avec `DFTACTGRP(*YES)` (compatibilité OPM), `ACTGRP` et `BNDDIR` sont interdits et un appel de procédure liée fait échouer la compilation (job-i).
- `EXTPROC('nom')` impose la casse du nom de procédure (important pour une fonction C) ; sans lui, le nom du prototype en majuscules (job-i).

**Bonnes pratiques** (job-i) : sortir du mode compatible (`DFTACTGRP(*NO)`), regrouper les procédures partagées en programmes de service par domaine, un répertoire de liage par application cité dans le `CTL-OPT`, un groupe d'activation nommé par application, noms exacts.
### Les quatre pièces
1. **Modules `NOMAIN`** (un par responsabilité) : p. ex. un module d'accès aux données (`ARTICLEDAO`) et un module point d'entrée. Un module `NOMAIN` n'a pas de cycle : il exporte des procédures.
2. **Copybooks (`/COPY`)** : prototypes (`DCL-PR`) et constantes partagés entre les modules et les appelants (`ARTICLE_H`).
3. **Programme de service** (`WSARTICLE`) : regroupe les modules (`CRTSRVPGM MODULE(...)`). Avec `EXPORT(*ALL)`, tout ce qui est exporté par les modules l'est aussi ; avec `EXPORT(*SRCFILE)`, un **source de liage** liste précisément les procédures (et la signature).
4. **Source de liage** : membre contenant `STRPGMEXP`, `EXPORT SYMBOL(...)`, `ENDPGMEXP` (voir « Source de liage et signature » ci-dessous) ; on peut le générer avec `RTVBNDSRC`. `DSPSRVPGM DETAIL(*PROCEXP)` contrôle ce qui est réellement exporté.

### Commandes de la chaîne (à tester)
```
CRTSQLRPGI OBJ(BIB01/ARTICLEDAO) SRCFILE(BIB01/QRPGLESRC) SRCMBR(ARTICLEDAO) OBJTYPE(*MODULE) COMMIT(*NONE)
CRTSRVPGM SRVPGM(BIB01/WSARTICLE) MODULE(BIB01/ARTICLEDAO BIB01/ARTICLE_API) EXPORT(*ALL) ACTGRP(*CALLER)
DSPSRVPGM SRVPGM(BIB01/WSARTICLE) DETAIL(*PROCEXP)
```
`CRTRPGMOD` (module sans SQL), `CRTBNDDIR` / `ADDBNDDIRE` (répertoire de liage) : voir le mémo des commandes (partie 4). Pour la suppression et la recréation : `DLTSRVPGM` puis `CRTSRVPGM` (les droits sont à vérifier, voir la partie 3 et le mémo de la partie 4).

### Exemple complet : liste de bonbons en JSON, exposée en service REST
> Code fourni par l'utilisateur (4 membres, ordre de création : `BONBON_H`, `BONBONDAO`, `GETBON_H`, `GET_BONBON`), **anonymisé** : bibliothèque `BIB01`, point d'entrée et copybook renommés (`GET_BONBON`, `GETBON_H`). **Compilé par l'utilisateur (les quatre membres et le programme de service)** ; l'exécution et le déploiement IWS ne sont pas confirmés. Table et colonnes (`BONBON` : `"NUMBER"`, `NOM`, `MARQUE`, `COULEUR`, `PRIX`) supposées d'après le code.

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
| `CAST(… AS VARCHAR(30000))` ; `"NUMBER"` entre guillemets ; `SELECT INTO :var :indicateur` | **compilé** (confirmé par l'utilisateur) ; résultat à l'exécution non confirmé | — |
| `SET OPTION COMMIT = *NONE, CLOSQLCSR = *ENDMOD` en tête d'un module `NOMAIN` | **compilé** (confirmé par l'utilisateur) | — |
| `**free` en première ligne d'un membre `/COPY` | **compilé** (confirmé par l'utilisateur) | — |
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

## Partie 4 : mémo des commandes système (ILE, IWS, exploitation)

> Toutes ces commandes ont une fiche sur job-i (vérifiée le 2026-11-23, syntaxe minimale reprise de la fiche). Dans une session 5250 : taper la commande puis **F4** pour l'invite, **F1** sur un paramètre pour l'aide. Les enchaînements viennent de l'exemple « bonbons » et de la page job-i « ILE ». Valeurs de paramètres non citées ici : à vérifier avec F4 (non vérifié).

### Compiler et lier

| Commande | Rôle | Syntaxe minimale |
|---|---|---|
| [`CRTSQLRPGI`](https://job-i.fr/commandes-ibm-i/crtsqlrpgi) | précompile le SQL puis compile ; `OBJTYPE(*PGM \| *SRVPGM \| *MODULE)` (voir la fiche 07) | `CRTSQLRPGI OBJ(BIB01/BONBONDAO) SRCFILE(BIB01/WEBSERVICE) SRCMBR(BONBONDAO) OBJTYPE(*MODULE) COMMIT(*NONE)` |
| [`CRTRPGMOD`](https://job-i.fr/commandes-ibm-i/crtrpgmod) | module RPG sans SQL (`DBGVIEW(*SOURCE)` pour déboguer) | `CRTRPGMOD MODULE(BIB01/GET_BONBON) SRCFILE(BIB01/WEBSERVICE)` |
| [`CRTBNDRPG`](https://job-i.fr/commandes-ibm-i/crtbndrpg) | compile et lie en un programme (module temporaire) ; `DFTACTGRP(*YES)` interdit `ACTGRP` / `BNDDIR` | `CRTBNDRPG PGM(BIB01/MONPGM) SRCFILE(BIB01/QRPGLESRC)` |
| [`CRTCLMOD`](https://job-i.fr/commandes-ibm-i/crtclmod) | module CL | `CRTCLMOD MODULE(BIB01/MONCL) SRCFILE(BIB01/QCLSRC)` |
| [`CRTPGM`](https://job-i.fr/commandes-ibm-i/crtpgm) | lie des modules (par copie) en un programme ; `ENTMOD` = module d'entrée | `CRTPGM PGM(BIB01/MONPGM) MODULE(BIB01/MOD1 BIB01/MOD2) ENTMOD(BIB01/MOD1)` |
| [`CRTSRVPGM`](https://job-i.fr/commandes-ibm-i/crtsrvpgm) | programme de service ; `EXPORT(*ALL)` ou `*SRCFILE` (+ `SRCFILE`, défaut `QSRVSRC`, `SRCMBR`) ; `ACTGRP(*CALLER)` ou nom ; `BNDDIR`, `BNDSRVPGM` | `CRTSRVPGM SRVPGM(BIB01/WSBONBON) MODULE(BIB01/BONBONDAO BIB01/GET_BONBON) EXPORT(*ALL) ACTGRP(*CALLER)` |
| [`UPDSRVPGM`](https://job-i.fr/commandes-ibm-i/updsrvpgm) | remplace un ou plusieurs modules d'un programme de service sans le recréer | `UPDSRVPGM SRVPGM(BIB01/WSBONBON) MODULE(BIB01/BONBONDAO)` |
| [`UPDPGM`](https://job-i.fr/commandes-ibm-i/updpgm) | idem pour un programme lié **par copie** | `UPDPGM PGM(BIB01/MONPGM) MODULE(BIB01/MOD1)` |
| [`CRTBNDDIR`](https://job-i.fr/commandes-ibm-i/crtbnddir) | crée un répertoire de liage | `CRTBNDDIR BNDDIR(BIB01/MONREP)` |
| [`ADDBNDDIRE`](https://job-i.fr/commandes-ibm-i/addbnddire) | ajoute un poste (module ou programme de service) | `ADDBNDDIRE BNDDIR(BIB01/MONREP) OBJ((BIB01/WSBONBON *SRVPGM))` |

### Inspecter

| Commande | Rôle | Syntaxe minimale |
|---|---|---|
| [`DSPSRVPGM`](https://job-i.fr/commandes-ibm-i/dspsrvpgm) | infos sur un programme de service ; `DETAIL(*PROCEXP)` = procédures exportées (signature courante), aussi `*MODULE`, `*SRVPGM`, `*DTAEXP`, `*SIGNATURE`, `*ALL`… | `DSPSRVPGM SRVPGM(BIB01/WSBONBON) DETAIL(*PROCEXP)` |
| [`DSPPGM`](https://job-i.fr/commandes-ibm-i/dsppgm) | infos sur un programme ; `DETAIL(*MODULE)` = modules et langage (exemple job-i) | `DSPPGM PGM(BIB01/MONPGM) DETAIL(*MODULE)` |
| [`DSPMOD`](https://job-i.fr/commandes-ibm-i/dspmod) | infos sur un module (compilateur, source d'origine) | `DSPMOD MODULE(BIB01/GET_BONBON)` |
| [`DSPBNDDIR`](https://job-i.fr/commandes-ibm-i/dspbnddir) | contenu d'un répertoire de liage | `DSPBNDDIR BNDDIR(BIB01/MONREP)` |
| [`RTVBNDSRC`](https://job-i.fr/commandes-ibm-i/rtvbndsrc) | extrait les exports de modules / programmes de service en source de liage | `RTVBNDSRC SRVPGM(BIB01/WSBONBON) SRCFILE(BIB01/QSRVSRC)` (paramètres exacts : F4) |
| [`DSPOBJD`](https://job-i.fr/commandes-ibm-i/dspobjd) | description d'objet (dates de création, source) | `DSPOBJD OBJ(BIB01/WSBONBON) OBJTYPE(*SRVPGM)` |
| [`DSPOBJAUT`](https://job-i.fr/commandes-ibm-i/dspobjaut) | liste des utilisateurs autorisés et leurs droits | `DSPOBJAUT OBJ(BIB01/WSBONBON) OBJTYPE(*SRVPGM)` |
| [`CHKOBJ`](https://job-i.fr/commandes-ibm-i/chkobj) | vérifie l'existence d'un objet et les droits de l'utilisateur | `CHKOBJ OBJ(BIB01/WSBONBON) OBJTYPE(*SRVPGM)` |

### Droits et nettoyage

| Commande | Rôle | Syntaxe minimale |
|---|---|---|
| [`GRTOBJAUT`](https://job-i.fr/commandes-ibm-i/grtobjaut) | accorde des droits sur des objets à un utilisateur ou groupe | `GRTOBJAUT OBJ(BIB01/WSBONBON) OBJTYPE(*SRVPGM) USER(QWSERVICE) AUT(*USE)` (paramètres `USER` et `AUT` : F4) |
| [`DLTSRVPGM`](https://job-i.fr/commandes-ibm-i/dltsrvpgm) | supprime un programme de service | `DLTSRVPGM SRVPGM(BIB01/WSBONBON)` |
| [`DLTMOD`](https://job-i.fr/commandes-ibm-i/dltmod) | supprime un module | `DLTMOD MODULE(BIB01/GET_BONBON)` |

### Environnement et sources

| Commande | Rôle | Syntaxe minimale |
|---|---|---|
| [`CRTLIB`](https://job-i.fr/commandes-ibm-i/crtlib) | crée une bibliothèque | `CRTLIB LIB(BIB01)` |
| [`CRTSRCPF`](https://job-i.fr/commandes-ibm-i/crtsrcpf) | crée un fichier source (`RCDLEN`) | `CRTSRCPF FILE(BIB01/WEBSERVICE)` |
| [`ADDPFM`](https://job-i.fr/commandes-ibm-i/addpfm) | ajoute un membre à un fichier physique | `ADDPFM FILE(BIB01/WEBSERVICE) MBR(BONBONDAO)` |
| [`CPYFRMSTMF`](https://job-i.fr/commandes-ibm-i/cpyfrmstmf) | copie un fichier STREAM (IFS) vers un membre source | `CPYFRMSTMF FROMSTMF('/tmp/src.rpgle') TOMBR('/QSYS.LIB/BIB01.LIB/WEBSERVICE.FILE/BONBONDAO.MBR')` (chemin : à vérifier) |
| [`ADDLIBLE`](https://job-i.fr/commandes-ibm-i/addlible) / [`DSPLIBL`](https://job-i.fr/commandes-ibm-i/dsplibl) | ajoute une bibliothèque à la liste / affiche la liste | `ADDLIBLE LIB(BIB01)` ; `DSPLIBL` |

### Serveur IWS et exploitation

| Commande | Rôle | Syntaxe minimale |
|---|---|---|
| [`STRTCPSVR`](https://job-i.fr/commandes-ibm-i/strtcpsvr) / [`ENDTCPSVR`](https://job-i.fr/commandes-ibm-i/endtcpsvr) | démarre / arrête les serveurs d'application TCP/IP ; `ENDTCPSVR` a des paramètres `SERVER`, `HTTPSVR`, `DNSSVR`… | `STRTCPSVR SERVER(...)` ; valeurs pour le serveur HTTP / IWS : F4 (non vérifié) |
| [`WRKACTJOB`](https://job-i.fr/commandes-ibm-i/wrkactjob) | travaux actifs ; l'utilisateur consulte le sous-système `QHTTPSVR` pour les travaux du serveur (option 5 puis 10 : non vérifié) | `WRKACTJOB` |
| [`DSPJOBLOG`](https://job-i.fr/commandes-ibm-i/dspjoblog) | historique d'un travail (messages d'erreur du service) | `DSPJOBLOG` |
| [`DSPJOB`](https://job-i.fr/commandes-ibm-i/dspjob) / [`WRKJOB`](https://job-i.fr/commandes-ibm-i/wrkjob) | état d'un travail / gestion d'un travail | `DSPJOB JOB(...)` |
| [`WRKSPLF`](https://job-i.fr/commandes-ibm-i/wrksplf) | fichiers spoule | `WRKSPLF` |
| [`STRDBG`](https://job-i.fr/commandes-ibm-i/strdbg) / [`ENDDBG`](https://job-i.fr/commandes-ibm-i/enddbg) | démarre / arrête le débogage (modules compilés avec `DBGVIEW(*SOURCE)`) | `STRDBG PGM(BIB01/MONPGM)` |

### Enchaînements à retenir
- **Après avoir changé le code d'un module** : recompiler le module (`CRTRPGMOD` / `CRTSQLRPGI … *MODULE`) puis `UPDSRVPGM` (programme de service) ; pour un programme lié par copie, `UPDPGM`.
- **Si une signature de procédure change** : recompiler tous les modules appelants et recréer les programmes concernés (IBM, page « Signature »).
- **Recréer un programme de service** (`DLTSRVPGM` puis `CRTSRVPGM`) : revérifier les droits (`DSPOBJAUT`, `GRTOBJAUT`) et, pour IWS, redéployer le service (hypothèse de la partie 2, non vérifiée).
- **Vérifier ce qui est exposé** : `DSPSRVPGM … DETAIL(*PROCEXP)`.
- **Savoir d'où vient un objet** : `DSPOBJD`, `DSPMOD`, `DSPPGM … DETAIL(*MODULE)`.
