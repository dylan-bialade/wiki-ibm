# Wiki IBM i (RPG / CL / DDS / Db2 for i)

> **Pour les LLM et les humains : lire ce fichier en premier.** Il décrit où trouver chaque ressource en 1 saut. Tous les chemins sont relatifs à la racine du dépôt. Langue des documents : français.

## Carte rapide (je cherche → je vais là)

| Je cherche… | Fichier / dossier |
|---|---|
| Une fiche mémo (commande, syntaxe, concept IBM i) | [docs/cheatsheets/README.md](docs/cheatsheets/README.md) |
| Concepts : objets, ILE, travaux, profils, sécurité, PTF, performances | [docs/cheatsheets/01-comprendre-ibm-i.md](docs/cheatsheets/01-comprendre-ibm-i.md) |
| Commandes CL, messages CPF/MCH, valeurs système | [docs/cheatsheets/02-reference-systeme.md](docs/cheatsheets/02-reference-systeme.md) |
| RPG III / RPG IV / full free, PR-PI, sous-fichiers, DTAARA, API | [docs/cheatsheets/03-rpg-par-version.md](docs/cheatsheets/03-rpg-par-version.md) |
| PF, LF, services SQL, recettes SQL, Node.js | [docs/cheatsheets/04-db2-for-i-et-sql.md](docs/cheatsheets/04-db2-for-i-et-sql.md) |
| Emploi, formation, structure de job-i.fr | [docs/cheatsheets/05-emploi-et-formation.md](docs/cheatsheets/05-emploi-et-formation.md) |
| Un exemple de code réel (mon code) | [docs/INDEX-SOURCES.md](docs/INDEX-SOURCES.md) → `sources/` |
| Liste machine-lisible des sources (CSV) | [docs/sources.csv](docs/sources.csv) |
| Structure d'une bibliothèque (types, objets de données) | `architecture/<BIBLIOTHEQUE>.md` |
| Si une commande/instruction du code existe sur job-i.fr | [docs/VERIFICATION-JOB-I.md](docs/VERIFICATION-JOB-I.md) |
| Ajouter mes propres notes/exemples | [docs/apports/README.md](docs/apports/README.md) |
| Énoncés de TP et d'examens résumés (anonymisés) | [docs/enonces/README.md](docs/enonces/README.md) |
| Ce qui manque dans les fiches (utilisé dans le code, absent des fiches) | [docs/MANQUES.md](docs/MANQUES.md) |
| Verdict automatique sur un document ajouté (pertinent ou non) | [docs/EVALUATION-APPORTS.md](docs/EVALUATION-APPORTS.md) |
| Plusieurs solutions pour un même exercice | [docs/VARIANTES.md](docs/VARIANTES.md) (collaborateurs), [docs/COMPARAISON-BIBLIOTHEQUES.md](docs/COMPARAISON-BIBLIOTHEQUES.md) (bibliothèques du cours) |
| Cycle RPG (cours) ou sous-routines | [fiche 06](docs/cheatsheets/06-cycle-rpg-et-sous-routines.md) |
| Exemples du cycle RPG (fichier primaire, L1-L9, 1P, OF) | [docs/CYCLE-GAP-EXEMPLES.md](docs/CYCLE-GAP-EXEMPLES.md) |
| Ajouter ma bibliothèque (collaborateur) | [contributions/README.md](contributions/README.md) |
| Règles de lecture, de vérification et de mise à jour (prompt système) | [docs/PROMPT-SYSTEME.md](docs/PROMPT-SYSTEME.md) (chargé via [CLAUDE.md](CLAUDE.md)) |
| Ce qui a changé sur job-i.fr depuis la dernière vérification | [docs/JOBI-CHANGES.md](docs/JOBI-CHANGES.md) (présent seulement s'il y a des changements) |
| Faire tourner le wiki depuis n'importe quel appareil (Actions, routine cloud, PowerShell 7) | [docs/PORTABILITE.md](docs/PORTABILITE.md) |

## Arborescence

```
README.md                    ← ce fichier (point d'entrée)
llms.txt                     ← même carte, format minimal pour agents
docs/
  cheatsheets/01..05-*.md    ← fiches mémo (source : https://job-i.fr/)
  INDEX-SOURCES.md           ← index de toutes les sources converties
  sources.csv                ← Type;Lib;File;Member;Lines;Width;Path
  VERIFICATION-JOB-I.md      ← code vs référence job-i.fr
  apports/                   ← notes de l'utilisateur à intégrer
  variantes/                 ← un exercice = une page comparant les solutions (généré)
contributions/               ← bibliothèques des collaborateurs (PR) : <pseudo>/contribution.json + <BIB>/…
architecture/<LIB>.md        ← une page par bibliothèque (BIB01 … BIB23, noms anonymisés)
sources/<TYPE>/<LIB>/<MEMBRE>.md   ← code converti, un fichier par membre
scripts/                     ← génération et automatisation (PowerShell)
depot/sauvegardes/           ← dépôt d'exports ACS (ignoré par Git)
```

### Types de sources (`sources/`)

| Dossier | Contenu | Fichier source IBM i d'origine |
|---|---|---|
| `RPG/RPG-ILE` | RPG IV (colonné ou `**free`) | QRPGLESRC |
| `RPG/RPG-III-400` | RPG III / RPG/400 | QRPGSRC |
| `RPG/Copy` | membres `/copy` (prototypes) | QCPYSRC |
| `CL/CL-procedural` | CL (OPM) | QCLPSRC |
| `CL/CL-ILE` | CLLE | QCLLESRC |
| `DDS` | PF / LF / écrans (DSPF) | QDDSSRC, QLFSRC, QPFSRC, QDSPSRC |
| `Menus` | menus | QMNUSRC |
| `Autres/Service-programs` | sources de liage (EXPORT) | QSRVSRC |
| `Autres/Web` | écrans/pages web | QWEBSRC |

Remarque : certains DDS peuvent se trouver dans `CL/` (membres rangés dans un mauvais fichier source d'origine).

## Format d'un fichier de `sources/`
```
---
bibliotheque: BIB05
fichier_source: QRPGLESRC
membre: BECRUD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 71
modifie: 2026-11-16
---
# BIB05/QRPGLESRC/BECRUD
```rpg ... ```      ← code intégral dans un bloc de code (rpg | cl | sql | text)
```
- Grep utile : `bibliotheque:`, `membre:`, `type:` dans l'en-tête ; le code est dans l'unique bloc de code.
- Les membres de **données** (fichiers physiques) ne sont pas convertis ; ils sont listés dans `architecture/<LIB>.md`.

## Format d'une cheat sheet (`docs/cheatsheets/`)
- Un bloc `<!-- AUTO:START --> … <!-- AUTO:END -->` : synthèse de job-i.fr, **régénérée** (chaque section a un lien `[source](https://job-i.fr/...)`).
- Une section `## Mes exemples` : exemples de l'utilisateur, liens vers `sources/`, **jamais écrasée**.
- Pages job-i utiles : fiche commande `https://job-i.fr/commandes-ibm-i/<commande-minuscule>` ; recherche `https://job-i.fr/aller?q=<terme>`.

## Conventions
- Noms IBM i en MAJUSCULES (`CRTPF`, `QRPGLESRC`). Bibliothèques : noms **anonymisés** `BIBnn` (la correspondance avec les noms réels reste privée, hors dépôt).
- Ne pas modifier les fichiers de `sources/`, `architecture/` et `docs/INDEX-SOURCES.md` à la main : ils sont régénérés. Les modifications durables vont dans `docs/apports/` ou dans « Mes exemples ».
- Les ressources brutes (PDF, zips de cours, exports ACS) restent **hors dépôt** dans `Documents\cour et autre` ; elles ne sont jamais extraites ni exécutées par l'automatisation.

## Automatisation
| Tâche | Fréquence | Effet |
|---|---|---|
| `wiki-ibmi-regeneration` | tous les jours 18h | `scripts\Run-All.bat` (convertit, vérifie job-i) → intègre `docs/apports/` → commit → `git push` → Drive |
| `cheatsheet-job-i-mensuel` | le 1er du mois | met à jour les blocs AUTO depuis job-i.fr → commit → push |

Chaque jour, `scripts\Check-JobIUpdates.ps1` compare job-i.fr (sitemaps + pages sources) à `docs/.jobi-state.json` ; en cas de changement, les blocs AUTO des fiches concernées sont mis à jour.

Contrôle de code neuf : `scripts\Verify-Code.ps1 -Path <fichier.clp|.rpgle>` vérifie commandes CL, instructions et fonctions RPG contre job-i.fr.

Scripts : `Verify-Code.ps1` (vérifie un code que vous écrivez), `Check-JobIUpdates.ps1` (détection de mises à jour job-i.fr), `Build-Wiki.ps1` (EBCDIC CCSID 1147 → Markdown), `Verify-JobI.ps1` (compare avec les 1 830 commandes et termes RPG de job-i.fr), `Push-Wiki.ps1` (push manuel avec confirmation), `Run-All.bat`.
