# tp-films : titres de films triés avec DSPLY (épreuve de 30 minutes)

- **Objectif** : programme qui affiche, par `DSPLY`, le titre de **tous les films** d'un PF, **triés par titre** ; à chaque appui sur Entrée, titre suivant.
- **Données** : PF `FILMS`, format `FILMF` : `NUMFILM` `5P 0` (clé unique), `TITFILM` `50A` ; DDS fourni (`UNIQUE`, `R FILMF`, `COLHDG`, `K NUMFILM`). Copier le PF dans une bibliothèque personnelle.
- **Règles** : **RPG IV en colonnes**, **SQL interdit**, un **LF** est autorisé (c'est la clé : LF trié sur `TITFILM`) ; documentation limitée (cours + job-i.fr) ; **IA interdite pendant l'épreuve**.
- **Compétences** : DDS d'un LF (`PFILE`, clé sur une autre zone), spécification F (fichier en entrée, clé), lecture séquentielle (`READ` + `%EOF`), `DSPLY` avec attente, `*INLR`.
- **Piège** : `TITFILM` fait 50 caractères, `DSPLY` coupe à 52 : le titre passe, mais pas d'étiquette longue.
- **Dans le dépôt** : [FILM (RPG, BIB05)](../../sources/RPG/RPG-ILE/BIB05/FILM.md), [FILM (DDS, BIB09)](../../sources/DDS/BIB09/FILM.md) ; version RPG IV colonné [TPS](../../sources/RPG/RPG-ILE/BIB02/TPS.md) (à confirmer).
