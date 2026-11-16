# tp-logistock : gestion d'articles en sous-fichier

- **Objectif** : programme RPG avec un écran sous-fichier pour gérer des articles de stock : **F6** créer, **option 2** modifier, **option 4** supprimer, **option 5** afficher dans une **fenêtre pop-up**.
- **Règles** :
  - un **format d'écran distinct** par option ;
  - modification et suppression se **confirment par F23** (pas par Entrée) ;
  - une zone « Afficher à partir de » (code produit) positionne le sous-fichier : l'ordre est celui de la **base** (clé alphanumérique), pas l'ordre numérique ;
  - le client exige un écran **identique à la maquette** (liste avec Opt, Code, Nom, Quantité, Date ; F3 = Exit, F6 = Créer).
- **Données** : table (SQL ou PF) au format `ENTREPOTF` : code produit `5A`, nom `30A`, quantité `3S 0`, date du dernier inventaire (DATE ISO) ; un **LF** à clé triée sur le code produit ; données copiées d'une table fournie.
- **Compétences** : sous-fichier (`SFL`, `SFLCTL`, `SFLDSP`, `SFLEND`), `SETLL` + lecture sur clé caractère, `WRITE`/`UPDATE`/`DELETE`, touches de fonction (`CAnn`/`CFnn`), `WINDOW` (fenêtre).
- **Ressources du wiki** : fiche [03 sous-fichiers](../cheatsheets/03-rpg-par-version.md), [MANQUES](../MANQUES.md) (mots-clés DDS d'écran `WINDOW`, `OVERLAY`, `CHGINPDFT` à documenter).
- **Dans le dépôt** : table et LF `ENTREPOT*` (DDS) et écrans `ENTREDSP*` / `ENTRETP*` ; le programme RPG correspondant n'est pas identifié.
