# tp-livres : gestion d'une base de livres (écran + PF/LF)

- **Objectif** : programme RPG IV (« RPG 400 ») pour gérer des livres avec un écran DSPF, un PF et un LF ; exercice **en binôme**, bibliothèque commune (initiales des deux prénoms), fichiers sources `QRPGLESRC` et `QDDSSRC`, pas de `QTEMP`.
- **Données** : PF `LIVRES` : `ISBN` `5P 0`, `TITRE` `30A`, `AUTEUR` `30A` ; LF `LIVREF` : clé `ISBN`, `PFILE(LIVRES)`.
- **Écran** : deux formats, `FMT1` (saisie de l'ISBN) et `FMT2` (ISBN, titre, auteur, en entrée/sortie).
- **Comportement** :
  - Entrée sur FMT1 → FMT2 avec les infos ;
  - **F3** quitte ; **F12** retourne de FMT2 à FMT1 ;
  - **F13** (depuis FMT2) supprime ; **F6** (depuis FMT1) ajoute un livre ;
  - FMT2 permet la modification.
- **Consigne de style** : utiliser `%EOF`, `%FOUND` (pas de style « 1987 »).
- **Critères** : bibliothèque et fichiers propres ; navigation fluide ; ajout, modification et suppression fonctionnels.
- **Compétences** : `EXFMT`, `CHAIN` + `%FOUND`, `WRITE`/`UPDATE`/`DELETE`, indicateurs de touches de fonction, deux formats d'écran.
- **Dans le dépôt (variantes)** : [GESTLIVRE](../../sources/RPG/RPG-III-400/BIB05/GESTLIVRE.md) (64 lignes), [GESTLIVRE](../../sources/RPG/RPG-III-400/BIB10/GESTLIVRE.md) (154), [PLIVRES](../../sources/RPG/RPG-III-400/BIB09/PLIVRES.md) (126), [LIVRESRPG3](../../sources/RPG/RPG-III-400/BIB17/LIVRESRPG3.md) (245) ; DDS : [LIVRES_PF](../../sources/DDS/BIB17/LIVRES_PF.md), [LIVDSP](../../sources/DDS/BIB17/LIVDSP.md). Comparaisons : [index](../COMPARAISON-BIBLIOTHEQUES.md).
