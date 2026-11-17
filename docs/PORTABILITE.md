# Faire tourner le wiki depuis n'importe quel appareil

Objectif : que la régénération, la détection de changements sur job-i.fr et les évaluations **ne dépendent d'aucun ordinateur en particulier**.

## Ce qui tourne où

| Tâche | Où | Besoin |
|---|---|---|
| Régénération quotidienne (job-i, vérifications, comparaisons, manques, évaluations) | **GitHub Actions** ([regeneration-quotidienne.yml](../.github/workflows/regeneration-quotidienne.yml)) | rien (ni PC allumé ni application ouverte) |
| Évaluation d'un apport ou d'une contribution à chaque PR | **GitHub Actions** (`evaluer-apports.yml`, `verif-contributions.yml`) | rien |
| Mise à jour rédigée des fiches depuis job-i.fr, tri des apports | **routine cloud Claude** (lit la branche de l'Action) | compte claude.ai + domaine job-i.fr autorisé |
| Conversion d'un **nouvel export ACS** (`*.LIB`) en Markdown | **un poste** qui a l'export | PowerShell + `Run-All.ps1` |
| Relecture et fusion des Pull Requests | navigateur, **téléphone compris** | compte GitHub |

Le résultat de la régénération arrive sous forme d'une **Pull Request** (branche `auto/regeneration-AAAAMMJJ`) : un clic pour fusionner (le propriétaire contourne la règle de relecture). Les simples changements de date ne créent pas de PR.

## Résultat des essais du 17/11/2026
- **Action GitHub** : essais complets réussis sous Linux (PowerShell 7). Les 9 étapes (job-i, vérifications, comparaisons, manques, évaluations, contexte) se terminent sans erreur, la branche `auto/regeneration-AAAAMMJJ` est poussée et **la Pull Request est créée** (réglage GitHub activé).
- **Bruit supprimé** : un premier essai a produit une PR de 64 fichiers uniquement parce que PowerShell 5.1 (Windows) et PowerShell 7 (Linux) ordonnent différemment les listes (tri sensible à la langue, égalités, JSON). Les scripts utilisent maintenant un **tri ordinal stable** (`Sort-By`) et un état job-i canonique : la même entrée donne la même sortie sous les deux versions, et l'Action ne propose une PR que s'il y a un changement de fond (les dates de génération sont ignorées).
- **Réseau** : `job-i.fr` répond parfois par une coupure de connexion ; les scripts réessaient maintenant jusqu'à 4 fois.
- **Routine cloud Claude** (« Wiki IBM i : relecture quotidienne (cloud) », 06:30 UTC) : deux essais réussis (dépôt cloné, documents lus, décisions correctes, aucun commit inutile). Limite : **`job-i.fr` n'est pas joignable depuis l'environnement cloud** tant que le domaine n'est pas autorisé (réglage 2) ; la routine n'en a pas eu besoin lors de ces essais.
## Réglages à faire une fois (sécurité : à vous)
1. Dépôt > **Settings > Actions > General** : « Allow GitHub Actions to create and approve pull requests » (**fait et vérifié** le 17/11/2026 : sans ce réglage l'Action pousse la branche mais ne peut pas ouvrir la Pull Request).
2. Réseau de la routine cloud : claude.ai > Code > Environnements (environnement « Default ») > accès réseau : **autoriser `job-i.fr`**. Sans cela la routine ne peut pas relire les pages job-i.fr pour mettre à jour les fiches (la détection de changements, elle, fonctionne dans l'Action).
3. Facultatif : si vous préférez que le robot fusionne seul, ajouter l'application « GitHub Actions » aux acteurs qui contournent la règle `nomain` (à éviter si des camarades peuvent proposer du code).
## Utiliser le wiki sur un autre ordinateur
1. `git clone` le dépôt.
2. PowerShell 5.1 (Windows) ou **PowerShell 7** (Windows, Linux, macOS) : `pwsh scripts/Run-All.ps1 -SansConversion` régénère tout sauf la conversion des exports.
3. Pour convertir des exports ACS : définir `WIKI_EXPORT_DIR` (dossier des `*.LIB`) puis `Run-All.ps1`.
4. **Fichier de correspondance des noms de bibliothèques** (`lib-alias.private.json`, privé, jamais dans le dépôt) : à copier sur chaque poste qui convertit, ou à indiquer par `WIKI_ALIAS_FILE`. Sans lui, les alias `BIBnn` seraient renumérotés et ne correspondraient plus à ceux du dépôt.

## Limites connues
- **Google Drive** : le connecteur ne sait pas remplacer le contenu d'un fichier existant, et l'envoi d'un fichier demande une validation humaine. Il ne peut donc pas être automatisé sans surveillance. La source de vérité est le dépôt GitHub ; Drive n'est qu'une copie, mise à jour à la main ou lors d'une session interactive.
- **Index des Documents** : il décrit les fichiers d'un ordinateur donné ; il reste propre à chaque appareil (un fichier par appareil, par exemple `INDEX_Documents_<nom-de-l-appareil>.md`).
- Les scripts ne sont **testés que sous Windows PowerShell 5.1** ; le premier passage de l'Action (Linux, PowerShell 7) confirmera leur portabilité.

## Tester le workflow Git sans toucher à `main`
- `git checkout -b test/actions-1 && git push -u origin test/actions-1` : **essai à blanc** (les 9 étapes tournent, aucune branche ni Pull Request n'est créée ; le résultat apparaît dans les annotations du run).
- `git checkout -b test/actions-pr-1 && git commit --allow-empty -m essai && git push -u origin test/actions-pr-1` : **essai complet** (crée la branche `auto/regeneration-AAAAMMJJ` et la Pull Request si le réglage GitHub est activé). Supprimer ensuite la branche de test et la branche `auto/…` (la PR se ferme toute seule).
- Une régénération qui ne change que les dates de génération ne crée **aucune** Pull Request. Si une PR apparaît sans cause réelle, regarder son diff : une différence d'ordre ou de format entre PowerShell 5.1 et 7 est un bug des scripts, à corriger.
- Surveillance : l'API publique de GitHub est limitée à 60 requêtes par heure et par adresse ; pour suivre un run, ouvrir sa page dans le navigateur (onglet Actions) plutôt que d'interroger l'API en boucle.
