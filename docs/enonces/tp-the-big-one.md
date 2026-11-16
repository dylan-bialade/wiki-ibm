# tp-the-big-one : reprendre un héritage RPG III, puis le moderniser en RPG IV

- **Contexte** : un constructeur de maisons fictif ; un développeur historique part à la retraite et laisse une bibliothèque : fichiers (maisons, composants), **2 data areas**, **3 programmes RPG III**, **2 CL**. Deux équipes de six travaillent chacune sur leur copie, puis se **relisent en croix**.
- **Programmes** : `NUMMAI` (numérotation des maisons via zone de données), `CALDEV` (calcul de devis), `GESMAI` (écran de gestion), CL `DEVIS` et une commande de changement de TVA.
- **Rôles** (un par membre) : chef de chantier, fichiers PF/LF, data areas et CL, programme de calcul, numérotation, écran. Règles de collaboration : un seul membre à la fois sur un source, journal de bord, commentaire daté dans chaque modification, bibliothèque de référence en **lecture seule**, une bibliothèque par équipe.
- **Étapes** (barème sur 20) :
  1. **Mettre en place** : environnement d'équipe (profil de groupe, bibliothèque partagée en `*ALL` pour le groupe et `*USE` pour le public), copie des sources (`CPYSRCF`, longueur 112), des fichiers (`CRTPF`, `CRTLF`, `CPYF`), création des data areas.
  2. **Comprendre** : plan de câblage (qui appelle qui, qui lit quoi) et inventaire des `GOTO` / `TAG` / `CABxx` ; **enquête sur 2 bugs**.
  3. **Maintenir** : 3 évolutions (E1 à E3) avec impact sur `DEVISMAI` et la commande de TVA.
  4. **Moderniser** en RPG IV : plus aucun `GOTO`, `TAG`, `CABxx`, `COMP` ni indicateur numérique hors touches de fonction ; pas de SQL ni de format libre ; zones déclarées en spécifications D ; `DOW`, `SELECT`/`WHEN`, `DCL-PR`/`DCL-PI`.
  5. **Revue croisée** : cahier des charges vérifié par recherche (`FNDSTRPDM`).
- **Pièges documentés** : un indicateur (50) réutilisé pour deux sens ; code mort ; **troncature au lieu d'arrondi** (le `DIV` sans `(H)` donne 889,56 au lieu de 889,57) ; 24 / 9 / 21 `GOTO` / `CAB` / `TAG` annoncés.
- **Data areas** : `TBONUM` (compteur) et `TBOPARM` (TVA en 4 positions avec 2 décimales, taux horaire en 5 positions avec 2 décimales, société ; positions 1-4, 5-9, 10-39) ; appel d'un CL avec paramètre numérique à zéros de tête et apostrophes.
- **Compétences** : lecture/maintenance de RPG III, `DTAARA` (`IN`, `OUT`, `UNLOCK`, `*DTAARA DEFINE`), `PLIST`/`PARM`, passage RPG III → RPG IV (`*ENTRY PLIST` → `DCL-PI`), arrondi `H`, `CPYSRCF`.
- **Dans le dépôt** : **aucune solution**. Fiches utiles : [03 (RPG III, PR/PI, DTAARA)](../cheatsheets/03-rpg-par-version.md), [06 (sous-routines)](../cheatsheets/06-cycle-rpg-et-sous-routines.md).
