# Sommaire général du wiki

> Page générée par `scripts/Build-Sommaire.ps1` (configuration : `scripts/sommaire.json`). Chaque page possède aussi son propre sommaire en tête. Retour à la [carte rapide du README](../README.md).

## Démarrer

Installer le wiki, le donner à un assistant, vérifier qu'il applique les règles.

- [README : installation, utilisation, carte rapide](../README.md) : Point d'entrée : prérequis, installation, variables, dépannage, carte « je cherche → je vais là ».
  - [Installation et utilisation (n'importe qui, n'importe quel appareil)](../README.md#installation-et-utilisation-nimporte-qui-nimporte-quel-appareil)
  - [Carte rapide (je cherche → je vais là)](../README.md#carte-rapide-je-cherche--je-vais-là)
  - [Arborescence](../README.md#arborescence)
  - [Format d'un fichier de `sources/`](../README.md#format-dun-fichier-de-sources)
- [Assistant, tests et automatisation](ASSISTANT-ET-AUTOMATISATION.md) : Texte à coller dans claude.ai, prompts de test avec grille, automatisation GitHub Actions et routine cloud.
  - [Partie 1 : donner le wiki à n'importe quel chat Claude](ASSISTANT-ET-AUTOMATISATION.md#partie-1--donner-le-wiki-à-nimporte-quel-chat-claude)
  - [Partie 2 : tester que l'assistant applique les règles](ASSISTANT-ET-AUTOMATISATION.md#partie-2--tester-que-lassistant-applique-les-règles)
  - [Partie 3 : faire tourner le wiki depuis n'importe quel appareil](ASSISTANT-ET-AUTOMATISATION.md#partie-3--faire-tourner-le-wiki-depuis-nimporte-quel-appareil)
- [Prompt système du projet](PROMPT-SYSTEME.md) : Règles de lecture, de vérification et de mise à jour appliquées par l'assistant.
  - [0. Workflow obligatoire quand tu crées ou modifies du code](PROMPT-SYSTEME.md#0-workflow-obligatoire-quand-tu-crées-ou-modifies-du-code)
  - [Contexte du dépôt](PROMPT-SYSTEME.md#contexte-du-dépôt)
  - [1. Où lire (dans cet ordre)](PROMPT-SYSTEME.md#1-où-lire-dans-cet-ordre)
  - [2. Règles de réponse](PROMPT-SYSTEME.md#2-règles-de-réponse)
  - [3. Vérifier à chaque fois (checklist avant de répondre)](PROMPT-SYSTEME.md#3-vérifier-à-chaque-fois-checklist-avant-de-répondre)
  - [4. Mise à jour automatique depuis job-i.fr](PROMPT-SYSTEME.md#4-mise-à-jour-automatique-depuis-job-ifr)
  - [5. Interdits](PROMPT-SYSTEME.md#5-interdits)
- [CLAUDE.md : instructions chargées par Claude Code](../CLAUDE.md) : Workflow obligatoire, rigueur de lecture, sources (wiki, job-i.fr, ibm.com), remontée automatique.
  - [0. Workflow obligatoire quand tu crées ou modifies du code](../CLAUDE.md#0-workflow-obligatoire-quand-tu-crées-ou-modifies-du-code)
  - [0 bis. Rigueur de lecture et de vérification (obligatoire, ajoutée après un écart constaté)](../CLAUDE.md#0-bis-rigueur-de-lecture-et-de-vérification-obligatoire-ajoutée-après-un-écart-constaté)
  - [1. Où lire (dans cet ordre)](../CLAUDE.md#1-où-lire-dans-cet-ordre)
  - [2. Règles de réponse](../CLAUDE.md#2-règles-de-réponse)
  - [3. Vérifier à chaque fois (checklist avant de répondre)](../CLAUDE.md#3-vérifier-à-chaque-fois-checklist-avant-de-répondre)
  - [4. Mise à jour depuis job-i.fr](../CLAUDE.md#4-mise-à-jour-depuis-job-ifr)
  - [5. Contributions des collaborateurs (à chaque merge)](../CLAUDE.md#5-contributions-des-collaborateurs-à-chaque-merge)
  - [6. Documents ajoutés : évaluation automatique de pertinence](../CLAUDE.md#6-documents-ajoutés--évaluation-automatique-de-pertinence)
  - [7. Interdits](../CLAUDE.md#7-interdits)
  - [8. Remontée automatique au wiki (sans attendre qu'on te le demande)](../CLAUDE.md#8-remontée-automatique-au-wiki-sans-attendre-quon-te-le-demande)

## Fiches mémo (source : job-i.fr)

Syntaxe, commandes et concepts IBM i, avec une zone « Mes exemples » par fiche.

- [Index des fiches](cheatsheets/README.md) : Liste des fiches et correspondance avec job-i.fr.
- [01 Comprendre IBM i](cheatsheets/01-comprendre-ibm-i.md) : Objets, ILE, travaux, profils, sécurité, PTF, performances.
  - [AS/400 et IBM i  (source, découverte)](cheatsheets/01-comprendre-ibm-i.md#as400-et-ibm-i--source-découverte)
  - [Objets  (source)](cheatsheets/01-comprendre-ibm-i.md#objets--source)
  - [ILE  (source)](cheatsheets/01-comprendre-ibm-i.md#ile--source)
  - [Travaux et sous-systèmes  (source)](cheatsheets/01-comprendre-ibm-i.md#travaux-et-sous-systèmes--source)
  - [Profils et droits  (source)](cheatsheets/01-comprendre-ibm-i.md#profils-et-droits--source)
  - [Sécurité  (source)](cheatsheets/01-comprendre-ibm-i.md#sécurité--source)
  - [PTF  (source)](cheatsheets/01-comprendre-ibm-i.md#ptf--source)
  - [Performances  (source)](cheatsheets/01-comprendre-ibm-i.md#performances--source)
  - [Mes exemples](cheatsheets/01-comprendre-ibm-i.md#mes-exemples)
- [02 Référence système](cheatsheets/02-reference-systeme.md) : Commandes CL, messages CPF/MCH, valeurs système.
  - [Commandes CL  (source) — 1 830 fiches](cheatsheets/02-reference-systeme.md#commandes-cl--source--1-830-fiches)
  - [Messages  (source) — 13 213 messages CPF / MCH (107 fiches « Comment s'en sortir »)](cheatsheets/02-reference-systeme.md#messages--source--13-213-messages-cpf--mch-107-fiches--comment-sen-sortir-)
  - [Valeurs système  (source) — 158 valeurs (7.5)](cheatsheets/02-reference-systeme.md#valeurs-système--source--158-valeurs-75)
  - [Mes exemples](cheatsheets/02-reference-systeme.md#mes-exemples)
- [03 RPG par version](cheatsheets/03-rpg-par-version.md) : RPG III, IV colonné, full free, PR/PI, sous-fichiers, DTAARA, API.
  - [Quelle version ?](cheatsheets/03-rpg-par-version.md#quelle-version-)
  - [RPG III  (source, codes opération)](cheatsheets/03-rpg-par-version.md#rpg-iii--source-codes-opération)
  - [Instructions RPG IV full free  (source)](cheatsheets/03-rpg-par-version.md#instructions-rpg-iv-full-free--source)
  - [Fonctions intégrées  (source)](cheatsheets/03-rpg-par-version.md#fonctions-intégrées--source)
  - [Cycle GAP  (source)](cheatsheets/03-rpg-par-version.md#cycle-gap--source)
  - [Constantes figuratives  (source)](cheatsheets/03-rpg-par-version.md#constantes-figuratives--source)
  - [Codes et mots d'édition  (source)](cheatsheets/03-rpg-par-version.md#codes-et-mots-dédition--source)
  - [Prototypes PR / PI  (source)](cheatsheets/03-rpg-par-version.md#prototypes-pr--pi--source)
  - [Sous-fichiers  (source)](cheatsheets/03-rpg-par-version.md#sous-fichiers--source)
  - [Zones de données  (source)](cheatsheets/03-rpg-par-version.md#zones-de-données--source)
  - [API système  (source)](cheatsheets/03-rpg-par-version.md#api-système--source)
  - [Mes exemples](cheatsheets/03-rpg-par-version.md#mes-exemples)
- [04 Db2 for i et SQL](cheatsheets/04-db2-for-i-et-sql.md) : PF, LF, services SQL, recettes, Node.js.
  - [Fichier physique (PF)  (source)](cheatsheets/04-db2-for-i-et-sql.md#fichier-physique-pf--source)
  - [Fichier logique (LF)  (source)](cheatsheets/04-db2-for-i-et-sql.md#fichier-logique-lf--source)
  - [Services SQL  (source) — 390 services](cheatsheets/04-db2-for-i-et-sql.md#services-sql--source--390-services)
  - [Recettes SQL d'exploitation  (source) — 36 recettes en lecture seule](cheatsheets/04-db2-for-i-et-sql.md#recettes-sql-dexploitation--source--36-recettes-en-lecture-seule)
  - [Node.js + Db2 for i  (source)](cheatsheets/04-db2-for-i-et-sql.md#nodejs--db2-for-i--source)
  - [Mes exemples](cheatsheets/04-db2-for-i-et-sql.md#mes-exemples)
- [05 Emploi et formation](cheatsheets/05-emploi-et-formation.md) : Se former, offres, structure de job-i.fr.
  - [Offres d'emploi  (toutes, par département)](cheatsheets/05-emploi-et-formation.md#offres-demploi--toutes-par-département)
  - [Se former  (source)](cheatsheets/05-emploi-et-formation.md#se-former--source)
  - [Structure du site (pour retrouver une fiche)](cheatsheets/05-emploi-et-formation.md#structure-du-site-pour-retrouver-une-fiche)
  - [Mes exemples](cheatsheets/05-emploi-et-formation.md#mes-exemples)
- [06 Cycle RPG et sous-routines](cheatsheets/06-cycle-rpg-et-sous-routines.md) : Cycle GAP, BEGSR/EXSR, exemples personnels.
  - [Le cycle RPG  (source)](cheatsheets/06-cycle-rpg-et-sous-routines.md#le-cycle-rpg--source)
  - [Sous-routines BEGSR / ENDSR / EXSR  (source)](cheatsheets/06-cycle-rpg-et-sous-routines.md#sous-routines-begsr--endsr--exsr--source)
  - [Mes exemples](cheatsheets/06-cycle-rpg-et-sous-routines.md#mes-exemples)
- [07 SQL embarqué en RPG](cheatsheets/07-sql-embarque-en-rpg.md) : Curseur, SQLCODE, CRTSQLRPGI, RUNSQL, RUNSQLSTM.
  - [Compiler un source RPG contenant du SQL : CRTSQLRPGI  (source)](cheatsheets/07-sql-embarque-en-rpg.md#compiler-un-source-rpg-contenant-du-sql--crtsqlrpgi--source)
  - [Exécuter une instruction SQL : RUNSQL  (source)](cheatsheets/07-sql-embarque-en-rpg.md#exécuter-une-instruction-sql--runsql--source)
  - [Exécuter un script SQL : RUNSQLSTM  (source)](cheatsheets/07-sql-embarque-en-rpg.md#exécuter-un-script-sql--runsqlstm--source)
  - [Mes exemples](cheatsheets/07-sql-embarque-en-rpg.md#mes-exemples)
- [08 Impression et fichiers imprimante](cheatsheets/08-impression-et-printer-ibm-i.md) : Fichiers imprimante, spools, OUTQ, exemple validé en full free.
  - [Spools et files de sortie (OUTQ)  (source)](cheatsheets/08-impression-et-printer-ibm-i.md#spools-et-files-de-sortie-outq--source)
  - [Créer un fichier imprimante : CRTPRTF  (source)](cheatsheets/08-impression-et-printer-ibm-i.md#créer-un-fichier-imprimante--crtprtf--source)
  - [Substituer un fichier imprimante : OVRPRTF  (source)](cheatsheets/08-impression-et-printer-ibm-i.md#substituer-un-fichier-imprimante--ovrprtf--source)
  - [Copier un spool : CPYSPLF  (source)](cheatsheets/08-impression-et-printer-ibm-i.md#copier-un-spool--cpysplf--source)
  - [Mes exemples](cheatsheets/08-impression-et-printer-ibm-i.md#mes-exemples)

## RPG : cycle et impression

Cours du cycle, passage au full free, impression et PRTCTL (sujets regroupés).

- [Cycle RPG III : cours, exemples, passage au full free](CYCLE-RPG.md) : 7 étapes, indicateurs, ruptures, spécification O, rapprochement, table de correspondance vers le full free.
  - [Partie 1 : cours du cycle RPG III et exemples](CYCLE-RPG.md#partie-1--cours-du-cycle-rpg-iii-et-exemples)
  - [Partie 2 : du cycle RPG III au full free (table de correspondance)](CYCLE-RPG.md#partie-2--du-cycle-rpg-iii-au-full-free-table-de-correspondance)
- [Impression en RPG : état à cycle et PRTCTL](IMPRESSION-RPG.md) : Retour d'expérience (spools mesurés), version validée, dispositions PRTCTL officielles.
  - [Partie 1 : réécrire un état à cycle en full free (retour d'expérience)](IMPRESSION-RPG.md#partie-1--réécrire-un-état-à-cycle-en-full-free-retour-dexpérience)
  - [Partie 2 : PRTCTL, contrôle dynamique d'impression](IMPRESSION-RPG.md#partie-2--prtctl-contrôle-dynamique-dimpression)
- [Exemples de cycle dans le code des bibliothèques](CYCLE-GAP-EXEMPLES.md) : Sources avec fichier primaire, L1-L9, 1P, OF (généré).
- [Dossier des exemples (RPG, DDS)](exemples-cycle/) : CYCLEQSYS (validé), CYCLEIMP + CYCLEPRT, CYCLEPRTCTL, CYCLETOTO, RUPT0 à RUPT2.

## Énoncés de TP

Résumés anonymisés d'énoncés et d'examens.

- [Index des énoncés](enonces/README.md) : Un résumé par énoncé, id d'exercice, solutions du dépôt.
- [Analyse des énoncés](enonces/ANALYSE-ENONCES.md) : Thèmes récurrents et points de vigilance.
  - [1. Exercices sans solution dans le dépôt](enonces/ANALYSE-ENONCES.md#1-exercices-sans-solution-dans-le-dépôt)
  - [2. Notions requises par les énoncés](enonces/ANALYSE-ENONCES.md#2-notions-requises-par-les-énoncés)
  - [3. Limites et incohérences relevées](enonces/ANALYSE-ENONCES.md#3-limites-et-incohérences-relevées)

## Exemples de code réels

Code converti, comparaisons entre bibliothèques et contributions.

- [Index de toutes les sources](INDEX-SOURCES.md) : Un tableau par type de source (généré).
  - [Autres\Aide (1)](INDEX-SOURCES.md#autresaide-1)
  - [Autres\Commandes (4)](INDEX-SOURCES.md#autrescommandes-4)
  - [Autres\Panneaux-UIM (1)](INDEX-SOURCES.md#autrespanneaux-uim-1)
  - [Autres\Service-programs (14)](INDEX-SOURCES.md#autresservice-programs-14)
  - [Autres\Web (5)](INDEX-SOURCES.md#autresweb-5)
  - [CL\CL-ILE (50)](INDEX-SOURCES.md#clcl-ile-50)
  - [CL\CL-procedural (128)](INDEX-SOURCES.md#clcl-procedural-128)
  - [COBOL (26)](INDEX-SOURCES.md#cobol-26)
  - [DDS (382)](INDEX-SOURCES.md#dds-382)
  - [Menus (14)](INDEX-SOURCES.md#menus-14)
  - [RPG\Copy (11)](INDEX-SOURCES.md#rpgcopy-11)
  - [RPG\RPG-III-400 (124)](INDEX-SOURCES.md#rpgrpg-iii-400-124)
  - [RPG\RPG-ILE (291)](INDEX-SOURCES.md#rpgrpg-ile-291)
  - [SQL (31)](INDEX-SOURCES.md#sql-31)
- [Comparaison des bibliothèques](COMPARAISON-BIBLIOTHEQUES.md) : Membres communs, différents ou identiques (généré).
- [Variantes des collaborateurs](VARIANTES.md) : Plusieurs solutions pour un même exercice (généré).
- [Contribuer avec sa bibliothèque](../contributions/README.md) : Fork, Pull Request, contribution.json.
  - [Comment contribuer (fork + Pull Request)](../contributions/README.md#comment-contribuer-fork--pull-request)
  - [`contribution.json`](../contributions/README.md#contributionjson)
  - [Ce qui est vérifié à chaque merge](../contributions/README.md#ce-qui-est-vérifié-à-chaque-merge)
  - [Règles](../contributions/README.md#règles)

## Contrôles, manques et évaluations

Ce que le wiki vérifie automatiquement et ce qui lui manque.

- [Manques des fiches](MANQUES.md) : Termes utilisés dans le code et absents des fiches (généré).
  - [Commandes CL : 60 manquants sur 104 utilises](MANQUES.md#commandes-cl--60-manquants-sur-104-utilises)
  - [Instructions / fonctions RPG (reconnues par job-i) : 41 manquants sur 102 utilises](MANQUES.md#instructions--fonctions-rpg-reconnues-par-job-i--41-manquants-sur-102-utilises)
  - [Messages (MONMSG, SQLCODE...) : 60 manquants sur 68 utilises](MANQUES.md#messages-monmsg-sqlcode--60-manquants-sur-68-utilises)
  - [Services SQL (QSYS2, SYSTOOLS) : 25 manquants sur 28 utilises](MANQUES.md#services-sql-qsys2-systools--25-manquants-sur-28-utilises)
  - [Mots-cles DDS / ecran : 84 manquants sur 102 utilises](MANQUES.md#mots-cles-dds--ecran--84-manquants-sur-102-utilises)
  - [Sources par type et bibliotheque](MANQUES.md#sources-par-type-et-bibliotheque)
- [Vérification du code contre job-i.fr](VERIFICATION-JOB-I.md) : Commandes et instructions reconnues ou à contrôler (généré).
  - [Commandes CL utilisees](VERIFICATION-JOB-I.md#commandes-cl-utilisees)
  - [Instructions / fonctions RPG reconnues](VERIFICATION-JOB-I.md#instructions--fonctions-rpg-reconnues)
- [Vérification des contributions](VERIFICATION-CONTRIBUTIONS.md) : Erreurs et avertissements par contribution (généré).
- [Évaluation des apports](EVALUATION-APPORTS.md) : Score de pertinence des documents ajoutés (généré).
- [Changements sur job-i.fr](JOBI-CHANGES.md) : Pages modifiées depuis la dernière vérification (présent seulement s'il y en a).

## Apports

Ajouter ses notes et exemples.

- [Apports personnels](apports/README.md) : Format d'un apport et évaluation automatique.
  - [Format conseillé (un fichier .md par apport)](apports/README.md#format-conseillé-un-fichier-md-par-apport)
  - [Évaluation automatique](apports/README.md#évaluation-automatique)
