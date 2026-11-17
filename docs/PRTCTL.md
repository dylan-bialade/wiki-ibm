# PRTCTL : contrôle dynamique d'impression en RPG

> Source officielle lue le 2026-11-17 : IBM Documentation, ILE RPG Reference (IBM i 7.5), [structure de données *COMPAT PRTCTL](https://www.ibm.com/docs/fr/i/7.5.0?topic=structcompat-compat-prtctl-data-structure) et [mot-clé PRTCTL](https://www.ibm.com/docs/fr/ssw_ibm_i_75/rzasd/fprtctl.htm). Synthèse personnelle, pas de copie. Résultat d'un test réel : [IMPRESSION-FULLFREE](IMPRESSION-FULLFREE.md).

## 1. Principe (documenté par IBM)
- `PRTCTL(structure{:*COMPAT})` active le contrôle dynamique de l'impression : la structure contient les informations de contrôle de formulaire (espace/saut avant et après) et le compteur de lignes. **Valide seulement pour un fichier décrit dans le programme** (`PRINTER(132)` par exemple).
- `*COMPAT` : disposition compatible RPG III (section 2). Sans `*COMPAT` : disposition « longueur étendue » (section 2 bis).
- Les valeurs de la structure sont les mêmes que celles des colonnes 40-51 de la spécification O. La structure ne sert que pour les sorties dont ces colonnes sont **à blanc** ; si elles et les sous-zones 1 à 4 sont à blanc, la valeur par défaut est **espace 1 après**. On peut changer les sous-zones pendant l'exécution.

## 2. Disposition `*COMPAT` (9 octets)

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

## 2 bis. Disposition « longueur étendue » (sans `*COMPAT`, 15 octets minimum)
Source : [IBM i 7.1, Extended Length PRTCTL Data Structure](https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_71/rzasd/sc092508475.htm) (lue le 2026-11-17 ; **non vérifiée en 7.5 / 7.6**). La page ne donne pas de valeurs par défaut.

| Positions | Sous-zone | Type | Valeurs valides |
|---|---|---|---|
| 1-3 | espace avant | `CHAR(3)` | blanc ou 0-255 |
| 4-6 | espace après | `CHAR(3)` | blanc ou 0-255 |
| 7-9 | saut avant | `CHAR(3)` | blanc ou 1-255 |
| 10-12 | saut après | `CHAR(3)` | blanc ou 1-255 |
| 13-15 | compteur de lignes | zoné 3,0 | numérique |

Les noms de sous-zones (`spaceB`, `spaceA`, `skipB`, `skipA`, `lineCnt`) sont libres. Le cadrage des valeurs (`'  1'` ou `'1  '`) n'est pas précisé : à tester sur le spool.
## 3. Cause de l'échec observé (très probable)
Le premier programme déclarait **quatre sous-zones `CHAR(3)`** (c'est la disposition *étendue*, appliquée à tort avec `*COMPAT`) (`spaceB`, `spaceA`, `skipB`, `skipA`) puis `ZONED(3:0)`, soit une structure de 15 octets, et les remplissait de `'000'` / `'001'`. Avec la disposition réelle (1+1+2+2+3), les octets étaient lus de travers : par exemple `'000' '001' '000' '000'` donne « saut après = 01 » (saut à la ligne 1 après chaque écriture) et le compteur de lignes écrasé. Cela est cohérent avec le spool observé (saut de page à tort, lignes superposées), sans l'avoir prouvé octet par octet. La disposition à `CHAR(3)` est correcte **sans** `*COMPAT` (section 2 bis), pas avec. (Constat de terrain : le programme compilait et s'exécutait.)

## 4. Règles pratiques
- Espace avant/après : **1 caractère**, blanc ou `0`-`3` (blanc = aucun, pas `'000'`).
- Saut avant/après : **2 caractères**, blanc ou `01`-`99`/`A0`… (blanc = aucun, jamais `00`).
- Utiliser des blancs (`*BLANKS`) pour « pas d'espacement » plutôt que des zéros.
- Le compteur de lignes (`lineCnt`) est écrit par le compilateur : ne pas le modifier.
- Même modèle de curseur que les O-specs (voir [CYCLE-VERS-FULLFREE](CYCLE-VERS-FULLFREE.md)).

## 5. Statut des exemples
- Variante étendue (sans `*COMPAT`) : non écrite ; la déclaration de la section 2 bis suffit, avec `PRTCTL(prtCtl)`.
- Version **validée** sans `PRTCTL` : [CYCLEQSYS.rpgle](exemples-cycle/CYCLEQSYS.rpgle).
- Version avec `PRTCTL` corrigé : [CYCLEPRTCTL.rpgle](exemples-cycle/CYCLEPRTCTL.rpgle) (**non compilée ni testée**).
