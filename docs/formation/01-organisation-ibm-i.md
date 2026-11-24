# Partie 01 : Principes généraux et organisation de l'IBM i

> Plan de formation, partie 01 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Objets et bibliothèques, commandes et aide, messages, travaux et sous-systèmes, impressions, profils et sécurité, unités et incidents, sauvegardes et IPL.
>
> **Mots-clés** : objet, bibliothèque, *FILE, *PGM, *JOB, *USRPRF, WRKOBJ, WRKJOB, WRKSPLF, DSPSYSVAL, MSGQ, sous-système, JOBQ, JOBD, OUTQ, profil utilisateur, droits, IFS, QSYSOPR, SAVLIB, IPL.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Pistes IBM](#pistes-ibm)
- [Cours détaillé](#cours-détaillé)
  - [Architecture et organisation du système](#architecture-et-organisation-du-système)
  - [Les messages](#les-messages)
  - [La gestion des travaux](#la-gestion-des-travaux)
  - [La gestion des impressions](#la-gestion-des-impressions)
  - [Les profils utilisateurs, la sécurité et les droits](#les-profils-utilisateurs-la-sécurité-et-les-droits)
  - [La gestion des unités et des incidents](#la-gestion-des-unités-et-des-incidents)
  - [Les sauvegardes, les restaurations et l'IPL](#les-sauvegardes-les-restaurations-et-lipl)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Architecture et organisation du système](#architecture-et-organisation-du-système-1)
  - [Les messages](#les-messages-1)
  - [La gestion des travaux](#la-gestion-des-travaux-1)
  - [La gestion des impressions](#la-gestion-des-impressions-1)
  - [Les profils utilisateurs, la sécurité et les droits](#les-profils-utilisateurs-la-sécurité-et-les-droits-1)
  - [La gestion des unités et des incidents](#la-gestion-des-unités-et-des-incidents-1)
  - [Les sauvegardes, les restaurations et l'IPL](#les-sauvegardes-les-restaurations-et-lipl-1)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Fiche 01 : comprendre IBM i](../cheatsheets/01-comprendre-ibm-i.md)
- [Fiche 02 : commandes, messages, valeurs système](../cheatsheets/02-reference-systeme.md)
- [Fiche 08 : impression, spools, OUTQ](../cheatsheets/08-impression-et-printer-ibm-i.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

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

## Cours détaillé

> Synthèse rédigée à partir de pages job-i lues le 2026-11-23 (**lecture partielle** : le début de chaque page, soit 5 à 8 Ko sur 11 à 26 Ko ; la fin de chaque page n'est pas lue) et d'une page IBM. Chaque bloc donne ses sources ; le statut « vérifié » vaut pour la partie lue. Les noms de bibliothèques de démonstration de job-i sont remplacés par `BIB01`.

### Architecture et organisation du système

**Les objets et les bibliothèques**
- Tout est **objet** : programme, fichier, file d'attente, profil. Un objet est identifié par **son nom, son type et sa bibliothèque** ; le type est fixé à la création et décide des opérations possibles (on ne « réécrit » pas un programme, on le recompile). Source : [job-i, objets](https://job-i.fr/objets-ibm-i). *Vérifié (partie lue).*
- **Nom** : 10 caractères au plus, commence par une lettre ; les objets d'IBM commencent par `Q` (à éviter pour les siens). **Attribut** : précise le type (langage d'un programme, nature d'un fichier : PF, LF, DSPF, PRTF). **Texte** : 50 caractères, affiché par `WRKOBJ`. **Description** (taille, dates de création, modification, dernière utilisation, sauvegarde, source d'origine) : `DSPOBJD`.
- **Même nom, types différents** : permis (un programme et une zone de données peuvent s'appeler `BONJOUR`) ; **même nom, même type, même bibliothèque** : impossible (CPF1023 « existe déjà »). Un type inadapté à la commande donne CPF2802 (ex. copier une zone de données comme un fichier).
- **Bibliothèque** (`*LIB`) : objet qui en contient d'autres, **sans imbrication** ; toutes sont rangées dans `QSYS`, la seule à pouvoir contenir des bibliothèques. Les profils (`*USRPRF`), listes d'autorisation (`*AUTL`) et descriptions d'unités (`*DEVD`) vivent dans `QSYS`. Création : `CRTLIB`.
- **Ce n'est pas l'IFS** : l'IFS (`/home`, `/QOpenSys`…) a ses propres types (`*STMF`, `*DIR`) ; les bibliothèques y apparaissent sous `/QSYS.LIB` (ex. `/QSYS.LIB/BIB01.LIB/BONJOUR.PGM`).
- **Liste de bibliothèques (`*LIBL`)** : un programme écrit `ARTICLE`, pas `BIB01/ARTICLE` ; le système cherche dans l'ordre de la liste du travail : partie **système** (valeur système `QSYSLIBL`), bibliothèques de **produits** (deux au plus), bibliothèque **en cours** (`*CURLIB`, `QGPL` si aucune), partie **utilisateur** (`ADDLIBLE`, `CHGLIBL`, `DSPLIBL`). C'est la première cause d'erreurs « objet non trouvé » (ex. CPF4101) ; mettre une bibliothèque de test devant celle de production fait travailler le même programme sur d'autres fichiers.
- **Types courants** : `*FILE` (attributs PF, LF, DSPF, PRTF…), `*PGM`, `*SRVPGM`, `*MODULE`, `*DTAARA`, `*JOBQ`, `*JOBD`, `*OUTQ`, `*MSGQ`, `*USRPRF`, `*AUTL`, `*SBSD`… (92 types en bibliothèque sur IBM i 7.5 d'après job-i).
- Les bibliothèques et leurs objets ont un propriétaire et des droits : voir « Les profils utilisateurs, la sécurité et les droits ».

**Les commandes**
- Une commande associe presque toujours un **verbe et un objet** : `CRT` (créer), `CHG` (modifier), `DSP` (afficher), `WRK` (gérer), `DLT` (supprimer), `ADD`, `SAV`, `RST`… Source : fiches des commandes sur [job-i](https://job-i.fr/commandes-ibm-i). *Vérifié.*
- **Aide à la saisie** : en session 5250, taper la commande puis **F4** (invite), **F10** pour afficher les paramètres supplémentaires, **F1** sur un paramètre pour l'aide (indication reprise sur les fiches job-i et dans les pages « profils » et « jobq-jobd »). Recherche d'une commande : `WRKCMD` (fiche job-i existante) ; catalogue dans la [fiche 02](../cheatsheets/02-reference-systeme.md).

**Les commandes essentielles** (syntaxe minimale et rôle d'après job-i)

| Commande | Rôle | Syntaxe minimale |
|---|---|---|
| [`WRKOBJ`](https://job-i.fr/commandes-ibm-i/wrkobj) | liste les objets d'une ou plusieurs bibliothèques | `WRKOBJ OBJ(BIB01/BONJOUR)` |
| [`WRKJOB`](https://job-i.fr/commandes-ibm-i/wrkjob) | gère un travail (menu du travail) | `WRKJOB JOB(numéro/utilisateur/nom)` (nom partiel accepté) |
| [`WRKSPLF`](https://job-i.fr/commandes-ibm-i/wrksplf) | liste des fichiers spoule, quelle que soit leur file | `WRKSPLF` |
| [`DSPSYSVAL`](https://job-i.fr/commandes-ibm-i/dspsysval) | affiche le nom et le contenu d'une valeur système | `DSPSYSVAL SYSVAL(QSECURITY)` |
| [`CHGSYSVAL`](https://job-i.fr/commandes-ibm-i/chgsysval) | modifie une valeur système | `CHGSYSVAL SYSVAL(...) VALUE(...)` |

### Les messages

| Élément | Statut | Source |
|---|---|---|
| `SNDMSG MSG(...)` : message immédiat vers une ou plusieurs files de messages | vérifié | [job-i SNDMSG](https://job-i.fr/commandes-ibm-i/sndmsg) |
| `DSPMSG` : affiche les messages reçus dans une file | vérifié | [job-i DSPMSG](https://job-i.fr/commandes-ibm-i/dspmsg) |
| `CRTMSGQ MSGQ(...)` : crée une file de messages dans une bibliothèque ; `WRKMSGQ` les gère | vérifié | [CRTMSGQ](https://job-i.fr/commandes-ibm-i/crtmsgq), [WRKMSGQ](https://job-i.fr/commandes-ibm-i/wrkmsgq) |
| `SNDPGMMSG` : envoie un message programme à une file ou à la file du poste de la liste d'appels | vérifié | [job-i SNDPGMMSG](https://job-i.fr/commandes-ibm-i/sndpgmmsg) |
| Un batch qui pose une question s'arrête en état **MSGW** (`INQMSGRPY(*RQD)`) jusqu'à réponse d'un opérateur | vérifié (partie lue) | [job-i travaux](https://job-i.fr/travaux-ibm-i) |
| La file de messages d'un profil (`MSGQ(*USRPRF)`) est créée dans `QUSRSYS` au nom du profil | vérifié (partie lue) | [job-i profils](https://job-i.fr/profils-utilisateurs-ibm-i) |
| Messages d'erreur : préfixes `CPF`, `MCH`, `CPD`, `RNQ`… (cause et solution sur job-i) | vérifié | [job-i messages](https://job-i.fr/messages-ibm-i), [fiche 02](../cheatsheets/02-reference-systeme.md) |
| `QSYSOPR` (file de messages de l'opérateur système) : rôle et lecture | **non vérifié** (connaissance générale) | — |

Exemples d'identifiants rencontrés dans les pages lues : CPF1023 (objet existe déjà), CPF1022 (non autorisé à la bibliothèque), CPF2802 / CPF2817 (fichier non trouvé / commande interrompue), CPF4101 (fichier de `*LIBL` non trouvé), CPD4090 (imprimante non trouvée, file de sortie remplacée par `QGPL/QPRINT`), RNQ1218 (enregistrement verrouillé, voir « travaux »).

### La gestion des travaux

**Travail, nom, types** ([job-i travaux](https://job-i.fr/travaux-ibm-i), *vérifié, partie lue*)
- Aucun programme ne tourne seul : tout s'exécute dans un **travail** (job), qui a un utilisateur, une liste de bibliothèques, une file de sortie, un historique de messages, et tourne dans un **sous-système**.
- **Nom qualifié** `numéro/utilisateur/nom` (numéro sur 6 chiffres attribué par le système) ; `WRKJOB JOB(011954/UTIL/EDITION)`, `JOB(UTIL/EDITION)` ou `JOB(EDITION)` si le nom suffit à identifier le travail (sinon liste de choix).

| | Interactif | Batch |
|---|---|---|
| Début / fin | ouverture / fermeture de session | prise dans une file par un sous-système / fin du programme |
| Entrée | poste écran du sous-système | file d'attente de travaux (JOBQ) |
| Sous-système livré | `QINTER` (console : `QCTL`) | `QBATCH` |
| Nom | celui de l'écran (`QPADEV0001`) | celui donné à `SBMJOB` |
| Priorité d'exécution | 20 (classe `QINTER`) | 50 (classe `QBATCH`) |
| Question posée | réponse à l'écran | attend une réponse (état `MSGW`) |

- **Chemin d'un travail batch** : `SBMJOB` crée le travail (attributs pris dans la commande, la JOBD, le profil et le travail soumetteur) → il attend dans une **JOBQ** (par priorité puis heure d'arrivée) → le sous-système le prend quand il a de la place, ses **données de routage** désignent un **poste de routage** (programme, classe, pool de mémoire) → il s'exécute → ses impressions deviennent des **spools** dans une **OUTQ**.

**Démarrage automatique et prédémarrés** : une description de sous-système contient des **postes autostart** (travaux lancés à chaque démarrage du sous-système, `ADDAJE`) et des **postes prédémarrés** (travaux démarrés à l'avance pour répondre vite, ceux des serveurs, `ADDPJE`). Un travail autostart tourne sous l'utilisateur de sa JOBD, qui ne peut donc pas être `*RQD`. Source : [job-i sous-systèmes](https://job-i.fr/sous-systemes-ibm-i) (*vérifié, partie lue*).

**Les sous-systèmes** ([job-i](https://job-i.fr/sous-systemes-ibm-i), *vérifié, partie lue*)
- Un sous-système est un environnement d'exécution : ses **portes d'entrée** (postes écrans, files de travaux…), sa **mémoire** (pools), sa **priorité**, son **débit** (nombre de travaux à la fois). Il est entièrement décrit par un objet **`*SBSD`** et piloté par un travail moniteur du même nom (type `SBS` dans `WRKACTJOB`) ; seuls les travaux système (`SYS`) sont hors sous-système.
- **Configurations IBM** : valeur système `QCTLSBSD` = `QBASE` (tout dans un sous-système) ou `QCTL` (réparti). Dans `QCTL` : `QCTL` (contrôle, console), `QINTER` (sessions 5250), `QBATCH` (batch, file `QGPL/QBATCH`), `QSPL` (éditeurs et lecteurs), `QCMN` (communications), `QSYSWRK` (fonctions système démarrées avec IBM i), `QUSRWRK` (travaux de serveurs pour un utilisateur, ex. `QZDASOINIT` pour ODBC/JDBC), `QSERVER` (serveur de fichiers) ; `QHTTPSVR` pour le serveur HTTP.
- **Qui démarre quoi** : à l'IPL, le système démarre le sous-système de contrôle (`QCTLSBSD`), dont un travail autostart appelle le **programme de démarrage** désigné par la valeur système `QSTRUPPGM` (défaut `QSTRUP` de `QSYS`) ; il démarre les autres sous-systèmes et les imprimantes. On peut le remplacer par une copie (effet au démarrage suivant, valeur modifiable par un responsable sécurité).
- **Parties d'un `*SBSD`** : attributs et pools (`CHGSBSD`), postes écrans (`ADDWSE`), postes files d'attente (`ADDJOBQE`), autostart (`ADDAJE`), prédémarrés (`ADDPJE`), routage (`ADDRTGE`). Affichage : `DSPSBSD`. Sans poste pour un type de travail, le sous-système ne peut pas l'exécuter.
- **Routage** : les données de routage du travail sont comparées dans l'ordre aux postes de routage ; le premier qui correspond donne programme, classe et pool ; aucun = le travail s'arrête. Une session utilise `QDFTJOBD` dont les données de routage valent `QCMDI`.
- **Commandes** : `STRSBS SBSD(...)`, `ENDSBS SBS(...)` (ex. `ENDSBS QINTER` arrête les sessions sans arrêter le batch), `WRKSBS`, `WRKACTJOB`.

**Files d'attente de travaux et descriptions de travail** ([job-i JOBQ / JOBD](https://job-i.fr/jobq-jobd-ibm-i), *vérifié, partie lue*)
- **JOBQ (`*JOBQ`)** : salle d'attente d'un sous-système. **Ordre de sortie** : disponibilité (prêts avant planifiés, puis suspendus), **priorité** de 0 à 9 (0 d'abord ; `SBMJOB` accepte 1 à 9), puis heure d'arrivée. Le sous-système prend des travaux jusqu'à `MAXACT` pour cette file ; **une file n'alimente qu'un seul sous-système actif à la fois**, un sous-système peut lire plusieurs files (ordre du numéro de séquence). Sur `QGPL/QBATCH`, un seul travail à la fois sur le système de démonstration : on augmente par `CHGJOBQE` ou on soumet dans une autre file.
- **Pourquoi un travail reste en file** : file non rattachée à un sous-système actif (`STRSBS` / `ADDJOBQE`), file suspendue (`RLSJOBQ`), travail suspendu (`HOLD(*YES)` ou `HLDJOB`, libérer par `RLSJOB`), `MAXACT` atteint (attendre, `CHGJOBQE` ou `CHGJOB JOBQ`), travail planifié (`SCDDATE` / `SCDTIME`). Commencer par `WRKSBMJOB` ou `WRKJOBQ`.
- **JOBD (`*JOBD`)** : modèle d'attributs partagé : `USER`, `JOBQ`, `JOBPTY`, `OUTQ`, `LOG` (niveau 0 à 4, gravité, texte), `RTGDTA` (défaut `QCMDI`), `RQSDTA`, `INLLIBL` (partie utilisateur de la liste de bibliothèques), `INQMSGRPY` (`*RQD` = attendre une réponse). Créée par `CRTJOBD`, affichée par `DSPJOBD`. Utilisée par les sessions interactives (celle du poste écran ou du profil), les batch (paramètre `JOBD` de `SBMJOB`, sinon celle du profil) et les travaux autostart / prédémarrés (celle de leur poste).
- **Piège** : `SBMJOB` ne reprend pas tout de la JOBD : chaque paramètre de `SBMJOB` a sa propre valeur par défaut, plusieurs cherchent la valeur ailleurs (vérifier avec F4 puis F10).

**Planifier un travail** ([job-i](https://job-i.fr/planification-travaux-ibm-i), *vérifié, partie lue*)
- Les entrées du **planning** (`ADDJOBSCDE`, `WRKJOBSCDE`) sont rangées dans un seul objet `QDFTJOBSCD` (`*JOBSCD`, `QUSRSYS`), sauvegardé avec `QUSRSYS` ; le moteur est le travail système `QJOBSCD`, qui soumet le travail dans une file comme un `SBMJOB`.
- Paramètres obligatoires : `JOB`, `CMD`, `FRQ` (`*ONCE`, `*WEEKLY`, `*MONTHLY`, `*YEARLY`). Autres : `SCDDATE`, `SCDDAY` (`*MON`…`*ALL`), `SCDTIME`, `RELDAYMON` (1re à 5e occurrence ou `*LAST`), `OMITDATE` (20 dates à sauter), `RCYACN`, `SAVE`, `JOBD`, `JOBQ`, `USER`, `MSGQ`.
- Exemples : tous les jours à 3 h 30 : `FRQ(*WEEKLY) SCDDAY(*ALL) SCDTIME('03:30:00')` (il n'y a pas de fréquence quotidienne) ; dernier jour du mois : `FRQ(*MONTHLY) SCDDATE(*MONTHEND)` (un 31 n'est pas soumis les mois de 30 jours).
- Droits : `*USE` sur la commande, la JOBD, la file et le profil de `USER`.

**Travail batch bloqué** ([job-i](https://job-i.fr/travail-batch-bloque-ibm-i), *vérifié, partie lue*) : un batch qui lit un enregistrement pour le modifier et le trouve tenu par un autre travail passe en **`LCKW`** pendant le délai `WAITRCD` du fichier (120 s dans l'exemple), puis le programme RPG s'arrête sur le message **RNQ1218** et le travail reste en **`MSGW`** jusqu'à la réponse d'un opérateur ; une réponse `R` (nouvelle tentative) a repris la chaîne sans perte ni doublon dans l'exemple.

### La gestion des impressions

([job-i OUTQ](https://job-i.fr/outq-ibm-i), *vérifié, partie lue* ; fiche 08 pour les fichiers imprimante)
- **Spool** : impression gardée sur disque quand le fichier imprimante demande `SPOOL(*YES)`. Il est imprimable selon `SCHEDULE` (`*FILEEND` défaut, `*JOBEND`, `*IMMED`) et **survit au travail** qui l'a créé.
- **Quelle OUTQ ?** Le fichier imprimante vaut le plus souvent `OUTQ(*JOB)` : la file du travail décide (profil, JOBD, écran, valeur système `QPRTDEV`, paramètre `OUTQ` de `SBMJOB`). **Si la file n'existe pas, le spool part dans `QGPL/QPRINT`** (message CPD4090) : premier endroit où chercher une impression « disparue » (`WRKOUTQ QGPL/QPRINT`, `WRKSPLF`).
- **`WRKOUTQ`** : options 5 (afficher), 3 (suspendre), 6 (libérer), 4 (supprimer), 2 (changer priorité, copies, file). Ordre de sortie : priorité du spool 1 à 9 (1 d'abord), puis `SEQ` (`*FIFO` ou `*JOBNBR`).
- **Droits par défaut d'une file de sortie** : public `*USE`, `DSPDTA(*NO)` (on ne lit pas les spools des autres), `AUTCHK(*OWNER)`, `OPRCTL(*YES)` (le droit spécial `*JOBCTL` permet de suspendre, libérer, supprimer).
- **Imprimantes et éditeurs** : un **éditeur** (writer, type `WTR`) tourne dans `QSPL`, lit une file et envoie chaque spool `RDY` à l'imprimante ; `STRPRTWTR`, `STRRMTWTR` (vers un autre système), `WRKWTR`, `ENDWTR` ; `AUTOEND` : attendre ou s'arrêter quand la file est vide. Sans éditeur, les spools restent en file.
- **En SQL** : service `QSYS2.OUTPUT_QUEUE_ENTRIES_BASIC` (colonnes `SPOOLED_FILE_NAME`, `JOB_NAME`, `STATUS`, `TOTAL_PAGES`…).
- Créer et surcharger un fichier imprimante : `CRTPRTF`, `OVRPRTF` ([fiche 08](../cheatsheets/08-impression-et-printer-ibm-i.md)), état à cycle : [Impression en RPG](../IMPRESSION-RPG.md).

### Les profils utilisateurs, la sécurité et les droits

**Profils** ([job-i](https://job-i.fr/profils-utilisateurs-ibm-i), *vérifié, partie lue*)
- Un **profil** (`*USRPRF`, dans `QSYS`) est l'objet qui représente un utilisateur : sécurité (connexion, mot de passe, droits spéciaux, audit), personnalisation (bibliothèque, menu, JOBD, file de sortie), gestion (objets possédés, droits privés), identification (son nom figure dans le nom des travaux et les spools). Chaque travail tourne sous un profil. Un **profil de groupe** est un profil qui partage ses droits (jusqu'à 16 groupes par utilisateur : `GRPPRF` + 15 `SUPGRPPRF`).
- **Création** : `CRTUSRPRF` (droit spécial `*SECADM`) ; modification `CHGUSRPRF`, liste `WRKUSRPRF`.

| Paramètre | Défaut | Rôle |
|---|---|---|
| `PASSWORD` | `*NONE` (depuis 7.5) | sans mot de passe, pas d'ouverture de session ; on peut tout de même soumettre un travail sous ce profil avec le droit `*USE` |
| `PWDEXP` | `*NO` | `*YES` force un nouveau mot de passe à la connexion suivante |
| `STATUS` | `*ENABLED` | `*DISABLED` interdit la session sans supprimer le profil |
| `USRCLS` | `*USER` | classe : menus et droits spéciaux par défaut |
| `CURLIB` | `*CRTDFT` (`QGPL`) | bibliothèque où vont les objets créés sans bibliothèque |
| `INLPGM` / `INLMNU` | `*NONE` / `MAIN` | programme et menu initiaux (`*SIGNOFF` ferme la session) |
| `LMTCPB` | `*NO` | limite la ligne de commande |
| `SPCAUT` | `*USRCLS` | droits spéciaux (selon la classe, ou liste) |
| `JOBD` | `QDFTJOBD` | attributs des travaux du profil, liste de bibliothèques |
| `MSGQ` / `OUTQ` | `*USRPRF` / `*WRKSTN` | file de messages (créée dans `QUSRSYS`) et file de sortie |
| `PTYLMT` | 3 | priorité maximale en soumission |
| `AUT` | `*EXCLUDE` | droit public sur le profil lui-même |

- **Mot de passe** : valeur système `QPWDLVL` (niveau 0 ou 1 : 10 caractères au plus ; niveaux 2 à 4 : jusqu'à 128, sensible à la casse). Oubli : `CHGUSRPRF … PASSWORD(…) PWDEXP(*YES)`.

**Sécurité du système** ([job-i](https://job-i.fr/securite-ibm-i), *vérifié, partie lue*)
- **`QSECURITY`** : 10 et 20 ne peuvent plus être choisis (au 20, tous ont `*ALLOBJ`) ; **30** vérifie les droits mais sans protection de l'intégrité ; **40** protège le système contre les utilisateurs (niveau livré, conseillé par job-i) ; **50** protection renforcée, difficile à mettre en place (contrôles non testables à l'avance, `QALWUSRDMN`, `QTEMP` d'un autre travail inaccessible, recompilations). Le changement prend effet à l'**IPL** suivant ; IBM conseille d'auditer d'abord (`*AUTFAIL`, `*PGMFAIL`) : `CHGSYSVAL SYSVAL(QSECURITY) VALUE('40')` puis `PWRDWNSYS OPTION(*IMMED) RESTART(*YES)`.
- **`PRTSYSSECA`** imprime les valeurs système de sécurité avec la valeur recommandée (43 valeurs conseillées sur 7.5). Exemples : `QALWOBJRST`, `QVFYOBJRST`, `QFRCCVNRST`, `QALWUSRDMN`, `QPWDLVL`, `QPWDRULES` (15 caractères au moins).
- **Droits spéciaux et classes** : la classe d'utilisateur (`USRCLS`) et les droits spéciaux (`SPCAUT`) donnent des pouvoirs sur tout le système (tout lire `*ALLOBJ`, gérer les profils `*SECADM`, piloter les travaux `*JOBCTL`, sauvegarder…) ([job-i](https://job-i.fr/droits-speciaux-ibm-i), *résumé de la page, non lue en détail*).
- **Listes d'autorisation et droits adoptés** : une `*AUTL` applique un même jeu de droits à plusieurs objets ; l'adoption (`USRPRF(*OWNER)`) prête les droits du propriétaire le temps de l'exécution ([job-i](https://job-i.fr/listes-autorisation-ibm-i), *résumé, non lu en détail*).

**Droits sur les objets** ([job-i](https://job-i.fr/droits-objets-ibm-i), *vérifié, partie lue*)
- Qui a un droit : le **propriétaire** (`*ALL` par défaut), les **droits privés** (profil ou groupe), le **public** (`*PUBLIC`, éventuellement `*EXCLUDE`), le **groupe principal** (droit stocké dans l'objet).

| Droit | Contenu |
|---|---|
| `*USE` | lire et exécuter (`*OBJOPR`, `*READ`, `*EXECUTE`) |
| `*CHANGE` | `*USE` + ajouter, modifier, supprimer le **contenu** (pas l'objet : manque `*OBJEXIST`) |
| `*ALL` | tout, y compris supprimer, déplacer, renommer l'objet et gérer ses droits |
| `*EXCLUDE` | aucun accès : ce n'est pas l'absence de droit (sans droit propre on reçoit le public ; avec `*EXCLUDE`, la vérification s'arrête sur un refus) |

- **Onze droits élémentaires** : sur l'objet (`*OBJOPR`, `*OBJMGT`, `*OBJEXIST`, `*OBJALTER`, `*OBJREF`, `*AUTLMGT`) et sur les données (`*READ`, `*ADD`, `*UPD`, `*DLT`, `*EXECUTE`). Les fichiers ont aussi des droits par zone (SQL `GRANT` / `REVOKE`) ; l'IFS utilise `*RWX`, `*RW`, `*RX`, `*R`… (`WRKAUT`, `CHGAUT`).
- **Ordre** : le système vérifie d'abord la **bibliothèque**, puis l'objet, et s'arrête au premier droit trouvé ; `*USE` sur la bibliothèque suffit pour la plupart des opérations, **créer** un objet demande `*ADD`. Un objet public `*ALL` dans une bibliothèque `*EXCLUDE` reste inaccessible (CPF1022). Sécurité « par bibliothèque » : fichiers confidentiels d'une application dans une bibliothèque en `*EXCLUDE`, droit donné seulement aux groupes concernés.
- **Commandes** : `DSPOBJAUT OBJ(...) OBJTYPE(...)` (F11 : détail), `GRTOBJAUT`, `RVKOBJAUT`, `CHKOBJ`, `WRKOBJOWN`, `CRTAUTL`.

**Droits sur l'IFS** ([job-i réseau et IFS](https://job-i.fr/securite-reseau-ifs-ibm-i), *résumé de la page, non lue en détail*) : fermer chaque répertoire au public dès sa création, car il hérite sinon des droits de son parent et la racine est livrée ouverte à tous ; commandes `WRKAUT`, `CHGAUT`, `WRKLNK`.

### La gestion des unités et des incidents

| Élément | Statut | Source |
|---|---|---|
| `WRKCFGSTS CFGTYPE(...)` : état de la configuration (unités, lignes, contrôleurs) | vérifié (fiche de commande) | [job-i WRKCFGSTS](https://job-i.fr/commandes-ibm-i/wrkcfgsts) |
| `VRYCFG CFGOBJ(...) CFGTYPE(...) STATUS(...)` : met en/hors fonction un objet de configuration et ses dépendants | vérifié | [job-i VRYCFG](https://job-i.fr/commandes-ibm-i/vrycfg) |
| `WRKDEVD` : gestion des descriptions d'unités (`*DEVD`, rangées dans `QSYS`) | vérifié | [job-i WRKDEVD](https://job-i.fr/commandes-ibm-i/wrkdevd) |
| `WRKPRB` : historique des incidents détectés par le système ou l'utilisateur ; `ANZPRB` : analyser, créer ou signaler un incident non détecté | vérifié | [WRKPRB](https://job-i.fr/commandes-ibm-i/wrkprb), [ANZPRB](https://job-i.fr/commandes-ibm-i/anzprb) |
| `DSPJOBLOG` : historique d'un travail (« boîte noire ») ; `DSPLOG` : historique du système (`QHST`) | vérifié | [DSPJOBLOG](https://job-i.fr/commandes-ibm-i/dspjoblog), [DSPLOG](https://job-i.fr/commandes-ibm-i/dsplog) |
| Méthode d'analyse d'un incident (messages, historique du travail, historique du système, état des unités) | **non vérifié** (démarche générale : à confirmer par la documentation) | — |
| Log de l'opérateur système (`QSYSOPR`) | **non vérifié** | — |

Pour un travail qui ne démarre pas ou reste bloqué : états `MSGW`, `LCKW`, causes listées dans « La gestion des travaux », puis `DSPJOBLOG` et `WRKJOBQ`.

### Les sauvegardes, les restaurations et l'IPL

**Commandes** (fiches job-i)

| Commande | Rôle | Syntaxe minimale |
|---|---|---|
| [`SAVLIB`](https://job-i.fr/commandes-ibm-i/savlib) | sauvegarde une ou plusieurs bibliothèques ; paramètres notables : `DEV`, `SAVF` (fichier sauvegarde), `SAVACT` (sauvegarde en mise à jour), `SPLFDTA`, `PVTAUT`, `ACCPTH`, `DTACPR`, `OMITLIB`, `OMITOBJ` | `SAVLIB LIB(...) DEV(...)` |
| [`SAVOBJ`](https://job-i.fr/commandes-ibm-i/savobj) | objets d'une même bibliothèque | `SAVOBJ OBJ(...) LIB(...) DEV(...)` |
| [`SAV`](https://job-i.fr/commandes-ibm-i/sav) | objets du système de fichiers intégré (IFS) | `SAV DEV(...)` |
| [`SAVSYS`](https://job-i.fr/commandes-ibm-i/savsys) | microcode sous licence + `QSYS`, au format permettant d'installer le système | `SAVSYS DEV(...)` |
| [`RSTLIB`](https://job-i.fr/commandes-ibm-i/rstlib) | restaure des bibliothèques sauvegardées par `SAVLIB` | `RSTLIB SAVLIB(...) DEV(...)` |
| [`RSTOBJ`](https://job-i.fr/commandes-ibm-i/rstobj) | restaure des objets (bande, optique ou fichier sauvegarde) | `RSTOBJ OBJ(...) SAVLIB(...) DEV(...)` |
| [`RST`](https://job-i.fr/commandes-ibm-i/rst) | restaure des objets de l'IFS | `RST DEV(...)` |
| [`CRTSAVF`](https://job-i.fr/commandes-ibm-i/crtsavf) | crée un **fichier sauvegarde** (`*SAVF`) | `CRTSAVF FILE(...)` |

**Supports** : bande ou volume optique (`DEV`, `VOL`, `SEQNBR`, `OPTFILE`) ou **fichier sauvegarde** (`SAVF`, `CRTSAVF`) ; `MEDDFN` pour une définition de support (paramètres des fiches de commande).

**Restaurer** : IBM, « Recovering your system » ([IBM i 7.5](https://www.ibm.com/docs/en/i/7.5.0?topic=recovery-recovering-your-system), *début de page lu, tronqué*) : sauvegarde complète par les options du menu `GO SAVE` ; **état restreint** (aucun sous-système actif hors celui de contrôle) pour de nombreuses procédures ; restauration des objets liés dans le bon ordre (MQT, LF, vues SQL) ; `RCLSTG` pour récupérer l'adressabilité d'objets perdus ou endommagés ; `RCLLNK` pour les liens de l'IFS ; contrôle de la restauration des objets sensibles par les valeurs système `QALWOBJRST` et `QVFYOBJRST` ; vérification par l'historique du travail ou un fichier de sortie ; **un IPL normal en fin de récupération, avant de rendre le système aux utilisateurs**.

**Principe de l'IPL** (job-i, *vérifié, partie lue*) : l'IPL démarre le système ; il lance le sous-système de contrôle (`QCTLSBSD`) puis le programme de démarrage (`QSTRUPPGM`) qui démarre les autres sous-systèmes (voir « sous-systèmes »). Les PTF s'installent par groupes depuis Fix Central ([job-i](https://job-i.fr/installer-ptf-ibm-i)) et **la plupart s'activent par un IPL sur le côté B** ; `INSPTF` charge et applique les PTF de plusieurs produits ; `PWRDWNSYS OPTION(*IMMED) RESTART(*YES)` arrête et redémarre le système ([`PWRDWNSYS`](https://job-i.fr/commandes-ibm-i/pwrdwnsys)). Les types d'IPL, le rôle du côté A / B et la valeur système `QIPLTYPE` : à compléter (**non vérifié**).

**À compléter** : stratégie de sauvegarde (quoi, quand, combien), procédure `GO SAVE`, journalisation et sauvegarde, BRMS (`WRKMEDIBRM` introuvable sur job-i).

## Plan détaillé (index des sujets)

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
