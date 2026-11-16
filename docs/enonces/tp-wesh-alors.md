# tp-wesh-alors : mettre en forme un texte et l'écrire dans la joblog

- **Objectif** : un programme `WESH` (RPG **full free**) lit une table d'**une seule ligne** (colonne `TEXTE_BRUT`, `VARCHAR(1000)` CCSID 1147) et écrit le poème mis en forme dans la **joblog**, un vers par message (18 messages attendus).
- **Règles de mise en forme** :
  - **deux espaces consécutifs** = saut de strophe, matérialisé par une ligne de 20 tirets ;
  - une **majuscule précédée de « . » ou de « , » suivi d'un espace** = passage à la ligne ;
  - chaque `!` est remplacé par `V`.
- **Contraintes** : instructions **RPG natives uniquement** (ni SQL ni API) ; le source de départ fourni **ne doit pas être modifié** (on ajoute à la suite) ; programme nommé `WESH` ; source de longueur **240** (lignes de plus de 100 caractères) ; le code doit être simple, lisible, optimisé.
- **Indice de l'énoncé** : `DSPLY` coupe à 52 caractères → utiliser **`SND-MSG`** (message dans la joblog) et les **fonctions intégrées** de chaînes ([job-i.fr/fonctions-rpg](https://job-i.fr/fonctions-rpg)).
- **Vérification** : `CALL WESH`, puis `DSPJOBLOG` et F10 pour les messages détaillés.
- **Compétences** : `SND-MSG`, `%SCAN`, `%SUBST`, `%REPLACE` / `%XLATE`, boucle `DOW` sur la position, `%TRIM`, `VARCHAR`, lecture d'un champ sans SQL (la table est lue par fichier : `DCL-F`).
- **Dans le dépôt (3 façons de faire)** : [WESH BIB04](../../sources/RPG/RPG-ILE/BIB04/WESH.md) (175 lignes), [WESH BIB11](../../sources/RPG/RPG-ILE/BIB11/WESH.md) (99), [WESH BIB16](../../sources/RPG/RPG-ILE/BIB16/WESH.md) (155). Comparatif automatique : [comparaisons/WESH](../comparaisons/WESH.md).
- **Notion manquante dans les fiches** : `SND-MSG` et plusieurs BIF de chaînes sont utilisés dans le code mais absents des fiches ([MANQUES](../MANQUES.md)).
