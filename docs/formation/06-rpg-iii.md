# Partie 06 : RPG III (RPG/400)

> Plan de formation, partie 06 sur 14. Historique, format colonné HFELICO, cycle RPG, codes opérations historiques, accès aux fichiers, sous-fichiers, maintenance du code existant.
>
> **Mots-clés** : RPG III, RPG/400, HFELICO, cycle, IP, LR, L1, MR, MOVE, MOVEL, Z-ADD, CHAIN, SETLL, READ, WRITE, UPDAT, DELET, EXCPT, BEGSR, SFL, SFLCTL, SEU, PDM.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Plan détaillé](#plan-détaillé)
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

## Plan détaillé

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
