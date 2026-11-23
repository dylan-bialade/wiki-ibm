# Partie 04 : Le langage de contrôle (CL)

> Plan de formation, partie 04 sur 14. Fondements du CL, fichiers et OVRDBF, structure d'un programme, boucles et conditions, chaînes, appels et paramètres, zones de données, sous-routines.
>
> **Mots-clés** : CL, CLP, CLLE, DCLPROPT, DCLF, OVRDBF, IF, DOWHILE, GOTO, CHGVAR, CALL, DTAARA, SUBR.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Plan détaillé](#plan-détaillé)
  - [Les fondements du langage de contrôle](#les-fondements-du-langage-de-contrôle)
  - [Structurer un programme CL](#structurer-un-programme-cl)
  - [Appels, données et sous-routines](#appels-données-et-sous-routines)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 02 : commandes CL](../cheatsheets/02-reference-systeme.md)
- [Sources CL dans le dépôt](../INDEX-SOURCES.md)

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Coder en CL (CLLE et CLP) : 3 programmes, MONMSG, écran, débogage](https://job-i.fr/coder-cl-ibm-i) | Un programme CL (PGM à ENDPGM) enchaîne des commandes avec variables, tests, boucles et MONMSG ; il pilote les travaux et les traitements. | En une phrase ; Préparer l'atelier ; HELLOCL : dire bonjour à l'utilisateur ; ETATSTK : lire un fichier et gérer les erreurs ; MENUCL : un menu qui affiche un écran ; Déboguer et tester ; CLP ou CLLE ? |
| [Zone de données (DTAARA) IBM i : CL, RPG, SQL et *LDA, exemples testés](https://job-i.fr/zone-de-donnees-dtaara-ibm-i) | Une zone de données *DTAARA contient une seule valeur (compteur, paramètre, état) partagée entre programmes et travaux. | En une phrase ; Une zone de données, c'est quoi ; Créer et afficher une zone de données ; Le numéro de facture suivant ; Le verrou, vu d'un autre travail ; Une zone de paramètres vue comme une structure ; La *LDA, propre à chaque travail ; Le piège du full free : les apostrophes ; Lire une zone de données en SQL ; Les erreurs, et ce qu'elles veulent dire |
| [API système IBM i : QSNDDTAQ, QUSROBJD, QCMDEXC, QsnWrtDta, exemples testés](https://job-i.fr/api-systeme-ibm-i) | Une API système est une procédure ou un programme livré par IBM pour ce qu'aucune instruction ne fait (files de données, description d'objet, exécution de commande, écran). | En une phrase ; Deux familles : les programmes et les procédures ; Le code erreur, commun aux API ; QSNDDTAQ et QRCVDTAQ : des commandes entre deux programmes ; La même file, vue et utilisée en SQL ; QCMDEXC : exécuter une commande CL ; QUSROBJD : la description d'un objet ; QsnWrtDta : écrire sur l'écran sans DSPF ; Les messages relevés |

## Plan détaillé

### Les fondements du langage de contrôle

- **Dans le wiki** : [Index des sources CL](../INDEX-SOURCES.md)

#### Le langage et le DCLPROPT

- **job-i** : [PGM](https://job-i.fr/commandes-ibm-i/pgm) · [DCL](https://job-i.fr/commandes-ibm-i/dcl)

#### L'utilisation des fichiers (base de données, écrans)

- **job-i** : [DCLF](https://job-i.fr/commandes-ibm-i/dclf) · [RCVF](https://job-i.fr/commandes-ibm-i/rcvf) · [SNDF](https://job-i.fr/commandes-ibm-i/sndf) · [SNDRCVF](https://job-i.fr/commandes-ibm-i/sndrcvf)

#### Les OVRDBF

- **job-i** : [OVRDBF](https://job-i.fr/commandes-ibm-i/ovrdbf) · [DLTOVR](https://job-i.fr/commandes-ibm-i/dltovr)

### Structurer un programme CL

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Boucles et conditions

- **job-i** : [IF](https://job-i.fr/commandes-ibm-i/if) · [DOWHILE](https://job-i.fr/commandes-ibm-i/dowhile) · [DOUNTIL](https://job-i.fr/commandes-ibm-i/dountil) · [DOFOR](https://job-i.fr/commandes-ibm-i/dofor) · [SELECT](https://job-i.fr/commandes-ibm-i/select) · [GOTO](https://job-i.fr/commandes-ibm-i/goto)

#### Conditionnement d'invites

- **job-i** : [PARM](https://job-i.fr/rpg-iii/parm)

#### Gestion des chaînes de caractères, switchs et indicateurs

- **job-i** : [CHGVAR](https://job-i.fr/commandes-ibm-i/chgvar)

### Appels, données et sous-routines

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Appels de programmes et passage de paramètres

- **job-i** : [CALL](https://job-i.fr/commandes-ibm-i/call) · [CALLPRC](https://job-i.fr/commandes-ibm-i/callprc) · [RETURN](https://job-i.fr/commandes-ibm-i/return) · [MONMSG](https://job-i.fr/commandes-ibm-i/monmsg)

#### Récupération d'informations externes du système

- **job-i** : [RTVJOBA](https://job-i.fr/commandes-ibm-i/rtvjoba) · [RTVSYSVAL](https://job-i.fr/commandes-ibm-i/rtvsysval) · [RTVOBJD](https://job-i.fr/commandes-ibm-i/rtvobjd) · [RTVDTAARA](https://job-i.fr/commandes-ibm-i/rtvdtaara) · [RTVNETA](https://job-i.fr/commandes-ibm-i/rtvneta)

#### Les zones de données (DTAARA)

- **job-i** : [DTAARA](https://job-i.fr/zone-de-donnees-dtaara-ibm-i) · [CRTDTAARA](https://job-i.fr/commandes-ibm-i/crtdtaara) · [CHGDTAARA](https://job-i.fr/commandes-ibm-i/chgdtaara) · [RTVDTAARA](https://job-i.fr/commandes-ibm-i/rtvdtaara) · [DSPDTAARA](https://job-i.fr/commandes-ibm-i/dspdtaara)

#### Les sous-routines

- **job-i** : [SUBR](https://job-i.fr/commandes-ibm-i/subr) · [ENDSUBR](https://job-i.fr/commandes-ibm-i/endsubr) · [CALLSUBR](https://job-i.fr/commandes-ibm-i/callsubr)
