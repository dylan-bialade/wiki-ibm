# Du cycle RPG III au full free : table de correspondance

> Chaque ligne indique son **statut** : *validé* = utilisé dans un programme compilé dont le spool est identique à la référence ([CYCLEQSYS.rpgle](exemples-cycle/CYCLEQSYS.rpgle), voir [IMPRESSION-FULLFREE](IMPRESSION-FULLFREE.md)) ; *proposé* = raisonnement non testé ; *non vérifié* = à confirmer. Contexte : [cours du cycle](CYCLE-RPG-COURS.md), [fiche 06](cheatsheets/06-cycle-rpg-et-sous-routines.md).

## 1. Fichiers et indicateurs

| RPG III (cycle) | Full free | Statut |
|---|---|---|
| Fichier primaire `IP` (F col. 16) | `DCL-F fichier DISK(*EXT) USAGE(*INPUT);` + `READ format;` dans `DOW NOT %EOF(fichier);` | validé |
| Lecture automatique à chaque tour | `READ` en tête de boucle, puis `READ` à la fin de chaque tour | validé |
| Indicateur d'enregistrement `01` | inutile : on est dans la boucle, l'enregistrement est lu | validé |
| `LR` (fin de fichier, `SETON LR`) | `*INLR = *ON; RETURN;` après la boucle | validé |
| Calculs `LR` / lignes `T` `LR` | instructions placées après `ENDDO` (totaux généraux) | validé |
| Fichiers secondaires `IS`, rapprochement `M1`-`M9`, `MR` | non traduit : lecture explicite de deux fichiers, comparaison des clés à la main (`SETLL`/`CHAIN` ou fusion) | non vérifié |

## 2. Ruptures `L1`-`L9`

| RPG III | Full free | Statut |
|---|---|---|
| Zone de contrôle `L1` (I col. 59-60) | variable `univPrec LIKE(zone)` et `rupture = (premier OR zone <> univPrec);` | validé |
| Calculs `L1` (total, avant le détail du nouveau groupe) | bloc `IF rupture AND NOT premier;` placé **avant** le traitement de l'enregistrement | validé |
| Cascade `L2` → `L1` | tester d'abord le niveau le plus fin ; si le niveau supérieur change, déclencher aussi le niveau inférieur | proposé |
| Remise à zéro des totaux (`B` en O col. 39 ou calcul détail) | `IF rupture; NBU = 0; ENDIF;` après le total | validé |
| Premier enregistrement (aucune rupture) | indicateur `premier IND INZ(*ON)` remis à `*OFF` après le premier tour | validé |

## 3. Lignes de sortie (spécification O)

| RPG III | Full free | Statut |
|---|---|---|
| Fichier `PRINTER` col. 40-46, `OF` col. 33-34 | `DCL-F QSYSPRT PRINTER(132) USAGE(*OUTPUT) OFLIND(*INOF);` | validé |
| Ligne `D`/`T`/`H` avec zones + constantes | une DS `LEN(132) INZ` par type de ligne, zones placées par `POS(n)`, constantes `INZ('…')`, puis `WRITE QSYSPRT <ds>;` | validé |
| Position de fin (O col. 40-43) | `POS` = début : fin − longueur + 1 (longueurs de zone connues) | validé |
| Code d'édition `Z` | `%EDITC(zone : 'Z')` dans une zone caractère de la DS | validé |
| Espace avant / après (O col. 17-18) | lignes blanches écrites (`dsVide`) selon le modèle du curseur : ligne = curseur + avant ; curseur après = ligne + après | validé |
| Saut `01` (nouvelle page) | remplir de lignes blanches jusqu'à la ligne 66 après dépassement de la ligne 60, puis curseur = 1 | validé |
| `PRTCTL(ds:*COMPAT)` pour l'espacement | **a donné un spool faux** avec des `'000'` : voir [PRTCTL](PRTCTL.md) | non vérifié |
| Fichier imprimante DDS (`SPACEB`, `SKIPB`, `PAGNBR`, formats) | variante [CYCLEIMP](exemples-cycle/CYCLEIMP.rpgle) + [CYCLEPRT](exemples-cycle/CYCLEPRT.prtf) | non vérifié |
| Ligne `E` + `EXCPT` | une procédure qui écrit la DS correspondante | proposé |
| `B` col. 39 (blank after) | affecter la zone à blanc/0 après le `WRITE` | proposé |

## 4. Page, date, dépassement

| RPG III | Full free | Statut |
|---|---|---|
| `1P` (en-tête de la 1re page) | appel de la procédure `Entete` avant la boucle | validé |
| `OF` (dépassement) | `Debordement()` appelé **au moment d'un enregistrement**, pas avant les totaux (mesure sur le spool de référence) | validé |
| `OR OF` sur ligne `H` | `IF ligneCour > 60;` (OVRFLW par défaut) puis nouvel en-tête | validé |
| `PAGE` | compteur `numPage PACKED(4:0)` incrémenté à chaque en-tête | validé |
| `UDATE`, `*DATE`, `D/J` (spéc. H) | non testé : `%DATE()` / `%EDITC` à vérifier | non vérifié |
| Spécification `L` (longueur de page, ligne de débordement) | constantes `LIGNE_DEBORD 60`, `LIGNES_PAGE 66` (défauts documentés en fiche 08) | validé |

## 5. Pièges propres au full free
- `NB += 1` sur une zone trop courte provoque une erreur d'exécution (RNQ0103, **non vérifié** dans le wiki) alors que RPG III tronque en silence : dimensionner la zone (`PACKED(4:0)` pour 400) ou utiliser `%REM`.
- Le débordement n'est pas automatique avec `OFLIND` : le programme doit finir la page lui-même.
- Comparer le **spool**, pas seulement l'absence d'erreur de compilation.

## 6. Fichier vide
Comportement du cycle RPG III sur un fichier primaire vide : **non vérifié**. Avec `CYCLEQSYS`, un fichier vide donne : en-tête, puis `TOTAL UNIVERS` et `TOTAL GENERAL` avec des zéros supprimés par le code d'édition `Z` (analyse du code, non testé). Test à faire : lancer le programme sur un fichier vide et comparer au programme RPG III d'origine.
