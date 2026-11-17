# Cycle RPG III : synthèse du cours et exemples

> Synthèse personnelle (réécrite) d'un support de cours sur le cycle RPG, complétée d'exemples **proposés, non compilés** : ils n'ont pas été passés au compilateur (seule la position des colonnes a été contrôlée par script). Teste-les avec `CRTRPGPGM` avant de t'y fier. Voir aussi la [fiche 06](cheatsheets/06-cycle-rpg-et-sous-routines.md) et [CYCLE-GAP-EXEMPLES](CYCLE-GAP-EXEMPLES.md). Les noms de fichiers/zones (VENTES, VENDRS, REGION, VENDEU, MOIS, MNT, NOMV) sont fictifs.

## 1. Principe
- Le cycle (appelé « cycle GAP » sur job-i) est un moteur intégré à RPG III/400 : il lit un fichier, exécute tes calculs, écrit, puis recommence, **sans que tu écrives la boucle**.
- Tu ne programmes que le traitement d'**un** enregistrement ; le cycle répète jusqu'à la fin du fichier primaire, puis met `LR` à 1 et termine.
- On le retrouve surtout dans le code ancien RPG III et pour les états imprimés à ruptures. En RPG IV libre on écrit la boucle soi-même (`DOW NOT %EOF`).
- Un programme **sans fichier primaire** boucle quand même une fois : sans `SETON LR` il ne se termine pas proprement (ex. `SANSFIC`).

## 2. Un tour de cycle (7 étapes)
1. Indicateurs de sortie (`H`/`D`/`T`) du tour précédent écrits ; `1P` (première page) traité au tout premier tour.
2. Lecture du prochain enregistrement du fichier primaire (et des secondaires, en rapprochement).
3. Détection des **ruptures** (zones de contrôle `L1`-`L9` : valeur différente de l'enregistrement précédent) et des correspondances (`M1`-`M9`, `MR`).
4. Mise à 1 des indicateurs de rupture/rapprochement ; exécution des **calculs totaux** (colonnes 7-8 = `L1`..`L9`, `LR`).
5. Écriture des lignes de sortie conditionnées par ces indicateurs (types `T` et `H`).
6. Chargement des zones d'entrée de l'enregistrement lu, mise à 1 de son indicateur d'enregistrement (`01`-`99`).
7. Exécution des **calculs détail** (colonnes 7-8 vides) puis écriture des lignes `D` ; retour à l'étape 1.

À retenir : les totaux d'une rupture s'exécutent **avant** le détail de l'enregistrement qui a provoqué la rupture (les zones pointent encore sur l'ancien groupe). Après `LR` (fin de fichier ou `SETON LR`) : un dernier passage des calculs totaux et lignes `T` conditionnées par `LR`, puis fin.

## 3. Indicateurs du cycle

| Indicateur | Rôle |
|---|---|
| `1P` | Premier passage : lignes d'en-tête de première page |
| `01`-`99` | Indicateur d'enregistrement (colonnes 19-20 de la spécification I) |
| `L1`-`L9` | Ruptures de niveau 1 à 9 (zones de contrôle, I col. 59-60) ; `L2` déclenche aussi `L1` (cascade) |
| `LR` | Dernier enregistrement : fin du cycle |
| `OF` | Dépassement de page (fichier imprimante déclaré `OF` en F, col. 33-34) |
| `MR` | Enregistrements rapprochés (matching) |
| `M1`-`M9` | Zones de rapprochement (I col. 61-62) |
| `H1`-`H9`, `U1`-`U8`, `KA`-`KY` | Halt, indicateurs utilisateur, touches de fonction |

