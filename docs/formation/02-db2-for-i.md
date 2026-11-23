# Partie 02 : Architecture et concepts de DB2 for i

> Plan de formation, partie 02 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Base de données intégrée, DDS contre SQL, fichiers physiques et logiques, vues, contraintes, sécurité par ligne et colonne, journalisation.
>
> **Mots-clés** : Db2 for i, PF, LF, DDS, SQL, table, index, vue, clé primaire, clé étrangère, contrainte, RCAC, journal, QSYS2.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Pistes IBM](#pistes-ibm)
- [Cours détaillé](#cours-détaillé)
  - [1. Une base de données intégrée au système](#1-une-base-de-données-intégrée-au-système)
  - [2. Les PF (tables)](#2-les-pf-tables)
  - [3. Les LF, les index et les vues](#3-les-lf-les-index-et-les-vues)
  - [4. Membres, multi-membre, multi-format, fichiers source](#4-membres-multi-membre-multi-format-fichiers-source)
  - [5. Contraintes et intégrité](#5-contraintes-et-intégrité)
  - [6. RCAC : sécurité par ligne et par colonne](#6-rcac--sécurité-par-ligne-et-par-colonne)
  - [7. La journalisation](#7-la-journalisation)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Architecture et concepts de DB2 for i](#architecture-et-concepts-de-db2-for-i)
  - [Les objets de données](#les-objets-de-données)
  - [Les contraintes et l'intégrité](#les-contraintes-et-lintégrité)
  - [Sécurité et journalisation](#sécurité-et-journalisation)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 04 : Db2 for i et SQL](../cheatsheets/04-db2-for-i-et-sql.md)
- [SQL avancé](../SQL-AVANCE.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Fichier physique (PF) IBM i : DDS, CRTPF, UPDDTA et comparaison avec SQL](https://job-i.fr/fichier-physique-pf-ibm-i) | Un PF est l'objet *FILE qui contient les données d'une table (format, enregistrements, clé) ; créé en DDS ou en SQL, lisible en RPG comme en SQL. | En une phrase ; Pourquoi les DDS ont été inventées ; Ce qu'est un PF ; Créer un PF en DDS ; Ajouter, modifier, supprimer avec UPDDTA ; Voir le contenu, et la place des supprimés ; La même table en SQL ; PF DDS et table SQL : les différences démontrées |
| [Fichier logique (LF) IBM i : à quoi ça sert, clé, sélection et jointure](https://job-i.fr/fichier-logique-lf-ibm-i) | Un LF présente les données d'un ou plusieurs PF (ordre, sélection, zones, jointure) sans en contenir ; vu de SQL, équivalent d'une vue ou d'un index. | En une phrase ; Pourquoi les LF existent ; Un autre ordre : la clé ; Une sélection : seulement le type Feu ; La jointure : le Pokémon et ses attaques ; Les équivalents SQL : index et vues |
| [Fichier source IBM i : CRTSRCPF, longueur d'enregistrement et différence avec un PF](https://job-i.fr/fichier-source-ibm-i) | Un fichier source est un PF de type *SRC (séquence, date, texte) ; chaque membre contient un source (RPG, CL, DDS). | En une phrase ; Créer un fichier source ; La longueur d'enregistrement ; Fichier source ou PF de données ? |
| [Membre d'un fichier IBM i : objet, membre et fichier sans membre](https://job-i.fr/membre-fichier-ibm-i) | Un fichier est un objet qui décrit les données et contient zéro à plusieurs membres ; on gère l'objet (création, droits) et le membre (remplir, vider, lire). | En une phrase ; L'objet et ses membres ; Des commandes pour l'objet, d'autres pour le membre ; Un fichier peut vivre sans membre |
| [Multi-membre et multi-format IBM i : OVRDBF, ALIAS et pourquoi les éviter](https://job-i.fr/multi-membre-multi-format-ibm-i) | Multi-membre : plusieurs membres de même format à choisir à chaque accès ; LF multi-format : plusieurs PF dans un seul ordre de clé ; SQL et la plupart des outils les gèrent mal. | En une phrase ; Le multi-membre : un Pokédex par génération ; Pourquoi on évite le multi-membre ; Le multi-format : chaque Pokémon suivi de ses attaques ; Pourquoi on évite le multi-format |
| [Services SQL IBM i et AS/400 (QSYS2, SYSTOOLS) : exemples et résultats réels](https://job-i.fr/services-sql-ibm-i) | Catalogue des services SQL (QSYS2, SYSTOOLS) avec exemples et résultats. | Gestion des travaux (35) ; Bibliothèques et objets (5) ; Sécurité (26) ; Messages (7) ; Fichiers spoule (8) ; IFS (13) ; Journaux et audit (56) ; PTF (8) ; Stockage (16) ; Communications (22) ; Configuration (5) ; Application (48) |

## Pistes IBM

Issues de recherches ibm.com du 2026-11-23 : les pages sans mention « lu » **ne sont pas lues** ; la version indiquée peut différer de la 7.5 (à vérifier avant de s'en servir).

- [Row and column access control, RCAC (IBM i 7.2)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzahf/rzahfrcactitle.htm)
- [Journal management (IBM i 7.4)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzaki/rzakikickoff.htm)
- [How journal management works (IBM i 7.2)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzaki/rzakihowwrks.htm)
- [Setting up journaling (IBM i 7.2)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzaki/rzakisetupjrngs.htm)
- [DSPJRN (IBM i 7.6)](https://www.ibm.com/docs/en/ssw_ibm_i_76/cl/dspjrn.htm)
- [Redpaper RCAC (IBM i 7.2)](https://redbooks.ibm.com/abstracts/redp5110.html)

## Cours détaillé

> Synthèses personnelles à partir de job-i.fr (pages lues en partie, exemples « relevés sur IBM i 7.5 » selon job-i) et d'IBM Documentation **IBM i 7.5** (CREATE PERMISSION, CREATE MASK). L'assistant ne compile ni n'exécute rien : les exemples sont ceux de job-i ou des *hypothèses* signalées. Noms de bibliothèques et d'objets : ceux des pages job-i (fictifs).

### 1. Une base de données intégrée au système

Db2 for i est la base **intégrée à l'IBM i** : un fichier est un objet `*FILE` rangé dans une bibliothèque (= schéma SQL), lisible par un programme RPG comme par une requête SQL. L'idée d'origine (System/38, 1978, d'après job-i) : **une seule description des données**, au niveau de la zone, rangée avec le fichier ; les compilateurs la relisent (fichier *décrit en externe*), et chaque format porte un **niveau** : si la description change, un programme compilé avec l'ancienne est signalé. Les DDS (*data description specifications*) décrivent aussi les écrans et les états ; le SQL est arrivé sur l'AS/400 avec le produit SQL/400 (guide de 1988) et les deux façons **coexistent** et produisent le même type d'objet.

Un objet fichier porte la description (format, attributs, droits) et contient **zéro à plusieurs membres** ; chaque membre contient les enregistrements, tous au format du fichier. Supprimer le fichier supprime tous ses membres.

| Élément | Statut | Source |
|---|---|---|
| DDS nées avec le System/38 (1978), description unique réutilisée, contrôle de niveau, SQL/400 | vérifié (début de page lu, histoire citée par job-i d'après IBM 1978) | [job-i : PF](https://job-i.fr/fichier-physique-pf-ibm-i) |
| Fichier = objet + 0..n membres, tous au même format | vérifié (début de page lu) | [job-i : membre](https://job-i.fr/membre-fichier-ibm-i) |
| Comparaison AS/400 et IBM i | existence vérifiée, non relue | [job-i](https://job-i.fr/as400-vs-ibm-i) |

### 2. Les PF (tables)

Un **PF** : objet `*FILE` d'attribut PF qui **contient** les données ; **un seul format** d'enregistrement ; un ou plusieurs membres (par défaut `MAXMBRS(1)`) ; chemin d'accès par ordre d'arrivée ou par clé. Les fichiers source sont aussi des PF.

**DDS d'un PF** (exemple job-i, annoncé compilé par `CRTPF`) :

```
A                                      UNIQUE
A          R CLIENTR                   TEXT('Client')
A            NUMCLI         5P 0       COLHDG('Numero' 'client')
A            NOM           30A         COLHDG('Nom')
A            CATEG          1A         VALUES('A' 'B' 'C')
A            SOLDE          9P 2       EDTCDE(J)
A          K NUMCLI
```

Colonnes : 17 type de ligne (`R` format, `K` clé, blanc zone) ; 19-28 nom (10 caractères) ; 30-34 longueur ; 35 type (`A` caractère, `P` condensé, `S` étendu, `B` binaire, `L` date, `T` heure, `Z` horodatage) ; 36-37 décimales ; 45-80 mots-clés (`TEXT`, `COLHDG`, `VALUES`, `EDTCDE`, et `UNIQUE` au niveau du fichier). Création : `CRTPF FILE(biblio/CLIENT) SRCFILE(biblio/QDDSSRC)` (messages CPC7301 fichier créé, CPC7305 membre ajouté). Valeurs par défaut relevées par job-i : `SIZE(10000 1000 3)`, `REUSEDLT(*NO)`, `MAXMBRS(1)`.

**La même table en SQL** (exemple job-i) :

```sql
CREATE TABLE JOBIPF.CLIENT_EN_SQL FOR SYSTEM NAME CLIENTSQL (
  NUMCLI DECIMAL(5,0) NOT NULL,
  NOM CHAR(30) NOT NULL DEFAULT '',
  CATEG CHAR(1) NOT NULL DEFAULT 'A',
  SOLDE DECIMAL(9,2) NOT NULL DEFAULT 0,
  CONSTRAINT JOBIPF.CLIENT_EN_SQL_PK PRIMARY KEY (NUMCLI),
  CONSTRAINT JOBIPF.CLIENT_EN_SQL_CATEG CHECK (CATEG IN ('A','B','C'))
) RCDFMT CLIENTSQLR
```

Les en-têtes/textes DDS deviennent des `LABEL ON`. Pièges signalés : `FOR SYSTEM NAME` refusé (SQL7029) si le nom long est déjà un nom système valide ; un nom de contrainte non qualifié va dans le schéma courant (SQL5051). Un PF DDS reste modifiable en SQL (`INSERT`, `UPDATE`, `DELETE`) : SQL lit et modifie **tous** les fichiers physiques.

**PF DDS ou table SQL : différences démontrées par job-i**

| Point | PF créé en DDS | Table créée en SQL |
|---|---|---|
| Données écrites | non vérifiées : des blancs dans une zone condensée sont acceptés (erreur à la **lecture** : MCH1202 / RNQ0907 en RPG) | vérifiées à l'écriture : CPF5029 / CPF2972, rien n'est écrit |
| Valeurs permises | `VALUES` ne joue qu'à la saisie **écran** (UPDDTA) ; un `INSERT` SQL passe | contrainte `CHECK` : SQL0545 pour tout le monde |
| Taille | `SIZE(10000 1000 3)` | pas de limite fixée (`*NOMAX`) |
| Supprimés | place perdue jusqu'au `RGZPFM` (`REUSEDLT(*NO)`) | place réutilisée (`REUSEDLT(*YES)`) |
| Noms | 10 caractères | noms longs + nom système de 10 caractères |
| Clé | `UNIQUE` + zone `K` | `PRIMARY KEY`, contraintes nommées |
| Journalisation | non automatique (`STRJRNPF` ou `STRJRNLIB`) | automatique dans un schéma SQL (journal `QSQJRN`) |

Constat de job-i : en SQL, une zone condensée invalide revient à `NULL` **sans arrêter la requête** (message d'information SQL0802 / CPF5035 dans l'historique du travail) ; `SUM(SOLDE)` rend alors `NULL`. Conseil de job-i : **nouveau fichier = SQL**.

**Outils de saisie** : `UPDDTA` (programme DFU temporaire : `F10` saisie, `F11` modification, `F23` deux fois pour supprimer, Fin de zone dans les zones numériques) ; `DSPPFM` affiche les octets (zones condensées illisibles) ; `STRDFU` pour un DFU conservé.

| Élément | Statut | Source |
|---|---|---|
| PF : un format, membres, `MAXMBRS(1)`, colonnes DDS, CRTPF, valeurs par défaut | vérifié (page lue, début et milieu) | [job-i : PF](https://job-i.fr/fichier-physique-pf-ibm-i) |
| CREATE TABLE équivalent, LABEL ON, SQL7029, SQL5051 | vérifié (exemples de la page) | idem |
| Tableau des différences, MCH1202, CPF5029, SQL0545, SQL0802 | vérifié (page lue) ; codes message non contrôlés sur ibm.com | idem |
| UPDDTA (touches), DSPPFM | vérifié (page) | idem |
| Commande CRTPF | existence vérifiée, non relue | [CRTPF](https://job-i.fr/commandes-ibm-i/crtpf) |

### 3. Les LF, les index et les vues

Un **LF** ne contient **aucune donnée** : il présente autrement un ou plusieurs PF (ordre, sélection, zones, jointure) ; vu de SQL, équivalent d'une **vue** ou d'un **index** (job-i, d'après IBM). Usage cité : un LF peut présenter l'ancien format après l'ajout d'une zone au PF, les programmes existants n'étant pas recompilés.

```
A          R POKEMONR                  PFILE(POKEMON)
A          K TYPE1
A          K NOM
```
*(autre ordre : `PFILE` désigne le PF ; sans liste de zones, le LF reprend le format du PF et **doit porter le même nom de format**)*

```
A          R POKEMONR                  PFILE(POKEMON)
A          K NOM
A          S TYPE1                     COMP(EQ 'Feu')
```
*(sélection : ligne `S` avec `COMP`, faite par le système, pas par le programme)*

```
A          R POKEJOINR                 JFILE(POKEMON ATTAQUE)
A          J                           JOIN(POKEMON ATTAQUE)
A                                      JFLD(NUMPOK NUMPOK)
A            NUMPOK                    JREF(POKEMON)
A            NOM
A            ATTAQUE
A            PUISS
A          K NUMPOK
```
*(jointure : `JFILE`, ligne `J` avec `JOIN` et `JFLD`, `JREF` pour une zone présente dans les deux PF ; `JDFTVAL` au niveau du fichier garde aussi les enregistrements sans correspondance, avec blancs et zéros ; clé issue du **fichier primaire**)*

Règles du LF de jointure (job-i) : **lecture seule** (SQL0150 sur un UPDATE), DFU/UPDDTA ne l'affichent pas, un seul format non partageable, pas de contrôle de validation. Un **ordre de clé** n'est garanti qu'en lecture par clé : un `SELECT` sur un LF à clé n'est **pas trié**, seul `ORDER BY` garantit l'ordre ; la clé suit l'ordre EBCDIC (« É » avant « E » sans accent).

**Équivalents SQL** (exemples job-i) : la clé = `CREATE INDEX … ON PF (colonnes)` ; la sélection = `CREATE VIEW … WHERE …` ; la jointure avec `JDFTVAL` = `LEFT JOIN` dans une vue. Les objets SQL créés sont, dans le catalogue, des fichiers logiques. Création DDS : `CRTLF FILE(biblio/LF) SRCFILE(biblio/QDDSSRC)` (créer le PF d'abord, puis le LF). Voir aussi les `CREATE INDEX` / `CREATE VIEW` dans la [partie 05, § 4](05-sql.md#cours-détaillé).

| Élément | Statut | Source |
|---|---|---|
| LF sans données, PFILE, S/COMP, JFILE/JOIN/JFLD/JREF, JDFTVAL, règles du LF de jointure, SQL0150 | vérifié (page lue, début et milieu) | [job-i : LF](https://job-i.fr/fichier-logique-lf-ibm-i) |
| Pas d'ordre garanti en SQL sans ORDER BY ; tri EBCDIC | vérifié (exemple de la page) | idem |
| Équivalents SQL index/vue/LEFT JOIN | vérifié (exemples de la page) ; syntaxe CREATE INDEX/VIEW lue sur IBM 7.5 (partie 05) | idem + [IBM 7.5](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-create-index) |
| Commande CRTLF | existence vérifiée, non relue | [CRTLF](https://job-i.fr/commandes-ibm-i/crtlf) |

### 4. Membres, multi-membre, multi-format, fichiers source

- **Commandes sur l'objet** : `CRTPF`, `CRTLF`, `CRTSRCPF`, `DLTF`, `MOVOBJ`, `RNMOBJ`, `CRTDUPOBJ`, `SAVOBJ`, `RSTOBJ`, `GRTOBJAUT`, `RVKOBJAUT`, `CHGPF`, `DSPFD`. **Sur le membre** : `ADDPFM`, `RMVM`, `RNMM`, `CLRPFM`, `RGZPFM`, `DSPPFM`, `CHGPFM`. Les droits se donnent sur l'objet (tous les membres d'un coup). Un fichier peut vivre **sans membre** : `CRTPF … MBR(*NONE)`.
- **Multi-membre** : `CRTPF … MBR(*NONE) MAXMBRS(*NOMAX)` puis `ADDPFM` ; un deuxième `ADDPFM` sur un PF créé par défaut est refusé (CPF3213). En SQL un `SELECT` ne voit que le **premier membre** (sans erreur ni avertissement) ; un `ALIAS` (`CREATE ALIAS … FOR table (membre)`) désigne un membre précis ; en programme, c'est `OVRDBF` qui choisit. job-i **conseille d'éviter** le multi-membre et le LF multi-format (SQL et la plupart des outils les gèrent mal).
- **Fichier source** : PF de type `*SRC` à trois zones (`SRCSEQ` numérique 6,2 ; `SRCDAT` numérique 6,0 ; `SRCDTA`) ; longueur d'enregistrement 92 par défaut (6 + 6 + 80), 112 habituel pour `QRPGLESRC` (100 caractères) ; `CRTSRCPF` crée le fichier **sans membre** et `MAXMBRS(*NOMAX)` ; noms par défaut `QRPGLESRC`, `QCLSRC`, `QDDSSRC`. `CPYF` vers un fichier plus court exige `FMTOPT(*MAP)` ou `*NOCHK` (CPF2962).
- Le catalogue SQL liste les membres : `QSYS2.SYSPARTITIONSTAT`.

| Élément | Statut | Source |
|---|---|---|
| Commandes objet / membre, `MBR(*NONE)`, SYSPARTITIONSTAT | vérifié (début de page) | [job-i : membre](https://job-i.fr/membre-fichier-ibm-i) |
| Multi-membre : MAXMBRS, CPF3213, premier membre en SQL, ALIAS, OVRDBF, conseil d'éviter | vérifié (début de page) ; suite (OVRDBF, multi-format) non relue | [job-i : multi-membre](https://job-i.fr/multi-membre-multi-format-ibm-i) |
| Fichier source : zones, RCDLEN 92/112, CRTSRCPF, CPF2962 | vérifié (début de page) | [job-i : fichier source](https://job-i.fr/fichier-source-ibm-i) |

### 5. Contraintes et intégrité

La commande **`ADDPFCST`** ajoute quatre types de contraintes à un PF : référentielle (`*REFCST`), unique (`*UNQCST`), clé primaire (`*PRIKEY`, une seule par fichier, cas particulier de contrainte unique) et de vérification (`*CHKCST`). Paramètres (aide F1 IBM i 7.5, reproduite par job-i) : `FILE`, `TYPE`, `KEY` (jusqu'à 120 zones), `CST` (nom ou `*GEN`), `PRNFILE`/`PRNKEY` (fichier et clé parents), `DLTRULE` (`*CASCADE`, `*NOACTION` défaut, `*SETDFT`, `*SETNULL`, `*RESTRICT`), `UPDRULE` (`*NOACTION`, `*RESTRICT`), `CHKCST` (condition). Règles : fichier physique à **un membre au plus** ; parent et dépendant doivent exister et ne pas être ouverts ; jusqu'à **300** contraintes par fichier ; pas de contrainte sur fichiers système, décrits dans le programme ou en `QTEMP` ; si des enregistrements sont « en attente de vérification », la contrainte passe automatiquement à l'état **désactivé**. `RMVPFCST` la retire, `DSPFD` liste celles d'un fichier dépendant, `WRKPFCST` les gère. En SQL les mêmes contraintes se déclarent dans `CREATE TABLE` (voir § 2, `PRIMARY KEY`, `CHECK`) et s'appliquent à **tous** les accès (SQL0545), contrairement à `VALUES` en DDS.

```
ADDPFCST FILE(biblio/COMMANDE) TYPE(*REFCST) KEY(NUMCLI) PRNFILE(biblio/CLIENT) PRNKEY(*PRNFILE) DLTRULE(*RESTRICT)
```
*(exemple écrit par moi d'après la liste des paramètres : hypothèse, non exécuté)*

| Élément | Statut | Source |
|---|---|---|
| Types, paramètres, valeurs de DLTRULE/UPDRULE, limites (300, une clé primaire, un membre), état désactivé | vérifié (aide de la commande lue sur ~2/3) | [job-i : ADDPFCST](https://job-i.fr/commandes-ibm-i/addpfcst) |
| Contraintes dans CREATE TABLE, SQL0545 | vérifié (job-i, voir § 2) | [job-i : PF](https://job-i.fr/fichier-physique-pf-ibm-i) |
| WRKPFCST, RMVPFCST | WRKPFCST : existence vérifiée, non relue ; RMVPFCST : citée par l'aide d'ADDPFCST | [WRKPFCST](https://job-i.fr/commandes-ibm-i/wrkpfcst) |
| Exemple ADDPFCST | hypothèse (non exécuté) | à tester |

### 6. RCAC : sécurité par ligne et par colonne

**Row and Column Access Control** : deux objets SQL créés par un **administrateur de sécurité** (*security administrator authority*, droit exigé par les deux instructions).

- **`CREATE PERMISSION`** (contrôle des lignes) : `CREATE [OR REPLACE] PERMISSION nom ON table AS corr FOR ROWS WHERE condition ENFORCED FOR ALL ACCESS [ENABLE|DISABLE]` ; la condition décrit les lignes accessibles ; elle ne peut référencer ni variables, ni marqueurs de paramètres, ni fonctions non déterministes ou à effet externe, ni la table elle-même.
- **`CREATE MASK`** (contrôle des colonnes) : `CREATE [OR REPLACE] MASK nom ON table AS corr FOR COLUMN col RETURN expression-CASE [ENABLE|DISABLE]` ; l'expression `CASE` remplace la valeur de la colonne dans le résultat ; type et attribut NULL compatibles avec la colonne ; un seul masque par colonne.
- Contraintes communes : le nom ne peut pas commencer par `QIBM` ; le schéma du nom = celui de la table ; la table ne peut être ni vue, ni LF, ni table QTEMP, ni temporaire déclarée, ni distribuée, ni fichier avec trigger de lecture, ni alias de membre, ni table du catalogue.
- Le contrôle ne **s'applique qu'une fois activé sur la table** (instruction d'activation) : cette étape n'a pas été lue.
- Effet sur les requêtes : les règles RCAC modifient le résultat d'un `SELECT` (vérifié dans la page *subselect* 7.5, partie 05).

```sql
CREATE MASK biblio.masque_solde ON biblio.client AS c
  FOR COLUMN solde
  RETURN CASE WHEN VERIFY_GROUP_FOR_USER(SESSION_USER,'COMPTA') = 1
              THEN c.solde ELSE 0 END
  ENABLE;
```
*(exemple écrit par moi, hypothèse non exécutée : la fonction `VERIFY_GROUP_FOR_USER` n'est pas contrôlée ici ; elle figure seulement dans la liste des fonctions exclues des clés d'index de CREATE INDEX)*

| Élément | Statut | Source |
|---|---|---|
| CREATE PERMISSION : syntaxe, droit exigé, restrictions de la condition et de la table | vérifié **partiellement** (début de la Description) | [IBM 7.5 : CREATE PERMISSION](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-create-permission) |
| CREATE MASK : syntaxe, CASE, un masque par colonne, restrictions | vérifié **partiellement** (début de la Description) | [IBM 7.5 : CREATE MASK](https://www.ibm.com/docs/en/i/7.5.0?topic=statements-create-mask) |
| Activation du contrôle (ALTER TABLE …), droits SECADM détaillés | **non vérifié** (non lu) | [Redpaper RCAC (7.2)](https://redbooks.ibm.com/abstracts/redp5110.html) |
| Exemple de masque | hypothèse | à tester |
| Page job-i RCAC | aucune trouvée | manque à signaler |

### 7. La journalisation

La journalisation enregistre les modifications d'un fichier dans un **journal** (`*JRN`) qui écrit dans des **récepteurs** (`*JRNRCV`).

1. **Récepteur** puis **journal** : `CRTJRNRCV`, puis `CRTJRN JRN(…) JRNRCV(…)` (le récepteur doit exister et être **vide** ; impossible en `QTEMP` ; le journal créé est `*ACTIVE` ; paramètres notables : `MNGRCV`, `DLTRCV`, `JRNOBJLMT`).
2. **Démarrer** : `STRJRNPF FILE(…) JRN(…)` ; `IMAGES` (après seule ou avant et après : les images **avant** sont nécessaires à `RMVJRNCHG` ; le système les capte automatiquement sous contrôle de validation) ; les nouveaux membres ajoutés sont aussi journalisés. Autres commandes : `STRJRNAP` (chemins d'accès), `STRJRN` (IFS), `STRJRNLIB` (bibliothèques), `STRJRNOBJ` (autres objets).
3. **Sauvegarder** : après le démarrage, `SAVCHGOBJ … OBJTYPE(*FILE) OBJJRN(*YES)` (les modifications journalisées ne s'appliquent pas à une sauvegarde antérieure à la journalisation).
4. **Lire** : `DSPJRN JRN(…)` convertit les postes du journal (filtres : `FILE`, `FROMTIME`/`TOTIME`, `JRNCDE`, `ENTTYP`, `JOB`, `PGM`, `USRPRF`, sortie en fichier `OUTFILE`).
5. Limites (STRJRNPF) : un fichier ne journalise que dans **un** journal ; journal **local** ; 250 000 objets par journal, ou 10 000 000 avec `JRNOBJLMT(*MAX10M)`.

Une table SQL créée dans un schéma SQL est journalisée automatiquement (journal `QSQJRN`, d'après job-i, § 2).

| Élément | Statut | Source |
|---|---|---|
| STRJRNPF : IMAGES, images avant/RMVJRNCHG, autres STRJRN*, SAVCHGOBJ, limites 250 000 / 10 M | vérifié (aide lue sur ~2/3) | [job-i : STRJRNPF](https://job-i.fr/commandes-ibm-i/strjrnpf) |
| CRTJRN : récepteur vide, QTEMP interdit, état *ACTIVE | vérifié (début de l'aide) | [job-i : CRTJRN](https://job-i.fr/commandes-ibm-i/crtjrn) |
| DSPJRN : paramètres de filtrage et de sortie | vérifié (liste des paramètres) | [job-i : DSPJRN](https://job-i.fr/commandes-ibm-i/dspjrn) |
| CRTJRNRCV | existence vérifiée, non relue | [CRTJRNRCV](https://job-i.fr/commandes-ibm-i/crtjrnrcv) |
| Gestion des récepteurs, reprise, contrôle de validation | **non vérifié** (pistes IBM non lues) | [Journal management 7.4](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzaki/rzakikickoff.htm) |
| QSQJRN automatique en schéma SQL | vérifié chez job-i, non contrôlé chez IBM | [job-i : PF](https://job-i.fr/fichier-physique-pf-ibm-i) |

### Ce qui reste à vérifier pour cette partie

Fin des pages job-i PF (sources), multi-membre/multi-format (OVRDBF), ADDPFCST ; activation et administration de RCAC ; gestion et reprise des journaux, contrôle de validation ; codes message (CPF…, SQL…) à contrôler sur ibm.com ; exemples `ADDPFCST` et masque à exécuter. Manques à signaler : aucune page job-i dédiée à RCAC, ni aux clés étrangères en SQL.

## Plan détaillé (index des sujets)

### Architecture et concepts de DB2 for i

- **Dans le wiki** : [Fiche 04](../cheatsheets/04-db2-for-i-et-sql.md)

#### Les concepts de la base de données intégrée

- **job-i** : [Fichier physique (PF) IBM i](https://job-i.fr/fichier-physique-pf-ibm-i) · [Fichier logique (LF) IBM i](https://job-i.fr/fichier-logique-lf-ibm-i) · [AS/400 et IBM i](https://job-i.fr/as400-vs-ibm-i)

#### Différences entre la version « historique » DDS et SQL

- **job-i** : [DDS](https://job-i.fr/fichier-physique-pf-ibm-i) · [Fichier logique (LF) IBM i](https://job-i.fr/fichier-logique-lf-ibm-i)

### Les objets de données

- **Dans le wiki** : [Fiche 04](../cheatsheets/04-db2-for-i-et-sql.md) · [Exemples DDS dans le dépôt](../INDEX-SOURCES.md)

#### Les PF (tables)

- **job-i** : [fichier physique](https://job-i.fr/fichier-physique-pf-ibm-i) · [CRTPF](https://job-i.fr/commandes-ibm-i/crtpf)

#### Les LF (index, vues)

- **job-i** : [fichier logique](https://job-i.fr/fichier-logique-lf-ibm-i) · [CRTLF](https://job-i.fr/commandes-ibm-i/crtlf)

#### Les vues DDS et les vues SQL

- **job-i** : [Fichier logique (LF) IBM i](https://job-i.fr/fichier-logique-lf-ibm-i)

### Les contraintes et l'intégrité

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Clés primaires et clés étrangères

- **job-i** : [ADDPFCST](https://job-i.fr/commandes-ibm-i/addpfcst)

#### Contraintes unique et check

- **job-i** : [WRKPFCST](https://job-i.fr/commandes-ibm-i/wrkpfcst)

### Sécurité et journalisation

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Les RCAC, sécurité sur les lignes et les colonnes

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### La journalisation des tables

- **job-i** : [STRJRNPF](https://job-i.fr/commandes-ibm-i/strjrnpf) · [CRTJRN](https://job-i.fr/commandes-ibm-i/crtjrn) · [CRTJRNRCV](https://job-i.fr/commandes-ibm-i/crtjrnrcv) · [DSPJRN](https://job-i.fr/commandes-ibm-i/dspjrn)
