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

### Exemple : liste de personnes avec cycle, rupture L1, tableau MSG, `*INZSR` et F3

> Statut : **proposé, non compilé** (à tester sur l'IBM i). Dérivé de l'exercice « BONBON » du cycle, avec le fichier `PERSO`.

- **Consigne** : reprendre l'exemple du cycle (fichier primaire `IP`) avec `PERSO` ; afficher **nom et prénom** ; quitter si `UNIVERS` vaut 5 ; quitter aussi avec **F3** avant la fin du fichier ; afficher « NOUVEL UNIVERS » à chaque changement d'univers (tableau chargé à la compilation) et au départ (sous-routine `*INZSR`) ; afficher le nombre de personnes à la fin.
- **Programme RPG III** (`PERSOCYC`, source `QRPGSRC`) :

```	ext
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
     FPERSO   IP  E                    DISK
     FPERSODSPCF  E                    WORKSTN
      *
     E                    MSG     1   1 52
      *
     IPERSOF      01
     I              UNIVERS                         UNIV  L1
      *
     C   01                EXFMTPERSOE1
     C   01                ADD  1         NB      30
      *
     C           UNIV      IFEQ 5
     C           *INKC     OREQ *ON
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

- **Écran DDS** (`PERSODSP`, source `QDDSSRC`) : un format `PERSOE1` avec `CF03(03)`, les zones `NOM` et `PRENOM` référencées sur `PERSO` (mêmes attributs que le fichier, ce qui évite un conflit de définition) :

```	ext
     A                                      DSPSIZ(24 80 *DS3)
     A          R PERSOE1
     A                                      CF03(03)
     A                                 1  2 SYSNAME
     A                                 1 30 'Liste des personnes'
     A                                 4  2 'Nom.......:'
     A            NOM       R        O 4 14 REFFLD(PERSOF/NOM *LIBL/PERSO)
     A                                 5  2 'Prenom....:'
     A            PRENOM    R        O 5 14 REFFLD(PERSOF/PRENOM *LIBL/PERSO)
     A                                23  2 'F3=Quitter   Entree=Suivant'
```

- **Pourquoi `EXFMT` et non `DSPLY` pour F3** : d'après job-i.fr, `DSPLY` « ne modifie aucun indicateur » et ne parle pas des touches de fonction. `*INKC` (F3) est positionné par un écran : même mécanisme que dans vos TP de gestion des livres ([TP3](../../sources/RPG/RPG-ILE/BIB05/TP3.md), [EXO3](../../sources/RPG/RPG-ILE/BIB05/EXO3.md)).
- **Pièges rencontrés** : `UNIVERS` fait 7 caractères, or un nom de zone RPG III en fait 6 au maximum : il faut le **renommer** dans la spécification I (`UNIV`) sinon le compilateur l'ignore (messages QRG4052 puis QRG7030) ; `K` sur la ligne F seulement si `PERSO` est à clé.
- **Comportement du cycle** : au premier enregistrement, les calculs de total (`CL1`) sont sautés, d'où le message du départ dans `*INZSR` ; en fin de fichier `LR` allume aussi `L1` : le message s'affiche une dernière fois.
- **À tester** : ce que fait `CL1` quand `SETON LR` arrête le programme (`UNIVERS = 5` ou F3) ; la rupture `L1` suppose les enregistrements **groupés par `UNIVERS`** (sinon lire la LF [PRSOLF](../../sources/DDS/BIB12/PRSOLF.md), à clé `UNIVERS`, dont le format est `PERSOFM`).
- **Création** : `CRTDSPF FILE(MABIB/PERSODSP) SRCFILE(MABIB/QDDSSRC)` puis `CRTRPGPGM PGM(MABIB/PERSOCYC) SRCFILE(MABIB/QRPGSRC)` ; test : `CALL PERSOCYC`.
- **Modèles complets du cycle** : [CYCDEMO](../../sources/RPG/RPG-III-400/BIB20/CYCDEMO.md), [CYCLE-GAP-EXEMPLES](../CYCLE-GAP-EXEMPLES.md).
