# Partie 03 : Outils de développement : traditionnels et modernes

> Plan de formation, partie 03 sur 14 (**partie rédigée** : cours détaillé ci-dessous). QRY, QMQRY, SEU, PDM, SDA, RLU, PNLGRP, DFU, écrans et états (DSPF, PRTF), puis RDi, VS Code et Code for IBM i.
>
> **Mots-clés** : QRY, QMQRY, SEU, PDM, SDA, RLU, PNLGRP, DFU, DSPF, PRTF, RDi, VS Code, Code for IBM i.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Cours détaillé](#cours-détaillé)
  - [1. Source, SEU et PDM](#1-source-seu-et-pdm)
  - [2. Interroger sans programmer : QRY et QMQRY](#2-interroger-sans-programmer--qry-et-qmqry)
  - [3. Utilitaires de conception : SDA, RLU, PNLGRP, DFU](#3-utilitaires-de-conception--sda-rlu-pnlgrp-dfu)
  - [4. Écrans et états : DSPF et PRTF](#4-écrans-et-états--dspf-et-prtf)
  - [5. Le développement moderne : RDi, VS Code et Code for IBM i](#5-le-développement-moderne--rdi-vs-code-et-code-for-ibm-i)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Les outils traditionnels](#les-outils-traditionnels)
  - [Le développement moderne](#le-développement-moderne)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 03 : RPG par version](../cheatsheets/03-rpg-par-version.md)
- [Fiche 08 : impression](../cheatsheets/08-impression-et-printer-ibm-i.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Fichier source IBM i : CRTSRCPF, longueur d'enregistrement et différence avec un PF](https://job-i.fr/fichier-source-ibm-i) | Un fichier source est un PF de type *SRC (séquence, date, texte) ; chaque membre contient un source (RPG, CL, DDS). | En une phrase ; Créer un fichier source ; La longueur d'enregistrement ; Fichier source ou PF de données ? |
| [Mot d'édition RPG (spécification O, %EDITW) : règles et exemples testés](https://job-i.fr/mots-edition-rpg) | Un mot d'édition est un gabarit entre apostrophes qui décrit l'impression d'un nombre (chiffres, suppression des zéros, virgule, signe). | En une phrase ; Où l'écrire ; Les trois parties d'un mot d'édition ; Les caractères qui ont un sens ; Les exemples, imprimés sur IBM i ; L'euro, la virgule et DECEDIT ; Un relevé de compte, en RPG III, RPG IV et full free ; Les pièges, vérifiés sur le banc |

## Cours détaillé

> Synthèses personnelles à partir de job-i.fr (aides de commandes « IBM i 7.5 en français » reproduites par job-i, pages lues en partie), de la documentation du projet **Code for IBM i** (projet communautaire open source, **non édité par IBM**) et de la page produit IBM de Rational Developer for i. Aucune manipulation n'a été faite par l'assistant sur un IBM i.

### 1. Source, SEU et PDM

Le source se range dans un **fichier source** : PF de type `*SRC`, trois zones (`SRCSEQ` numérique 6,2 ; `SRCDAT` numérique 6,0 ; `SRCDTA` texte), un **membre** par source ; `RCDLEN` 92 par défaut (80 caractères de texte), 112 habituel pour `QRPGLESRC` ; `CRTSRCPF` crée le fichier sans membre ; noms habituels `QRPGLESRC`, `QCLSRC`, `QDDSSRC`, valeurs par défaut des compilateurs ([partie 02, § 4](02-db2-for-i.md#cours-détaillé)).

- **`STRSEU`** (bibliothèque QPDA) : « créer, modifier, afficher ou imprimer un membre source ». Paramètres : `SRCFILE`, `SRCMBR` (nom, `*PRV`, `*SELECT`), `TYPE` (type du source : `RPG`, `RPGLE`, `SQLRPGLE`, `CLP`, `CLLE`, `PF`, `LF`, `DSPF`, `PRTF`, `PNLGRP`, `QRY`, `DFU`, `TXT`…), `OPTION` (`2`, `5`, `6` ou blanc), `TEXT`. Le **type** du membre fixe la grille de saisie (ligne FMT) et la commande de compilation proposée.
- **`STRPDM`** : « appelle l'utilitaire Gestionnaire de développement (PDM) » : menu de gestion des bibliothèques, objets, **membres** (`WRKMBRPDM`) et options utilisateur. Sans paramètre. Dans PDM, l'**option 2** édite un membre (SEU) et l'**option 14** le compile (job-i, [coder en RPG III](https://job-i.fr/coder-rpg-iii)).
- Dans SEU, **F4** sur une ligne ouvre l'invite de la spécification (libellés par zone) ; la ligne **FMT** rappelle les colonnes (job-i, même page).

| Élément | Statut | Source |
|---|---|---|
| Fichier source : zones, RCDLEN, CRTSRCPF, noms par défaut | vérifié (début de page) | [job-i : fichier source](https://job-i.fr/fichier-source-ibm-i) |
| STRSEU : rôle, paramètres, liste des types de source | vérifié (aide lue, début) | [job-i : STRSEU](https://job-i.fr/commandes-ibm-i/strseu) |
| STRPDM : rôle, sans paramètre, menu bibliothèques/objets/membres | vérifié (aide lue en entier) | [job-i : STRPDM](https://job-i.fr/commandes-ibm-i/strpdm) |
| Signification des options 2 / 5 / 6 de `STRSEU OPTION` | **non vérifié** (valeurs listées, texte non lu) | [job-i : STRSEU](https://job-i.fr/commandes-ibm-i/strseu) |
| PDM option 2 éditer, 14 compiler ; SEU F4 et ligne FMT | vérifié (page job-i, captures décrites) | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |

### 2. Interroger sans programmer : QRY et QMQRY

- **QRY (Query for i5/OS)** : `STRQRY` affiche le menu principal de l'utilitaire ; **`WRKQRY`** (bibliothèque QQRYLIB) gère les définitions d'analyse : créer, visualiser, modifier, copier, supprimer, imprimer, **exécuter** une analyse. Commandes voisines citées : `RUNQRY` (lancer), `ANZQRY` (analyser une définition), `DLTQRY` (supprimer). Aucune de ces commandes WRKQRY/STRQRY n'a de paramètre.
- **QMQRY (requête Query Management)** : une requête QM est **une seule instruction SQL** rangée dans un membre source. `CRTQMQRY QMQRY(…) SRCFILE SRCMBR` la crée à partir de ce membre ; **`STRQMQRY QMQRY(…)`** l'exécute avec, notamment, `OUTPUT`, `QMFORM` (format de rapport), `OUTFILE`, `SETVAR` (variables de substitution), `NAMING`, `RDB`.

| Élément | Statut | Source |
|---|---|---|
| WRKQRY, STRQRY : rôle, aucun paramètre, commandes voisines | vérifié (aides lues en entier) | [WRKQRY](https://job-i.fr/commandes-ibm-i/wrkqry) · [STRQRY](https://job-i.fr/commandes-ibm-i/strqry) |
| CRTQMQRY (source = une instruction SQL, membre source), STRQMQRY (paramètres) | vérifié (début des aides) | [CRTQMQRY](https://job-i.fr/commandes-ibm-i/crtqmqry) · [STRQMQRY](https://job-i.fr/commandes-ibm-i/strqmqry) |
| Syntaxe des variables de substitution `&VAR`, formats QMFORM | **non vérifié** (non lu) | à chercher sur ibm.com |
| Page job-i « QMQRY » | introuvable (404) ; commandes STRQMQRY et CRTQMQRY seules | manque à signaler |

### 3. Utilitaires de conception : SDA, RLU, PNLGRP, DFU

- **SDA** (*Screen Design Aid*) : `STRSDA` (QPDA) « commande principale de l'Aide à la conception d'images-écran ». `OPTION` : `*SELECT` (menu principal) ou 1 à 3 ; `SRCFILE`, `SRCMBR`, `OBJLIB`, `JOBD`, `TSTFILE`, `MODE` (`*STD`, `*S38`, `*S36`). Messages SDA0001 à SDA0005 (poste non accepté, fichier écran inaccessible, arrêt sur erreur grave…) et SDA0601 (SDA déjà actif). Produit un source **DDS** de fichier écran.
- **RLU** (*Report Layout Utility*) : `STRRLU` démarre l'utilitaire de maquette d'état ; `SRCFILE`, `SRCMBR`, `OPTION` (2 ou 6), `PAGWIDTH` (1-378), `TEXT`. Produit un source DDS d'état imprimé.
- **PNLGRP** (groupes de panneaux d'aide) : `CRTPNLGRP PNLGRP(…) SRCFILE SRCMBR` crée des groupes de panneaux d'aide en ligne affichables avec des écrans DDS, des commandes CL ou l'aide par index (membre de type `PNLGRP`, source en balisage UIM : contenu non lu).
- **DFU** (*Data File Utility*) : `STRDFU` (QSYS) : `OPTION` 1 exécuter, 2 créer, 3 modifier, 4 supprimer un programme DFU, **5 exécuter un programme DFU temporaire** ; second niveau pour l'exécution : 1 modifier les données, 2 les afficher sans modifier ; paramètres `DFUPGM`, `FILE`, `MBR`. `UPDDTA` crée un programme DFU temporaire (voir [partie 02, § 2](02-db2-for-i.md#cours-détaillé)) ; pour un DFU conservé on passe par `STRDFU`. Messages DFU0005, DFU0018.

| Élément | Statut | Source |
|---|---|---|
| STRSDA : options, paramètres, MODE, messages SDA00xx | vérifié (aide lue, début) | [job-i : STRSDA](https://job-i.fr/commandes-ibm-i/strsda) |
| STRRLU : paramètres, OPTION 2/6, PAGWIDTH 1-378 | vérifié (aide lue, début) | [job-i : STRRLU](https://job-i.fr/commandes-ibm-i/strrlu) |
| CRTPNLGRP : rôle, paramètres | vérifié (début de l'aide) ; langage UIM **non lu** | [job-i : CRTPNLGRP](https://job-i.fr/commandes-ibm-i/crtpnlgrp) |
| STRDFU : options 1 à 5, paramètres, messages | vérifié (aide lue, début) | [job-i : STRDFU](https://job-i.fr/commandes-ibm-i/strdfu) |
| SDA/RLU produisent du DDS | hypothèse (connaissance générale, non relevée dans les aides lues) | à confirmer |

### 4. Écrans et états : DSPF et PRTF

- **`CRTDSPF`** crée un **fichier écran** : il contient la description d'unité et les formats d'enregistrement décrits par les DDS, **aucune donnée** ; il sert à envoyer des enregistrements à des écrans et à en recevoir. Les informations viennent de deux endroits : le source DDS (formats et zones) et la commande. `CHGDSPF` / `OVRDSPF` modifient ou substituent des paramètres, la substitution devant précéder l'ouverture. Paramètres notables : `SRCFILE`, `SRCMBR`, `MAXDEV`, `DFRWRT` (écriture différée), `LVLCHK`, `REPLACE`.
- **`CRTPRTF`** crée un **fichier imprimante** à partir de ses paramètres et, au besoin, de DDS. Paramètres notables : `PAGESIZE`, `LPI`, `CPI`, `OVRFLW` (numéro de ligne de fin de page), `SPOOL`, `OUTQ`, `COPIES`, `FORMTYPE`, `HOLD`, `SAVE`, `FILESEP`, `MAXRCDS`. Impression RPG, `OFLIND`, `PRTCTL` : [Impression RPG](../IMPRESSION-RPG.md) et [fiche 08](../cheatsheets/08-impression-et-printer-ibm-i.md).
- **DDS d'écran** (exemple job-i, annoncé exécuté) : `DSPSIZ(24 80 *DS3)`, `CA03(03 'Fin')` (F3 allume l'indicateur 03), un format `R ECRAN`, zones en `B` (entrée-sortie) ou `O` (sortie), `CHECK(LC)` (minuscules acceptées), `DATE EDTCDE(Y)`, indicateurs en colonnes 7-8/9-10 pour afficher un message d'erreur ; côté RPG : fichier `CF E WORKSTN` et `EXFMT format` ([job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii)). Mots-clés de sous-fichier : [partie 06, § 6](06-rpg-iii.md#cours-détaillé).
- **Mots d'édition** (job-i) : gabarit entre apostrophes qui décrit l'impression d'un nombre ; en DDS d'écran ou d'état, le mot-clé **`EDTWRD('mot')`** sur une zone numérique (à la place d'un code d'édition `EDTCDE`) ; RPG III spécification O : mot en colonnes 45-70 (24 caractères max), colonne 38 vide ; RPG IV colonné : 53-80 ; full free : `%EDITW(zone : mot)`. Trois parties : corps (blancs = positions de chiffres, `0` ou `*` = arrêt de suppression des zéros, `$` symbole flottant, `.` et `,` effacés à gauche du premier chiffre), signe (`CR` ou `-`, imprimé seulement si négatif), extension (toujours imprimée) ; `&` imprime un blanc.

| Élément | Statut | Source |
|---|---|---|
| CRTDSPF : fichier écran sans données, deux sources d'information, CHGDSPF/OVRDSPF avant ouverture | vérifié (début de l'aide) | [job-i : CRTDSPF](https://job-i.fr/commandes-ibm-i/crtdspf) |
| CRTPRTF : paramètres (liste) | vérifié (liste des paramètres) ; description détaillée non lue | [job-i : CRTPRTF](https://job-i.fr/commandes-ibm-i/crtprtf) |
| DDS d'écran, CA03, EXFMT, `CF E WORKSTN` | vérifié (exemple ARTECR/ARTCON) | [job-i : coder en RPG III](https://job-i.fr/coder-rpg-iii) |
| Mots d'édition : emplacement par version, 3 parties, caractères spéciaux, `EDTWRD`, `%EDITW` | vérifié (début de page lu) ; exemples imprimés non relus | [job-i : mots d'édition](https://job-i.fr/mots-edition-rpg) |
| Page job-i `/commandes-ibm-i/dspf` (liée dans le plan) | existence vérifiée, non relue | [DSPF](https://job-i.fr/commandes-ibm-i/dspf) |

### 5. Le développement moderne : RDi, VS Code et Code for IBM i

- **Rational Developer for i (RDi)** : environnement de développement intégré **basé sur Eclipse** pour créer, maintenir et moderniser des applications IBM i ; recherche, édition, compilation, analyse, refactorisation et débogage pour RPG, COBOL et autres ; environnements connecté ou déconnecté ; essai de 120 jours ; licences utilisateur autorisé, flottant, flottant à durée limitée (page produit IBM, sans numéro de version).
- **Code for IBM i** : extension **VS Code** (projet communautaire, documentation sur le site du projet) pour « maintenir et compiler du RPGLE, CL, COBOL, C/C++ sur l'IBM i depuis Visual Studio Code ». Connexion : icône IBM i, *Connect to an IBM i* (ou F1 puis *IBM i: New Connection*), mot de passe, clé privée ou agent SSH (option MFA disponible). **Parcourir/éditer des membres** : *Object Browser*, nouveau filtre, objet = fichier source physique, type `*SRCPF`, clic sur un membre (pas de verrouillage de membre ; dates de source non conservées par défaut). **Compiler** : bibliothèque de bibliothèques de la connexion dans *USER LIBRARY LIST* ; `Ctrl+E` (ou `Cmd+E`) sur le source ouvert ; si `*EVENTF` est utilisé, les erreurs chargent l'onglet *PROBLEMS*. Autres thèmes du site : RPGLE moderne, Db2 for IBM i, terminaux 5250 dans VS Code, git et IBM i.
- Conséquence pratique : une connexion SSH au serveur est nécessaire pour Code for IBM i (mot de passe/clé/agent) ; sources RPG free de plus de 80 colonnes ⇒ `QRPGLESRC` en 112 (voir § 1).

| Élément | Statut | Source |
|---|---|---|
| RDi : IDE Eclipse, fonctions, essai 120 jours, licences | vérifié (page produit lue, début) ; version et prérequis **non lus** | [IBM : Rational Developer for i](https://www.ibm.com/products/rational-developer-for-i) |
| Code for IBM i : connexion, Object Browser `*SRCPF`, `Ctrl+E`, `*EVENTF`/PROBLEMS, pas de verrouillage de membre | vérifié (page *Quick Start* lue en entier) ; source **non officielle IBM** (projet communautaire) | [Code for IBM i : Quick Start](https://codefori.github.io/docs/quickstart/) |
| Installation, débogueur, RPGLE, Db2, git | **non lu** (sections listées seulement sur la page d'accueil) | [Code for IBM i Docs](https://codefori.github.io/docs/) |
| Page job-i RDi / VS Code | aucune trouvée ; une mention de « VS Code avec Code for IBM i » existe dans la page PF de job-i | [job-i : PF](https://job-i.fr/fichier-physique-pf-ibm-i) |

### Ce qui reste à vérifier pour cette partie

Options 2/5/6 de SEU ; syntaxe des variables QMQRY et formats de rapport ; langage UIM des PNLGRP ; contenu détaillé de CRTPRTF et CRTDSPF ; fonctionnement de SDA/RLU (ce cours liste surtout les paramètres des commandes) ; installation et débogueur de Code for IBM i ; prérequis de RDi (versions IBM i, licences). Manques à signaler : aucune page job-i dédiée à QMQRY, RDi, ni VS Code/Code for IBM i.

## Plan détaillé (index des sujets)

### Les outils traditionnels

- **Dans le wiki** : [Exemples DDS d'écrans (DSPF) dans le dépôt](../INDEX-SOURCES.md)

#### QRY, QMQRY, SEU, PDM

- **job-i** : [STRSEU](https://job-i.fr/commandes-ibm-i/strseu) · [STRPDM](https://job-i.fr/commandes-ibm-i/strpdm) · [WRKQRY](https://job-i.fr/commandes-ibm-i/wrkqry)

#### SDA, RLU, PNLGRP, DFU

- **job-i** : [STRSDA](https://job-i.fr/commandes-ibm-i/strsda) · [STRRLU](https://job-i.fr/commandes-ibm-i/strrlu) · [STRDFU](https://job-i.fr/commandes-ibm-i/strdfu)

#### Les écrans et les fichiers d'impression (DSPF et PRTF)

- **job-i** : [CRTDSPF](https://job-i.fr/commandes-ibm-i/crtdspf) · [CRTPRTF](https://job-i.fr/commandes-ibm-i/crtprtf) · [DSPF](https://job-i.fr/commandes-ibm-i/dspf)

### Le développement moderne

- **Dans le wiki** : aucune page dédiée (à documenter).

#### RDi

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### VS Code et Code for IBM i

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).
