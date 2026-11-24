# Partie 07 : RPG IV (ILE RPG, format fixe étendu)

> Plan de formation, partie 07 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Du RPG III au RPG IV, spécifications H, F, D, C, P, types et structures de données, expressions et structures de contrôle, fonctions intégrées, gestion des erreurs, compilation.
>
> **Mots-clés** : RPG IV, ILE RPG, CVTRPGSRC, H, F, D, C, P, EVAL, IF, DOW, FOR, SELECT, %TRIM, %SUBST, %SCAN, MONITOR, CRTBNDRPG, CRTRPGMOD, STRDBG.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Cours détaillé](#cours-détaillé)
  - [1. Du RPG III au RPG IV](#1-du-rpg-iii-au-rpg-iv)
  - [2. Les spécifications du RPG IV (format colonné)](#2-les-spécifications-du-rpg-iv-format-colonné)
  - [3. Types et structures de données](#3-types-et-structures-de-données)
  - [4. Expressions et structures de contrôle](#4-expressions-et-structures-de-contrôle)
  - [5. Fonctions intégrées (BIF)](#5-fonctions-intégrées-bif)
  - [6. Gestion des erreurs](#6-gestion-des-erreurs)
  - [7. Appels prototypés : PR et PI](#7-appels-prototypés--pr-et-pi)
  - [8. Compilation et mise au point](#8-compilation-et-mise-au-point)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Du RPG III au RPG IV](#du-rpg-iii-au-rpg-iv)
  - [Les spécifications du RPG IV](#les-spécifications-du-rpg-iv)
  - [Les types et structures de données](#les-types-et-structures-de-données)
  - [Expressions et structures de contrôle](#expressions-et-structures-de-contrôle)
  - [Les fonctions intégrées](#les-fonctions-intégrées)
  - [La gestion des erreurs](#la-gestion-des-erreurs)
  - [Compilation et mise au point](#compilation-et-mise-au-point)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 03 : RPG par version](../cheatsheets/03-rpg-par-version.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Coder en RPG IV colonné : 3 programmes, CRTBNDRPG, débogage STRDBG et tests](https://job-i.fr/coder-rpg-iv) | RPG IV (RPGLE) : colonnes élargies, spécification D, vraies expressions ; CRTBNDRPG et STRDBG. | En une phrase ; Préparer l'atelier ; Les colonnes du RPG IV ; Hello world : une déclaration, deux calculs ; Sortir du stock un article lu par sa clé ; Consulter un article par son code ou par son libellé ; Compiler avec CRTBNDRPG ; Déboguer avec STRDBG ; Tester (tester, c'est douter !) |
| [Instructions RPG full free (DCL-S, DCL-DS, CHAIN, FOR-EACH…) sur IBM i et AS/400](https://job-i.fr/instructions-rpg) | Index des instructions RPG full free (déclarations, fichiers, structures de contrôle, appels). | Déclarations ; Mots-clés de déclaration ; Structures de contrôle ; Procédures, sous-programmes et erreurs ; Lecture de fichiers ; Écriture et contrôle des fichiers ; Données et calculs |
| [Fonctions RPG full free (BIF) sur IBM i et AS/400 : exemples testés](https://job-i.fr/fonctions-rpg) | Index des fonctions intégrées (BIF) du full free, par famille. | Chaînes de caractères ; Conversions et calculs ; Dates et heures ; Tableaux et listes ; Fichiers et erreurs ; Paramètres, procédures et mémoire ; Bits, XML et JSON |
| [Mot d'édition RPG (spécification O, %EDITW) : règles et exemples testés](https://job-i.fr/mots-edition-rpg) | Un mot d'édition est un gabarit entre apostrophes qui décrit l'impression d'un nombre (chiffres, suppression des zéros, virgule, signe). | En une phrase ; Où l'écrire ; Les trois parties d'un mot d'édition ; Les caractères qui ont un sens ; Les exemples, imprimés sur IBM i ; L'euro, la virgule et DECEDIT ; Un relevé de compte, en RPG III, RPG IV et full free ; Les pièges, vérifiés sur le banc |
| [Constantes figuratives RPG : *BLANKS, *HIVAL, *LOVAL, *ALL, exemples testés](https://job-i.fr/constantes-figuratives-rpg) | Une constante figurative (*BLANKS, *HIVAL, *LOVAL, *ALL...) prend la taille et le type de la zone cible. | En une phrase ; Les constantes du RPG ; Ce que chaque constante met dans la zone ; Ce que le compilateur refuse ; *BLANKS sur une structure : l'erreur de données décimales ; *LOVAL, *HIVAL, *START et *END dans un fichier ; Les mêmes constantes en RPG III ; En CL, *BLANKS n'est pas une constante |
| [PR et PI en RPG : prototype et interface de procédure, colonné et full free](https://job-i.fr/prototypes-rpg-pr-pi) | Le prototype PR décrit l'appel, l'interface PI déclare les paramètres reçus ; le compilateur contrôle leur cohérence dans un même source. | En une phrase ; PR et PI, c'est quoi ; Où ça s'écrit en RPG IV colonné ; Un PI à la place de *ENTRY PLIST ; Appeler un programme par son prototype ; Pourquoi le prototype dans un /COPY ; Des procédures internes, avec ou sans PR ; Les modes de passage des paramètres ; Voir les paramètres reçus dans le débogueur ; Les erreurs, et ce qu'elles veulent dire |

## Cours détaillé

> Synthèses personnelles à partir de job-i.fr (pages lues en partie ; les exemples « compilés et exécutés sur IBM i 7.5 » sont ceux que job-i annonce comme tels) et des aides de commandes IBM i 7.5 reproduites par job-i. L'assistant ne compile rien : les exemples que j'écris moi-même sont marqués *hypothèse*. La **référence IBM « ILE RPG » (ibm.com) n'a pas été lue** pour cette partie.

### 1. Du RPG III au RPG IV

Le RPG IV (ILE RPG, type de membre `RPGLE`) est sorti en **1994** ; ses programmes sont des programmes **ILE**. Il garde les colonnes mais les élargit, ajoute la **spécification D** (déclarations) et accepte de vraies **expressions**. Il n'y a plus de spécification E : tableaux, zones et paramètres se déclarent en D. L'ordre devient H, puis F et D (mélangeables depuis la 7.2, selon job-i), I, C, O, puis les sous-procédures (P). Les DDS (PF, LF, écran) ne dépendent pas du langage : les mêmes servent en RPG III et IV.

| RPG III | RPG IV | Gain (job-i) |
|---|---|---|
| `*ENTRY PLIST` + `PARM` | spécification D de type `PI` | paramètres déclarés avec leur type |
| `MOVEL`/`MOVE` pour un texte | `INZ('Hello world !')` | plus de limite de 8 caractères |
| `MOVE PQTEA QTE 50` | `EVAL Qte = %DEC(PQteA:5:0)` | conversion explicite |
| indicateur 91 en 54-55 du `CHAIN` | `IF NOT %FOUND(ARTICLE)` | condition lisible |
| `IFGT` imbriqué dans un `ELSE` | `ELSEIF Qte > ARTSTK` | une seule structure |
| `SUB QTE ARTSTK` | `EVAL ARTSTK = ARTSTK - Qte` | expression |
| `UPDAT`, `SETON LR` | `UPDATE`, `EVAL *INLR = *ON` | codes opération non tronqués |
| `MOVE *BLANKS` + `Z-ADD 0` | `CLEAR zone` | remise à blanc ou zéro selon le type |

**Conversion automatique : `CVTRPGSRC`** (bibliothèque QDEVTOOLS) « convertit le code source RPG III ou RPG/400 en code source ILE RPG ». Paramètres : `FROMFILE`, `FROMMBR` (nom, générique ou `*ALL`), `TOFILE` (défaut `QRPGLESRC`), `TOMBR`, `EXPCPY` (développer les membres COPY), `CVTRPT` (rapport de conversion), `SECLVL`, `INSRTPL`, `LOGFILE` (défaut `QRNCVTLG`), `LOGMBR`. Limites de la conversion : voir « à vérifier » (non lues).

| Élément | Statut | Source |
|---|---|---|
| RPG IV de 1994, programmes ILE, spécification D, disparition de la E, tableau de comparaison | vérifié (page lue, début) | [job-i : coder en RPG IV](https://job-i.fr/coder-rpg-iv) |
| CVTRPGSRC : rôle, paramètres, valeurs par défaut | vérifié (aide lue, début) | [job-i : CVTRPGSRC](https://job-i.fr/commandes-ibm-i/cvtrpgsrc) |
| Limites de la conversion (ce que CVTRPGSRC ne convertit pas, rapport) | **non vérifié** | à chercher sur ibm.com |

### 2. Les spécifications du RPG IV (format colonné)

| Spéc. F | Colonnes |
|---|---|
| Nom du fichier | 7-16 (10 caractères) |
| Type | 17 : `I` entrée, `O` sortie, `U` mise à jour, `C` combiné (écran) |
| Désignation | 18 : `F` procédure complète |
| Format | 22 : `E` décrit en externe |
| Type d'adresse | 34 : `K` accès par la clé |
| Unité | 36-42 : `DISK`, `WORKSTN`, `PRINTER` |
| Mots-clés | 44-80 : `RENAME`, `PREFIX`, `INFDS`… |

| Spéc. D | Colonnes |
|---|---|
| Nom | 7-21 (casse libre) |
| Type de déclaration | 24-25 : `S` zone simple, `C` constante, `DS` structure, `PR` prototype, `PI` interface ; blanc = paramètre ou sous-zone |
| Longueur | 33-39 (cadrée à droite) |
| Type de données | 40 : `A`, `P`, `S`… |
| Décimales | 41-42 |
| Mots-clés | 44-80 : `INZ`, `DIM`, `LIKE`… |

| Spéc. C | Colonnes |
|---|---|
| Facteur 1 | 12-25 (14 positions) |
| Code opération | 26-35 (10 positions, extension comprise : `CHAIN(N)`) |
| Facteur 2 | 36-49 ; **facteur 2 étendu** 36-80 (expression pour `EVAL`, `IF`, `ELSEIF`, `DOW`…) |
| Résultat | 50-63 |
| Longueur | 64-68 (rarement utile) |
| Indicateurs résultants | 71-76 (remplacés par `%FOUND`, `%EOF`, `%ERROR`) |

**Spécification H / `CTL-OPT`** : en format libre `ctl-opt` remplace la spécification H ; mots-clés notables : `dftactgrp(*no)`, `actgrp(*new | *caller | 'NOM')`, `datfmt`, `timfmt`, `decedit('0,')`, `alwnull(*usrctl)`. L'instruction est lue à la compilation et vaut pour tout le programme ; presque tous les programmes modernes commencent par `dftactgrp(*no) actgrp(*new)`. En colonné, la ligne `H DFTACTGRP(*NO) DECEDIT('0,')` fait le même travail (exemple TVA4 de job-i).

**Spécifications P** : les procédures sont encadrées par `P` en `B` (début) et `E` (fin) en colonne 24.

**Exemple colonné complet** (job-i, annoncé compilé : programme SORTIE) :

```
F ARTICLE  UF   E           K DISK
D SORTIE          PI
D  PCode                         5A
D  PQteA                         5A
D  PRet                          3A
D Qte             S              5P 0
C                   EVAL      Qte = %DEC(PQteA:5:0)
C     PCode         CHAIN     ARTICLE
C                   IF        NOT %FOUND(ARTICLE)
C                   EVAL      PRet = 'INC'
C                   ELSEIF    Qte > ARTSTK
C                   EVAL      PRet = 'INS'
C                   ELSE
C                   EVAL      ARTSTK = ARTSTK - Qte
C                   UPDATE    ARTICLR
C                   EVAL      PRet = 'OK '
C                   ENDIF
C                   EVAL      *INLR = *ON
```

| Élément | Statut | Source |
|---|---|---|
| Colonnes des spécifications F, D, C | vérifié (tableaux de la page) | [job-i : coder en RPG IV](https://job-i.fr/coder-rpg-iv) |
| `CTL-OPT` : mots-clés, rôle, position | vérifié (début de page) | [job-i : CTL-OPT](https://job-i.fr/instructions-rpg/ctl-opt) |
| Spécifications P (`B`/`E` col. 24) | vérifié | [job-i : PR et PI](https://job-i.fr/prototypes-rpg-pr-pi) |
| Mélange F/D permis depuis la 7.2 | vérifié (formulation de job-i) ; non contrôlé sur ibm.com | [job-i : coder en RPG IV](https://job-i.fr/coder-rpg-iv) |
| Spécification I, O en RPG IV | **non lue** | liens du plan |

### 3. Types et structures de données

**Zone simple** (`dcl-s` en libre, `S` en spécification D) : types `char`, `varchar`, `packed`, `zoned`, `int`, `uns`, `float`, `ind`, `date`, `time`, `timestamp`, `pointer`… avec longueur et décimales ; `inz` (sans valeur : blancs ou zéro), `like(autre)`, `dim(n)` pour un tableau, `static` (dans une procédure, garde la valeur d'un appel à l'autre). Conseils de job-i : `packed`/`zoned` pour un montant, `int` pour un compteur, `varchar` quand la longueur varie, `ind` pour un booléen.

```
dcl-s nomClient char(20) inz('Dupont SA');
dcl-s solde packed(9:2) inz(1250.50);
dcl-s actif ind inz(*on);
```

**Structure de données** (`dcl-ds … end-ds`, `DS` en colonné) : regrouper des zones (copie d'un bloc, passage en paramètre, découpage). `qualified` (sous-champs écrits `nom.sousChamp`, à préférer), `inz` (sans lui, les sous-champs numériques ne contiennent **pas de nombre valide**), `likeds(modèle)`, `overlay(sousChamp : position)` pour découper une zone (ex. date `AAAAMMJJ` en trois sous-champs), `%size(structure)`.

**Constantes nommées** : `dcl-c` ([page](https://job-i.fr/instructions-rpg/dcl-c), non relue). **Constantes figuratives** (`*BLANKS`, `*ZEROS`, `*HIVAL`, `*LOVAL`, `*ALL`) : prennent la taille et le type de la zone cible ; `*BLANKS` sur une structure contenant des numériques provoque l'erreur de données décimales ([job-i](https://job-i.fr/constantes-figuratives-rpg), rubriques lues, texte non relu). **Dates et heures** : types `date`, `time`, `timestamp`, format interne fixé par `datfmt`/`timfmt` ; `%DIFF(v1 : v2 : unité)` rend l'écart entier (`*YEARS`, `*MONTHS`, `*DAYS`, `*HOURS`, `*MINUTES`, `*SECONDS`, `*MSECONDS`), positif si `v1` est plus récent, reste supprimé sans arrondi.

| Élément | Statut | Source |
|---|---|---|
| DCL-S : types, inz, like, dim, static | vérifié (début de page) | [job-i : DCL-S](https://job-i.fr/instructions-rpg/dcl-s) |
| DCL-DS : qualified, inz, likeds, overlay, piège de l'inz | vérifié (début de page) | [job-i : DCL-DS](https://job-i.fr/instructions-rpg/dcl-ds) |
| %DIFF (unités, signe, troncature) | vérifié (début de page) | [job-i : %DIFF](https://job-i.fr/fonctions-rpg/diff) |
| `%DATE`, `%DAYS`, DIM, OVERLAY (pages dédiées), DCL-C | existence vérifiée, non relues | [%DATE](https://job-i.fr/fonctions-rpg/date) · [%DAYS](https://job-i.fr/fonctions-rpg/days) · [DIM](https://job-i.fr/instructions-rpg/dim) |
| Page job-i dédiée aux dates (formats, `*ISO`, `*EUR`…) | aucune trouvée | manque à signaler |

### 4. Expressions et structures de contrôle

- **`EVAL`** (facteur 2 étendu en colonné) : affectation par expression ; `EVAL(H)` arrondit (exemple TVA4 : `EVAL(H) MONTANTTTC = MONTANTHT * (1 + TAUX/100)`). **`EVALR`** : cadre à droite (page [EVAL](https://job-i.fr/instructions-rpg/eval), non relue).
- **`IF` / `ELSEIF` / `ELSE` / `ENDIF`**, **`DOW`** (test avant), **`DOU`**, **`LEAVE`** (sortie de boucle, vu dans ARTCON), **`FOR i = début TO fin [BY pas]` / `DOWNTO` / `ENDFOR`** : le compteur vaut à la sortie la première valeur qui dépasse la limite (4 après `FOR i = 1 TO 3`), `FOR-EACH` pour parcourir un tableau.
- **`SELECT` / `WHEN` / `OTHER` / `ENDSL`** : seul le bloc du **premier** `WHEN` vrai s'exécute ; formes `SELECT valeur; WHEN-IS valeur; WHEN-IN liste;` acceptées sur la machine d'essai de job-i (IBM i 7.5).
- **Réduire les indicateurs** : à la place de l'indicateur résultant, `%FOUND`, `%EOF`, `%ERROR` ; les indicateurs d'écran restent possibles par affectation (`EVAL *IN41 = NOT %FOUND(ARTICLE)`, `EVAL *IN42 = %EOF(ARTICL1)`) ; `DOW NOT *IN03` pour la boucle d'un écran (job-i, programme ARTCON).

| Élément | Statut | Source |
|---|---|---|
| FOR (TO/DOWNTO/BY, valeur finale du compteur) | vérifié (début de page + exemple exécuté) | [job-i : FOR](https://job-i.fr/instructions-rpg/for) |
| SELECT / WHEN / OTHER, WHEN-IS / WHEN-IN | vérifié (début de page + exemple exécuté) | [job-i : SELECT](https://job-i.fr/instructions-rpg/select) |
| Boucle d'écran, LEAVE, `*IN41 = NOT %FOUND`, CLEAR | vérifié (programme ARTCON) | [job-i : coder en RPG IV](https://job-i.fr/coder-rpg-iv) |
| EVAL/EVALR, IF, DOW, DOU, FOR-EACH | pages existantes, non relues (sauf FOR) | [EVAL](https://job-i.fr/instructions-rpg/eval) · [IF](https://job-i.fr/instructions-rpg/if) · [DOW](https://job-i.fr/instructions-rpg/dow) · [DOU](https://job-i.fr/instructions-rpg/dou) |
| Page job-i sur la réduction des indicateurs | aucune trouvée | manque à signaler |

### 5. Fonctions intégrées (BIF)

| BIF | Rôle (synthèse job-i) |
|---|---|
| `%TRIM(chaîne [: caractères])` | retire blancs (ou caractères listés) au début et à la fin ; résultat variable ; vide si tout est retiré |
| `%SCAN(recherché : chaîne [: début])` | position de la 1re occurrence (à partir de 1), `0` si absent, **casse comptée** ; test direct `if %scan('x':texte) > 0` |
| `%SUBST(chaîne : début [: longueur])` | extrait une portion ; à gauche du `=`, désigne la portion à remplacer |
| `%FOUND [(fichier)]` | `*ON` si le dernier `CHAIN`/`SETLL`/`SETGT` a trouvé |
| `%STATUS [(fichier)]` | code d'état : 0 = bon ; < 1000 situations du programme ou de lecture (11 fin de fichier, 12 non trouvé, 102 division par zéro, 211 appel en erreur) ; ≥ 1000 erreurs d'E/S (1021 doublon, 1211 fichier fermé, 1299 donnée illisible) |
| `%DIFF(v1 : v2 : unité)` | écart entre deux dates, heures ou horodatages |

Autres BIF du plan (pages existantes, **non relues**) : `%REPLACE`, `%CHAR`, `%DEC`, `%INT`, `%EDITC`, `%EDITW`, `%EOF`, `%ERROR`, `%DATE`, `%DAYS`, `%OPEN`. Mots d'édition et `%EDITW` : [partie 03, § 4](03-outils-de-developpement.md#cours-détaillé).

| Élément | Statut | Source |
|---|---|---|
| %TRIM, %SCAN, %SUBST, %FOUND, %STATUS, %DIFF | vérifié (début de chaque page) | [%TRIM](https://job-i.fr/fonctions-rpg/trim) · [%SCAN](https://job-i.fr/fonctions-rpg/scan) · [%SUBST](https://job-i.fr/fonctions-rpg/subst) · [%FOUND](https://job-i.fr/fonctions-rpg/found) · [%STATUS](https://job-i.fr/fonctions-rpg/status) |
| %REPLACE, %CHAR, %DEC (rôle dans SORTIE : conversion de texte en nombre), %INT, %EDITC, %EOF, %ERROR, %OPEN | `%DEC` et `%EOF` vus dans des exemples ; autres non relus | [job-i : fonctions RPG](https://job-i.fr/fonctions-rpg) |

### 6. Gestion des erreurs

- **`MONITOR` / `ON-ERROR` / `ENDMON`** : surveille un groupe d'instructions ; à l'erreur, saut au `ON-ERROR` dont le code correspond (codes séparés par `:`, ou `*PROGRAM` pour les erreurs de programme) ; les instructions du `MONITOR` qui suivent l'erreur ne s'exécutent pas ; l'exécution reprend **après `ENDMON`** ; `%STATUS` contient le code à l'entrée du `ON-ERROR` ; un `ON-ERROR` sans code, placé en dernier, sert de filet. Exemples de codes (job-i) : `00102` division par zéro, `00105` conversion impossible, `00202` appel terminé en erreur.

```
monitor;
  moyenne = montant / nbclient;
on-error 00102;
  snd-msg 'Division par zero, statut ' + %char(%status);
  moyenne = 0;
endmon;
```
*(extrait d'un exemple job-i annoncé exécuté)*

- **Avant MONITOR** : extension **(E)** sur l'opération (erreur testée par `%ERROR`) ou indicateur d'erreur en 56-57 en RPG III (voir [partie 06](06-rpg-iii.md#cours-détaillé)). Sans indicateur d'erreur, job-i précise (page CHAIN, RPG III) qu'une erreur d'entrée-sortie arrête le programme.

| Élément | Statut | Source |
|---|---|---|
| MONITOR / ON-ERROR : syntaxe, codes, `%STATUS`, reprise après ENDMON | vérifié (début de page + exemple) | [job-i : MONITOR](https://job-i.fr/instructions-rpg/monitor) |
| %STATUS (codes courants) | vérifié (début de page) | [job-i : %STATUS](https://job-i.fr/fonctions-rpg/status) |
| %ERROR, extension (E) en RPG IV | page existante, non relue | [%ERROR](https://job-i.fr/fonctions-rpg/error) |
| Routines d'erreur (`*PSSR`, `INFSR`) | **non vérifié** (aucune page lue) | à chercher sur ibm.com |

### 7. Appels prototypés : PR et PI

Le **prototype (PR)** décrit un appel (chez l'appelant, et par `/COPY` chez l'appelé) ; l'**interface de procédure (PI)** déclare, dans l'appelé, les paramètres reçus ; dans un même source, le compilateur **vérifie la cohérence**. En colonné : spécification D, `PR`/`PI` en 24-25 ; en libre : `dcl-pr … end-pr`, `dcl-pi … end-pi`. `EXTPGM('NOM')` fait du prototype celui d'un **programme** (appel dynamique) ; sans `EXTPGM` ni `EXTPROC` c'est le prototype d'une procédure. Quand un prototype existe, le PI porte **le même nom** et le prototype le précède (`/COPY` avant). Paramètres d'un programme : toujours transmis **par référence** ; `CONST` interdit à l'appelé de les modifier. Appel : `CALLP TVA4(100 : 20 : TTC)`. Compilation : une `CRTBNDRPG` par programme, bibliothèque dans la liste des bibliothèques (le `/COPY` cherche `QRPGLESRC` par `*LIBL`).

| Élément | Statut | Source |
|---|---|---|
| PR/PI, EXTPGM, /COPY, CONST, CALLP, exemples TVA4/TVAF | vérifié (début de page lu) | [job-i : PR et PI](https://job-i.fr/prototypes-rpg-pr-pi) |
| Modes de passage (VALUE, OPTIONS), débogage des paramètres, erreurs | **non lu** (suite de la page) | idem |
| Sur IBM i 7.5 aucun prototype exigé pour le programme principal | vérifié (formulation de job-i) | [job-i : coder en RPG IV](https://job-i.fr/coder-rpg-iv) |

### 8. Compilation et mise au point

- **`CRTBNDRPG`** compile **et** lie en une étape un programme `*PGM` ; paramètres notables : `PGM`, `SRCFILE`, `SRCMBR`, `SRCSTMF` (source dans l'IFS), `GENLVL` (gravité de génération, défaut 10, de 0 à 20), `DFTACTGRP`, `ACTGRP`, `BNDDIR`, `OPTION`, `DBGVIEW`, `OPTIMIZE`, `TGTRLS`, `ALWNULL`, `TRUNCNBR`, `INCDIR`. **`CRTRPGMOD`** crée seulement un **module** (à lier ensuite : [partie 10 ILE](10-ile.md)). L'option 14 de PDM appelle `CRTBNDRPG` pour un membre `RPGLE`.
- **`DBGVIEW(*SOURCE)`** garde la vue source pour le débogueur ; sans vue de débogage, `STRDBG` n'a pas de source à afficher.
- **`STRDBG`** (ILE) place le travail en mode débogage (jusqu'à 20 programmes, 20 programmes de service, 20 classes) ; `STRISDB` **refuse** un programme ILE (« Type de programme non valide ») : STRISDB = RPG III/OPM, STRDBG = ILE. Séquence de job-i : `STRDBG PGM(biblio/SORTIE) UPDPROD(*YES)`, point d'arrêt `F6` sur la ligne, `F12` pour rendre la main, `CALL SORTIE PARM('A0002' '00005' ' ')`, puis `ENDDBG`. `UPDPROD(*YES)` est nécessaire si le programme met à jour un fichier d'une bibliothèque de production.
- **Lecture des erreurs de compilation** : voir le listing (spoule du travail) ; messages et marques décrits dans [partie 06, § 7](06-rpg-iii.md#cours-détaillé) et [job-i : coder en RPG full free](https://job-i.fr/coder-rpg-full-free) (page non relue).

| Élément | Statut | Source |
|---|---|---|
| CRTBNDRPG : rôle, GENLVL 10, DBGVIEW, SRCSTMF, liste de paramètres | vérifié (début de page + aide partielle) | [job-i : CRTBNDRPG](https://job-i.fr/commandes-ibm-i/crtbndrpg) |
| CRTRPGMOD : liste de paramètres | vérifié (liste seulement) | [job-i : CRTRPGMOD](https://job-i.fr/commandes-ibm-i/crtrpgmod) |
| STRDBG : rôle et paramètres, séquence F6/F12/CALL/ENDDBG, STRISDB refusé sur ILE | vérifié (début de l'aide + page) | [job-i : STRDBG](https://job-i.fr/commandes-ibm-i/strdbg) · [coder en RPG IV](https://job-i.fr/coder-rpg-iv) |
| Mémo des commandes ILE | vérifié dans le wiki | [ILE-ET-SERVICES-WEB.md](../ILE-ET-SERVICES-WEB.md#partie-4--mémo-des-commandes-système-ile-iws-exploitation) |

### Ce qui reste à vérifier pour cette partie

Référence IBM *ILE RPG* (versions 7.5/7.6) : aucune page lue ; limites de `CVTRPGSRC` ; spécifications I et O en RPG IV ; `%ERROR`, extension (E), `*PSSR`/`INFSR` ; modes de passage des paramètres ; formats de date et d'heure ; le détail de `CRTBNDRPG` (options, `OPTION(*SRCSTMT)`…). Aucun exemple n'a été compilé par l'assistant. Manques à signaler : pas de page job-i dédiée aux dates, à la réduction des indicateurs, ni aux routines d'erreur.

## Plan détaillé (index des sujets)

### Du RPG III au RPG IV

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Les apports du RPG IV

- **job-i** : [RPG IV](https://job-i.fr/coder-rpg-iv)

#### La conversion CVTRPGSRC et ses limites

- **job-i** : [CVTRPGSRC](https://job-i.fr/commandes-ibm-i/cvtrpgsrc)

#### Le format fixe étendu et la lisibilité du source

- **job-i** : [Coder en RPG IV colonné](https://job-i.fr/coder-rpg-iv)

### Les spécifications du RPG IV

- **Dans le wiki** : aucune page dédiée (à documenter).

#### La spécification de contrôle H et ses mots-clés

- **job-i** : [CTL-OPT](https://job-i.fr/instructions-rpg/ctl-opt) · [Instructions RPG full free (DCL-S, DCL-DS, CHAIN, FOR-EAC...](https://job-i.fr/instructions-rpg) · [Coder en RPG IV colonné](https://job-i.fr/coder-rpg-iv)

#### La spécification F et les mots-clés de fichiers

- **job-i** : [DCL-F](https://job-i.fr/instructions-rpg/dcl-f)

#### La spécification D, déclaration des données

- **job-i** : [DCL-S](https://job-i.fr/instructions-rpg/dcl-s) · [DCL-DS](https://job-i.fr/instructions-rpg/dcl-ds) · [DCL-C](https://job-i.fr/instructions-rpg/dcl-c)

#### Les spécifications C et P

- **job-i** : [DCL-PROC](https://job-i.fr/instructions-rpg/dcl-proc)

### Les types et structures de données

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Types numériques, alphanumériques et varying

- **job-i** : [Coder en RPG IV colonné](https://job-i.fr/coder-rpg-iv) · [Instructions RPG full free (DCL-S, DCL-DS, CHAIN, FOR-EAC...](https://job-i.fr/instructions-rpg)

#### Dates, heures et horodatages

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Structures de données et sous-zones

- **job-i** : [DCL-DS](https://job-i.fr/instructions-rpg/dcl-ds) · [OVERLAY](https://job-i.fr/instructions-rpg/overlay)

#### Tableaux et tables

- **job-i** : [DIM](https://job-i.fr/instructions-rpg/dim)

#### Constantes nommées

- **job-i** : [DCL-C](https://job-i.fr/instructions-rpg/dcl-c)

### Expressions et structures de contrôle

- **Dans le wiki** : aucune page dédiée (à documenter).

#### EVAL, EVALR et les opérateurs

- **job-i** : [EVAL](https://job-i.fr/instructions-rpg/eval)

#### IF, DOW, DOU, FOR, SELECT

- **job-i** : [IF](https://job-i.fr/instructions-rpg/if) · [DOW](https://job-i.fr/instructions-rpg/dow) · [DOU](https://job-i.fr/instructions-rpg/dou) · [FOR](https://job-i.fr/instructions-rpg/for) · [SELECT](https://job-i.fr/instructions-rpg/select)

#### La réduction progressive des indicateurs

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Les fonctions intégrées

- **Dans le wiki** : [Fiche 03](../cheatsheets/03-rpg-par-version.md)

#### %TRIM, %SUBST, %SCAN, %REPLACE

- **job-i** : [%TRIM](https://job-i.fr/fonctions-rpg/trim) · [%SUBST](https://job-i.fr/fonctions-rpg/subst) · [%SCAN](https://job-i.fr/fonctions-rpg/scan) · [%REPLACE](https://job-i.fr/fonctions-rpg/replace)

#### %CHAR, %DEC, %INT, %EDITC

- **job-i** : [%CHAR](https://job-i.fr/fonctions-rpg/char) · [%DEC](https://job-i.fr/fonctions-rpg/dec) · [%INT](https://job-i.fr/fonctions-rpg/int) · [%EDITC](https://job-i.fr/fonctions-rpg/editc)

#### %FOUND, %EOF, %ERROR, %OPEN

- **job-i** : [%FOUND](https://job-i.fr/fonctions-rpg/found) · [%EOF](https://job-i.fr/fonctions-rpg/eof) · [%ERROR](https://job-i.fr/fonctions-rpg/error) · [%OPEN](https://job-i.fr/instructions-rpg/open)

#### Les BIF de date, %DATE, %DIFF, %DAYS

- **job-i** : [%DATE](https://job-i.fr/fonctions-rpg/date) · [%DIFF](https://job-i.fr/fonctions-rpg/diff) · [%DAYS](https://job-i.fr/fonctions-rpg/days)

### La gestion des erreurs

- **Dans le wiki** : aucune page dédiée (à documenter).

#### MONITOR, ON-ERROR, ENDMON

- **job-i** : [MONITOR](https://job-i.fr/instructions-rpg/monitor)

#### L'extension E et %ERROR / %STATUS

- **job-i** : [%STATUS](https://job-i.fr/fonctions-rpg/status) · [%ERROR](https://job-i.fr/fonctions-rpg/error)

#### Les routines d'erreur

- **job-i** : [Instructions RPG full free (DCL-S, DCL-DS, CHAIN, FOR-EAC...](https://job-i.fr/instructions-rpg)

### Compilation et mise au point

- **Dans le wiki** : [Mémo des commandes système (ILE)](../ILE-ET-SERVICES-WEB.md#partie-4--mémo-des-commandes-système-ile-iws-exploitation)

#### CRTBNDRPG et CRTRPGMOD

- **job-i** : [CRTBNDRPG](https://job-i.fr/commandes-ibm-i/crtbndrpg) · [CRTRPGMOD](https://job-i.fr/commandes-ibm-i/crtrpgmod)

#### STRDBG, points d'arrêt et variables surveillées

- **job-i** : [STRDBG](https://job-i.fr/commandes-ibm-i/strdbg)

#### Lecture des erreurs de compilation

- **job-i** : [Coder en RPG IV colonné](https://job-i.fr/coder-rpg-iv) · [Coder en RPG full free (**FREE)](https://job-i.fr/coder-rpg-full-free)
