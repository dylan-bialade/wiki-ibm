# 06 - Cycle RPG (GAP) et sous-routines

> Source : [job-i.fr](https://job-i.fr/). Blocs `AUTO` régénérés ; écrivez dans « Mes exemples ».

<!-- AUTO:START -->
## Le cycle RPG  ([source](https://job-i.fr/cycle-gap-rpg))
- Un programme qui déclare un **fichier primaire** (spécification F, `IP`) reçoit du compilateur une boucle invisible : pas de `READ`, pas de test de fin de fichier. Le nom « GAP » (Générateur Automatique de Programmes) vient de l'ancien nom français du RPG.
- **Sans fichier primaire, pas de cycle.** Le full free (`DCL-F`) ne peut pas avoir de fichier primaire ; `CTL-OPT MAIN(...)` et les modules `NOMAIN` non plus.

| Étape | Ce qui se passe |
|---|---|
| 1 | Sorties d'en-tête et de détail (lignes `H` et `D`). Au premier cycle, seules les en-têtes sous `1P`. |
| 2 | Lecture du fichier primaire ; comparaison des zones de contrôle (allume `L1`-`L9`) ; fin de fichier → `LR`. |
| 3 | Calculs de **total** (conditionnés par `L1`-`L9` / `LR`). Ils voient encore les valeurs du groupe précédent. Sautés au 1er enregistrement. |
| 4 | Sorties de **total** (lignes `T`), puis en-tête de débordement si `OF`. |
| 5 | Test de `LR` : s'il est allumé, fermeture des fichiers et arrêt. |
| 6 | Transfert des zones de l'enregistrement lu vers les variables. |
| 7 | Calculs de **détail** (sans niveau), puis retour à l'étape 1. |

- Point clé : le total d'un groupe est calculé et imprimé **avant** le transfert des zones du nouvel enregistrement.

| Indicateur | Rôle |
|---|---|
| `1P` | premier cycle |
| `01`… | enregistrement du format concerné lu |
| `L1`-`L9` | rupture d'une zone de contrôle ; `LR` allume tous les niveaux |
| `LR` | fin de fichier |
| `OF` | débordement de page |

- Pièges : ne pas initialiser un calcul `L1` avant le premier groupe (utiliser `1P` ou des calculs de détail conditionnés) ; une zone éditée peut en recouvrir une autre sans message ; en RPG/400 avec fichier externe, la ligne I porte le nom externe et le nom RPG aux bonnes positions ; sans cycle, mettre `*INLR = *ON` ou `RETURN` (sinon boucle ; `RETURN` seul laisse les fichiers ouverts).
- Pour le code neuf, job-i conseille la boucle explicite : `READ` + `DOW NOT %EOF`.
- L'indicateur `MR` et les fichiers secondaires ne sont pas détaillés sur la page job-i : voir l'exemple `CYCDEMO` ci-dessous (constat dans le code du dépôt, non documenté par job-i).

## Sous-routines BEGSR / ENDSR / EXSR  ([source](https://job-i.fr/instructions-rpg/begsr))
- `BEGSR nom;` … `LEAVESR;` … `ENDSR;` délimite un sous-programme **interne** ; `EXSR nom;` l'appelle depuis le même programme ou la même procédure. L'exécution reprend après `EXSR`.
- Un sous-programme n'a **ni paramètres ni variables locales** : il partage toutes les variables de l'appelant. Un `DCL-S` après `BEGSR` est refusé (RNF0724).
- Piège : un même indice de boucle utilisé par l'appelant et le sous-programme donne un résultat faux sans erreur ; nommer à part les variables du sous-programme.
- Pour le code neuf, job-i recommande une **procédure** (`DCL-PROC`) plutôt qu'un sous-programme. `*INZSR` n'est pas traité par la page.
- La page détaille la forme full free ; la syntaxe en colonnes existe (`BEGSR`/`ENDSR` en code opération) mais n'y est pas décrite.
<!-- AUTO:END -->

## Mes exemples
- **Cycle complet** : [CYCDEMO](../../sources/RPG/RPG-III-400/BIB20/CYCDEMO.md) : fichier primaire `IP` + secondaire `IS`, niveaux `L1`/`L2`, concordance `M1`/`MR`, indicateur de zone, `1P`, `OF`, lignes `H`/`D`/`T`, remise à zéro `B`, pas de `SETON LR`. Les commentaires donnent l'ordre d'un tour de cycle.
- **Trois niveaux** : [FILMCYC](../../sources/RPG/RPG-III-400/BIB21/FILMCYC.md) (`L1` à `L3`, `OF`).
- **Rupture simple `L1`** : [LIVGAP1](../../sources/RPG/RPG-III-400/BIB01/LIVGAP1.md), [LIVGAP2](../../sources/RPG/RPG-III-400/BIB01/LIVGAP2.md), [SYNTAX3](../../sources/RPG/RPG-III-400/BIB01/SYNTAX3.md).
- Liste détectée automatiquement : [CYCLE-GAP-EXEMPLES](../CYCLE-GAP-EXEMPLES.md).
- **Sous-routines** (RPG III, `BEGSR`/`EXSR`) : [EDBOR](../../sources/RPG/RPG-III-400/BIB20/EDBOR.md) (21 sous-routines), [FICCLIRPG](../../sources/RPG/RPG-III-400/BIB17/FICCLIRPG.md), [BIERERPG](../../sources/RPG/RPG-III-400/BIB17/BIERERPG.md) ; avec écran : [RPGSFLOPT](../../sources/RPG/RPG-ILE/BIB20/RPGSFLOPT.md).

### Exemple : liste de personnes avec cycle, rupture L1, tableau MSG, `*INZSR` et sortie (DSPLY seul)

> Statut : **compile** (RPG/400, compilation réussie le 16/11/2026 après correction de QRG2001 et QRG7030). Exécution et comportement de `CL1` à la sortie : à confirmer. Dérivé de l'exercice « BONBON » du cycle, avec le fichier `PERSO`. Sans fichier écran : tout passe par `DSPLY`.

- **Consigne** : reprendre l'exemple du cycle (fichier primaire `IP`) avec `PERSO` ; afficher **nom et prénom** ; quitter si `UNIVERS` vaut 5 ; pouvoir quitter avant la fin du fichier ; afficher « NOUVEL UNIVERS » à chaque changement d'univers (tableau chargé à la compilation) et au départ (sous-routine `*INZSR`) ; afficher le nombre de personnes à la fin.
- **Repère de colonnes** (pour contrôler l'alignement ; **ne pas le copier dans le membre** : chaque ligne de repère donne une erreur QRG2001) :

```	ext
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

- **Programme RPG III** (`PERSOCYC`, source `QRPGSRC` ou autre fichier source) :

```	ext
     FPERSO   IP  E                    DISK
      *
     E                    MSG     1   1 52
      *
     IPERSOF      01
     I              UNIVERS                         UNIV  L1
      *
     C   01      NOM       CAT  PRENOM:1  NOMPRE 31 P
     C   01      NOMPRE    DSPLY          REP     1
     C   01                ADD  1         NB      30
      *
     C           UNIV      IFEQ 5
     C           REP       OREQ 'Q'
     C           REP       OREQ 'q'
     C                     SETON                     LR
     C                     ENDIF
      *
     CL1         MSG,1     DSPLY
     CLR         NB        DSPLY
      *
      * SOUS ROUTINE INIT
     C           *INZSR    BEGSR
     C           MSG,1     DSPLY
     C                     ENDSR
**
NOUVEL UNIVERS
```

- **Pause à chaque personne** : la zone résultat `REP` de `DSPLY` fait **attendre la réponse** de l'utilisateur ; Entrée affiche la personne suivante. Sans zone résultat, les messages défilent sans pause.
- **Sortie anticipée** : taper `Q` puis Entrée (`REP`). **F3 n'est pas possible avec `DSPLY` seul** : le compilateur refuse `*INKC` (QRG7030, l'indicateur KC n'est défini par aucun fichier) et job-i.fr indique que `DSPLY` « ne modifie aucun indicateur ». F3 demande un fichier écran et `EXFMT` (voir [TP3](../../sources/RPG/RPG-ILE/BIB05/TP3.md)).
- **Format du fichier `PERSO`** (listage du compilateur) : format `PERSOF` ; `NOM` alphanumérique 15, `PRENOM` alphanumérique 15, `UNIVERS` numérique 4 chiffres (renommé `UNIV`), `TEMPS` numérique 20 chiffres ; enregistrement de 54 octets.
- **Pièges rencontrés** : `UNIVERS` fait 7 caractères, or un nom de zone RPG III en fait 6 au maximum : il faut le **renommer** dans la spécification I (`UNIV`) sinon le compilateur l'ignore (QRG4052 puis QRG7030) ; `*INKC` sans fichier écran → QRG7030 ; une ligne de repère collée dans le source → QRG2001 ; un fichier écran déclaré mais non créé → QRG2120 / QRG5154 / QRG7064 ; `CRTRPGPGM` avec `REPLACE(*NO)` sur un programme existant → QRG0012.
- **Comportement du cycle** : au premier enregistrement, les calculs de total (`CL1`) sont sautés, d'où le message du départ dans `*INZSR` ; en fin de fichier `LR` allume aussi `L1` : le message s'affiche une dernière fois.
- **À confirmer à l'exécution** : ce que fait `CL1` quand `SETON LR` arrête le programme ; la rupture `L1` suppose les enregistrements **groupés par `UNIVERS`** (sinon lire la LF [PRSOLF](../../sources/DDS/BIB12/PRSOLF.md), à clé `UNIVERS`, dont le format est `PERSOFM`).
- **Création** : `CRTRPGPGM PGM(MABIB/PERSOCYC) SRCFILE(MABIB/QRPGSRC)` ; test : `CALL PERSOCYC`.
- **Modèles complets du cycle** : [CYCDEMO](../../sources/RPG/RPG-III-400/BIB20/CYCDEMO.md), [CYCLE-GAP-EXEMPLES](../CYCLE-GAP-EXEMPLES.md).

### Variante : impression avec cartes O à la place de DSPLY

> Statut : **compile** (RPG/400, 16/11/2026). Rendu à l'impression à confirmer sur le spool. Même fichier `PERSO` et même cycle que l'exemple précédent, mais le résultat part dans un **fichier imprimante** (`QSYSPRT`) : plus de `DSPLY`, plus de tableau `MSG`, **plus de limite à `UNIVERS = 5`** (tout le fichier est lu, le cycle s'arrête seul à la fin).

- **Repère de colonnes** (**ne pas le copier dans le membre**) :

```	ext
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

- **Programme RPG III** (source `QRPGSRC` ou autre fichier source) :

```	ext
     FPERSO   IP  E                    DISK
     FQSYSPRT O   F     132     OF     PRINTER
      *
     IPERSOF      01
     I              UNIVERS                         UNIV  L1
      *
     C   01                ADD  1         NB      30
      *
      * SOUS ROUTINE INIT
     C           *INZSR    BEGSR
     C                     Z-ADD0         NB
     C                     ENDSR
      *
     OQSYSPRT H  101   1P
     O       OR        OF
     O                                   40 'NOUVELLE ANIME'
     O                                   70 'Page'
     O                         PAGE  Z   75
     OQSYSPRT D 11     L1
     O                                    8 'UNIVERS'
     O                         UNIV  Z   12
     OQSYSPRT D  1     01
     O                         NOM       16
     O                         PRENOM    34
     OQSYSPRT T 2      LR
     O                                   22 'NOMBRE DE PERSONNES'
     O                         NB    Z   26
```

- **En-tête** : le titre « NOUVELLE ANIME » et le numéro de page (zone réservée `PAGE`) sont imprimés sur la première page (`1P`) et à chaque débordement (`OF`), comme dans [CYCDEMO](../../sources/RPG/RPG-III-400/BIB20/CYCDEMO.md).
- **Rupture `L1`** : une ligne « UNIVERS nn » est imprimée avant la première personne de chaque groupe (ligne de détail conditionnée par `L1`, placée **avant** la ligne de détail `01` dans les spécifications O). Pour afficher « NOUVELLE ANIME » à chaque changement d'anime plutôt qu'en titre, remplacer la constante `'UNIVERS'` par `'NOUVELLE ANIME'`.
- **Détail** : nom (fin en position 16) et prénom (fin en position 34), une ligne par personne ; **total** « NOMBRE DE PERSONNES » à `LR`.
- **Sous-routine `*INZSR`** conservée : elle ne fait plus que remettre `NB` à zéro.
- **Spécifications O** : fichier `QSYSPRT` déclaré en spécification F (`O   F     132     OF     PRINTER`), indicateur d'en-tête `1P` / `OR OF`, colonnes de fin de zone en 40-43 et constante à partir de la colonne 45 ; mise en page reprise de [CYCDEMO](../../sources/RPG/RPG-III-400/BIB20/CYCDEMO.md).
- **Création et lecture** : `CRTRPGPGM PGM(BIALADE/CYCLEIMP) SRCFILE(BIALADE/ANIME) SRCMBR(CYCLEIMP)` (un nouveau membre évite QRG0012 si le programme existe déjà, ou `REPLACE(*YES)`) ; `CALL` puis `WRKSPLF` pour ouvrir l'impression.
- **À confirmer** : la rupture `L1` suppose les enregistrements **groupés par `UNIVERS`**.
