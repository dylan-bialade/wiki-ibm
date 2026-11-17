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
- **Action GitHub** : essai complet réussi sous Linux (PowerShell 7) : les 9 étapes (job-i, vérifications, comparaisons, manques, évaluations, contexte) se terminent sans erreur et la branche uto/regeneration-AAAAMMJJ est poussée.
- **Routine cloud Claude** (Wiki IBM i : relecture quotidienne (cloud), 06:30 UTC) : essai réussi (dépôt cloné, documents lus, décisions correctes, aucun commit inutile). Limite constatée : **job-i.fr n'est pas joignable depuis l'environnement cloud** tant que le domaine n'est pas autorisé (voir réglage 3).

## Réglages à faire une fois (sécurité : à vous)
1. Dépôt > **Settings > Actions > General** : cocher « Allow GitHub Actions to create and approve pull requests » (**sans cela l'Action pousse la branche mais ne peut pas ouvrir la Pull Request**, constaté à l'essai ; la PR se crée alors à la main depuis la branche).
3. Réseau de la routine cloud : claude.ai > Code > Environnements (environnement « Default ») > accès réseau : **autoriser job-i.fr**. Sans cela la routine ne peut pas relire les pages job-i.fr pour mettre à jour les fiches (la détection de changements, elle, fonctionne dans l'Action).
2. Facultatif : si vous préférez que le robot fusionne seul, ajouter l'application « GitHub Actions » aux acteurs qui contournent la règle `nomain` (à éviter si des camarades peuvent proposer du code).

## Utiliser le wiki sur un autre ordinateur
1. `git clone` le dépôt.
2. PowerShell 5.1 (Windows) ou **PowerShell 7** (Windows, Linux, macOS) : `pwsh scripts/Run-All.ps1 -SansConversion` régénère tout sauf la conversion des exports.
3. Pour convertir des exports ACS : définir `WIKI_EXPORT_DIR` (dossier des `*.LIB`) puis `Run-All.ps1`.
4. **Fichier de correspondance des noms de bibliothèques** (`lib-alias.private.json`, privé, jamais dans le dépôt) : à copier sur chaque poste qui convertit, ou à indiquer par `WIKI_ALIAS_FILE`. Sans lui, les alias `BIBnn` seraient renumérotés et ne correspondraient plus à ceux du dépôt.

## Limites connues
- **Google Drive** : le connecteur ne sait pas remplacer le contenu d'un fichier existant, et l'envoi d'un fichier demande une validation humaine. Il ne peut donc pas être automatisé sans surveillance. La source de vérité est le dépôt GitHub ; Drive n'est qu'une copie, mise à jour à la main ou lors d'une session interactive.
- **Index des Documents** : il décrit les fichiers d'un ordinateur donné ; il reste propre à chaque appareil (un fichier par appareil, par exemple `INDEX_Documents_<nom-de-l-appareil>.md`).
- Les scripts ne sont **testés que sous Windows PowerShell 5.1** ; le premier passage de l'Action (Linux, PowerShell 7) confirmera leur portabilité.
