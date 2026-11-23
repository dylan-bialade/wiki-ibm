# Partie 10 : ILE : modules, programmes de service, tests et journalisation

> Plan de formation, partie 10 sur 14. OPM contre ILE, groupes d'activation, procédures et prototypes, modules et programmes de service, liage, signatures, conception modulaire, débogage, journalisation.
>
> **Mots-clés** : ILE, OPM, groupe d'activation, DCL-PROC, DCL-PR, DCL-PI, CONST, OPTIONS, CRTRPGMOD, CRTPGM, CRTSRVPGM, BNDDIR, NOMAIN, /COPY, signature, STRDBG, STRISDB, dump, journal, DSPJRN.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (vérifié dans le wiki)](#lessentiel-vérifié-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Pistes IBM](#pistes-ibm)
- [Plan détaillé](#plan-détaillé)
  - [Les principes de l'ILE](#les-principes-de-lile)
  - [Procédures et prototypes](#procédures-et-prototypes)
  - [Modules et programmes de service](#modules-et-programmes-de-service)
  - [Conception modulaire](#conception-modulaire)
  - [Tests, débogage et dumps](#tests-débogage-et-dumps)
  - [La journalisation](#la-journalisation)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Architecture ILE et services REST : concepts, exemple complet, mémo des commandes](../ILE-ET-SERVICES-WEB.md)

## L'essentiel (vérifié dans le wiki)

- **Objets ILE** : `*MODULE` (sortie du compilateur), `*PGM` (modules liés + `ENTMOD`), `*SRVPGM` (sans entrée, partagé), `*BNDDIR` (liste où le binder cherche) ([concepts](../ILE-ET-SERVICES-WEB.md#concepts-ile-job-i-et-ibm)).
- **Par copie ou par référence** : `UPDPGM` pour un programme lié par copie, `UPDSRVPGM` une fois pour tous les programmes liés par référence.
- **Source de liage** : ne jamais retirer ni réordonner les exports, ajouter à la fin ; sans signature explicite, ajouter un bloc `PGMLVL(*CURRENT)` et passer l'ancien en `*PRV`.
- **Groupes d'activation** : `*CALLER` (partage fichiers, validation, pas de frontière de contrôle) ou groupe nommé (isolation) ; `DFTACTGRP(*NO)` obligatoire pour `ACTGRP` et `BNDDIR`.
- **Mémo des commandes** : CRTRPGMOD, CRTSRVPGM, UPDSRVPGM, DSPSRVPGM `DETAIL(*PROCEXP)`, etc. ([partie 4](../ILE-ET-SERVICES-WEB.md#partie-4--mémo-des-commandes-système-ile-iws-exploitation)).

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [ILE sur IBM i : modules, programmes de service, liage, exemple RPG, C et CL](https://job-i.fr/ile-ibm-i) | ILE : le compilateur produit un module ; on lie des modules de langages différents en programme ou en programme de service partagé. | En une phrase ; L'ILE, c'est quoi ; Pourquoi l'ILE existe ; L'exemple : un programme RPG, un module C, un module CL ; Mettre en place 1 : trois modules, un programme ; Mettre en place 2 : un programme de service ; Par copie ou par référence : la preuve ; Déboguer d'un langage à l'autre ; Mettre l'ILE en place dans une application |
| [PR et PI en RPG : prototype et interface de procédure, colonné et full free](https://job-i.fr/prototypes-rpg-pr-pi) | Le prototype PR décrit l'appel, l'interface PI déclare les paramètres reçus ; le compilateur contrôle leur cohérence dans un même source. | En une phrase ; PR et PI, c'est quoi ; Où ça s'écrit en RPG IV colonné ; Un PI à la place de *ENTRY PLIST ; Appeler un programme par son prototype ; Pourquoi le prototype dans un /COPY ; Des procédures internes, avec ou sans PR ; Les modes de passage des paramètres ; Voir les paramètres reçus dans le débogueur ; Les erreurs, et ce qu'elles veulent dire |
| [API système IBM i : QSNDDTAQ, QUSROBJD, QCMDEXC, QsnWrtDta, exemples testés](https://job-i.fr/api-systeme-ibm-i) | Une API système est une procédure ou un programme livré par IBM pour ce qu'aucune instruction ne fait (files de données, description d'objet, exécution de commande, écran). | En une phrase ; Deux familles : les programmes et les procédures ; Le code erreur, commun aux API ; QSNDDTAQ et QRCVDTAQ : des commandes entre deux programmes ; La même file, vue et utilisée en SQL ; QCMDEXC : exécuter une commande CL ; QUSROBJD : la description d'un objet ; QsnWrtDta : écrire sur l'écran sans DSPF ; Les messages relevés |

## Pistes IBM

Issues de recherches ibm.com du 2026-11-23 : les pages sans mention « lu » **ne sont pas lues** ; la version indiquée peut différer de la 7.5 (à vérifier avant de s'en servir).

- [Binder Language (IBM i 7.4) : lu](https://www.ibm.com/docs/en/i/7.4.0?topic=concepts-binder-language)
- [Signature (IBM i 7.3) : lu](https://www.ibm.com/docs/en/i/7.3.0?topic=language-signature)
- [Journal management (IBM i 7.4)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzaki/rzakikickoff.htm)

## Plan détaillé

### Les principes de l'ILE

- **Dans le wiki** : [ILE : concepts (job-i et IBM)](../ILE-ET-SERVICES-WEB.md#concepts-ile-job-i-et-ibm)

#### OPM et ILE, ce qui change

- **job-i** : [ILE](https://job-i.fr/ile-ibm-i)

#### Les groupes d'activation et leur portée

- **job-i** : [groupe d'activation](https://job-i.fr/ile-ibm-i)

#### La pile d'appels et la durée de vie des ressources

- **job-i** : [RCLRSC](https://job-i.fr/commandes-ibm-i/rclrsc) · [RCLACTGRP](https://job-i.fr/commandes-ibm-i/rclactgrp)

### Procédures et prototypes

- **Dans le wiki** : [Fiche 03 (PR/PI)](../cheatsheets/03-rpg-par-version.md)

#### La déclaration d'une procédure, DCL-PROC

- **job-i** : [DCL-PROC](https://job-i.fr/instructions-rpg/dcl-proc)

#### Prototypes et interfaces de procédure

- **job-i** : [DCL-PR](https://job-i.fr/instructions-rpg/dcl-pr) · [DCL-PI](https://job-i.fr/instructions-rpg/dcl-pi) · [PR et PI en RPG](https://job-i.fr/prototypes-rpg-pr-pi)

#### Le passage de paramètres, valeur, référence, CONST, OPTIONS

- **job-i** : [CONST](https://job-i.fr/instructions-rpg/const) · [OPTIONS](https://job-i.fr/instructions-rpg/options) · [PR et PI en RPG](https://job-i.fr/prototypes-rpg-pr-pi)

#### Les procédures retournant une valeur

- **job-i** : [RETURN](https://job-i.fr/commandes-ibm-i/return) · [PR et PI en RPG](https://job-i.fr/prototypes-rpg-pr-pi)

#### Portée des variables, locales et globales

- **job-i** : [PR et PI en RPG](https://job-i.fr/prototypes-rpg-pr-pi)

### Modules et programmes de service

- **Dans le wiki** : [Architecture ILE : modules, srvpgm, source de liage](../ILE-ET-SERVICES-WEB.md#partie-1--modules-programme-de-service-source-de-liage)

#### La compilation en module, CRTRPGMOD

- **job-i** : [CRTRPGMOD](https://job-i.fr/commandes-ibm-i/crtrpgmod)

#### Le liage par copie, CRTPGM

- **job-i** : [CRTPGM](https://job-i.fr/commandes-ibm-i/crtpgm)

#### Les programmes de service, CRTSRVPGM

- **job-i** : [CRTSRVPGM](https://job-i.fr/commandes-ibm-i/crtsrvpgm) · [UPDSRVPGM](https://job-i.fr/commandes-ibm-i/updsrvpgm)

#### Les modules NOMAIN et les sources /COPY

- **job-i** : [/COPY](https://job-i.fr/commandes-ibm-i/copy)

#### Les répertoires de liage (BNDDIR)

- **job-i** : [BNDDIR](https://job-i.fr/ile-ibm-i) · [CRTBNDDIR](https://job-i.fr/commandes-ibm-i/crtbnddir) · [ADDBNDDIRE](https://job-i.fr/commandes-ibm-i/addbnddire)

#### Signature, fichier de liage et gestion des versions

- **job-i** : [RTVBNDSRC](https://job-i.fr/commandes-ibm-i/rtvbndsrc)

### Conception modulaire

- **Dans le wiki** : [Exemple complet BONBON](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)

#### Découpage fonctionnel d'une application

- **Dans le wiki** : [Exemple BONBON : 4 membres, ordre de création](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)
- **job-i** : [ILE sur IBM i](https://job-i.fr/ile-ibm-i)

#### Réutilisation et bibliothèques de procédures

- **job-i** : [ILE sur IBM i](https://job-i.fr/ile-ibm-i)

#### Centralisation des erreurs et des logs

- **job-i** : [SNDPGMMSG](https://job-i.fr/commandes-ibm-i/sndpgmmsg)

### Tests, débogage et dumps

- **Dans le wiki** : aucune page dédiée (à documenter).

#### STRISDB et STRDBG, breakpoints et watch variables

- **job-i** : [STRDBG](https://job-i.fr/commandes-ibm-i/strdbg) · [STRISDB](https://job-i.fr/commandes-ibm-i/strisdb) · [ENDDBG](https://job-i.fr/commandes-ibm-i/enddbg)

#### Le débogage d'un programme de service, service entry point

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Lecture et interprétation d'un dump

- **job-i** : [DMPJOB](https://job-i.fr/commandes-ibm-i/dmpjob) · [DSPJOBLOG](https://job-i.fr/commandes-ibm-i/dspjoblog) · [dump](https://job-i.fr/rpg-iii/dump)

#### Stratégie de tests unitaires et fonctionnels

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### La journalisation

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Journaux et récepteurs

- **job-i** : [CRTJRN](https://job-i.fr/commandes-ibm-i/crtjrn) · [CRTJRNRCV](https://job-i.fr/commandes-ibm-i/crtjrnrcv) · [STRJRNPF](https://job-i.fr/commandes-ibm-i/strjrnpf)

#### Analyse de l'activité via DSPJRN

- **job-i** : [DSPJRN](https://job-i.fr/commandes-ibm-i/dspjrn) · [RCVJRNE](https://job-i.fr/commandes-ibm-i/rcvjrne)
