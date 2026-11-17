# Impression en RPG : réécrire un état à cycle, PRTCTL

> Impression en RPG full free : retour d'expérience (spools mesurés, version validée) puis le détail de PRTCTL. Voir aussi la [fiche 08](cheatsheets/08-impression-et-printer-ibm-i.md) et le [cycle RPG](CYCLE-RPG.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](SOMMAIRE.md))

- [Partie 1 : réécrire un état à cycle en full free (retour d'expérience)](#partie-1--réécrire-un-état-à-cycle-en-full-free-retour-dexpérience)
  - [Résumé (à retenir)](#résumé-à-retenir)
  - [1. Ce qui s'est passé](#1-ce-qui-sest-passé)
  - [2. Mesure du spool de référence (RPG III à cycle)](#2-mesure-du-spool-de-référence-rpg-iii-à-cycle)
  - [3. Modèle de spacing (celui des O-specs)](#3-modèle-de-spacing-celui-des-o-specs)
  - [4. Choix de la version corrigée](#4-choix-de-la-version-corrigée)
  - [5. Test à faire (le wiki ne peut pas compiler)](#5-test-à-faire-le-wiki-ne-peut-pas-compiler)
  - [6. Pièges rencontrés](#6-pièges-rencontrés)
  - [7. Méthode habituelle de tes bibliothèques : fichier imprimante externe (recommandée)](#7-méthode-habituelle-de-tes-bibliothèques--fichier-imprimante-externe-recommandée)
  - [8. Variante sans DDS : `QSYSPRT` avec une DS par type de ligne](#8-variante-sans-dds--qsysprt-avec-une-ds-par-type-de-ligne)
- [Partie 2 : PRTCTL, contrôle dynamique d'impression](#partie-2--prtctl-contrôle-dynamique-dimpression)
  - [1. Principe (documenté par IBM)](#1-principe-documenté-par-ibm)
  - [2. Disposition `*COMPAT` (9 octets)](#2-disposition-compat-9-octets)
  - [2 bis. Disposition « longueur étendue » (sans `*COMPAT`, 15 octets minimum)](#2-bis-disposition--longueur-étendue--sans-compat-15-octets-minimum)
  - [2 ter. Variante vue en cours : sous-zones `ZONED(3:0)` (disposition étendue)](#2-ter-variante-vue-en-cours--sous-zones-zoned30-disposition-étendue)
  - [3. Cause de l'échec observé (très probable)](#3-cause-de-léchec-observé-très-probable)
  - [4. Règles pratiques](#4-règles-pratiques)
  - [5. Statut des exemples](#5-statut-des-exemples)
<!-- TOC:END -->

## Partie 1 : réécrire un état à cycle en full free (retour d'expérience)

> Page issue d'un **test réel** : un programme RPG III à cycle (état avec rupture, en-tête de page, totaux) réécrit en full free. Les constats sur les spools sont **observés** (PDF de spool comparés). **Version validée : [CYCLEQSYS.rpgle](exemples-cycle/CYCLEQSYS.rpgle)** (`QSYSPRT` + une DS par type de ligne) : **compilée par l'utilisateur, spool identique à la référence RPG III** (8 pages, texte identique sur les 418 lignes, rendu identique au pixel près hors bruit d'anti-aliasing). Les autres variantes (`CYCLEIMP` + `CYCLEPRT`, `CYCLETOTO`) restent **non testées**. Voir aussi la [fiche 08](cheatsheets/08-impression-et-printer-ibm-i.md) et le [cours du cycle](CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples).

### Résumé (à retenir)
- **Vérifié (compilé et exécuté)** : `DCL-F QSYSPRT PRINTER(132) USAGE(*OUTPUT) OFLIND(*INOF)` ; `WRITE QSYSPRT <ds>` avec une DS `LEN(132) INZ` par type de ligne ; sous-zones placées par `POS(n)` avec constantes `INZ('...')` ; `%EDITC(zone : 'Z')` pour numéros de page, univers et totaux ; espacements par lignes blanches (`dsVide`) selon le modèle du curseur (section 3) ; saut de page par remplissage jusqu'à la ligne 66 après dépassement de la ligne 60.
- **Cause de l'échec `PRTCTL`** : mauvaise disposition de la structure (voir [PRTCTL](IMPRESSION-RPG.md#partie-2--prtctl-contrôle-dynamique-dimpression)) ; version corrigée non testée : [CYCLEPRTCTL.rpgle](exemples-cycle/CYCLEPRTCTL.rpgle).
- **Non vérifié** : mots-clés du fichier imprimante DDS de `CYCLEPRT` (`SKIPB`, `SPACEA(0)`, `PAGNBR`), comportement du cycle sur fichier vide.
### 1. Ce qui s'est passé
Une première version full free utilisait `PRTCTL(prtCtl:*COMPAT)` avec une structure d'espacement remplie de `'000'` / `'001'`. Elle **compilait et s'exécutait**, mais le spool obtenu (40 pages au lieu de 8) était faux :
- l'en-tête était en ligne 1 mais « UNIVERS 1 » en ligne ~10 ;
- les 20 lignes de détail d'un univers étaient **superposées sur la même ligne** d'une page à part ;
- « TOTAL UNIVERS » apparaissait sur cette même page, vers la ligne 20 ; les saut de page étaient incohérents.
Cause très probable : la structure `PRTCTL` avait la **mauvaise disposition** (4 sous-zones `CHAR(3)` au lieu de `CHAR(1)`, `CHAR(1)`, `CHAR(2)`, `CHAR(2)` + compteur), donc les octets étaient lus de travers. Disposition officielle IBM et explication : [PRTCTL](IMPRESSION-RPG.md#partie-2--prtctl-contrôle-dynamique-dimpression). `PRTCTL` n'est pas documenté sur job-i.fr.

### 2. Mesure du spool de référence (RPG III à cycle)
Mesures faites sur le spool d'origine (66 lignes par page, saut à la ligne 60) :

| Élément | Position observée |
|---|---|
| En-tête (1P et débordement) | ligne 1 de chaque page, puis l'enregistrement suivant directement en ligne 2 |
| Ligne `UNIVERS n` | une ligne après le curseur (après un en-tête : une ligne blanche entre les deux ; après un total : aucune) |
| Détail | une ligne par enregistrement |
| `TOTAL UNIVERS` | deux lignes blanches avant |
| `TOTAL GENERAL` | une ligne blanche après le dernier total |
| Débordement | en-tête de la page suivante au **prochain enregistrement**, jamais avant un total (le dernier total est imprimé à la ligne 63 puis 65 de la page 8) |
| Total des pages | 8 pour 400 enregistrements |

### 3. Modèle de spacing (celui des O-specs)
Après une ligne écrite en `L` avec « espace après » `A`, le **curseur** est en `L + A`. Une ligne avec « espace avant » `B` s'imprime en `curseur + B`. Équivalences utilisées :

| O-spec d'origine (déduit) | Appel |
|---|---|
| H (1P ou OF) : saut ligne 1, espace après 1 | `Ecrire(0 : 1)` après remise du curseur à 1 |
| D `UNIVERS` : espace avant 1, après 1 | `Ecrire(1 : 1)` |
| D détail : espace après 1 | `Ecrire(0 : 1)` |
| T total : espace avant 2 | `Ecrire(2 : 0)` |

Une simulation de ces règles sur 20 univers de 20 enregistrements redonne le spool de référence (8 pages, page 1 finie sur le 9e détail du 3e univers, `TOTAL GENERAL` ligne 65 de la page 8). C'est une vérification de la **géométrie**, pas de la compilation.

### 4. Choix de la version corrigée
- **Pas de `PRTCTL`** : les espacements sont de vraies lignes blanches écrites (`WRITE QSYSPRT ligne`) ; le saut de page = écriture de lignes blanches jusqu'à la fin de la page (66 lignes, valeur par défaut documentée en fiche 08).
- `OFLIND(*INOF)` est conservé pour que le programme gère lui-même le débordement.
- Le débordement n'est testé qu'au moment d'un enregistrement (comme le cycle) ; les totaux ne le testent pas.
- Hypothèse à tester : si ton spool montre une **page blanche** en début de page 2, c'est que le système saute lui-même à la ligne 60 : supprime alors la boucle de remplissage dans `Debordement` (garde seulement `ligneCour = 1`).

### 5. Test à faire (le wiki ne peut pas compiler)
1. `CRTBNDRPG PGM(<BIB>/CYCLETOTO) SRCFILE(<BIB>/QRPGLESRC) SRCMBR(CYCLETOTO)` ; vérifier le message de compilation (aucune erreur attendue ; ne pas conclure sans le résultat).
2. Lancer, puis comparer le nouveau spool au spool de référence : 8 pages, `Page 8` avec `TOTAL GENERAL 400` en ligne 65, `UNIVERS 4` précédé directement du total.
3. Renvoyer le spool en cas de différence (les écarts de ligne se corrigent avec les valeurs du tableau 3).

### 6. Pièges rencontrés
- Un programme qui **compile** et s'exécute peut produire un spool entièrement faux : toujours comparer le spool, pas seulement l'absence d'erreur.
- `%EDITC(zone : 'Z')` et le placement par position de fin (`%SUBST` + `%LEN`) ont donné le résultat attendu sur « UNIVERS n », « Page n » et « TOTAL … » (constat sur le spool).
- La comparaison « à l'octet près » d'un PDF est trompeuse ; comparer les lignes (ex. `CPYSPLF`, non documenté dans le wiki).

### 7. Méthode habituelle de tes bibliothèques : fichier imprimante externe (recommandée)
Recherche dans les sources du dépôt : tes impressions RPG ILE / SQLRPGLE n'utilisent **ni `PRTCTL` ni lignes blanches écrites** ; elles déclarent un fichier imprimante **décrit en DDS** et écrivent des formats d'enregistrement. Exemples (anonymisés) :
- `sources/RPG/RPG-ILE/BIB02/PRINT.md` + `sources/DDS/BIB02/ECRANPRTF.md` : formats `ENTETE`, `TITRE`, `DETAIL`, `EJECT` ; saut de page par compteur de lignes.
- `sources/DDS/BIB20/BONRPGFREE.md` + `sources/DDS/BIB20/BONPRT.md` : full free, `DCL-F BONPRT PRINTER OFLIND(*in60)`, `IF *in60; WRITE EJECT; WRITE TITRE; WRITE ENTETE; *in60 = *off;`. DDS : `SPACEB(001)`, `SKIPA(1)`.
- `sources/RPG/RPG-ILE/BIB20/TPBONBON.md`, `sources/RPG/RPG-ILE/BIB17/ANIMSFSQL2.md` (`oflind(sautPage)`, `usropn`, `open/close`).
- `sources/DDS/BIB21/PRTFEX.md` : `DATE(*Y)`, `TIME`, `EDTCDE(Z)`, `PAGNBR`, `SKIPA(1)`.
- `sources/SQL/BIB02/PRTFSQL.md` + `PRINTSQL.md` : même schéma avec SQL.
Seule exception : `sources/RPG/RPG-ILE/BIB19/IDBGSRV.md` (`DCL-F QSYSPRT PRINTER(132)`, `WRITE QSYSPRT prtLine`, trace de debug, sans mise en page).

La version alignée sur cette méthode : [CYCLEPRT.prtf](exemples-cycle/CYCLEPRT.prtf) (DDS) + [CYCLEIMP.rpgle](exemples-cycle/CYCLEIMP.rpgle). Les 5 formats reproduisent le tableau 3 : `ENTETE` `SKIPB(1)` `SPACEA(1)` ; `UNIVERS` `SPACEB(1)` `SPACEA(1)` ; `DETAIL` `SPACEA(1)` ; `TOTUNI` et `TOTGEN` `SPACEB(2)` `SPACEA(0)`.
Création : `CRTPRTF FILE(<BIB>/CYCLEPRT) SRCFILE(<BIB>/QPRTSRC) SRCMBR(CYCLEPRT) PAGESIZE(66 132) OVRFLW(60)`, puis `CRTBNDRPG` (non testé).
Points **non vérifiés** (ni dans le wiki ni sur job-i) : `SKIPB(1)` en tête d'un format qui sert aussi de saut de page (alternative de tes sources : un format `EJECT` avec `SKIPA(1)` écrit avant `ENTETE`) ; `SPACEA(0)` accepté par `CRTPRTF` (sinon supprimer ces lignes) ; `PAGNBR` en colonne 72 imprimé sur 4 caractères ; `NOM` et `PRENOM` supposés de 15 caractères (déduit des colonnes du spool).

### 8. Variante sans DDS : `QSYSPRT` avec une DS par type de ligne
[CYCLEQSYS.rpgle](exemples-cycle/CYCLEQSYS.rpgle) : `DCL-F QSYSPRT PRINTER(132)` et `WRITE QSYSPRT <ds>` avec une DS de 132 caractères par type de ligne (`dsEntete`, `dsUnivers`, `dsDetail`, `dsTotUni`, `dsTotGen`), les zones placées par `POS(...)` aux colonnes du spool de référence. Espacements = lignes blanches (`dsVide`) selon le modèle du curseur (section 3). **Compilé et testé par l'utilisateur : spool identique à la référence.** `POS` sur les sous-zones d'une DS `LEN(132)`, `INZ` des constantes de sous-zone et plusieurs DS de même longueur écrites dans `QSYSPRT` sont donc validés.

## Partie 2 : PRTCTL, contrôle dynamique d'impression

> Source officielle lue le 2026-11-17 : IBM Documentation, ILE RPG Reference (IBM i 7.5), [structure de données *COMPAT PRTCTL](https://www.ibm.com/docs/fr/i/7.5.0?topic=structcompat-compat-prtctl-data-structure) et [mot-clé PRTCTL](https://www.ibm.com/docs/fr/ssw_ibm_i_75/rzasd/fprtctl.htm). Synthèse personnelle, pas de copie. Résultat d'un test réel : [Impression full free](IMPRESSION-RPG.md#partie-1--réécrire-un-état-à-cycle-en-full-free-retour-dexpérience).

### 1. Principe (documenté par IBM)
- `PRTCTL(structure{:*COMPAT})` active le contrôle dynamique de l'impression : la structure contient les informations de contrôle de formulaire (espace/saut avant et après) et le compteur de lignes. **Valide seulement pour un fichier décrit dans le programme** (`PRINTER(132)` par exemple).
- `*COMPAT` : disposition compatible RPG III (section 2). Sans `*COMPAT` : disposition « longueur étendue » (section 2 bis).
- Les valeurs de la structure sont les mêmes que celles des colonnes 40-51 de la spécification O. La structure ne sert que pour les sorties dont ces colonnes sont **à blanc** ; si elles et les sous-zones 1 à 4 sont à blanc, la valeur par défaut est **espace 1 après**. On peut changer les sous-zones pendant l'exécution.

### 2. Disposition `*COMPAT` (9 octets)

| Positions | Sous-zone | Type | Valeurs valides |
|---|---|---|---|
| 1 | espace avant | `CHAR(1)` | blanc ou `0` à `3` |
| 2 | espace après | `CHAR(1)` | blanc ou `0` à `3` |
| 3-4 | saut avant | `CHAR(2)` | blanc, `1`-`99`, `A0`-`A9` (100-109), `B0`-`B2` (110-112) |
| 5-6 | saut après | `CHAR(2)` | idem saut avant |
| 7-9 | compteur de lignes | zoné 3,0 | géré par le compilateur : initialisé après la première ligne imprimée, mis à jour après chaque sortie |

```rpgle
DCL-DS prtCtl;
  spaceB  CHAR(1);
  spaceA  CHAR(1);
  skipB   CHAR(2);
  skipA   CHAR(2);
  lineCnt ZONED(3:0);
END-DS;
DCL-F QSYSPRT PRINTER(132) USAGE(*OUTPUT) PRTCTL(prtCtl:*COMPAT);
```
(Le bloc de code est une transcription de la table IBM ; il n'a pas été compilé ici.)

### 2 bis. Disposition « longueur étendue » (sans `*COMPAT`, 15 octets minimum)
Source : [IBM i 7.1, Extended Length PRTCTL Data Structure](https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_71/rzasd/sc092508475.htm) (lue le 2026-11-17 ; **non vérifiée en 7.5 / 7.6**). La page ne donne pas de valeurs par défaut.

| Positions | Sous-zone | Type | Valeurs valides |
|---|---|---|---|
| 1-3 | espace avant | `CHAR(3)` | blanc ou 0-255 |
| 4-6 | espace après | `CHAR(3)` | blanc ou 0-255 |
| 7-9 | saut avant | `CHAR(3)` | blanc ou 1-255 |
| 10-12 | saut après | `CHAR(3)` | blanc ou 1-255 |
| 13-15 | compteur de lignes | zoné 3,0 | numérique |

Les noms de sous-zones (`spaceB`, `spaceA`, `skipB`, `skipA`, `lineCnt`) sont libres. Le cadrage des valeurs (`'  1'` ou `'1  '`) n'est pas précisé : à tester sur le spool.
### 2 ter. Variante vue en cours : sous-zones `ZONED(3:0)` (disposition étendue)
Un exemple de formateur déclare la structure sans `*COMPAT`, donc en disposition **étendue** (section 2 bis), mais avec des sous-zones numériques :
```rpgle
dcl-ds ctlImpr len(15);
  espAvant   zoned(3:0);    // espace avant  (colonnes 40-42 de la spécification O RPG IV)
  espApres   zoned(3:0);    // espace après  (43-45)
  sautAvant  zoned(3:0);    // saut avant    (46-48)
  sautApres  zoned(3:0);    // saut après    (49-51)
  ligneCour  zoned(3:0);    // ligne courante (rendue par le système)
end-ds;
dcl-f QSYSPRT printer(132) prtctl(ctlImpr);
```
- **Cohérent avec IBM** : 15 octets, 5 × 3 positions, mêmes positions que la section 2 bis, et sans `*COMPAT`. Les largeurs rappellent la spécification O : RPG IV = 3 positions chacun (colonnes 40-51), RPG III = 1+1+2+2 (colonnes 17-22), qui est la disposition `*COMPAT`.
- **Différence avec IBM** : IBM décrit les quatre premières sous-zones en **caractère** (« blanc ou 0-255 »), pas en numérique. Pour une valeur positive, un zoné de 3 chiffres occupe les mêmes 3 octets que le texte `'001'` : le résultat est équivalent pour 1 à 255 (raisonnement, non testé).
- **Point à surveiller** : un zoné à 0 contient `'000'` et non des blancs. IBM donne « blanc ou 1-255 » pour le **saut** : 0 n'y figure pas. Pour « aucun saut », utiliser des blancs (`CHAR(3)` et `*BLANKS`) ou tester le spool avant de s'y fier. Le blanc reste la valeur documentée pour « aucune action ».
- **Statut** : exemple rapporté, **non compilé ni testé ici**. Aucune explication du formateur n'est écrite dans le wiki : seule la déclaration est reprise.
### 3. Cause de l'échec observé (très probable)
Le premier programme déclarait **quatre sous-zones `CHAR(3)`** (c'est la disposition *étendue*, appliquée à tort avec `*COMPAT`) (`spaceB`, `spaceA`, `skipB`, `skipA`) puis `ZONED(3:0)`, soit une structure de 15 octets, et les remplissait de `'000'` / `'001'`. Avec la disposition réelle (1+1+2+2+3), les octets étaient lus de travers : par exemple `'000' '001' '000' '000'` donne « saut après = 01 » (saut à la ligne 1 après chaque écriture) et le compteur de lignes écrasé. Cela est cohérent avec le spool observé (saut de page à tort, lignes superposées), sans l'avoir prouvé octet par octet. La disposition à `CHAR(3)` est correcte **sans** `*COMPAT` (section 2 bis), pas avec. (Constat de terrain : le programme compilait et s'exécutait.)

### 4. Règles pratiques
- Espace avant/après : **1 caractère**, blanc ou `0`-`3` (blanc = aucun, pas `'000'`).
- Saut avant/après : **2 caractères**, blanc ou `01`-`99`/`A0`… (blanc = aucun, jamais `00`).
- Utiliser des blancs (`*BLANKS`) pour « pas d'espacement » plutôt que des zéros.
- Le compteur de lignes (`lineCnt`) est écrit par le compilateur : ne pas le modifier.
- Même modèle de curseur que les O-specs (voir [Cycle vers full free](CYCLE-RPG.md#partie-2--du-cycle-rpg-iii-au-full-free-table-de-correspondance)).

### 5. Statut des exemples
- Variante étendue (sans `*COMPAT`) : non écrite ; la déclaration de la section 2 bis suffit, avec `PRTCTL(prtCtl)`.
- Version **validée** sans `PRTCTL` : [CYCLEQSYS.rpgle](exemples-cycle/CYCLEQSYS.rpgle).
- Version avec `PRTCTL` corrigé : [CYCLEPRTCTL.rpgle](exemples-cycle/CYCLEPRTCTL.rpgle) (**non compilée ni testée**).
