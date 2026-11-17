# PRTCTL : contrôle dynamique d'impression en RPG

> Page de **synthèse prudente**. Ce que le wiki, job-i.fr et la documentation IBM consultée permettent d'affirmer est séparé de ce qui n'est pas confirmé. Résultat d'un test réel : [IMPRESSION-FULLFREE](IMPRESSION-FULLFREE.md).

## 1. Ce qui est documenté
- **IBM** (référence ILE RPG, [mot-clé PRTCTL, IBM i 7.1](https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/rzasd/sc092508474.htm)) : `PRTCTL(structure)` active le contrôle dynamique de l'impression ; la structure contient des informations de contrôle de formulaire et une valeur de compteur de lignes ; **valide seulement pour un fichier décrit dans le programme** ; `*COMPAT` rend la structure compatible avec RPG III ; sans `*COMPAT`, la structure par défaut est de format **étendu**.
- **job-i.fr** : `PRTCTL`, `OFLIND` et `OVRFLW` n'apparaissent ni dans l'index des commandes ni dans la page des instructions RPG full free (recherche du 2026-11-17, lectures partielles).
- **Ce wiki** : `OVRFLW` seul est documenté (fiche 08 : ligne qui déclenche le saut de page, défaut 60).

## 2. Ce qui n'est pas confirmé
La mise en page exacte de la structure (noms, longueurs, ordre, valeurs permises, blanc ou `'000'`) n'a **pas été trouvée dans un texte IBM consulté** (les pages lues ne détaillent pas les sous-zones). Un message d'un forum communautaire (IBM Ideas) donne 4 sous-zones `CHAR(3)` (espace avant, espace après, saut avant, saut après) ; c'est une source **non officielle**.

## 3. Constat de terrain
Un programme full free avec `PRTCTL(prtCtl:*COMPAT)` et une DS `CHAR(3)` ×4 + `ZONED(3:0)` remplie de `'000'` / `'001'` **compilait et s'exécutait**, mais produisait un spool faux (40 pages au lieu de 8 : détails superposés sur une même ligne, `UNIVERS` en ligne ~10). L'explication la plus probable est une valeur `'000'` mal interprétée comme un saut à la ligne 0, mais ce n'est **qu'une hypothèse**.

## 4. Recommandation
- Ne pas utiliser `PRTCTL` sans avoir lu les tableaux de la référence ILE RPG (sections « PRTCTL » et « Printer control data structure ») et testé le spool.
- Alternative **validée** : `WRITE QSYSPRT <ds>` avec espacement par lignes blanches ([CYCLE-VERS-FULLFREE](CYCLE-VERS-FULLFREE.md), [CYCLEQSYS](exemples-cycle/CYCLEQSYS.rpgle)).
- Alternative habituelle de tes bibliothèques (non testée ici) : fichier imprimante décrit en DDS.

## 5. À compléter (quand la source officielle sera lue)
Disposition de la structure (`*COMPAT` et étendue), valeurs permises pour `blanc` et `0`, rôle du compteur de lignes.
