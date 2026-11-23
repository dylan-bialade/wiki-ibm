# Partie 08 : RPG full free

> Plan de formation, partie 08 sur 14. Syntaxe full free, conversion depuis le format fixe, structures de données modernes, tableaux dynamiques, BIF récentes, FOR-EACH.
>
> **Mots-clés** : **FREE, CTL-OPT, DCL-F, DCL-S, DCL-C, DCL-DS, DCL-PR, DCL-PI, DCL-PROC, LIKEDS, LIKEREC, TEMPLATE, DIM(*AUTO), %SPLIT, %CONCAT, %LOOKUP, FOR-EACH, CVTRPGFREE.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Plan détaillé](#plan-détaillé)
  - [La syntaxe full free](#la-syntaxe-full-free)
  - [La conversion vers le full free](#la-conversion-vers-le-full-free)
  - [Les données et les fonctions modernes](#les-données-et-les-fonctions-modernes)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 03 : RPG par version](../cheatsheets/03-rpg-par-version.md)
- [Exemples full free : impression](../IMPRESSION-RPG.md)
- [SQL avancé et exemples ILE](../ILE-ET-SERVICES-WEB.md)

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

## Plan détaillé

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
