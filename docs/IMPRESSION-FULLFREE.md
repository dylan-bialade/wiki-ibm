# Impression en RPG full free : réécrire un état à cycle (retour d'expérience)

> Page issue d'un **test réel** : un programme RPG III à cycle (état avec rupture, en-tête de page, totaux) réécrit en full free. Les constats sur les spools sont **observés** (deux PDF de spool comparés) ; les explications sont des **hypothèses** tant qu'elles ne sont pas confirmées. Code : [CYCLETOTO.rpgle](exemples-cycle/CYCLETOTO.rpgle) (version corrigée, **non encore compilée ni testée** par l'auteur du wiki). Voir aussi la [fiche 08](cheatsheets/08-impression-et-printer-ibm-i.md) et le [cours du cycle](CYCLE-RPG-COURS.md).

## 1. Ce qui s'est passé
Une première version full free utilisait `PRTCTL(prtCtl:*COMPAT)` avec une structure d'espacement remplie de `'000'` / `'001'`. Elle **compilait et s'exécutait**, mais le spool obtenu (40 pages au lieu de 8) était faux :
- l'en-tête était en ligne 1 mais « UNIVERS 1 » en ligne ~10 ;
- les 20 lignes de détail d'un univers étaient **superposées sur la même ligne** d'une page à part ;
- « TOTAL UNIVERS » apparaissait sur cette même page, vers la ligne 20 ; les saut de page étaient incohérents.
Cause probable (hypothèse) : les valeurs `'000'` de saut/espace, ou la façon dont `*COMPAT` interprète la structure, n'ont pas eu l'effet attendu (`'000'` saut avant = « ligne 0 » ?). **`PRTCTL` n'est documenté ni dans ce wiki ni sur job-i.fr** (recherche du terme, de `OFLIND` et de `OVRFLW` : introuvables ; seul `OVRFLW` figure dans la fiche 08 comme paramètre du fichier imprimante). Vérifier dans la documentation IBM avant de réutiliser `PRTCTL`.

## 2. Mesure du spool de référence (RPG III à cycle)
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

## 3. Modèle de spacing (celui des O-specs)
Après une ligne écrite en `L` avec « espace après » `A`, le **curseur** est en `L + A`. Une ligne avec « espace avant » `B` s'imprime en `curseur + B`. Équivalences utilisées :

| O-spec d'origine (déduit) | Appel |
|---|---|
| H (1P ou OF) : saut ligne 1, espace après 1 | `Ecrire(0 : 1)` après remise du curseur à 1 |
| D `UNIVERS` : espace avant 1, après 1 | `Ecrire(1 : 1)` |
| D détail : espace après 1 | `Ecrire(0 : 1)` |
| T total : espace avant 2 | `Ecrire(2 : 0)` |

Une simulation de ces règles sur 20 univers de 20 enregistrements redonne le spool de référence (8 pages, page 1 finie sur le 9e détail du 3e univers, `TOTAL GENERAL` ligne 65 de la page 8). C'est une vérification de la **géométrie**, pas de la compilation.

## 4. Choix de la version corrigée
- **Pas de `PRTCTL`** : les espacements sont de vraies lignes blanches écrites (`WRITE QSYSPRT ligne`) ; le saut de page = écriture de lignes blanches jusqu'à la fin de la page (66 lignes, valeur par défaut documentée en fiche 08).
- `OFLIND(*INOF)` est conservé pour que le programme gère lui-même le débordement.
- Le débordement n'est testé qu'au moment d'un enregistrement (comme le cycle) ; les totaux ne le testent pas.
- Hypothèse à tester : si ton spool montre une **page blanche** en début de page 2, c'est que le système saute lui-même à la ligne 60 : supprime alors la boucle de remplissage dans `Debordement` (garde seulement `ligneCour = 1`).

## 5. Test à faire (le wiki ne peut pas compiler)
1. `CRTBNDRPG PGM(<BIB>/CYCLETOTO) SRCFILE(<BIB>/QRPGLESRC) SRCMBR(CYCLETOTO)` ; vérifier le message de compilation (aucune erreur attendue ; ne pas conclure sans le résultat).
2. Lancer, puis comparer le nouveau spool au spool de référence : 8 pages, `Page 8` avec `TOTAL GENERAL 400` en ligne 65, `UNIVERS 4` précédé directement du total.
3. Renvoyer le spool en cas de différence (les écarts de ligne se corrigent avec les valeurs du tableau 3).

## 6. Pièges rencontrés
- Un programme qui **compile** et s'exécute peut produire un spool entièrement faux : toujours comparer le spool, pas seulement l'absence d'erreur.
- `%EDITC(zone : 'Z')` et le placement par position de fin (`%SUBST` + `%LEN`) ont donné le résultat attendu sur « UNIVERS n », « Page n » et « TOTAL … » (constat sur le spool).
- La comparaison « à l'octet près » d'un PDF est trompeuse ; comparer les lignes (ex. `CPYSPLF`, non documenté dans le wiki).

## 7. Méthode habituelle de tes bibliothèques : fichier imprimante externe (recommandée)
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
