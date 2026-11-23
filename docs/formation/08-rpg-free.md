# Partie 08 : RPG full free

> Plan de formation, partie 08 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Syntaxe full free, conversion depuis le format fixe, structures de données modernes, tableaux dynamiques, BIF récentes, FOR-EACH.
>
> **Mots-clés** : **FREE, CTL-OPT, DCL-F, DCL-S, DCL-C, DCL-DS, DCL-PR, DCL-PI, DCL-PROC, LIKEDS, LIKEREC, TEMPLATE, DIM(*AUTO), %SPLIT, %CONCAT, %LOOKUP, FOR-EACH, CVTRPGFREE.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Cours détaillé](#cours-détaillé)
  - [1. Le full free : principe](#1-le-full-free--principe)
  - [2. CTL-OPT et déclarations](#2-ctl-opt-et-déclarations)
  - [3. Procédures, prototypes et interfaces](#3-procédures-prototypes-et-interfaces)
  - [4. Structures de contrôle en libre](#4-structures-de-contrôle-en-libre)
  - [5. Conversion vers le full free](#5-conversion-vers-le-full-free)
  - [6. Données et fonctions modernes](#6-données-et-fonctions-modernes)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [La syntaxe full free](#la-syntaxe-full-free)
  - [La conversion vers le full free](#la-conversion-vers-le-full-free)
  - [Les données et les fonctions modernes](#les-données-et-les-fonctions-modernes)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 03 : RPG par version](../cheatsheets/03-rpg-par-version.md)
- [Exemples full free : impression](../IMPRESSION-RPG.md)
- [SQL avancé et exemples ILE](../ILE-ET-SERVICES-WEB.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## L'essentiel (vérifié dans le wiki)

- **Impression en full free (validé)** : `QSYSPRT PRINTER(132)` + une DS de 132 caractères par type de ligne (`POS`), espacements par lignes blanches ; spool identique à la référence RPG III ([partie 1](../IMPRESSION-RPG.md)).
- **PRTCTL** : structure `*COMPAT` de 9 octets (1+1+2+2+3) ou « longueur étendue » de 15 octets ([partie 2](../IMPRESSION-RPG.md#partie-2--prtctl-contrôle-dynamique-dimpression)).
- **Table de correspondance** cycle RPG III vers full free ([CYCLE-RPG, partie 2](../CYCLE-RPG.md#partie-2--du-cycle-rpg-iii-au-full-free-table-de-correspondance)).

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Coder en RPG full free (**FREE) : 3 programmes, compilation, débogage STRDBG et tests](https://job-i.fr/coder-rpg-full-free) | Full free : première ligne **FREE, format libre sans spécification en colonnes ; même compilateur et même débogueur que le RPG IV. | En une phrase ; Préparer l'atelier ; Et SEU ? ; Hello world : quatre lignes ; Sortir du stock un article lu par sa clé ; Consulter un article par son code ou par son libellé ; Déboguer avec STRDBG ; Tester |
| [Instructions RPG full free (DCL-S, DCL-DS, CHAIN, FOR-EACH…) sur IBM i et AS/400](https://job-i.fr/instructions-rpg) | Index des instructions RPG full free (déclarations, fichiers, structures de contrôle, appels). | Déclarations ; Mots-clés de déclaration ; Structures de contrôle ; Procédures, sous-programmes et erreurs ; Lecture de fichiers ; Écriture et contrôle des fichiers ; Données et calculs |
| [Fonctions RPG full free (BIF) sur IBM i et AS/400 : exemples testés](https://job-i.fr/fonctions-rpg) | Index des fonctions intégrées (BIF) du full free, par famille. | Chaînes de caractères ; Conversions et calculs ; Dates et heures ; Tableaux et listes ; Fichiers et erreurs ; Paramètres, procédures et mémoire ; Bits, XML et JSON |
| [PR et PI en RPG : prototype et interface de procédure, colonné et full free](https://job-i.fr/prototypes-rpg-pr-pi) | Le prototype PR décrit l'appel, l'interface PI déclare les paramètres reçus ; le compilateur contrôle leur cohérence dans un même source. | En une phrase ; PR et PI, c'est quoi ; Où ça s'écrit en RPG IV colonné ; Un PI à la place de *ENTRY PLIST ; Appeler un programme par son prototype ; Pourquoi le prototype dans un /COPY ; Des procédures internes, avec ou sans PR ; Les modes de passage des paramètres ; Voir les paramètres reçus dans le débogueur ; Les erreurs, et ce qu'elles veulent dire |

## Cours détaillé

> Synthèses personnelles à partir de job-i.fr (pages lues en partie ; exemples « compilés et exécutés sur IBM i 7.5 » = annonce de job-i) et du wiki. L'assistant ne compile rien. Les noms de bibliothèque des exemples sont ceux de job-i (fictifs). **La référence IBM « ILE RPG » n'a pas été lue pour cette partie.**

### 1. Le full free : principe

Un source full free commence par **`**FREE`** en colonne 1 : tout ce qui suit est en **format libre, de la colonne 1 à la fin de la ligne**, sans aucune spécification en colonnes. C'est toujours du **RPG IV** : même compilateur (`CRTBNDRPG`), même débogueur (`STRDBG`), même type de membre `RPGLE`. job-i précise que IBM présente `**FREE` parmi les nouveautés de la **7.3** ; en full free il n'y a pas de limite pratique à la longueur d'une ligne, mais dans un membre c'est la `RCDLEN` du fichier source qui limite (92 ⇒ 80 caractères).

- **Commentaire** : `//` jusqu'à la fin de la ligne. Casse libre. Chaque instruction se termine par `;`.
- **Hello world** : `dsply 'Hello world !'; *inlr = *on;` (le littéral va directement dans l'instruction).
- **SEU n'est plus l'outil** : il lit le source à partir de la colonne 6 (le code full free apparaît amputé de ses 5 premiers caractères) et refuse des lignes valides pour le compilateur (« Type de spécification de procédure principale incorrect ou hors séquence ») ; on écrit le full free dans un éditeur qui connaît le format libre ([partie 03 : Code for IBM i, RDi](03-outils-de-developpement.md#cours-détaillé)).
- **Débogage** : `STRDBG` affiche le source libre tel qu'il est écrit, numéroté ligne par ligne ; point d'arrêt par la commande `BREAK 19` (au lieu de `F6`), `EVAL ARTSTK` pour voir une zone, `F10` pas à pas, `EVAL ARTSTK = 3` pour forcer un cas.

| Élément | Statut | Source |
|---|---|---|
| `**FREE` col. 1, format libre, même compilateur et débogueur, RPGLE, nouveauté 7.3 selon IBM (citée par job-i) | vérifié (page lue, début) | [job-i : coder en RPG full free](https://job-i.fr/coder-rpg-full-free) |
| SEU inadapté, `//`, `BREAK`, `EVAL`, `F10` | vérifié (même page) | idem |
| « 7.3 » sur ibm.com | **non contrôlé** (job-i cite l'ILE RPG Reference 7.5) | [ILE RPG Reference SC09-2508 (7.5)](https://www.ibm.com/docs/en/i/7.5.0) à lire |

### 2. CTL-OPT et déclarations

- **`ctl-opt`** remplace la spécification H, juste après `**FREE`, avant les déclarations : `dftactgrp(*no)`, `actgrp(*new | *caller | 'NOM')`, `datfmt`, `timfmt`, `decedit('0,')`, `alwnull(*usrctl)` ([partie 07, § 2](07-rpg-iv.md#cours-détaillé)).
- **`dcl-f`** remplace la spécification F : `dcl-f fichier [usage(*input | *update | *output | *delete)] [keyed] [usropn] [extdesc('BIB/FICHIER') extfile(*extdesc)] [prefix(p_)]`. **`*input` est la valeur par défaut** (sans `usage`, un fichier DISK est en lecture seule) ; `usage(*update : *output : *delete)` cumule les droits ; `usropn` = le programme fait `open`/`close` ; `prefix` évite les conflits de noms ; un fichier déclaré `*input` ne peut pas recevoir un `write` (contrôlé à la compilation). Un écran se déclare `dcl-f ARTECR workstn;` (entrée et sortie). En colonné, `U` permet aussi de supprimer ; en libre il faut ajouter `*DELETE`.
- **`dcl-s`**, **`dcl-ds`** (`qualified`, `template`, `likeds`), **`dcl-c`** : voir [partie 07, § 3](07-rpg-iv.md#cours-détaillé). **QUALIFIED** : `structure.sous_zone` ; sans lui, deux sous-zones de même nom dans deux structures donnent l'erreur **RNF3315** ; **TEMPLATE** : la structure ne sert que de modèle (convention de nom suffixé `_t`) copié par `likeds` pour variables, paramètres et retours de procédure ; `inz(*likeds)` reprend les valeurs initiales du modèle ; une structure qualifiée peut être un tableau (`clients(2).nom`).

Correspondance colonné → libre (programme SORTIE de job-i, annoncé compilé) :

| RPG IV colonné | Full free |
|---|---|
| `FARTICLE UF E K DISK` | `dcl-f ARTICLE usage(*update) keyed;` |
| `DSORTIE PI` … | `dcl-pi *n; … end-pi;` |
| `D PCode 5A` | `pCode char(5);` |
| `DQte S 5P 0` | `dcl-s qte packed(5:0);` |
| `C EVAL ARTSTK = ARTSTK - Qte` | `ARTSTK -= qte;` |
| `C PCode CHAIN ARTICLE` | `chain pCode ARTICLE;` |

| Élément | Statut | Source |
|---|---|---|
| DCL-F : usage (*input par défaut), keyed, usropn, extdesc/extfile, prefix, contrôle à la compilation | vérifié (début de page) | [job-i : DCL-F](https://job-i.fr/instructions-rpg/dcl-f) |
| QUALIFIED / TEMPLATE / likeds / RNF3315 | vérifié (début de page) | [job-i : QUALIFIED](https://job-i.fr/instructions-rpg/qualified) |
| CTL-OPT, DCL-S, DCL-DS | vérifié (voir partie 07) | [CTL-OPT](https://job-i.fr/instructions-rpg/ctl-opt) · [DCL-S](https://job-i.fr/instructions-rpg/dcl-s) · [DCL-DS](https://job-i.fr/instructions-rpg/dcl-ds) |
| Tableau de correspondance colonné/libre | vérifié (page lue) | [job-i : coder en RPG full free](https://job-i.fr/coder-rpg-full-free) |
| DCL-C | page existante, non relue | [DCL-C](https://job-i.fr/instructions-rpg/dcl-c) |

### 3. Procédures, prototypes et interfaces

- **`dcl-proc nom; dcl-pi *n [type de retour]; … end-pi; déclarations locales; instructions; return valeur; end-proc;`** : bloc réutilisable avec paramètres, **variables locales** (recréées et réinitialisées à chaque appel, sauf `static`), valeur de retour, récursivité ; remplace les sous-routines `begsr` (sans vrais paramètres). Dans un programme à cycle ou à procédure principale, les procédures se placent **après** le code principal.
- **`dcl-pr nom [type de retour] [extpgm('PGM')]; paramètre type(long) [const | value] [options(*nopass : *omit)]; end-pr;`** : décrit un appel pour que le compilateur le contrôle. `extpgm` = programme externe `*PGM` ; `const` = référence en lecture seule (on peut passer un littéral ou une expression) ; `value` = copie modifiable sans effet sur l'appelant ; `*nopass`/`*omit` = paramètre facultatif ou sautable. Une erreur du programme appelé par `extpgm` remonte comme exception interceptable par `monitor` (`%status`).
- **`dcl-pi *n; … end-pi;`** : l'interface reçue ; `*n` reprend le nom de la procédure ; avec un prototype copié avant, le PI porte son nom et le compilateur vérifie la concordance ; `%parms` = nombre de paramètres réellement passés. Pour un **programme**, le PI global remplace `*ENTRY PLIST`.

```
**free
dcl-pr tvaf extpgm('TVAF');
  montantHt packed(11:2) const;
  taux packed(5:2) const;
  montantTtc packed(11:2);
end-pr;
```
*(prototype du programme TVAF de job-i, `/copy` dans l'appelant **et** l'appelé)*

| Élément | Statut | Source |
|---|---|---|
| DCL-PROC : structure, locales, static, retour, placement | vérifié (début de page) | [job-i : DCL-PROC](https://job-i.fr/instructions-rpg/dcl-proc) |
| DCL-PR : const/value/options/extpgm, exception remontée | vérifié (début de page) | [job-i : DCL-PR](https://job-i.fr/instructions-rpg/dcl-pr) |
| DCL-PI : `*n`, `%parms`, concordance avec le prototype | vérifié (début de page) | [job-i : DCL-PI](https://job-i.fr/instructions-rpg/dcl-pi) |
| Appels prototypés colonné/libre, TVA4/TVAF | vérifié (page lue, début) | [job-i : PR et PI](https://job-i.fr/prototypes-rpg-pr-pi) |
| Procédures exportées, modules, service programs | hors de cette partie | [partie 10 : ILE](10-ile.md) |

### 4. Structures de contrôle en libre

Mêmes structures qu'en RPG IV colonné, sans colonnes : `if / elseif / else / endif`, `dow`, `dou`, `for … to / downto / by … endfor`, `select / when / other / endsl` (et `when-is`, `when-in`), `leave`, `monitor / on-error / endmon`. Exemples de syntaxe libre : `dow not *in03;`, `if *in03; leave; endif;`, `*in41 = not %found(ARTICLE);`, `clear ARTCOD;`, opérateur composé `-=`. **FOR-EACH** : `for-each ville in villes; … endfor;` parcourt un tableau sans indice ; la variable reçoit une **copie** de l'élément (le tableau n'est pas modifié par les affectations faites sur cette copie) ; pour un tableau de structures, la variable est une structure `likeds`.

| Élément | Statut | Source |
|---|---|---|
| FOR-EACH : syntaxe, copie de l'élément, tableau de structures | vérifié (début de page + exemple exécuté) | [job-i : FOR-EACH](https://job-i.fr/instructions-rpg/for-each) |
| Boucle d'écran ARTCON en libre | vérifié (page lue) | [job-i : coder en RPG full free](https://job-i.fr/coder-rpg-full-free) |
| IF, DOW, FOR, SELECT, MONITOR | vérifié (voir partie 07) | [partie 07, § 4 et 6](07-rpg-iv.md#cours-détaillé) |

### 5. Conversion vers le full free

- **Hors `**FREE`, il reste des opérations historiques** : `MOVE`, `MOVEL`, `Z-ADD`, `CAB`, `GOTO`, `TAG`… qui n'existent pas en libre (*connaissance générale, liste exacte non vérifiée*) ; leurs remplaçants : affectation `=`, `+=`/`-=`, `eval`, `%subst`, `monitor`, structures `if`/`select`/`dow` ; table `MOVE`/`CABxx` → full free : [partie 06, § 4](06-rpg-iii.md#cours-détaillé) pour les anciennes opérations, [CYCLE-RPG.md, partie 2](../CYCLE-RPG.md#partie-2--du-cycle-rpg-iii-au-full-free-table-de-correspondance) pour le cycle (fichiers, `L1`-`L9`, lignes de sortie, page/date/overflow, pièges, fichier vide).
- **Indicateurs** : remplacés par `%found`, `%eof`, `%error` ; ceux d'écran peuvent rester par affectation (`*in41 = …`). **Impression** : `QSYSPRT PRINTER(132)` + une DS de 132 caractères par ligne ([IMPRESSION-RPG.md](../IMPRESSION-RPG.md), exemple CYCLEQSYS **validé par toi** : spool identique).
- **GOTO** : l'opération RPG `GOTO` est documentée dans [job-i : RPG III GOTO](https://job-i.fr/rpg-iii/goto) ; **le lien du plan ci-dessous (`/commandes-ibm-i/goto`) pointe vers la commande CL, pas vers l'opération RPG** : à ne pas confondre.
- **`CVTRPGFREE`** : **non vérifié**. Aucune page job-i (`/commandes-ibm-i/cvtrpgfree` : 404, recherche job-i sans résultat dédié) et la recherche IBM Documentation (`cvtrpgfree`, IBM i 7.5) ne trouve aucune correspondance. La commande **documentée et vérifiée** pour convertir RPG III en RPG IV colonné est `CVTRPGSRC` ([partie 07, § 1](07-rpg-iv.md#cours-détaillé)). Pour passer du RPG IV colonné au libre, un outil de conversion existe peut-être dans RDi ; **non lu**, à chercher sur ibm.com.

| Élément | Statut | Source |
|---|---|---|
| Équivalence cycle → full free ; impression `QSYSPRT` + DS 132 | vérifié dans le wiki (CYCLEQSYS validé par l'utilisateur) | [CYCLE-RPG.md](../CYCLE-RPG.md) · [IMPRESSION-RPG.md](../IMPRESSION-RPG.md) |
| MOVE, MOVEL, COMP, CABxx : comportement | vérifié (partie 06) | [job-i](https://job-i.fr/rpg-iii) |
| Liste exacte des opérations non permises en libre | **non vérifié** (non lue) | [ILE RPG Reference (7.5)](https://www.ibm.com/docs/en/i/7.5.0) |
| `CVTRPGFREE` | **non vérifié** (404 job-i, aucun résultat IBM 7.5 dans la recherche faite) | à chercher ; remonté comme manque |

### 6. Données et fonctions modernes

- **Tableaux** : `dim(n)` ; `dim(*auto : n)` (taille dynamique, `%elem` compte les éléments : cité par la page `%SPLIT`) ; `dim(*ctdata)` non lu. **`%SPLIT(chaîne [: séparateurs])`** : découpe en morceaux (chaque caractère de la liste coupe ; sans paramètre, le blanc) ; liste à parcourir avec `for-each` ou à ranger dans un tableau ; **`%CONCAT(sép : ch1 : ch2 …)`** : assemble avec un séparateur ; **`%LOOKUP(valeur : tableau [: départ [: nombre]])`** : position de l'égalité exacte ou 0 ; variantes `LT`, `LE`, `GE`, `GT` pour un tableau déclaré `ascend`/`descend` et réellement trié (pas de `%subarr` en paramètre) ; **`%MAXARR(tableau [: départ [: nombre]])`** : **position** (pas la valeur) du plus grand élément, première en cas d'ex aequo, 0 pour un `dim(*auto)` vide.
- **Exemple de job-i** (annoncé exécuté) : `for-each ville in villes; snd-msg 'Agence : [' + %trim(ville) + ']'; endfor;`

| Élément | Statut | Source |
|---|---|---|
| %SPLIT, %CONCAT, %LOOKUP (+ variantes), %MAXARR : syntaxe et résultat | vérifié (début de chaque page) | [%SPLIT](https://job-i.fr/fonctions-rpg/split) · [%CONCAT](https://job-i.fr/fonctions-rpg/concat) · [%LOOKUP](https://job-i.fr/fonctions-rpg/lookup) · [%MAXARR](https://job-i.fr/fonctions-rpg/maxarr) |
| DIM(*AUTO), DIM(*CTDATA) | `*AUTO` vu dans %SPLIT ; `*CTDATA` **non vérifié** (voir apport CTDATA/ALT) | [DIM](https://job-i.fr/instructions-rpg/dim) |
| Autres BIF (listes, JSON, XML, dates) | existence des familles vérifiée, non relues | [job-i : fonctions RPG](https://job-i.fr/fonctions-rpg) |

### Ce qui reste à vérifier pour cette partie

ILE RPG Reference 7.5/7.6 : liste des opérations interdites en libre, nouveautés par version (7.3 `**FREE`, autres) ; `CVTRPGFREE` et tout outil de conversion libre ; `DIM(*CTDATA)` ; sous-routines `begsr`/`endsr` en libre ; modes de passage et `*nopass` en pratique ; exemples non compilés par l'assistant. Manque à signaler : aucune page job-i sur la conversion colonné → libre.

## Plan détaillé (index des sujets)

### La syntaxe full free

- **Dans le wiki** : [Fiche 03](../cheatsheets/03-rpg-par-version.md)

#### CTL-OPT et les options de contrôle

- **job-i** : [CTL-OPT](https://job-i.fr/instructions-rpg/ctl-opt)

#### DCL-F, DCL-S, DCL-C et DCL-DS

- **job-i** : [DCL-F](https://job-i.fr/instructions-rpg/dcl-f) · [DCL-S](https://job-i.fr/instructions-rpg/dcl-s) · [DCL-C](https://job-i.fr/instructions-rpg/dcl-c) · [DCL-DS](https://job-i.fr/instructions-rpg/dcl-ds)

#### DCL-PR, DCL-PI et DCL-PROC

- **job-i** : [DCL-PR](https://job-i.fr/instructions-rpg/dcl-pr) · [DCL-PI](https://job-i.fr/instructions-rpg/dcl-pi) · [DCL-PROC](https://job-i.fr/instructions-rpg/dcl-proc)

#### Les structures de contrôle en free

- **job-i** : [IF](https://job-i.fr/instructions-rpg/if) · [DOW](https://job-i.fr/instructions-rpg/dow) · [FOR](https://job-i.fr/instructions-rpg/for) · [SELECT](https://job-i.fr/instructions-rpg/select) · [MONITOR](https://job-i.fr/instructions-rpg/monitor)

#### Les règles de formatage et de lisibilité

- **job-i** : [Coder en RPG full free (**FREE)](https://job-i.fr/coder-rpg-full-free)

### La conversion vers le full free

- **Dans le wiki** : [Cycle vers full free](../CYCLE-RPG.md#partie-2--du-cycle-rpg-iii-au-full-free-table-de-correspondance)

#### CVTRPGFREE et ses limites

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Le traitement des opcodes historiques restants

- **job-i** : [Codes opération RPG III et RPG/400 (MOVE, CHAIN, Z-ADD…) ...](https://job-i.fr/rpg-iii) · [Coder en RPG full free (**FREE)](https://job-i.fr/coder-rpg-full-free)

#### La suppression des GOTO et des indicateurs

- **job-i** : [GOTO](https://job-i.fr/commandes-ibm-i/goto)

### Les données et les fonctions modernes

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Les structures de données qualifiées, LIKEDS, LIKEREC, TEMPLATE

- **job-i** : [QUALIFIED](https://job-i.fr/instructions-rpg/qualified)

#### Les tableaux DIM(*AUTO) et DIM(*CTDATA)

- **job-i** : [DIM](https://job-i.fr/instructions-rpg/dim)

#### Les BIF récentes, %SPLIT, %CONCAT, %LOOKUP, %MAXARR

- **job-i** : [%SPLIT](https://job-i.fr/fonctions-rpg/split) · [%CONCAT](https://job-i.fr/fonctions-rpg/concat) · [%LOOKUP](https://job-i.fr/fonctions-rpg/lookup) · [%MAXARR](https://job-i.fr/fonctions-rpg/maxarr)

#### FOR-EACH et les listes

- **job-i** : [FOR-EACH](https://job-i.fr/instructions-rpg/for-each)
