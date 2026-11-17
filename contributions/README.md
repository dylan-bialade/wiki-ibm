# Contributions : ajouter votre bibliothèque

Ce dossier reçoit le code des collaborateurs (camarades). Objectif : pour **un même exercice**, réunir **plusieurs solutions** (structures et codes différents) qui donnent **le même résultat final**, afin d'avoir un large choix d'exemples. Chaque contribution est **vérifiée** à chaque merge ([VERIFICATION-CONTRIBUTIONS](../docs/VERIFICATION-CONTRIBUTIONS.md)) puis comparée aux autres ([VARIANTES](../docs/VARIANTES.md)).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../docs/SOMMAIRE.md))

- [Comment contribuer (fork + Pull Request)](#comment-contribuer-fork--pull-request)
- [`contribution.json`](#contributionjson)
- [Ce qui est vérifié à chaque merge](#ce-qui-est-vérifié-à-chaque-merge)
- [Règles](#règles)
<!-- TOC:END -->

## Comment contribuer (fork + Pull Request)

1. Copiez le dossier [`_modele`](_modele/) en `contributions/<votre-pseudo>/` (pseudo en minuscules, chiffres, tirets : `marie-d`).
2. Placez vos sources (texte UTF-8, pas d'export EBCDIC) dans `contributions/<pseudo>/<BIBLIOTHEQUE>/<FICHIER-SOURCE>/<MEMBRE>.<ext>` ; exemple : `contributions/marie-d/MABIB/QRPGLESRC/CLIENT.rpgle`.
3. Décrivez chaque exercice dans `contributions/<pseudo>/contribution.json` (champs ci-dessous).
4. Ouvrez une Pull Request vers `main`. La vérification automatique tourne ; corrigez les erreurs éventuelles.

## `contribution.json`

```json
{
  "auteur": "marie-d",
  "bibliotheque": "MABIB",
  "exercices": [
    {
      "id": "gestion-clients-crud",
      "titre": "Gestion de clients : consulter, ajouter, modifier, supprimer",
      "consigne": "Écran qui permet de gérer la table CLIENT (clé NUMCLI).",
      "resultat_attendu": "Un client ajouté apparaît à la consultation ; supprimé, il disparaît.",
      "langage": "RPG-ILE",
      "approche": "Sous-fichier + CHAIN, une procédure par action.",
      "dependances": ["CLIENT"],
      "fichiers": ["QRPGLESRC/CLIENT.rpgle", "QDSPSRC/CLIENTD.dspf"]
    }
  ]
}
```

| Champ | Règle |
|---|---|
| `auteur` | identique au nom de votre dossier |
| `bibliotheque` | nom de la bibliothèque, MAJUSCULES, 10 caractères max ; le dossier du même nom doit exister |
| `id` | **identifiant de l'exercice**. Pour la même consigne, utilisez le **même `id`** que les autres : c'est ce qui regroupe les variantes (voir [VARIANTES](../docs/VARIANTES.md)) |
| `titre`, `consigne`, `resultat_attendu`, `approche` | texte libre (5 caractères minimum) ; `resultat_attendu` doit décrire le résultat **observable** |
| `langage` | `RPG-III`, `RPG-ILE`, `RPG-free`, `CL`, `DDS`, `SQL` ou `Autre` |
| `dependances` | objets utilisés mais non fournis (ex. `CLIENT`, `QSYS2/QCMDEXC`) |
| `fichiers` | chemins relatifs au dossier de la bibliothèque ; **chaque fichier doit exister** |

## Ce qui est vérifié à chaque merge

- le JSON est valide et complet ; l'`auteur` correspond au dossier ;
- **chaque fichier déclaré existe réellement** dans la bibliothèque, n'est pas vide ni binaire, a une extension autorisée (`.rpgle .rpg .sqlrpgle .rpgleinc .clp .clle .cl .dds .pf .lf .dspf .prtf .sql .txt .md .cpy .mnu`) ;
- aucun chemin hors de la bibliothèque (`..`), aucun secret (clé, jeton) ;
- les fichiers présents mais **non déclarés** sont signalés (orphelins) ;
- les objets référencés (fichiers `DCLF`/`dcl-f`/spécification F, `/COPY`, `CALL`) sont **fournis** ou déclarés dans `dependances` (avertissement sinon) ;
- les commandes CL, instructions et fonctions RPG sont contrôlées contre job-i.fr (`Verify-Code.ps1`, option `-Jobi`).

Pour vérifier avant d'ouvrir la PR : `powershell -File scripts/Verify-Contributions.ps1 -Only <pseudo>`.

## Règles

- Ne mettez **jamais** de mot de passe, jeton ou donnée personnelle.
- Un fichier = un membre source en texte ; pas d'archive, d'exécutable ni de binaire.
- Vous ne pouvez pas modifier `main` directement : tout passe par une Pull Request relue par le propriétaire du dépôt.
