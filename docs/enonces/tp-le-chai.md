# tp-le-chai : réception des vendanges (SQL embarqué en RPG ILE full free)

- **Contexte** : cave coopérative fictive ; un programme compilé `VX100` dont le **source a disparu** doit être compris, puis un programme `CHAI` doit traiter en fin de journée les lots de raisin en attente.
- **Environnement** : tables dans une bibliothèque commune au groupe (toujours qualifiées, ex. `TPVIN.APPORTS`), programmes fournis compilés `VX100` et `VERIFVX` (à ne pas modifier), table de prédictions pour les essais, script `INIT` de remise à zéro lancé par `RUNSQLSTM` (**avant chaque campagne de tests** ; les tables sont partagées : prévenir le groupe).
- **Tables** : appellations, cépages, cépages autorisés par appellation, parcelles, cuves, apports (lots), journal d'encuvage, registre de chaptalisation (obligatoire), alertes, bilan (une ligne par exécution).
- **Mission 1 – l'enquête** : deviner ce que fait `VX100` par **boîte noire** (hypothèses → vérificateur fourni → score), puis produire les prédictions et la description.
- **Mission 2 – le programme `CHAI`** : parcourir les lots en attente ; règles par lot : contrôle sanitaire, classement (appellation / déclassement), chaptalisation, choix de la cuve, encuvage, registres, alertes ; **« tout ou rien »** par lot (transaction : `COMMIT` / `ROLLBACK`) ; fin de traitement : ligne de bilan. Facultatif : tableau de bord des vendanges.
- **Contraintes techniques** : `SQLRPGLE` en **full free**, SQL embarqué (curseurs, `SQLCODE` / `SQLSTATE`), contrôle de validation.
- **Compétences** : `EXEC SQL` (curseur `DECLARE`/`OPEN`/`FETCH`/`CLOSE`, `INSERT`, `UPDATE`), `SET OPTION COMMIT`, `COMMIT`/`ROLLBACK`, `GET DIAGNOSTICS`, tests de conditions métier.
- **Dans le dépôt** : seulement des débuts liés à `VX100` : [VINVX100](../../sources/RPG/RPG-ILE/BIB12/VINVX100.md), [TEXTVX100](../../sources/RPG/RPG-ILE/BIB17/TEXTVX100.md). **Pas de programme `CHAI`.**
- **Notion manquante dans les fiches** : le SQL embarqué (≈ 290 `EXEC SQL` dans le code) n'est expliqué nulle part ([MANQUES](../MANQUES.md)).
