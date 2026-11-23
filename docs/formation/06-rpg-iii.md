# Partie 06 : RPG III (RPG/400)

> Plan de formation, partie 06 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Historique, format colonné HFELICO, cycle RPG, codes opérations historiques, accès aux fichiers, sous-fichiers, maintenance du code existant.
>
> **Mots-clés** : RPG III, RPG/400, HFELICO, cycle, IP, LR, L1, MR, MOVE, MOVEL, Z-ADD, CHAIN, SETLL, READ, WRITE, UPDAT, DELET, EXCPT, BEGSR, SFL, SFLCTL, SEU, PDM.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Cours détaillé](#cours-détaillé)
  - [1. Historique et positionnement](#1-historique-et-positionnement)
  - [2. Les spécifications et le format colonné](#2-les-spécifications-et-le-format-colonné)
  - [3. Le cycle RPG](#3-le-cycle-rpg)
  - [4. Les codes opérations historiques](#4-les-codes-opérations-historiques)
  - [5. L'accès aux fichiers](#5-laccès-aux-fichiers)
  - [6. Les sous-fichiers](#6-les-sous-fichiers)
  - [7. Maintenance du code existant](#7-maintenance-du-code-existant)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Historique et positionnement du RPG](#historique-et-positionnement-du-rpg)
  - [Les spécifications](#les-spécifications)
  - [Le cycle RPG](#le-cycle-rpg)
  - [Les codes opérations historiques](#les-codes-opérations-historiques)
  - [L'accès aux fichiers](#laccès-aux-fichiers)
  - [Les sous-fichiers](#les-sous-fichiers)
  - [Maintenance du code existant](#maintenance-du-code-existant)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 03 : RPG par version](../cheatsheets/03-rpg-par-version.md)
- [Fiche 06 : cycle et sous-routines](../cheatsheets/06-cycle-rpg-et-sous-routines.md)
- [Cycle RPG III (cours, exemples, full free)](../CYCLE-RPG.md)
- [Impression RPG (état à cycle, PRTCTL)](../IMPRESSION-RPG.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## L'essentiel (vérifié dans le wiki)

- **Cycle** : un tour = en-têtes/détail, lecture, totaux, test `LR`, transfert des zones, calculs de détail ; le total d'un groupe est calculé **avant** le transfert des zones du nouvel enregistrement ([cours du cycle](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)).
- **Spécification O** : type en col. 15, espaces en 17-18, saut en 19-20, indicateurs en 23-31, zone en 32-37, code d'édition en 38, `B` en 39, position de fin en 40-43, constante ou mot d'édition en 45-70 ([§7](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)).
- **Série progressive CYC01 à CYC14** : du cycle seul au bilan mensuel (ruptures `L1`/`L2`, tableaux, `CHAIN` dans le cycle, rapprochement `IP`/`IS`, fichier décrit dans le programme) ([partie 3](../CYCLE-RPG.md#partie-3--série-de-14-programmes-progressifs-corrigé-pesées-de-collecte)).
- **Exemples dans le dépôt** : programmes PERSOCYC / PERSOIMP (fiche 06, « Mes exemples ») et état à cycle réécrit ([Impression RPG](../IMPRESSION-RPG.md)).

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Codes opération RPG III et RPG/400 (MOVE, CHAIN, Z-ADD…) sur IBM i et AS/400](https://job-i.fr/rpg-iii) | Index des codes opération RPG III par famille (fichiers, structures de contrôle, indicateurs, calculs, transferts, chaînes, tableaux, écrans). | Lecture de fichiers ; Écriture et contrôle des fichiers ; Structures de contrôle ; Indicateurs et branchements ; Sous-programmes et appels ; Calculs ; Transferts de données ; Chaînes de caractères ; Tableaux, structures et bits ; Écrans (5250) |
| [Coder en RPG III : 3 programmes, compilation, débogage STRISDB et tests](https://job-i.fr/coder-rpg-iii) | RPG III : source dans QRPGSRC aux colonnes imposées, fichiers créés d'abord, compilation CRTRPGPGM, débogage STRISDB. | En une phrase ; Préparer l'atelier ; La spécification C, colonne par colonne ; Hello world : quatre lignes de calcul ; Sortir du stock un article lu par sa clé ; Consulter un article par son code ou par son libellé ; Compiler : ce qu'il faut savoir ; Déboguer avec STRISDB ; Tester : des cas écrits à l'avance |
| [Sous-fichier RPG (SFL, SFLCTL) : statique, en RPG III, RPG IV et full free](https://job-i.fr/sous-fichier-rpg) | Un sous-fichier est une liste d'enregistrements écrite ligne par ligne puis affichée en une fois ; l'utilisateur la fait défiler et le programme relit seulement les lignes modifiées. | En une phrase ; Le principe ; Trois façons de le charger, une seule à retenir ; L'écran : un gabarit, un seul DSPF pour les trois versions ; En RPG III ; En RPG IV colonné ; En RPG full free ; Le résultat, identique pour les trois ; Le piège : SFLMSG sur une liste vide |
| [Zone de données (DTAARA) IBM i : CL, RPG, SQL et *LDA, exemples testés](https://job-i.fr/zone-de-donnees-dtaara-ibm-i) | Une zone de données *DTAARA contient une seule valeur (compteur, paramètre, état) partagée entre programmes et travaux. | En une phrase ; Une zone de données, c'est quoi ; Créer et afficher une zone de données ; Le numéro de facture suivant ; Le verrou, vu d'un autre travail ; Une zone de paramètres vue comme une structure ; La *LDA, propre à chaque travail ; Le piège du full free : les apostrophes ; Lire une zone de données en SQL ; Les erreurs, et ce qu'elles veulent dire |
| [Mot d'édition RPG (spécification O, %EDITW) : règles et exemples testés](https://job-i.fr/mots-edition-rpg) | Un mot d'édition est un gabarit entre apostrophes qui décrit l'impression d'un nombre (chiffres, suppression des zéros, virgule, signe). | En une phrase ; Où l'écrire ; Les trois parties d'un mot d'édition ; Les caractères qui ont un sens ; Les exemples, imprimés sur IBM i ; L'euro, la virgule et DECEDIT ; Un relevé de compte, en RPG III, RPG IV et full free ; Les pièges, vérifiés sur le banc |
| [Constantes figuratives RPG : *BLANKS, *HIVAL, *LOVAL, *ALL, exemples testés](https://job-i.fr/constantes-figuratives-rpg) | Une constante figurative (*BLANKS, *HIVAL, *LOVAL, *ALL...) prend la taille et le type de la zone cible. | En une phrase ; Les constantes du RPG ; Ce que chaque constante met dans la zone ; Ce que le compilateur refuse ; *BLANKS sur une structure : l'erreur de données décimales ; *LOVAL, *HIVAL, *START et *END dans un fichier ; Les mêmes constantes en RPG III ; En CL, *BLANKS n'est pas une constante |

## Cours détaillé

> Synthèses personnelles à partir du wiki et de job-i.fr (pages lues en partie : début de chaque page, exemples compris). Les exemples ci-dessous reprennent des **exemples que job-i annonce compilés et exécutés sur IBM i 7.5** (`CRTRPGPGM`) ou sont des exemples du wiki ; ceux que j'écris moi-même sont marqués *hypothèse*. L'assistant ne compile rien.

### 1. Historique et positionnement

Le RPG III est né sur le System/38 ; sur l'AS/400 son compilateur s'appelle **RPG/400** et c'est lui qui compile encore aujourd'hui les programmes en colonnes (listing 5770WDS V7R5M0, « IBM RPG/400 » sur un IBM i 7.5). Le source se range dans un fichier `QRPGSRC` (longueur d'enregistrement 92 = 80 caractères de source), se tape dans **SEU** (touche F4 = invite avec libellés) via **PDM** (`WRKMBRPDM`, option 2 éditer, option 14 compiler) et se compile par **`CRTRPGPGM`** (pas `CRTBNDRPG`, qui est le compilateur du RPG IV). Le programme créé est un programme **OPM**.

| Élément | Statut | Source |
|---|---|---|
| RPG/400, QRPGSRC RCDLEN(92), SEU, PDM option 2 / 14, CRTRPGPGM vs CRTBNDRPG, listing V7R5M0 | vérifié (page lue, début) | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |
| Origine System/38 | vérifié (formulation de job-i) | idem |
| STRSEU / STRPDM (commandes) | pages job-i existantes, non relues pour ce cours | [STRSEU](https://job-i.fr/commandes-ibm-i/strseu) · [STRPDM](https://job-i.fr/commandes-ibm-i/strpdm) |

### 2. Les spécifications et le format colonné

Un programme est une suite de spécifications dans **cet ordre** : H (contrôle), F (fichiers), E (tableaux), L, I (entrées), C (calculs), O (sorties). La lettre du type est en **colonne 6** ; un `*` en colonne 7 fait un commentaire.

**Spécification C (calculs)** :

| Colonnes | Zone | Rôle |
|---|---|---|
| 6 | Type | `C` |
| 7-8 | Niveau | `L1`-`L9`, `LR`, ou `SR` (sous-routine) |
| 9-17 | Indicateurs de condition | jusqu'à 3, `N` pour la négation |
| 18-27 | Facteur 1 | 1er opérande |
| 28-32 | Code opération | 5 caractères au plus (`UPDAT`, pas `UPDATE`) |
| 33-42 | Facteur 2 | 2e opérande |
| 43-48 | Résultat | 6 caractères au plus pour un nom |
| 49-51 | Longueur | déclare la zone à sa 1re apparition, cadrée à droite |
| 52 | Décimales | une zone avec décimales (même 0) est numérique |
| 53 | Extension | `H` arrondi, `N` sans verrouillage, `P` complément à blanc |
| 54-59 | Indicateurs résultants | 54-55 sup./non trouvé, 56-57 inf./erreur, 58-59 égal/fin de fichier |
| 60-74 | Commentaire | |

Conséquence : un littéral en facteur 1 ou 2 tient en 10 positions apostrophes comprises (**8 caractères utiles**).

**Spécification F** (exemple job-i) : `FARTICLE UF E K DISK` = fichier en mise à jour (`U`, col. 15), procédure complète (`F`, col. 16), décrit en externe (`E`, col. 19), accès par clé (`K`, col. 31), `DISK` en col. 40. Fichier écran : `CF E WORKSTN` (combiné, affichage et saisie). **Spécification O** : voir le [cours du cycle, §7](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples) (type col. 15, zone 32-37, code d'édition 38, position de fin 40-43, constante dès 45) ; mots d'édition : [job-i](https://job-i.fr/mots-edition-rpg).

**Règle de nommage** : en RPG III un nom de **fichier**, de **format** et de **zone** doivent être distincts. Cas rencontré par job-i : un LF nommé `ARTLIB` comme la zone `ARTLIB` → compilation refusée (QRG4143, QRG5194, QRG6048, gravité 30). Autre règle : `GENLVL` vaut 9 par défaut, donc un seul message de gravité ≥ 10 empêche la création du programme (QRG9001).

| Élément | Statut | Source |
|---|---|---|
| Ordre H-F-E-L-I-C-O, colonnes de la spécification C, limite 8 caractères utiles d'un littéral | vérifié | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |
| Spécification F (U, F, E, K, DISK, WORKSTN) | vérifié (exemples de la page) | idem |
| Noms fichier/format/zone distincts, QRG4143 / 5194 / 6048, GENLVL 9, QRG9001 | vérifié (listing et texte de la page) | idem |
| Spécifications E, L, I (zones de contrôle) | vérifié dans le wiki | [Cycle RPG III §4-5](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples) |
| Spécification O | vérifié dans le wiki | [Cycle RPG III §7](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples) |

### 3. Le cycle RPG

Le cycle est le moteur du RPG III : le programme **ne boucle pas**, c'est le cycle qui relit un enregistrement du fichier primaire, déclenche les ruptures (`L1`-`L9`), imprime les en-têtes, les lignes de détail et de total, et se termine par `LR`. Un tour dans l'ordre du wiki : en-têtes/détail, lecture, **totaux** (avant le transfert des zones du nouvel enregistrement), test `LR`, transfert des zones, calculs de détail. Indicateurs : `1P`, `LR`, `L1`-`L9`, `OF`, `MR`. Un programme **sans fichier primaire** ou sans cycle utile se termine par `SETON LR` (sinon le cycle relance les calculs sans fin, selon job-i).

Pour tout le détail (étapes, ruptures, cascade des totaux, rapprochement, dépassement de page, 14 programmes progressifs) : [Cycle RPG III](../CYCLE-RPG.md) et [fiche 06](../cheatsheets/06-cycle-rpg-et-sous-routines.md). L'impression par cycle et sa réécriture en full free sont dans [Impression RPG](../IMPRESSION-RPG.md).

| Élément | Statut | Source |
|---|---|---|
| Un tour de cycle (7 étapes), indicateurs, ruptures, OF, MR | vérifié dans le wiki (cours existant) | [CYCLE-RPG.md](../CYCLE-RPG.md) |
| `SETON LR` obligatoire pour terminer ; sans lui le cycle relance les calculs | vérifié (formulation de job-i sur un programme sans fichier) | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |
| Page job-i du cycle | existence vérifiée, contenu non relu pour ce cours | [cycle-gap-rpg](https://job-i.fr/cycle-gap-rpg) |

### 4. Les codes opérations historiques

**Transferts**. `MOVE` aligne à **droite**, `MOVEL` à **gauche**, sans calcul ni arrondi ; facteur 1 non utilisé ; colonne 53 `P` = remplit la cible de blancs avant ; sans `P`, la partie de la cible non couverte est **conservée**. Si la source est trop longue, on perd son début (`MOVE`) ou sa fin (`MOVEL`). Vers une zone numérique, seule la partie chiffre de chaque caractère est prise et les décimales ne comptent pas (chiffres alignés comme des entiers).

```
C                     MOVEL'Hello'   MSG     13
C                     MOVE 'world !' MSG
C           MSG       DSPLY
C                     SETON                     LR
```
*(exemple job-i, donné comme exécuté : MSG vaut « Hello world ! »)*

**Calculs** : `Z-ADD`, `ADD`, `SUB`, `MULT`, `DIV`, `XFOOT` (somme d'un tableau) : pages [Z-ADD](https://job-i.fr/rpg-iii/z-add), [ADD](https://job-i.fr/rpg-iii/add), [SUB](https://job-i.fr/rpg-iii/sub), [MULT](https://job-i.fr/rpg-iii/mult), [DIV](https://job-i.fr/rpg-iii/div), [XFOOT](https://job-i.fr/rpg-iii/xfoot) (existence vérifiée, non relues).

**Comparaison et branchements**. `COMP` compare facteur 1 et 2 et allume HI (54-55), LO (56-57), EQ (58-59) ; au moins un indicateur est obligatoire ; en alphanumérique, comparaison de gauche à droite, la zone courte complétée de blancs. `CABxx` (`EQ NE GT LT GE LE`) = COMP + saut vers un `TAG` nommé en zone résultat (avant ou après le CAB, donc boucle possible) ; indicateurs HI/LO/EQ facultatifs, positionnés dans les deux cas. `GOTO`/`TAG` : [GOTO](https://job-i.fr/rpg-iii/goto).

```
C           SOLDE     CABGT1000      GROS
C                     'Normal' DSPLY
C           GROS      TAG
```
*(exemple job-i, donné comme exécuté)*

**Structures de contrôle** vues dans les exemples job-i : `IFEQ`/`IFGT`/`ELSE`/`ENDIF`, `DOWEQ`/`ENDDO`, `END` ; test d'un indicateur : `*IN99 IFEQ '1'`.

**Chaînes, tableaux, sous-routines, appels** : [SCAN](https://job-i.fr/rpg-iii/scan), [SUBST](https://job-i.fr/rpg-iii/subst), [CAT](https://job-i.fr/rpg-iii/cat), [LOOKUP](https://job-i.fr/fonctions-rpg/lookup), [BEGSR](https://job-i.fr/rpg-iii/begsr), [EXSR](https://job-i.fr/rpg-iii/exsr), [CALL](https://job-i.fr/rpg-iii/call), [PARM](https://job-i.fr/rpg-iii/parm), [PLIST](https://job-i.fr/rpg-iii/plist). Recevoir des paramètres : `*ENTRY PLIST` puis un `PARM` par paramètre dans l'ordre de l'appel (exemple SORTIE de job-i). Zones de données : `IN`/`OUT`, DTAARA, *LDA : [job-i](https://job-i.fr/zone-de-donnees-dtaara-ibm-i).

| Élément | Statut | Source |
|---|---|---|
| MOVE / MOVEL : alignement, colonne 53 P, troncature, numérique, pas d'indicateur | vérifié (début des pages lu) | [MOVE](https://job-i.fr/rpg-iii/move) · [MOVEL](https://job-i.fr/rpg-iii/movel) |
| COMP : HI/LO/EQ, indicateur obligatoire, comparaison alpha | vérifié (début de page lu) | [COMP](https://job-i.fr/rpg-iii/comp) |
| CABxx : relations, TAG avant/après, indicateurs facultatifs | vérifié (début de page lu) | [CABxx](https://job-i.fr/rpg-iii/cabxx) |
| `*ENTRY PLIST` + `PARM` | vérifié (exemple SORTIE) | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |
| Z-ADD, ADD, SUB, MULT, DIV, XFOOT, SCAN, SUBST, CAT, LOOKUP, BEGSR, EXSR, CALL, PARM, PLIST, IN, OUT, GOTO | pages existantes (vérifiées le 2026-11-23), contenu **non relu** pour ce cours | liens ci-dessus |

### 5. L'accès aux fichiers

Un fichier indexé est déclaré avec `K` en colonne 31 de la spécification F. Les opérations de lecture :

| Opération | Effet (synthèse job-i) | Indicateurs |
|---|---|---|
| `clé CHAIN fichier` | lecture directe par la clé ; position courante ; verrouille l'enregistrement en mise à jour (sauf `N` col. 53) | 54-55 : clé inexistante (**obligatoire** en RPG/400 : QRG5127 sinon) ; 56-57 : erreur (facultatif, sinon arrêt) |
| `clé SETLL fichier` | se place avant la 1re clé ≥ ; ne lit rien ; `*LOVAL`/`*HIVAL` permis | 58-59 : clé exacte existe (test d'existence sans lecture) ; 54-55 : clé > toutes les clés |
| `clé SETGT fichier` | se place après la 1re clé > ; ne lit rien | 54-55 seulement (indicateur en 58-59 refusé : QRG5130) |
| `READ fichier` | enregistrement suivant ; facteur 1 vide | 58-59 fin de fichier (**obligatoire**, QRG5134 sinon) |
| `clé READE fichier` | suivant seulement si même clé (clé partielle possible) | 58-59 plus de même clé (obligatoire) |
| `READP fichier` | enregistrement **précédent** ; pour partir de la fin : `*HIVAL SETGT` puis `READP` | 58-59 début de fichier (obligatoire) |

Schémas classiques (issus des exemples exécutés de job-i) :

```
* lire tout le fichier
C                     READ CLIENT3                  99
C           *IN99     DOWEQ'0'
C           NOM       DSPLY
C                     READ CLIENT3                  99
C                     END
```

```
* chercher par le début d'un libellé dans un LF trié (programme ARTCON)
C           ERECH     SETLL ARTICL1
C                     READ  ARTICL1                 42
```

Un échec de `CHAIN` ou de `READ` **laisse les zones inchangées** (elles gardent l'enregistrement précédent, constat de job-i) ; un `READ` après la fin de fichier échoue encore. Pour un groupe de même clé (lignes d'une commande) : `SETLL` sur la clé puis `READE` jusqu'à l'indicateur (couple classique sur un LF trié).

**Écriture et mise à jour** : `UPDAT` porte le nom du **format** (pas celui du fichier) et exige une lecture préalable sans `N` col. 53 ; exemple :

```
C           PCODE     CHAIN ARTICLE                 91
C           QTE       IFGT  ARTSTK
C                     MOVE 'INS'     PRET
C                     ELSE
C                     SUB  QTE       ARTSTK
C                     UPDAT ARTICLR
```
*(programme SORTIE de job-i, annoncé compilé et testé : trois cas OK / INC / INS)*

`WRITE` (ajout) : [WRITE](https://job-i.fr/rpg-iii/write) ; `DELET` : [DELETE](https://job-i.fr/instructions-rpg/delete) (existence vérifiée, non relues). **Sortie par exception** : `EXCPT nom` écrit les lignes `E` de la spécification O portant ce nom (imprimante : fichier en colonnes 7-14 ; fichier disque décrit en externe : **nom du format**, sinon QRG6100 ; `ADD` en 16-18 pour ajouter, sinon mise à jour de l'enregistrement courant ; seules les zones citées sont modifiées).

**Fichiers d'impression** : [Impression RPG](../IMPRESSION-RPG.md) (PRTCTL, OFLIND) et [fiche 08](../cheatsheets/08-impression-et-printer-ibm-i.md).

| Élément | Statut | Source |
|---|---|---|
| CHAIN (54-55 obligatoire QRG5127, 56-57, verrouillage, zones inchangées après échec) | vérifié (début de page + exemples) | [CHAIN](https://job-i.fr/rpg-iii/chain) |
| SETLL (58-59 EQ, 54-55, `*LOVAL`/`*HIVAL`) | vérifié | [SETLL](https://job-i.fr/rpg-iii/setll) |
| SETGT (54-55 seulement, QRG5130) | vérifié | [SETGT](https://job-i.fr/rpg-iii/setgt) |
| READ (58-59 obligatoire QRG5134, boucle DOWEQ) | vérifié | [READ](https://job-i.fr/rpg-iii/read) |
| READE (clé identique, clé partielle) | vérifié (début) | [READE](https://job-i.fr/rpg-iii/reade) |
| READP (début de fichier, `SETGT *HIVAL`) | vérifié (début) | [READP](https://job-i.fr/rpg-iii/readp) |
| UPDAT (nom du format, lecture préalable) | vérifié (programme SORTIE) | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |
| EXCPT (spécification O, ADD, QRG6100) | vérifié (début de page) | [EXCPT](https://job-i.fr/rpg-iii/excpt) |
| WRITE, DELET | existence vérifiée, non relus | liens ci-dessus |
| Codes de message QRG… et leur sens | cités par job-i (non vérifiés sur ibm.com) | job-i |

### 6. Les sous-fichiers

Un sous-fichier est une liste d'enregistrements écrite ligne à ligne dans un **fichier écran** puis affichée en une fois. En DDS : un format **SFL** (une ligne) et un format **SFLCTL** (contrôle, en-tête). Mots-clés : `SFLSIZ` (≤ 9999, plus grand que `SFLPAG` pour que le système étende et pagine), `SFLPAG` (lignes affichées), `SFLDSP`, `SFLDSPCTL`, `SFLCLR` (vider, via une écriture du contrôle avec l'indicateur allumé), `SFLEND(*MORE)`, `SFLRCDNBR` (page affichée), `SFLMSG`. Opérations RPG : `SFILE(SFL1:RANG)` relie le format à la zone du rang ; `WRITE SFL1` écrit une ligne ; `EXFMT SF1CTL` affiche et attend ; `READC SFL1` lit la ligne modifiée suivante (option saisie).

Trois méthodes de chargement : **statique** (tout en une fois, SFLSIZ > SFLPAG ; conseillée par job-i : code le plus court, pas de position à mémoriser), **extensible** (une page, `PAGEDOWN` rend la main) et **page à page** (SFLSIZ = SFLPAG, vidage/rechargement à chaque touche). Pour un gros fichier, une zone « Afficher à partir de » positionne la lecture par `SETLL`. Piège signalé par job-i : `SFLMSG` sur une liste vide. Les exemples complets (un seul DSPF pour RPG III, IV colonné et full free) sont sur [job-i : sous-fichier](https://job-i.fr/sous-fichier-rpg) ; les sous-fichiers du dépôt : [INDEX-SOURCES](../INDEX-SOURCES.md) et [fiche 03](../cheatsheets/03-rpg-par-version.md).

| Élément | Statut | Source |
|---|---|---|
| SFL/SFLCTL, SFLSIZ/SFLPAG, SFLDSP/SFLDSPCTL/SFLCLR/SFLEND, SFLRCDNBR, SFILE, WRITE, EXFMT, READC | vérifié (début de page lu : tableaux de mots-clés et d'opérations) | [job-i : sous-fichier](https://job-i.fr/sous-fichier-rpg) |
| Trois méthodes de chargement, conseil du statique | vérifié | idem |
| Code RPG III complet du sous-fichier, sous-fichier message, CRUD | **non lu** (section « En RPG III » de la page non lue pour ce cours) | idem |

### 7. Maintenance du code existant

Méthode appuyée sur ce qui précède : (1) lire le source dans l'ordre des spécifications (H, F, E, I, C, O) ; repérer le fichier primaire (`P` col. 16) et donc la présence du cycle ; (2) retrouver les fichiers et formats dans [architecture/](../../architecture) et [INDEX-SOURCES](../INDEX-SOURCES.md) ; (3) compiler avec `CRTRPGPGM` et **lire le listing** (spoule au nom du programme, `WRKSPLF` option 5) : le résumé en fin de listing donne les messages, la marque `* 4143` dans le source montre la ligne fautive ; (4) déboguer avec `STRISDB PGM(...) UPDPROD(*YES) PARM(...)` : `F6` point d'arrêt, `F17` exécuter, `F5` pas à pas, `F11` voir une zone, `F23` la modifier pour forcer un cas ; `UPDPROD(*NO)` (défaut) bloque l'ouverture d'un fichier en mise à jour d'une bibliothèque de production (CPF4203) : déboguer plutôt sur une **copie des données** ; (5) pour ne pas régresser : écrire les cas de test **avant** (job-i : 3/3 cas de test) et changer un point à la fois.

| Élément | Statut | Source |
|---|---|---|
| Listing, QRG…, GENLVL, spoule, option 14 PDM | vérifié | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |
| STRISDB, UPDPROD(*YES), touches F5/F6/F11/F17/F23, CPF4203 | vérifié (début de la section lu) | idem |
| Commandes CRTRPGPGM, DSPJOBLOG | pages existantes, non relues | [CRTRPGPGM](https://job-i.fr/commandes-ibm-i/crtrpgpgm) · [DSPJOBLOG](https://job-i.fr/commandes-ibm-i/dspjoblog) |
| Méthode de lecture d'un ancien programme (étapes 1-5) | hypothèse (synthèse personnelle) | à valider avec ton formateur |

### Ce qui reste à vérifier pour cette partie

Pages job-i d'opérations non relues (arithmétique, chaînes, tableaux, sous-routines, CALL/PARM/PLIST, IN/OUT, WRITE, DELET) ; code RPG III du sous-fichier ; messages QRG… sur ibm.com ; aucune page IBM (7.5) lue pour le RPG/400 : à chercher dans la référence *ILE RPG* / *RPG/400 Reference* si besoin. Aucun exemple n'a été compilé par l'assistant : seuls ceux que job-i annonce exécutés sont repris.

## Plan détaillé (index des sujets)

### Historique et positionnement du RPG

- **Dans le wiki** : [Fiche 03](../cheatsheets/03-rpg-par-version.md)

#### Du RPG au RPG II puis au RPG III

- **job-i** : [AS/400 et IBM i](https://job-i.fr/as400-vs-ibm-i) · [Coder en RPG III](https://job-i.fr/coder-rpg-iii)

#### Le format colonné et les règles de saisie

- **job-i** : [coder en RPG III](https://job-i.fr/coder-rpg-iii) · [Codes opération RPG III et RPG/400 (MOVE, CHAIN, Z-ADD…) ...](https://job-i.fr/rpg-iii)

#### Les outils historiques, SEU et PDM

- **job-i** : [STRSEU](https://job-i.fr/commandes-ibm-i/strseu) · [STRPDM](https://job-i.fr/commandes-ibm-i/strpdm)

### Les spécifications

- **Dans le wiki** : [Cycle RPG III, partie 1 (spécifications F, I, O)](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)

#### Les spécifications de contrôle et de fichiers, H et F

- **Dans le wiki** : [Cycle RPG III : spécification F (§4)](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)
- **job-i** : [Coder en RPG III](https://job-i.fr/coder-rpg-iii)

#### Les spécifications d'extension et d'entrée, E et I

- **Dans le wiki** : [Cycle RPG III : spécification I, zones de contrôle (§5)](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)
- **job-i** : [Coder en RPG III](https://job-i.fr/coder-rpg-iii)

#### Les spécifications de calcul et de sortie, C et O

- **Dans le wiki** : [Cycle RPG III : spécification O (§7)](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)
- **job-i** : [Coder en RPG III](https://job-i.fr/coder-rpg-iii) · [Mot d'édition RPG (spécification O, %EDITW)](https://job-i.fr/mots-edition-rpg)

#### Fichiers décrits en externe et décrits en programme

- **Dans le wiki** : [Cycle RPG III : fichiers primaire / secondaire (§4)](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)
- **job-i** : [Coder en RPG III](https://job-i.fr/coder-rpg-iii)

### Le cycle RPG

- **Dans le wiki** : [Cycle RPG III](../CYCLE-RPG.md) · [Fiche 06](../cheatsheets/06-cycle-rpg-et-sous-routines.md) · [Programmes progressifs CYC01 à CYC14](../CYCLE-RPG.md#partie-3--série-de-14-programmes-progressifs-corrigé-pesées-de-collecte)

#### Le déroulement automatique du cycle

- **Dans le wiki** : [Cycle RPG III : un tour de cycle (§2)](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)
- **job-i** : [cycle-gap-rpg](https://job-i.fr/cycle-gap-rpg)

#### Les indicateurs, LR, MR, indicateurs de niveau et de conditionnement

- **Dans le wiki** : [Cycle RPG III : indicateurs (§3), rapprochement (§9)](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)
- **job-i** : [cycle-gap-rpg](https://job-i.fr/cycle-gap-rpg)

#### Les ruptures de contrôle

- **Dans le wiki** : [Cycle RPG III : ruptures et cascade des totaux (§6)](../CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)
- **job-i** : [cycle-gap-rpg](https://job-i.fr/cycle-gap-rpg)

### Les codes opérations historiques

- **Dans le wiki** : [Fiche 03](../cheatsheets/03-rpg-par-version.md)

#### MOVE, MOVEL, Z-ADD, ADD, SUB, MULT, DIV

- **job-i** : [MOVE](https://job-i.fr/rpg-iii/move) · [MOVEL](https://job-i.fr/rpg-iii/movel) · [Z-ADD](https://job-i.fr/rpg-iii/z-add) · [ADD](https://job-i.fr/rpg-iii/add) · [SUB](https://job-i.fr/rpg-iii/sub) · [MULT](https://job-i.fr/rpg-iii/mult) · [DIV](https://job-i.fr/rpg-iii/div)

#### COMP, CABxx, GOTO et TAG

- **job-i** : [COMP](https://job-i.fr/rpg-iii/comp) · [CABxx](https://job-i.fr/rpg-iii/cabxx) · [GOTO](https://job-i.fr/rpg-iii/goto)

#### SCAN, SUBST, CAT, LOOKUP, XFOOT

- **job-i** : [SCAN](https://job-i.fr/rpg-iii/scan) · [SUBST](https://job-i.fr/rpg-iii/subst) · [CAT](https://job-i.fr/rpg-iii/cat) · [LOOKUP](https://job-i.fr/fonctions-rpg/lookup) · [XFOOT](https://job-i.fr/rpg-iii/xfoot)

#### Les sous-routines, BEGSR, ENDSR, EXSR

- **job-i** : [BEGSR](https://job-i.fr/rpg-iii/begsr) · [EXSR](https://job-i.fr/rpg-iii/exsr)

#### Les zones de données et les appels CALL / PARM

- **job-i** : [CALL](https://job-i.fr/rpg-iii/call) · [PARM](https://job-i.fr/rpg-iii/parm) · [PLIST](https://job-i.fr/rpg-iii/plist) · [IN](https://job-i.fr/rpg-iii/in) · [OUT](https://job-i.fr/rpg-iii/out) · [DTAARA](https://job-i.fr/zone-de-donnees-dtaara-ibm-i)

### L'accès aux fichiers

- **Dans le wiki** : [Fiche 03](../cheatsheets/03-rpg-par-version.md) · [Fiche 08 (fichiers d'impression)](../cheatsheets/08-impression-et-printer-ibm-i.md)

#### CHAIN, SETLL, SETGT, READ, READE, READP

- **job-i** : [CHAIN](https://job-i.fr/rpg-iii/chain) · [SETLL](https://job-i.fr/rpg-iii/setll) · [SETGT](https://job-i.fr/rpg-iii/setgt) · [READ](https://job-i.fr/rpg-iii/read) · [READE](https://job-i.fr/rpg-iii/reade) · [READP](https://job-i.fr/rpg-iii/readp)

#### WRITE, UPDAT, DELET

- **job-i** : [WRITE](https://job-i.fr/rpg-iii/write) · [UPDATE](https://job-i.fr/instructions-rpg/update) · [DELETE](https://job-i.fr/instructions-rpg/delete)

#### Les fichiers d'impression

- **Dans le wiki** : [Impression en RPG](../IMPRESSION-RPG.md)
- **job-i** : [EXCPT](https://job-i.fr/rpg-iii/excpt) · [Mot d'édition RPG (spécification O, %EDITW)](https://job-i.fr/mots-edition-rpg) · [OUTQ IBM i](https://job-i.fr/outq-ibm-i)

### Les sous-fichiers

- **Dans le wiki** : [Fiche 03 (sous-fichiers)](../cheatsheets/03-rpg-par-version.md) · [Exemples de sous-fichiers dans le dépôt](../INDEX-SOURCES.md)

#### Le DDS d'un sous-fichier, SFL et SFLCTL

- **job-i** : [SFL](https://job-i.fr/sous-fichier-rpg)

#### Les mots-clés de contrôle, SFLDSP, SFLDSPCTL, SFLCLR, SFLEND

- **job-i** : [Sous-fichier RPG (SFL, SFLCTL)](https://job-i.fr/sous-fichier-rpg)

#### Les sous-fichiers statiques, chargement complet

- **job-i** : [Sous-fichier RPG (SFL, SFLCTL)](https://job-i.fr/sous-fichier-rpg)

#### Les sous-fichiers dynamiques avec rechargement de pages

- **job-i** : [Sous-fichier RPG (SFL, SFLCTL)](https://job-i.fr/sous-fichier-rpg)

#### Le sous-fichier message

- **job-i** : [Sous-fichier RPG (SFL, SFLCTL)](https://job-i.fr/sous-fichier-rpg)

#### Un CRUD complet avec navigation et validations

- **job-i** : [Sous-fichier RPG (SFL, SFLCTL)](https://job-i.fr/sous-fichier-rpg)

### Maintenance du code existant

- **Dans le wiki** : [Index des sources RPG III](../INDEX-SOURCES.md) · [Comparaison des bibliothèques](../COMPARAISON-BIBLIOTHEQUES.md)

#### Lecture et analyse d'un programme ancien

- **job-i** : [Coder en RPG III](https://job-i.fr/coder-rpg-iii)

#### Compilation et traitement des erreurs

- **job-i** : [CRTRPGPGM](https://job-i.fr/commandes-ibm-i/crtrpgpgm) · [DSPJOBLOG](https://job-i.fr/commandes-ibm-i/dspjoblog)

#### Modification sans régression

- **job-i** : [Coder en RPG III](https://job-i.fr/coder-rpg-iii)
