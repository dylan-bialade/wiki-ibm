# 03 - RPG par version (RPG III / RPG IV colonné / full free)

> Source : [job-i.fr](https://job-i.fr/). Blocs `AUTO` régénérés ; écrivez dans « Mes exemples ».

<!-- AUTO:START -->

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Quelle version ?](#quelle-version-)
- [RPG III  (source, codes opération)](#rpg-iii--source-codes-opération)
- [Instructions RPG IV full free  (source)](#instructions-rpg-iv-full-free--source)
- [Fonctions intégrées  (source)](#fonctions-intégrées--source)
- [Cycle GAP  (source)](#cycle-gap--source)
- [Constantes figuratives  (source)](#constantes-figuratives--source)
- [Codes et mots d'édition  (source)](#codes-et-mots-dédition--source)
- [Prototypes PR / PI  (source)](#prototypes-pr--pi--source)
- [Sous-fichiers  (source)](#sous-fichiers--source)
- [Zones de données  (source)](#zones-de-données--source)
- [API système  (source)](#api-système--source)
- [Mes exemples](#mes-exemples)
<!-- TOC:END -->

## Quelle version ?

| Version | Source | Compilateur | Débogage | Forme |
|---|---|---|---|---|
| **RPG III / RPG/400** | `QRPGSRC` | `CRTRPGPGM` | `STRISDB` | tout en colonnes (H F E I C O) |
| **RPG IV (ILE) colonné** | `QRPGLESRC` | `CRTBNDRPG` / `CRTRPGMOD` | `STRDBG` | spécifications D, EVAL, BIF |
| **RPG IV full free** (`**FREE`, 7.2 TR3+) | `QRPGLESRC` | `CRTBNDRPG` | `STRDBG` | `DCL-S`, `DCL-F`, `DCL-PI`, sans colonnes |

## RPG III  ([source](https://job-i.fr/coder-rpg-iii), [codes opération](https://job-i.fr/rpg-iii))
- **79 codes opération** répartis en 10 familles (lecture fichiers 9, écriture/contrôle 12, structures 9, indicateurs/branchements 5, sous-programmes/appels 11, calculs 9, transferts 7, chaînes 6, tableaux/bits 9, écrans 2) ; chaque fiche donne un piège et l'équivalent RPG ILE. Site : 54 instructions et 95 fonctions RPG IV.
- Spécif. en colonne 6 : **H** contrôle, **F** fichiers, **E** tableaux, **L** saut (citée sans explication), **I** entrées, **C** calculs, **O** sorties.
- Spécification **C** (calculs), colonne par colonne :

| Colonnes | Contenu |
|---|---|
| 6 | `C` (spécification de calcul) ; `*` en colonne 7 = commentaire |
| 7-8 | niveau de rupture (L1-L9, LR) ou SR |
| 9-17 | indicateurs de condition (`N` = négation) |
| 18-27 | facteur 1 |
| 28-32 | code opération (5 car. max) |
| 33-42 | facteur 2 |
| 43-48 | résultat (6 car. max) |
| 49-51 | longueur |
| 52 | décimales |
| 53 | extension (`H`, `N`, `P`) |
| 54-59 | 3 paires d'indicateurs résultants |
| 60-74 | commentaire |

- Repère de colonnes (à placer au-dessus d'un source RPG III en police fixe) :

```text
         1         2         3         4         5         6         7
1234567890123456789012345678901234567890123456789012345678901234567890123456789
     C           PCODE     CHAINARTICLE              91
```
- Cycle : `SETON LR` pour terminer (sinon boucle).
- Opérations : `MOVE`/`MOVEL`, `Z-ADD`, `SUB`, `IFEQ…ENDIF`, `DOWEQ…ENDDO`, `CHAIN`, `SETLL`, `READ`, `UPDAT`, `EXFMT`, `DSPLY`, `SETON`/`SETOF`.
- Piège : en RPG III, fichier/format/zone doivent avoir des noms distincts ; littéral de 8 car. utiles en facteurs.
```
     FARTICLE UF  E           K        DISK
     C           PCODE     CHAINARTICLE              91
     C           *IN91     IFEQ '1'
     C                     MOVE 'INC'     PRET
     C                     ENDIF
     C                     SETON                     LR
```

## Instructions RPG IV full free  ([source](https://job-i.fr/instructions-rpg))

| Famille | Instructions |
|---|---|
| Déclarations | `DCL-S`, `DCL-DS`, `DCL-F`, `DCL-PR`, `DCL-PI`, `DCL-PROC` |
| Contrôle | `IF`, `SELECT`, `DOW`, `DOU`, `FOR`, `FOR-EACH` |
| Procédures / erreurs | `CALLP`, `RETURN`, `MONITOR` |
| Fichiers | `CHAIN`, `READE`, `SETLL`, `WRITE`, `UPDATE` |
| Calcul | `EVAL` |

## Fonctions intégrées  ([source](https://job-i.fr/fonctions-rpg))

| Fonction | Rôle |
|---|---|
| `%SUBST`, `%TRIM`, `%SCAN`, `%REPLACE`, `%CHECK`, `%LEN` | chaînes |
| `%DEC`, `%INT`, `%CHAR`, `%EDITC` | conversions / édition |
| `%DATE`, `%DIFF` | dates |
| `%ELEM`, `%LOOKUP`, `%MAX` | tableaux / max |
| `%EOF`, `%FOUND` | état fichier après lecture/CHAIN |
| `%ABS`, `%REM`, `%SQRT` | calcul |

## Cycle GAP  ([source](https://job-i.fr/cycle-gap-rpg))
- Boucle ajoutée avec un fichier primaire (`IP`) : entêtes/détail → lecture + ruptures → calculs de total (L1-L9, LR) → sorties de total → fin si LR → transfert zones → calculs de détail.
- Indicateurs : `1P` premier cycle, `01` enregistrement lu, `L1-L9` ruptures, `OF` fin de page, `LR` fin. Full free : pas de fichier primaire.

## Constantes figuratives  ([source](https://job-i.fr/constantes-figuratives-rpg))
`*BLANKS`, `*ZEROS`, `*HIVAL` (x'FF' / max numérique), `*LOVAL`, `*ALL'xx'`, `*ON`/`*OFF`, `*NULL`. Piège : `*BLANKS` sur DS à sous-zones numériques → erreur décimale ; utiliser `CLEAR`/`INZ`.

## Codes et mots d'édition  ([source](https://job-i.fr/mots-edition-rpg))
- Code `J` : virgule décimale + signe négatif à droite (1234,5 → `1.234,50`).
- Mot d'édition : gabarit (blanc = chiffre, `0`/`*` arrêt de suppression des zéros, `$`, `&`, `CR`/`-`). Full free : `%EDITW(zone : mot)`, `%EDITC(zone : 'J')`.

## Prototypes PR / PI  ([source](https://job-i.fr/prototypes-rpg-pr-pi))
- `DCL-PR` = appel (`EXTPGM`/`EXTPROC`), `DCL-PI` = paramètres reçus (remplace `*ENTRY PLIST`).
- Passage : défaut par référence · `CONST` lecture seule (accepte littéraux) · `VALUE` par copie (procédures) · `OPTIONS(*NOPASS)` facultatif (`%PARMS`).
- Partager le PR via `/COPY` ; erreurs : RNF3764 (PI≠PR), RNF7542 (littéral sans CONST), MCH1202 à l'exécution.

## Sous-fichiers  ([source](https://job-i.fr/sous-fichier-rpg))
- DDS : formats `SFL` + `SFLCTL` ; mots-clés `SFLSIZ`, `SFLPAG`, `SFLDSPCTL`, `SFLDSP`, `SFLCLR`, `SFLEND(*MORE)`, `SFLRCDNBR`.
- RPG : `SFILE(SFL1:RANG)`, `WRITE SFL1`, `EXFMT SF1CTL`, `READC SFL1`. Chargement statique recommandé (SFLSIZ > SFLPAG).
- Piège : `SFLMSG` invisible si `SFLDSP` coupé.

## Zones de données  ([source](https://job-i.fr/zone-de-donnees-dtaara-ibm-i))
- `CRTDTAARA`, `RTVDTAARA`, `CHGDTAARA`, `DSPDTAARA` ; `*LDA` (par job). RPG : `dcl-s v packed(7:0) dtaara('LIB/NOM'); in *lock v; ... out v;`. SQL : `QSYS2.DATA_AREA_INFO`.

## API système  ([source](https://job-i.fr/api-systeme-ibm-i))
- Familles `*PGM` (`EXTPGM`, ex. `QCMDEXC`, `QUSROBJD`, `QSNDDTAQ`) et procédures ILE (`EXTPROC`). Dernier paramètre : structure d'erreur (octets fournis `inz(%size(ds))`, disponibles, ID CPFxxxx).
- `QCMDEXC(cmd : %len(cmd))` à entourer de `MONITOR`.
<!-- AUTO:END -->

## Mes exemples
- **RPG III (colonné, boucles, CHAIN)** : [BECRUD](../../sources/RPG/RPG-ILE/BIB05/BECRUD.md) (CRUD écran + fichier clé), [GESTLIVRE](../../sources/RPG/RPG-III-400/BIB05/GESTLIVRE.md), [MAJIDCLI](../../sources/RPG/RPG-III-400/BIB05/MAJIDCLI.md).
- **Sous-fichier en RPG** : [EXAMPLESF](../../sources/RPG/RPG-ILE/BIB05/EXAMPLESF.md) (`SFILE(SFL1:RRN)`, `SETLL *LOVAL`, chargement par `READ`).
- **Full free + prototypes + module** : copie [TP3MODP](../../sources/RPG/Copy/BIB03/TP3MODP.md) (`DCL-PR`, garde `/if not defined`) et module [TP3MOD](../../sources/RPG/RPG-ILE/BIB03/TP3MOD.md) (`ctl-opt nomain`, `dcl-proc`).
- **Cycle RPG (GAP)** : [CYCDEMO](../../sources/RPG/RPG-III-400/BIB20/CYCDEMO.md) (fichier primaire + secondaire, niveaux L1/L2, concordance M1/MR, 1P, OF, totaux), [FILMCYC](../../sources/RPG/RPG-III-400/BIB21/FILMCYC.md) (L1 à L3), [LIVGAP1](../../sources/RPG/RPG-III-400/BIB01/LIVGAP1.md) et [LIVGAP2](../../sources/RPG/RPG-III-400/BIB01/LIVGAP2.md) (rupture L1). Liste complète : [CYCLE-GAP-EXEMPLES](../CYCLE-GAP-EXEMPLES.md).
- **Mêmes exercices, façons différentes** : [COMPARAISON-BIBLIOTHEQUES](../COMPARAISON-BIBLIOTHEQUES.md).
- **Les 7 spécifications du RPG III : « HFELICO »** (cours RPG/400, type en colonne 6, dans cet ordre dans le source) : **H** contrôle (options globales : format de date, séparateur décimal) ; **F** fichiers (obligatoire dès qu'un fichier est utilisé) ; **E** extension (tableaux et tables) ; **L** saut (règles de saut de page des impressions) ; **I** entrée (description des enregistrements lus, indicateurs d'enregistrement, zones de contrôle L1-L9, renommage de zones) ; **C** calcul (traitement, sous-routines) ; **O** sortie (mise en forme des impressions). job-i.fr cite la spécification **L** dans sa liste mais ne l'explique pas (ni **H**, **E**, **I**, **O** : seule **C** est détaillée colonne par colonne). Exemple dans le dépôt : [fiche 06](06-cycle-rpg-et-sous-routines.md) (F, E, I, C, O) ; détail des colonnes de **C** plus haut.
- **`%LOWER` / `%UPPER`** (apport 2026-11-17) : les fonctions existent (index job-i des fonctions RPG, section chaînes de caractères : « Passer en minuscules / en majuscules »). IBM (« What's New in 7.5 », [source](https://www.ibm.com/docs/en/ssw_ibm_i_75/rzasd/rpgrelv7r5.htm)) : `%LOWER` convertit la casse d'une chaîne caractère ou UCS-2, avec conversion partielle possible (position et longueur), et renvoie la chaîne entière ; un PTF d'exécution est requis sur tout système qui exécute un programme utilisant `%LOWER`, `%UPPER` ou `%SPLIT` ; introduites avec IBM i 7.4 TR4 (article de presse, source secondaire). **Syntaxe exacte non vérifiée** : lire /fonctions-rpg/lower sur job-i et la référence IBM avant usage.
- **Tableaux de compilation `CTDATA` et `ALT`** (apport 2026-11-18) : vérifié sur IBM i 7.4 (« Defining Related Arrays », [source](https://www.ibm.com/docs/ssw_ibm_i_74/rzasd/defrel.htm)) : `ALT` sur la définition du tableau alterné charge deux tableaux de compilation (ou de pré-exécution) en format alterné ; le principal porte `CTDATA` ; `PERRCD`, `FROMFILE`, `TOFILE` et `CTDATA` sont interdits sur le tableau alterné ; les données sont alternées en commençant par le principal. **Non vérifié** : la limite « un seul `ALT` par tableau principal » et les messages RNF3454 et RNF8045 (aucune source IBM ou job-i trouvée) ; RNF3442 est cité par un forum (non officiel) quand `ALT` est utilisé sans `CTDATA` ni `FROMFILE`. Exemples de tableaux dans les sources : ASYNTAXTAB, VISMOIS.
