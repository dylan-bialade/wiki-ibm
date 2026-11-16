# 03 - RPG par version (RPG III / RPG IV colonné / full free)

> Source : [job-i.fr](https://job-i.fr/). Blocs `AUTO` régénérés ; écrivez dans « Mes exemples ».

<!-- AUTO:START -->
## Quelle version ?
| Version | Source | Compilateur | Débogage | Forme |
|---|---|---|---|---|
| **RPG III / RPG/400** | `QRPGSRC` | `CRTRPGPGM` | `STRISDB` | tout en colonnes (H F E I C O) |
| **RPG IV (ILE) colonné** | `QRPGLESRC` | `CRTBNDRPG` / `CRTRPGMOD` | `STRDBG` | spécifications D, EVAL, BIF |
| **RPG IV full free** (`**FREE`, 7.2 TR3+) | `QRPGLESRC` | `CRTBNDRPG` | `STRDBG` | `DCL-S`, `DCL-F`, `DCL-PI`, sans colonnes |

## RPG III  ([source](https://job-i.fr/coder-rpg-iii))
- Spécif. en colonne 6 : **H** contrôle, **F** fichiers, **E** tableaux, **I** entrées, **C** calculs, **O** sorties.
- Spécif. C : 7-8 niveau (L1-L9, LR, SR) · 9-17 indicateurs · 18-27 facteur 1 · 28-32 opération · 33-42 facteur 2 · 43-48 résultat · 49-51 longueur · 52 décimales · 54-59 indicateurs résultants.
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
- **RPG III (colonné, boucles, CHAIN)** : [BECRUD](../../sources/RPG/RPG-ILE/BIALADE/BECRUD.md) (CRUD écran + fichier clé), [GESTLIVRE](../../sources/RPG/RPG-III-400/BIALADE/GESTLIVRE.md), [MAJIDCLI](../../sources/RPG/RPG-III-400/BIALADE/MAJIDCLI.md).
- **Sous-fichier en RPG** : [EXAMPLESF](../../sources/RPG/RPG-ILE/BIALADE/EXAMPLESF.md) (`SFILE(SFL1:RRN)`, `SETLL *LOVAL`, chargement par `READ`).
- **Full free + prototypes + module** : copie [TP3MODP](../../sources/RPG/Copy/BIAILE/TP3MODP.md) (`DCL-PR`, garde `/if not defined`) et module [TP3MOD](../../sources/RPG/RPG-ILE/BIAILE/TP3MOD.md) (`ctl-opt nomain`, `dcl-proc`).
