# Partie 07 : RPG IV (ILE RPG, format fixe étendu)

> Plan de formation, partie 07 sur 14. Du RPG III au RPG IV, spécifications H, F, D, C, P, types et structures de données, expressions et structures de contrôle, fonctions intégrées, gestion des erreurs, compilation.
>
> **Mots-clés** : RPG IV, ILE RPG, CVTRPGSRC, H, F, D, C, P, EVAL, IF, DOW, FOR, SELECT, %TRIM, %SUBST, %SCAN, MONITOR, CRTBNDRPG, CRTRPGMOD, STRDBG.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Plan détaillé](#plan-détaillé)
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

## Plan détaillé

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
