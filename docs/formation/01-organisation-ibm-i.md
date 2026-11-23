# Partie 01 : Principes généraux et organisation de l'IBM i

> Plan de formation, partie 01 sur 14. Objets et bibliothèques, commandes et aide, messages, travaux et sous-systèmes, impressions, profils et sécurité, unités et incidents, sauvegardes et IPL.
>
> **Mots-clés** : objet, bibliothèque, *FILE, *PGM, *JOB, *USRPRF, WRKOBJ, WRKJOB, WRKSPLF, DSPSYSVAL, MSGQ, sous-système, JOBQ, JOBD, OUTQ, profil utilisateur, droits, IFS, QSYSOPR, SAVLIB, IPL.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Pistes IBM](#pistes-ibm)
- [Plan détaillé](#plan-détaillé)
  - [Architecture et organisation du système](#architecture-et-organisation-du-système)
  - [Les messages](#les-messages)
  - [La gestion des travaux](#la-gestion-des-travaux)
  - [La gestion des impressions](#la-gestion-des-impressions)
  - [Les profils utilisateurs, la sécurité et les droits](#les-profils-utilisateurs-la-sécurité-et-les-droits)
  - [La gestion des unités et des incidents](#la-gestion-des-unités-et-des-incidents)
  - [Les sauvegardes, les restaurations et l'IPL](#les-sauvegardes-les-restaurations-et-lipl)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 01 : comprendre IBM i](../cheatsheets/01-comprendre-ibm-i.md)
- [Fiche 02 : commandes, messages, valeurs système](../cheatsheets/02-reference-systeme.md)
- [Fiche 08 : impression, spools, OUTQ](../cheatsheets/08-impression-et-printer-ibm-i.md)

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Les objets IBM i : définition, bibliothèques et types les plus utilisés](https://job-i.fr/objets-ibm-i) | Tout est objet (nom, type, bibliothèque) : programmes, fichiers, files d'attente, profils ; les mêmes commandes servent à les gérer. | En une phrase ; C'est quoi, un objet ? ; Ce qui identifie et décrit un objet ; Les bibliothèques : où les objets sont rangés ; Les types d'objets les plus utilisés ; Et les objets SQL ? ; Notre bibliothèque d'exemple, en entier ; Les commandes pour travailler avec les objets ; Tous les types d'objets d'IBM i 7.5 |
| [Les travaux IBM i (jobs) : interactif, batch, QINTER et QBATCH](https://job-i.fr/travaux-ibm-i) | Tout programme tourne dans un travail (nom, utilisateur, numéro) rattaché à un sous-système ; interactif = dialogue avec un écran, batch = file d'attente puis arrière-plan. | En une phrase ; C'est quoi, un travail ? ; Le nom d'un travail : numéro, utilisateur, nom ; Interactif ou batch ; Le chemin d'un travail batch ; Les types de travaux ; Voir les travaux : WRKACTJOB et WRKSBMJOB ; L'historique du travail ; Les commandes pour gérer les travaux |
| [Les sous-systèmes IBM i : QINTER, QBATCH, QCTL, QSPL expliqués](https://job-i.fr/sous-systemes-ibm-i) | Un sous-système reçoit les travaux par ses points d'entrée, leur attribue mémoire et priorité ; ses règles sont dans un objet *SBSD. | En une phrase ; À quoi sert un sous-système ? ; Les sous-systèmes livrés par IBM ; Qui démarre les sous-systèmes ? ; La description de sous-système (*SBSD) ; Le routage : comment un travail reçoit sa priorité ; La mémoire : les pools ; Créer son propre sous-système ; Les commandes des sous-systèmes |
| [JOBQ et JOBD IBM i : file d'attente et description de travail](https://job-i.fr/jobq-jobd-ibm-i) | JOBQ = file où patientent les travaux batch ; JOBD = modèle d'attributs (file, priorité, sortie, liste de bibliothèques) repris par les travaux. | En une phrase ; La file d'attente de travaux (JOBQ) ; Pourquoi mon travail reste en file d'attente ; La description de travail (JOBD) ; Le piège : SBMJOB ne prend pas tout dans la JOBD ; Les commandes des files et des descriptions |
| [Planifier un travail sur IBM i : WRKJOBSCDE et ADDJOBSCDE](https://job-i.fr/planification-travaux-ibm-i) | Le planning des travaux lance seul une commande à une heure et une fréquence données (ADDJOBSCDE) en soumettant un travail comme SBMJOB. | En une phrase ; À quoi sert le planning des travaux ? ; Ajouter une entrée : ADDJOBSCDE ; Notre démonstration sur un IBM i 7.5 ; Gérer les entrées ; Et si le système est arrêté à l'heure prévue ? ; Planning ou SBMJOB à heure fixe ? |
| [Travail batch bloqué sur IBM i : LCKW, MSGW et RNQ1218](https://job-i.fr/travail-batch-bloque-ibm-i) | Un batch qui attend un enregistrement verrouillé passe en LCKW pendant le délai du fichier, puis le RPG s'arrête sur RNQ1218 et le travail reste en MSGW jusqu'à une réponse. | En une phrase ; La chaîne de nuit ; Le diagnostic, écran par écran ; Deux minutes plus tard : MSGW et RNQ1218 ; Débloquer et relancer ; Éviter que la chaîne reste en MSGW |
| [Profil utilisateur IBM i : créer un profil (CRTUSRPRF), paramètres et JOBD](https://job-i.fr/profils-utilisateurs-ibm-i) | Le profil *USRPRF représente l'utilisateur (connexion, mot de passe, droits spéciaux, réglages de session) ; chaque travail tourne sous un profil. | En une phrase ; C'est quoi, un profil ? ; Créer un profil : CRTUSRPRF ; Ce que le profil règle à l'ouverture de session ; Attacher une description de travail à un profil ; Les profils de groupe ; Désactiver ou supprimer un profil ; Les commandes des profils |
| [Sécurité IBM i : QSECURITY, valeurs conseillées, MFA 7.6, profils et audit](https://job-i.fr/securite-ibm-i) | Choisir le niveau de sécurité (QSECURITY 40), régler les valeurs système, limiter les droits, auditer ; les droits sur les objets font le reste. | En une phrase ; Les niveaux de sécurité ; Les valeurs système conseillées ; Les outils d'IBM : GO SECTOOLS ; Les profils : fermer les portes connues ; IBM i 7.6 : activez le MFA ; L'audit : savoir ce qui se passe |
| [Droits sur les objets IBM i : *USE, *CHANGE, *ALL, GRTOBJAUT et exemples](https://job-i.fr/droits-objets-ibm-i) | Droits du propriétaire, droits privés, droit public ; le système vérifie la bibliothèque puis l'objet et s'arrête au premier droit trouvé. | En une phrase ; Qui a un droit sur un objet ? ; *USE, *CHANGE, *ALL et *EXCLUDE ; D'abord la bibliothèque, puis l'objet ; L'ordre de vérification, et le piège ; Neuf essais sur un IBM i 7.5 ; Donner et retirer des droits ; Le droit public des nouveaux objets : CRTAUT et QCRTAUT ; Les commandes des droits |
| [Classes d'utilisateurs et droits spéciaux IBM i (*ALLOBJ, *SECADM, *JOBCTL…)](https://job-i.fr/droits-speciaux-ibm-i) | La classe d'utilisateur (USRCLS) et les droits spéciaux (SPCAUT) donnent des pouvoirs sur tout le système (tout lire, gérer les profils, piloter les travaux, sauvegarder). | En une phrase ; Les cinq classes d'utilisateurs ; Les droits donnés par chaque classe ; Les huit droits spéciaux ; Les droits spéciaux passent par les groupes ; Qui peut donner un droit spécial ? ; Contrôler qui a quoi |
| [Listes d'autorisation et droits adoptés IBM i : exemples et conseils](https://job-i.fr/listes-autorisation-ibm-i) | Une liste d'autorisation *AUTL applique un même jeu de droits à plusieurs objets ; l'adoption (USRPRF(*OWNER)) prête les droits du propriétaire le temps de l'exécution. | En une phrase ; Les listes d'autorisation ; Les programmes qui adoptent les droits ; Dix conseils pour des droits clairs ; Contrôler les droits en SQL |
| [Sécurité réseau et IFS IBM i : se protéger des attaques, droits des répertoires](https://job-i.fr/securite-reseau-ifs-ibm-i) | Réduire ce qui écoute, chiffrer (SSH, TLS), auditer ; dans l'IFS, fermer chaque répertoire au public dès sa création car la racine est ouverte et les droits sont hérités. | En une phrase ; Réduire ce qui écoute sur le réseau ; Chiffrer : SSH et TLS ; Les accès à distance passent à côté des menus ; Repérer les tentatives de connexion ; L'IFS : la racine est livrée ouverte ; Démonstration : un répertoire fermé au public ; Bibliothèques, partages et antivirus |
| [OUTQ IBM i : files d'attente de sortie, spools et éditeurs](https://job-i.fr/outq-ibm-i) | Un spool attend dans une OUTQ qu'un éditeur l'envoie à une imprimante ; on peut aussi le lire, le convertir en PDF ou le supprimer. | En une phrase ; C'est quoi, un spool ? ; Dans quelle OUTQ part un spool ? ; Gérer une file de sortie : WRKOUTQ ; Les éditeurs : de l'OUTQ à l'imprimante ; Les spools en SQL ; Convertir un spool en PDF ; Supprimer des spools sans casse ; Les commandes des files de sortie et des spools |
| [Installer des PTF sur IBM i pas à pas : Fix Central, INSPTF, IPL](https://job-i.fr/installer-ptf-ibm-i) | Les PTF s'installent par groupes depuis Fix Central via un catalogue d'images ; la plupart s'activent par un IPL sur le côté B. | En une phrase ; Les types de PTF ; Les groupes proposés par Fix Central en 7.5 ; HIPER, Sécurité, Technology Refresh : la différence ; Le côté A et le côté B du microcode ; Les statuts d'une PTF ; Les prérequis ; Étape 1 : l'état des lieux ; Étape 2 : commander sur Fix Central ; Étape 3 : télécharger avec Download Director ; Étape 4 : transférer les images dans l'IFS ; Étape 5 : contrôler avant l'installation |
| [Performances IBM i : les seuils officiels, mesurés sur une vraie machine](https://job-i.fr/performances-ibm-i) | Pas de réglage universel : mesurer d'abord ; les rares seuils d'IBM portent sur l'application (ouvertures de fichiers, groupes d'activation). | En une phrase ; La méthode d'IBM avant tout réglage ; Les seuils chiffrés d'IBM ; La machine de mesure ; Lire le CPU : IBM i et la HMC ne comptent pas pareil ; Partition partagée : l'attente de capacité ; Mémoire et pools ; Mesure 1 : les ouvertures de fichiers (*INLR ou RETURN) ; Mesure 2 : les groupes d'activation (*NEW ou *CALLER) ; Mesure 3 : la lecture séquentielle (SEQONLY) ; Mesure 4 : FRCRATIO(1) ; Mesure 5 : la compression des sauvegardes (DTACPR) |
| [Messages d'erreur IBM i et AS/400 (CPF, MCH) : cause et solution](https://job-i.fr/messages-ibm-i) | Messages d'erreur CPF et MCH avec leur cause et leur solution. | Les plus rencontrés ; Toutes les fiches « Comment s'en sortir » (107) ; Messages CPF ; Messages MCH |
| [AS/400 et IBM i : ce qui a changé depuis 1988, ce qui n'a pas bougé](https://job-i.fr/as400-vs-ibm-i) | IBM i est l'OS/400 sous un autre nom : architecture conservée (interface machine, stockage à un niveau, objets, base intégrée), donc compatibilité des anciens programmes. | En une phrase ; Un seul système, plusieurs noms ; Ce qui n'a pas bougé ; Ce qui a changé ; AS/400 et IBM i, côte à côte ; La démonstration, sur un IBM i 7.5 |

## Pistes IBM

Issues de recherches ibm.com du 2026-11-23 : les pages sans mention « lu » **ne sont pas lues** ; la version indiquée peut différer de la 7.5 (à vérifier avant de s'en servir).

- [Recovering your system (IBM i 7.5)](https://www.ibm.com/docs/en/ssw_ibm_i_75/rzarm/rzarmkickoff.htm)
- [SAVLIB (IBM i 7.4)](https://www.ibm.com/docs/en/ssw_ibm_i_74/cl/savlib.htm)
- [RSTLIB (IBM i 7.2)](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/cl/rstlib.htm)

## Plan détaillé

### Architecture et organisation du système

- **Dans le wiki** : [Fiche 01](../cheatsheets/01-comprendre-ibm-i.md)

#### Les objets (*FILE, *PGM, *JOB, *USRPRF, etc.) et les bibliothèques

- **job-i** : [objets IBM i](https://job-i.fr/objets-ibm-i) · [CRTLIB](https://job-i.fr/commandes-ibm-i/crtlib) · [DSPOBJD](https://job-i.fr/commandes-ibm-i/dspobjd)

#### Les commandes, organisation, recherche, aide F1 / F10

- **job-i** : [WRKCMD](https://job-i.fr/commandes-ibm-i/wrkcmd)

#### Les commandes essentielles (WRKOBJ, WRKJOB, WRKSPLF, DSPSYSVAL)

- **job-i** : [WRKOBJ](https://job-i.fr/commandes-ibm-i/wrkobj) · [WRKJOB](https://job-i.fr/commandes-ibm-i/wrkjob) · [WRKSPLF](https://job-i.fr/commandes-ibm-i/wrksplf) · [DSPSYSVAL](https://job-i.fr/commandes-ibm-i/dspsysval)

### Les messages

- **Dans le wiki** : [Fiche 02 (messages CPF/MCH)](../cheatsheets/02-reference-systeme.md)

#### Principes généraux

- **job-i** : [SNDMSG](https://job-i.fr/commandes-ibm-i/sndmsg) · [DSPMSG](https://job-i.fr/commandes-ibm-i/dspmsg)

#### Les files d'attente de messages

- **job-i** : [CRTMSGQ](https://job-i.fr/commandes-ibm-i/crtmsgq) · [WRKMSGQ](https://job-i.fr/commandes-ibm-i/wrkmsgq)

### La gestion des travaux

- **Dans le wiki** : [Fiche 01](../cheatsheets/01-comprendre-ibm-i.md)

#### Travaux interactifs et travaux batchs

- **job-i** : [SBMJOB](https://job-i.fr/commandes-ibm-i/sbmjob) · [WRKACTJOB](https://job-i.fr/commandes-ibm-i/wrkactjob)

#### Travaux à démarrage automatique et à démarrages anticipés

- **job-i** : [ADDAJE](https://job-i.fr/commandes-ibm-i/addaje) · [ADDPJE](https://job-i.fr/commandes-ibm-i/addpje)

#### Les sous-systèmes

- **job-i** : [STRSBS](https://job-i.fr/commandes-ibm-i/strsbs) · [ENDSBS](https://job-i.fr/commandes-ibm-i/endsbs) · [WRKSBSD](https://job-i.fr/commandes-ibm-i/wrksbsd)

#### Les files d'attente de travaux et les descriptions de travail

- **job-i** : [JOBQ](https://job-i.fr/jobq-jobd-ibm-i) · [CRTJOBQ](https://job-i.fr/commandes-ibm-i/crtjobq) · [CRTJOBD](https://job-i.fr/commandes-ibm-i/crtjobd) · [WRKJOBQ](https://job-i.fr/commandes-ibm-i/wrkjobq)

#### La liste de bibliothèques

- **job-i** : [liste de bibliothèques](https://job-i.fr/objets-ibm-i) · [ADDLIBLE](https://job-i.fr/commandes-ibm-i/addlible) · [DSPLIBL](https://job-i.fr/commandes-ibm-i/dsplibl) · [CHGLIBL](https://job-i.fr/commandes-ibm-i/chglibl)

### La gestion des impressions

- **Dans le wiki** : [Fiche 08](../cheatsheets/08-impression-et-printer-ibm-i.md) · [Impression RPG](../IMPRESSION-RPG.md)

#### Les files d'attente de sortie

- **job-i** : [OUTQ](https://job-i.fr/outq-ibm-i) · [CRTOUTQ](https://job-i.fr/commandes-ibm-i/crtoutq) · [WRKOUTQ](https://job-i.fr/commandes-ibm-i/wrkoutq)

#### La gestion des imprimantes

- **job-i** : [CRTPRTF](https://job-i.fr/commandes-ibm-i/crtprtf) · [OVRPRTF](https://job-i.fr/commandes-ibm-i/ovrprtf) · [STRPRTWTR](https://job-i.fr/commandes-ibm-i/strprtwtr)

### Les profils utilisateurs, la sécurité et les droits

- **Dans le wiki** : [Fiche 01 (profils, sécurité)](../cheatsheets/01-comprendre-ibm-i.md)

#### Les profils utilisateurs, création et maintenance

- **job-i** : [CRTUSRPRF](https://job-i.fr/commandes-ibm-i/crtusrprf) · [CHGUSRPRF](https://job-i.fr/commandes-ibm-i/chgusrprf) · [WRKUSRPRF](https://job-i.fr/commandes-ibm-i/wrkusrprf)

#### La sécurité IBM i et les droits sur les objets

- **job-i** : [GRTOBJAUT](https://job-i.fr/commandes-ibm-i/grtobjaut) · [RVKOBJAUT](https://job-i.fr/commandes-ibm-i/rvkobjaut) · [DSPOBJAUT](https://job-i.fr/commandes-ibm-i/dspobjaut) · [WRKOBJOWN](https://job-i.fr/commandes-ibm-i/wrkobjown) · [CRTAUTL](https://job-i.fr/commandes-ibm-i/crtautl)

#### Les droits sur l'IFS

- **job-i** : [CHGAUT](https://job-i.fr/commandes-ibm-i/chgaut) · [WRKAUT](https://job-i.fr/commandes-ibm-i/wrkaut) · [WRKLNK](https://job-i.fr/commandes-ibm-i/wrklnk)

### La gestion des unités et des incidents

- **Dans le wiki** : aucune page dédiée (à documenter).

#### La gestion des unités (écrans, imprimantes, lecteurs de bandes)

- **job-i** : [WRKCFGSTS](https://job-i.fr/commandes-ibm-i/wrkcfgsts) · [VRYCFG](https://job-i.fr/commandes-ibm-i/vrycfg) · [WRKDEVD](https://job-i.fr/commandes-ibm-i/wrkdevd)

#### Les méthodes d'analyse d'incident

- **job-i** : [DSPJOBLOG](https://job-i.fr/commandes-ibm-i/dspjoblog) · [WRKPRB](https://job-i.fr/commandes-ibm-i/wrkprb) · [ANZPRB](https://job-i.fr/commandes-ibm-i/anzprb)

#### Le log système et le log de l'opérateur système

- **job-i** : [DSPLOG](https://job-i.fr/commandes-ibm-i/dsplog)

### Les sauvegardes, les restaurations et l'IPL

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Principes généraux des sauvegardes et restaurations

- **job-i** : [SAVLIB](https://job-i.fr/commandes-ibm-i/savlib) · [SAVOBJ](https://job-i.fr/commandes-ibm-i/savobj) · [RSTLIB](https://job-i.fr/commandes-ibm-i/rstlib) · [RSTOBJ](https://job-i.fr/commandes-ibm-i/rstobj) · [SAV](https://job-i.fr/commandes-ibm-i/sav) · [RST](https://job-i.fr/commandes-ibm-i/rst) · [SAVSYS](https://job-i.fr/commandes-ibm-i/savsys)

#### Les supports

- **job-i** : [CRTSAVF](https://job-i.fr/commandes-ibm-i/crtsavf)

#### Le principe de l'IPL

- **job-i** : [PWRDWNSYS](https://job-i.fr/commandes-ibm-i/pwrdwnsys)