## 4. Fichiers primaire / secondaire (spécification F)
- Colonne 15 : `I` (entrée), `O`, `U`, `C` ; colonne 16 : `P` primaire, `S` secondaire, `F` pour accès programmé, etc.
- Colonne 19 : `E` = fichier à description **externe** ; `F` = décrit dans le programme (spécifications I / longueur d'enregistrement en 24-27).
- Colonnes 40-46 : périphérique (`DISK`, `PRINTER`, `WORKSTN`) ; col. 33-34 : `OF` pour imprimante ; col. 31 : `K` clé.
- Un seul primaire ; secondaires uniquement avec rapprochement ou lecture alternée.
- Message `QRG5007` : plusieurs primaires ou primaire manquant avec ruptures déclarées.

## 5. Spécification I : zones de contrôle et rapprochement
Les colonnes (`IFichier`) : 7-14 nom du format, 19-20 indicateur d'enregistrement ; pour les zones : 53-58 nom de zone, **59-60 niveau de rupture** (`L1`-`L9`), **61-62 rapprochement** (`M1`-`M9`).
Ordre de lecture et tri : le fichier doit être **trié** sur les zones de rupture (clé ou LF) ; sinon le cycle produit une rupture à chaque changement de valeur, donc des totaux fractionnés (piège classique).

## 6. Ruptures et cascade des totaux
- `L1` = rupture sur la zone la plus fine ; `L2` sur la zone englobante, etc. Quand `L2` change, `L1` est aussi mis à 1 : les totaux s'additionnent en cascade (`L1` → total niveau 2 → `LR` → total général).
- Technique d'addition en cascade : détail → `ADD MNT TOTVEN` ; sous `L1` → `ADD TOTVEN TOTREG` ; sous `L2` → `ADD TOTREG TOTGEN`.
- La remise à zéro des totaux se fait via **`B` (colonne 39 de la spécification O, blank after)** : la zone est imprimée puis remise à blanc/zéro. Variante : remise à zéro par un calcul de détail (`Z-ADD`) ; les deux sont équivalentes, `B` est plus compacte.

## 7. Spécification O : lignes de sortie
Colonnes essentielles : 14-15 `OR`/type (`H` en-tête, `D` détail, `T` total, `E` exception), 17-18 espacement avant/après, 19-22 saut de ligne (`01` = ligne 1, donc nouvelle page), 23-31 indicateurs (trois emplacements : `N` en col. 23/26/29, indicateur en 24-25/27-28/30-31), 32-37 nom de zone ou constante, 38 code édition, 39 `B`, 40-43 position de fin, 45-70 constante entre apostrophes.
- Une ligne `OR` sur une seconde ligne ajoute une condition « OU » (ex. `1P` OU `OF`).
- Type `E` : écrite uniquement par `EXCPT` (hors cycle ou dans une boucle explicite).
- Codes d'édition (col. 38) : `Y` (date), `Z` (supprime les zéros), `1`-`4` (virgule/point/signe/zéro) ; **le détail exact n'est pas vérifié ici** : voir `/mots-edition-rpg` sur job-i et la fiche 03.
- Spécification H, col. 19 : `D/J` pour le format de date (le cours cite aussi le message `QRG5167` quand la valeur est incohérente).
- `PAGE`, `UDATE`, `*DATE` : zones système utilisables en sortie (numéro de page, date du jour).

## 8. Dépassement de page (OF)
Déclarer `OF` dans la spécification F de l'imprimante (col. 33-34) et, si besoin, une spécification **L** (`LQSYSPRT 024FL018OL` : 24 lignes, ligne de saut 18 = dépassement). Les lignes d'en-tête sont alors conditionnées `1P` **OU** `OF` (ligne `OR`). Sans `L`, la taille de page vient de la description du fichier imprimante.

## 9. Rapprochement (matching records)
- Deux fichiers ou plus (primaire + secondaires) déclarés avec les mêmes zones `M1`, `M2`… : le cycle lit le plus petit ; si les clés sont égales, `MR` est mis à 1.
- Les enregistrements sans correspondance donnent `NMR` : on le teste en sortie (ligne conditionnée `NMR`) pour lister les orphelins.
- Les fichiers doivent être triés dans le même ordre ; le rapprochement ne se fait que sur des zones de même type/longueur.

## 10. Sortir du cycle
- `SETON LR` (ou `RETURN` selon version) ; ou dépasser la fin du primaire.
- Boucle explicite : tu lis toi-même avec `READ`, `DOW NOT %EOF`/`DOW *IN99 = *OFF`, et tu écris avec `EXCPT` ; fichier déclaré en F comme secondaire `IF`/`UF` sans `P` et `*INLR` forcé au début.

## 11. Exemples (non compilés)
Rappel des colonnes : toutes les lignes sont en format colonné (la colonne 6 donne le type F/I/C/O ; **les en-têtes H commencent par `H`** ; `HFELICO` désigne l'ensemble des spécifications dans l'ordre H, F, E, L, I, C, O).

### 11.1 `RUPT0` : cycle minimal
Lit tout `VENTES`, affiche chaque vendeur, compte les lignes.
```rpg
     FVENTES  IP  E           K        DISK
     IVENTEF      01
     C  01       VENDEU    DSPLY
     C  01                 ADD  1         NB      30
     CLR         NB        DSPLY
```

### 11.2 `SANSFIC` : cycle sans fichier primaire
Boucle jusqu'à 3 puis termine grâce à `LR`.
```rpg
     C                     ADD  1         N       10
     C           N         DSPLY
     C           N         COMP 3                    LR
```

### 11.3 `RUPT1` : une rupture (L1) et total général
Le détail est imprimé, `L1` (changement de région) déclenche le total région, `LR` le total général.
```rpg
     FVENTES  IP  E           K        DISK
     FQSYSPRT O   F      80     OF     PRINTER
     IVENTEF      01
     I                                              REGIONL1
     C  01                 ADD  MNT       TOTREG  92
     CL1                   ADD  TOTREG    TOTGEN  92
     OQSYSPRT H  201   1P
     O                                   24 'VENTES PAR REGION'
     OQSYSPRT D  1     01
     O                         REGION     8
     O                         VENDEU    18
     O                         MOIS      23
     O                         MNT   1   35
     OQSYSPRT T  2     L1
     O                                   15 'TOTAL REGION'
     O                         REGION    22
     O                         TOTREG1B  35
     OQSYSPRT T  1     LR
     O                                   15 'TOTAL GENERAL'
     O                         TOTGEN1   35
```

### 11.4 `RUPT2` : deux niveaux, cascade, date, page, dépassement
Rupture `L2` sur la région, `L1` sur le vendeur ; en-têtes sur `1P` ou `OF` ; `D/J` ; spécification L.
```rpg
     H            D/J
     FVENTES  IP  E           K        DISK
     FQSYSPRT O   F      80     OF     PRINTER
     IVENTEF      01
     I                                              REGIONL2
     I                                              VENDEUL1
     C  01                 ADD  MNT       TOTVEN  92
     CL1                   ADD  TOTVEN    TOTREG  92
     CL2                   ADD  TOTREG    TOTGEN  92
     OQSYSPRT H  201   1P
     O       OR        OF
     O                                   30 'VENTES PAR REGION'
     O                         UDATE Y   50
     O                                   59 'PAGE'
     O                         PAGE  Z   64
     OQSYSPRT H  1     1P
     O       OR        OF
     O                                   30 'REGION  VENDEUR   MOIS'
     O                                   44 'MONTANT'
     OQSYSPRT D  1     01
     O                 L2      REGION     6
     O                         VENDEU    16
     O                         MOIS      23
     O                         MNT   2   44
     OQSYSPRT T  1     L1
     O                                   26 'TOTAL VENDEUR'
     O                         TOTVEN2B  44
     OQSYSPRT T  2     L2
     O                                   22 'TOTAL REGION'
     O                         REGION    29
     O                         TOTREG2B  44
     OQSYSPRT T  1     LR
     O                                   15 'TOTAL GENERAL'
     O                         TOTGEN2   44
```

### 11.5 `CONCORD` : rapprochement (ébauche)
Deux fichiers primaire/secondaire déclarés avec les mêmes zones `M1`/`M2`. À compléter avec des sorties `MR` et `NMR` : voir section 9 (non écrit ici car non vérifié).
```rpg
     FVENDRS  IP  E           K        DISK
     FVENTES  IS  E           K        DISK
     FQSYSPRT O   F      80            PRINTER
     IVENDEF      01
     I                                              REGION  M2
     I                                              VENDEU  M1
     IVENTEF      02
     I                                              REGION  M2
     I                                              VENDEU  M1
     OQSYSPRT D 11     01
     O                         REGION     6
     O                         VENDEU    16
     O                         NOMV      38
     OQSYSPRT D  1     02
     O                                   30 'VENTE'
     O                         MOIS      33
     O                         MNT   2   45
```

## 12. Ce que ce cours ajoute à job-i
job-i décrit le cycle et cite les spécifications mais détaille peu la **spécification O** (colonnes, `OR`, `B`), les fichiers secondaires et `MR`/`NMR`, les codes d'édition et le dépassement de page : ces sections comblent ces points. Différence avec la variante `T` du dépôt (fiche 06) : ici la remise à zéro passe par `B` (col. 39) ; l'autre variante remet à zéro par un calcul de détail.

## 13. TP types (énoncés)
1. Rapport de ventes avec ruptures : détail, total par région (L1), total général (LR).
2. Réécrire un rapport à cycle sans cycle : boucle `READ`, comparaison manuelle de la zone de contrôle, sortie par `EXCPT`.
