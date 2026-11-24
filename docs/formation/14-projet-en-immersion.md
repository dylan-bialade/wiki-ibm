# Partie 14 : Projet en immersion

> Plan de formation, partie 14 sur 14 (**partie rédigée** : feuille de route d'intégration, sans énoncé source). Projet intégrant IBM i, DB2, CL, SQL, RPG, IA, PHL Web et Web Services.
>
> **Mots-clés** : projet, immersion, IBM i, DB2, CL, SQL, RPG, IA, web services.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Cours détaillé](#cours-détaillé)
  - [1. Ce que les énoncés du wiki montrent d'un projet d'intégration](#1-ce-que-les-énoncés-du-wiki-montrent-dun-projet-dintégration)
  - [2. Carte d'intégration : quelle partie sert à quoi](#2-carte-dintégration--quelle-partie-sert-à-quoi)
  - [3. Feuille de route proposée (hypothèse de méthode)](#3-feuille-de-route-proposée-hypothèse-de-méthode)
  - [4. Utiliser l'IA dans un projet (règles du dépôt)](#4-utiliser-lia-dans-un-projet-règles-du-dépôt)
  - [5. Check-list avant livraison (hypothèse, à compléter avec l'énoncé)](#5-check-list-avant-livraison-hypothèse-à-compléter-avec-lénoncé)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Projet](#projet)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Énoncés de TP et analyse](../enonces/README.md)
- [Exemples réels (BONBON REST, état à cycle, pesées)](../ILE-ET-SERVICES-WEB.md)
- [Sommaire de la formation](README.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## Cours détaillé

> **Limite importante** : le plan de formation ne donne **aucun énoncé** pour le projet en immersion : seulement « projet intégrant IBM i, DB2, CL, SQL, RPG, IA, PHL Web et Web Services ». Cette partie ne peut donc pas être un cours sourcé comme les autres : c'est une **feuille de route d'intégration** construite à partir de ce que le wiki sait déjà (parties 01 à 13, énoncés de TP anonymisés). Tout ce qui est **proposition de méthode ou d'architecture est une hypothèse** à adapter à l'énoncé réel. **« PHL Web » n'est identifié nulle part** (aucun résultat dans le wiki ni sur job-i ; la recherche `job-i.fr/aller?q=PHL` renvoie la page de recherche générique) : à demander au formateur. Les énoncés de TP du wiki sont des résumés anonymisés ; **les épreuves interdisent l'IA pendant l'épreuve** : si le projet est évalué, vérifier ce qui est autorisé avant d'utiliser l'assistant.

### 1. Ce que les énoncés du wiki montrent d'un projet d'intégration

Trois énoncés du wiki s'en rapprochent, chacun avec sa **démarche** et ses **livrables** (résumés vérifiés dans le wiki) :

| Énoncé | Ce qu'il intègre | Démarche / livrables retenus |
|---|---|---|
| [examen-kebab](../enonces/examen-kebab.md) (7 h, 100 points) | environnement (bibliothèque, profil, `JOBD`, sous-système), fichiers source, DDS (PF/LF), CL (liste d'objets, écran), SQL (jointure externe, `GROUP BY`), RPG III | livrables : **sauvegarde (SAVF) de la bibliothèque** et la requête SQL ; barème par partie (environnement 15, CL 20, RPG 50…) |
| [tp-le-chai](../enonces/tp-le-chai.md) | SQL embarqué en RPG ILE full free : curseurs, `SQLCODE`/`SQLSTATE`, contrôle de validation (« tout ou rien » par lot), registres, alertes, ligne de bilan | tables partagées par un groupe (qualifiées), script `INIT` par `RUNSQLSTM` **avant chaque campagne de tests** (prévenir le groupe), programmes de contrôle fournis compilés |
| [tp-the-big-one](../enonces/tp-the-big-one.md) | reprise d'un héritage RPG III, `DTAARA`, `CL`, modernisation en RPG IV, travail **en équipes** avec revue croisée | rôles par membre, bibliothèque de référence en lecture seule, un seul membre à la fois par source, journal de bord, commentaire daté |

À ces énoncés s'ajoutent [tp-logistock](../enonces/tp-logistock.md) (sous-fichier + CRUD + fenêtre), [tp-livres](../enonces/tp-livres.md) et les exemples réels du dépôt (BONBON REST, état à cycle, pesées).

| Élément | Statut | Source |
|---|---|---|
| Contenu et livrables des énoncés ci-dessus | vérifié (résumés du wiki) | [enonces/README](../enonces/README.md) |
| Énoncé du projet en immersion | **inexistant dans le wiki** | à obtenir du formateur |
| « PHL Web » | **non identifié** | à demander |

### 2. Carte d'intégration : quelle partie sert à quoi

| Domaine du projet | Ce qu'on y fait | Partie du wiki (sourcée) |
|---|---|---|
| **IBM i** | bibliothèque, profil, listes de bibliothèques, `JOBD`, files, sauvegarde `SAVLIB`/`SAVF` | [01](01-organisation-ibm-i.md#cours-détaillé) |
| **DB2** | tables SQL (contraintes), index/vues, journalisation | [02](02-db2-for-i.md#cours-détaillé) |
| **Outils** | SEU/PDM, DSPF/PRTF, Code for IBM i, RDi | [03](03-outils-de-developpement.md#cours-détaillé) |
| **CL** | programmes de lancement, fichiers (`OVRDBF`), paramètres, zones de données | [04](04-langage-de-controle-cl.md#cours-détaillé) |
| **SQL** | requêtes, `INSERT`/`UPDATE`/`MERGE`, vues, triggers, services `QSYS2` | [05](05-sql.md#cours-détaillé) |
| **RPG** | RPG IV / full free, procédures, `MONITOR`, impression | [07](07-rpg-iv.md#cours-détaillé) · [08](08-rpg-free.md#cours-détaillé) (et [06](06-rpg-iii.md#cours-détaillé) pour l'existant) |
| **SQL embarqué** | curseurs, diagnostics, transactions | [09](09-sql-embarque.md#cours-détaillé) |
| **ILE** | modules, programmes de service, répertoire de liage, débogage | [10](10-ile.md#cours-détaillé) |
| **Modernisation / maintenance** | lecture, correctifs, tests | [11](11-modernisation-et-maintenance.md#cours-détaillé) |
| **IA** | usage cadré (anonymisation, vérification, statuts) | [12](12-ia-et-assistants.md#cours-détaillé) |
| **Web services** | JSON SQL, fonctions HTTP, IWS, IFS | [13](13-web-services-et-api.md#cours-détaillé) |

Chaque ligne renvoie à une partie dont le contenu est **sourcé et marqué vérifié / non vérifié** : consulter aussi la rubrique « Ce qui reste à vérifier » de chaque partie avant de construire dessus.

### 3. Feuille de route proposée (hypothèse de méthode)

*Aucune source ne l'impose : c'est un enchaînement logique des briques ci-dessus.*

1. **Cadrer** : lire l'énoncé, lister les **exigences** et le **format de livraison** (SAVF ? code ? démonstration ?), identifier les inconnues (dont « PHL Web »), convenir des rôles si c'est un travail d'équipe.
2. **Environnement** (partie 01) : une bibliothèque par équipe, une bibliothèque de référence en lecture seule, profil et `JOBD` dédiés si demandé, fichiers source (`QRPGLESRC` en 112 si du libre, `QDDSSRC`, `QCLSRC`).
3. **Données** (parties 02 et 05) : tables SQL avec clés et contraintes, jeu d'essai et **script d'initialisation rejouable** (modèle : `INIT` du *Chai*) ; journalisation si on veut annuler ou rejouer.
4. **Métier** (parties 07 à 10) : procédures dans des modules `NOMAIN` regroupés en programme(s) de service, prototypes en `/COPY`, un groupe d'activation nommé, source de liage versionné ; SQL embarqué pour les traitements ensemblistes ou par lot.
5. **Interfaces** : écrans (DSPF) et états (PRTF) si l'énoncé le demande (partie 03) ; services web et JSON (partie 13) pour l'ouverture vers l'extérieur.
6. **Lancement et exploitation** : programmes CL de lancement, files, sous-système si demandé (partie 01/04).
7. **Tester** (parties 06, 10, 11) : cas de test **écrits avant**, un CL ou un script de test, débogueur sur **copie des données** (`UPDPROD(*NO)` bloque la mise à jour de la production).
8. **Livrer** : sauvegarde de la bibliothèque dans un fichier de sauvegarde (voir ci-dessous), documentation courte (objets, ordre de création, jeu d'essai, limites connues).
9. **Revoir** : revue croisée (modèle *The Big One* : un autre membre relit avec une grille ; recherche dans les sources par `FNDSTRPDM`).

**Sauvegarde de livraison** (commandes existantes sur job-i, aides IBM i 7.5, début) : `CRTSAVF FILE(biblio/FICHIER)` crée un fichier sauvegarde (paramètres `FILE`, `TEXT`, `MAXRCDS`, `ASP`, `AUT`…) ; `SAVLIB LIB(…) DEV(*SAVF) SAVF(…)` sauvegarde une bibliothèque (paramètres `LIB`, `DEV`, `SAVF`, `TGTRLS`, `CLEAR`…) ; `RSTLIB` la restaure. Le choix `DEV(*SAVF)` est l'usage courant mais la valeur n'est **pas** relevée dans les pages lues (seul le paramètre `SAVF` l'est) : à vérifier dans l'invite F4.

| Élément | Statut | Source |
|---|---|---|
| Démarches d'équipe, rôles, journal de bord, environnement | vérifié (énoncé du wiki) | [tp-the-big-one](../enonces/tp-the-big-one.md) |
| Script d'initialisation rejouable, tables partagées qualifiées | vérifié (énoncé du wiki) | [tp-le-chai](../enonces/tp-le-chai.md) |
| `CRTSAVF`, `SAVLIB`, `RSTLIB` : existence et paramètres | vérifié (début des aides) | [CRTSAVF](https://job-i.fr/commandes-ibm-i/crtsavf) · [SAVLIB](https://job-i.fr/commandes-ibm-i/savlib) · [RSTLIB](https://job-i.fr/commandes-ibm-i/rstlib) |
| `DEV(*SAVF)` pour SAVLIB | **non vérifié** (valeur non lue) | à contrôler (F4) |
| Feuille de route en 9 étapes, découpage, ordre | **hypothèse** | — |

### 4. Utiliser l'IA dans un projet (règles du dépôt)

- **Cadre** ([partie 12](12-ia-et-assistants.md#cours-détaillé)) : anonymiser (`BIBnn`) ; aucun secret, nom réel de bibliothèque, personne ou organisme dans un prompt ; fournir le contexte (version IBM i, objets existants) et exiger le format de livraison **code + hypothèses + tableau `Élément | Statut | Source` + commande de création + cas de test** ([CLAUDE.md](../../CLAUDE.md), section 0).
- **Vérifier** chaque instruction, mot-clé de fichier, commande et message avant de s'en servir : wiki, puis job-i, puis ibm.com ; **compiler et tester toi-même** (l'assistant ne compile rien) ; confirmer au wiki ce qui est validé, pour que ce soit **remonté** ([CLAUDE.md](../../CLAUDE.md), section 8).
- **Épreuve ou évaluation** : l'aide d'une IA est interdite pendant les épreuves ; pour un projet noté, **demander les règles** avant.

| Élément | Statut | Source |
|---|---|---|
| Règles d'usage de l'assistant dans ce dépôt | vérifié (règles du dépôt) | [CLAUDE.md](../../CLAUDE.md) · [ASSISTANT-ET-AUTOMATISATION](../ASSISTANT-ET-AUTOMATISATION.md) |
| Règles d'usage de l'IA pour le projet noté | **inconnues** | à demander au formateur |

### 5. Check-list avant livraison (hypothèse, à compléter avec l'énoncé)

- [ ] Tous les objets se recréent depuis les sources, **dans un ordre documenté** (PF, LF, écrans, modules, programmes de service, programmes) ; exemple de référence : BONBON ([ILE-ET-SERVICES-WEB](../ILE-ET-SERVICES-WEB.md#exemple-complet--liste-de-bonbons-en-json-exposée-en-service-rest)).
- [ ] Les tests passent sur un **jeu d'essai rejouable** ; l'état final est connu.
- [ ] Les erreurs sont gérées (`MONITOR`, `SQLCODE`/`GET DIAGNOSTICS`, messages) et les transactions « tout ou rien » là où l'énoncé le demande.
- [ ] Les droits et la liste de bibliothèques sont documentés ; aucun secret dans les sources.
- [ ] Une sauvegarde de livraison existe et a été **restaurée à blanc** dans une bibliothèque d'essai pour vérifier qu'elle est lisible.
- [ ] Chaque point **non vérifié** ou **non testé** est listé comme tel dans la documentation.

### Ce qui reste à vérifier pour cette partie

Énoncé réel du projet, critères de notation, livrables, règles sur l'IA ; signification de **« PHL Web »** ; valeur `DEV(*SAVF)` de `SAVLIB` ; toutes les limites listées dans les parties 01 à 13. Manques à signaler : aucune page du wiki ni job-i sur la conduite d'un projet, aucun énoncé du projet en immersion.

## Plan détaillé (index des sujets)

### Projet

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Réalisation d'un projet en immersion, intégrant l'ensemble des notions vues durant les semaines précédentes (IBM i, DB2, CL, SQL, RPG, IA, PHL Web, Web Services)

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).
