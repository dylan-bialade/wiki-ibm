# Wiki IBM i (RPG / CL / DDS / Db2 for i)

> **Pour les LLM et les humains : lire ce fichier en premier. Navigation par sujet : [sommaire général](docs/SOMMAIRE.md).** Il décrit où trouver chaque ressource en 1 saut. Tous les chemins sont relatifs à la racine du dépôt. Langue des documents : français.

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](docs/SOMMAIRE.md))

- [Installation et utilisation (n'importe qui, n'importe quel appareil)](#installation-et-utilisation-nimporte-qui-nimporte-quel-appareil)
  - [1. Prérequis](#1-prérequis)
  - [2. Installer (3 minutes)](#2-installer-3-minutes)
  - [3. Utiliser](#3-utiliser)
  - [4. Variables d'environnement (facultatives)](#4-variables-denvironnement-facultatives)
  - [5. Automatisation (propriétaire du dépôt, une fois)](#5-automatisation-propriétaire-du-dépôt-une-fois)
  - [6. Règles à respecter (résumé de CLAUDE.md)](#6-règles-à-respecter-résumé-de-claudemd)
  - [7. Dépannage](#7-dépannage)
- [Carte rapide (je cherche → je vais là)](#carte-rapide-je-cherche--je-vais-là)
- [Arborescence](#arborescence)
  - [Types de sources (`sources/`)](#types-de-sources-sources)
- [Format d'un fichier de `sources/`](#format-dun-fichier-de-sources)
<!-- TOC:END -->

## Installation et utilisation (n'importe qui, n'importe quel appareil)

### 1. Prérequis

| Outil | Pour quoi | Obligatoire |
|---|---|---|
| Un compte GitHub + [Git](https://git-scm.com/) | cloner le dépôt, proposer des apports | oui |
| [Claude Code](https://claude.com/claude-code) **ou** un chat claude.ai | utiliser le wiki comme base de vérité | un des deux |
| PowerShell 5.1 (Windows) ou [PowerShell 7](https://learn.microsoft.com/powershell/) (Windows, Linux, macOS) | scripts de régénération et de vérification | non (le wiki se lit sans) |
| [GitHub CLI `gh`](https://cli.github.com/) | ouvrir une Pull Request automatiquement | non |

Aucun jeton ni mot de passe n'est nécessaire ni ne doit être placé dans le dépôt.

### 2. Installer (3 minutes)
```bash
git clone https://github.com/dylan-bialade/wiki-ibm.git
cd wiki-ibm
```
- **Claude Code** : ouvrir un terminal dans ce dossier et lancer `claude`. Le fichier [CLAUDE.md](CLAUDE.md) est chargé automatiquement : règles de lecture, de vérification (wiki, job-i.fr, puis ibm.com), tableau « Élément | Statut | Source », remontée automatique des manques.
- **Claude Code dans un autre projet** (pour avoir le wiki partout) : copier dans `~/.claude/CLAUDE.md` (`%USERPROFILE%\.claude\CLAUDE.md` sous Windows) les lignes de [docs/ASSISTANT-ET-AUTOMATISATION.md](docs/ASSISTANT-ET-AUTOMATISATION.md#partie-1--donner-le-wiki-à-nimporte-quel-chat-claude), section 3.
- **claude.ai** (tous les chats) : coller le texte de la section 1 de [docs/ASSISTANT-ET-AUTOMATISATION.md](docs/ASSISTANT-ET-AUTOMATISATION.md#partie-1--donner-le-wiki-à-nimporte-quel-chat-claude) dans les préférences, ou créer un projet et lui donner [llms-full.txt](llms-full.txt) (URL brute : `https://raw.githubusercontent.com/dylan-bialade/wiki-ibm/main/llms-full.txt`, plus de 100 Ko : l'assistant doit le lire en entier).

### 3. Utiliser
- **Poser une question ou faire écrire du code** : l'assistant cherche dans le wiki, vérifie sur job-i.fr, puis sur ibm.com (documentation officielle) si job-i n'a pas l'information, cite ses sources, ne dit jamais « ça compile » sans votre confirmation, et signale ce qui manque.
- **Vérifier du code** : `pwsh scripts/Verify-Code.ps1 -Path mon.rpgle` (commandes CL et instructions RPG reconnues par job-i).
- **Régénérer les pages calculées** : `pwsh scripts/Run-All.ps1 -SansConversion` (sous Windows 5.1 : `powershell -File scripts\Run-All.ps1 -SansConversion`).
- **Remonter une information au wiki** : automatique (l'assistant lance `scripts/Report-ToWiki.ps1`), ou à la main : déposer un fichier dans [docs/apports/](docs/apports/README.md), ou ouvrir une Issue « Apport au wiki ». Chaque apport est évalué automatiquement ([EVALUATION-APPORTS](docs/EVALUATION-APPORTS.md)).
- **Contribuer vos exemples de bibliothèque** : [contributions/README.md](contributions/README.md) (fork + Pull Request).
- **Vérifier que l'assistant applique bien les règles** : jouer les prompts de [docs/ASSISTANT-ET-AUTOMATISATION.md](docs/ASSISTANT-ET-AUTOMATISATION.md#partie-2--tester-que-lassistant-applique-les-règles) (5 prompts + grille).

### 4. Variables d'environnement (facultatives)

| Variable | Rôle | Défaut |
|---|---|---|
| `WIKI_REPORT_MODE` | remontée automatique : `branche` (branche `apport/…` + Pull Request si `gh`), `main` (propriétaire : commit et push sur `main`), `aucun` (fichier seul) | `branche` |
| `WIKI_EXPORT_DIR` | dossier des exports ACS `*.LIB` à convertir | aucun |
| `WIKI_ALIAS_FILE` | fichier **privé** de correspondance des noms de bibliothèques (jamais dans le dépôt) | `../lib-alias.private.json` |

### 5. Automatisation (propriétaire du dépôt, une fois)
1. GitHub > **Settings > Actions > General** : cocher « Allow GitHub Actions to create and approve pull requests » (régénération quotidienne et Pull Requests automatiques).
2. Routine cloud Claude (facultative) : dans claude.ai > Code > Environnements, autoriser le réseau vers **`job-i.fr`** et **`ibm.com`** pour que la routine relise les pages sources.
3. Détails, essais et limites : [docs/ASSISTANT-ET-AUTOMATISATION.md](docs/ASSISTANT-ET-AUTOMATISATION.md#partie-3--faire-tourner-le-wiki-depuis-nimporte-quel-appareil).

### 6. Règles à respecter (résumé de [CLAUDE.md](CLAUDE.md))
- **Anonymat** : bibliothèques `BIBnn` uniquement ; aucun nom réel de personne, d'organisme ou de machine dans le dépôt public.
- **Pas de secret** (mot de passe, jeton, clé) ; pas de longs extraits de job-i.fr ou d'IBM (synthèse et lien).
- **Pas d'IA pendant un TP surprise ou un examen** : n'utiliser le wiki qu'en révision.
- **Sources** : wiki, puis job-i.fr, puis ibm.com ; les forums et blogs sont non officiels.
- **Organisation** : un sujet = un seul fichier ; chaque page a un sommaire en tête (généré, ne pas l'éditer) et figure dans [docs/SOMMAIRE.md](docs/SOMMAIRE.md) (configuration : scripts/sommaire.json).

### 7. Dépannage

| Symptôme | Cause probable | Que faire |
|---|---|---|
| L'assistant dit avoir lu seulement le début de `llms-full.txt` | fichier trop long pour une lecture | lui demander de le lire par morceaux ou de chercher le mot-clé dans `docs/` |
| `Report-ToWiki.ps1` répond `REFUSE` | secret, nom réel de bibliothèque ou statut `verifie` sans source | corriger le contenu ; ne pas contourner |
| La routine cloud ne lit pas job-i.fr / ibm.com | domaine non autorisé dans l'environnement | réglage 2 de la section 5 |
| Une Pull Request automatique n'est pas créée | réglage GitHub Actions non activé | réglage 1 de la section 5 |
| Un script PowerShell échoue sous Linux/macOS | version de PowerShell | utiliser `pwsh` (PowerShell 7) |

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
| SQL embarqué en RPG (curseur, SQLCODE, RUNSQL) | [fiche 07](docs/cheatsheets/07-sql-embarque-en-rpg.md) |
| Impression, fichier imprimante, spool, OUTQ | [fiche 08](docs/cheatsheets/08-impression-et-printer-ibm-i.md) |
| Cycle RPG (cours) ou sous-routines | [fiche 06](docs/cheatsheets/06-cycle-rpg-et-sous-routines.md) |
| Exemples du cycle RPG (fichier primaire, L1-L9, 1P, OF) | [docs/CYCLE-GAP-EXEMPLES.md](docs/CYCLE-GAP-EXEMPLES.md) |
| Cours du cycle RPG III (7 étapes, ruptures, spéc. O, rapprochement) + exemples | [docs/CYCLE-RPG.md](docs/CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples) |
| Réécrire un état à cycle en full free (retour d'expérience, spool) | [docs/IMPRESSION-RPG.md](docs/IMPRESSION-RPG.md#partie-1--réécrire-un-état-à-cycle-en-full-free-retour-dexpérience) |
| SQL avancé : JSON, IFS_WRITE_UTF8, FETCH multi-lignes | [docs/SQL-AVANCE.md](docs/SQL-AVANCE.md) |
| Architecture ILE (modules, programme de service) et services REST IWS | [docs/ILE-ET-SERVICES-WEB.md](docs/ILE-ET-SERVICES-WEB.md) |
| Cycle RPG III -> full free : table de correspondance | [docs/CYCLE-RPG.md](docs/CYCLE-RPG.md#partie-2--du-cycle-rpg-iii-au-full-free-table-de-correspondance) |
| PRTCTL (contrôle d'impression RPG) : ce qui est documenté ou non | [docs/IMPRESSION-RPG.md](docs/IMPRESSION-RPG.md#partie-2--prtctl-contrôle-dynamique-dimpression) |
| Tester que l'assistant applique les règles du wiki (prompts + grille) | [docs/ASSISTANT-ET-AUTOMATISATION.md](docs/ASSISTANT-ET-AUTOMATISATION.md#partie-2--tester-que-lassistant-applique-les-règles) |
| Ajouter ma bibliothèque (collaborateur) | [contributions/README.md](contributions/README.md) |
| Règles de lecture, de vérification et de mise à jour (prompt système) | [docs/PROMPT-SYSTEME.md](docs/PROMPT-SYSTEME.md) (chargé via [CLAUDE.md](CLAUDE.md)) |
| Ce qui a changé sur job-i.fr depuis la dernière vérification | [docs/JOBI-CHANGES.md](docs/JOBI-CHANGES.md) (présent seulement s'il y a des changements) |
| Donner le wiki à n'importe quel chat Claude (texte à coller, projet, fichier unique) | [docs/ASSISTANT-ET-AUTOMATISATION.md](docs/ASSISTANT-ET-AUTOMATISATION.md#partie-1--donner-le-wiki-à-nimporte-quel-chat-claude), [llms-full.txt](llms-full.txt) |
| Faire tourner le wiki depuis n'importe quel appareil (Actions, routine cloud, PowerShell 7) | [docs/ASSISTANT-ET-AUTOMATISATION.md](docs/ASSISTANT-ET-AUTOMATISATION.md#partie-3--faire-tourner-le-wiki-depuis-nimporte-quel-appareil) |

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
