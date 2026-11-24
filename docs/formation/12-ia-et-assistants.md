# Partie 12 : Intelligence artificielle et assistants de développement

> Plan de formation, partie 12 sur 14 (**partie rédigée** : cours détaillé ci-dessous). Concepts de l'IA, LLM et tokens, prompting, modes d'utilisation, assistant BOB, cadre d'usage (confidentialité, RGPD), mise en situation IBM i.
>
> **Mots-clés** : IA, LLM, token, contexte, hallucination, température, prompt engineering, fine-tuning, RAG, agents, workflows, BOB, RGPD, anonymisation.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (définitions générales, non sourcées)](#lessentiel-définitions-générales-non-sourcées)
- [Cours détaillé](#cours-détaillé)
  - [1. Les concepts fondamentaux](#1-les-concepts-fondamentaux)
  - [2. Le prompting](#2-le-prompting)
  - [3. Les modes d'utilisation](#3-les-modes-dutilisation)
  - [4. Cadre d'usage : confidentialité, RGPD, responsabilité](#4-cadre-dusage--confidentialité-rgpd-responsabilité)
  - [5. Mise en situation sur un cas IBM i](#5-mise-en-situation-sur-un-cas-ibm-i)
  - [Ce qui reste à vérifier pour cette partie](#ce-qui-reste-à-vérifier-pour-cette-partie)
- [Plan détaillé (index des sujets)](#plan-détaillé-index-des-sujets)
  - [Les concepts fondamentaux](#les-concepts-fondamentaux)
  - [Le prompting](#le-prompting)
  - [Les modes d'utilisation](#les-modes-dutilisation)
  - [Cadre d'usage et responsabilité](#cadre-dusage-et-responsabilité)
  - [Mise en situation](#mise-en-situation)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Assistant, tests et automatisation du wiki](../ASSISTANT-ET-AUTOMATISATION.md)
- [Prompt système du projet](../PROMPT-SYSTEME.md)
- [Règles du dépôt (CLAUDE.md)](../../CLAUDE.md)
- [Cours détaillé de cette partie (synthèses sourcées)](#cours-détaillé)

## L'essentiel (définitions générales, non sourcées)

> Cette partie ne vient pas de la documentation IBM i : les définitions ci-dessous sont des **connaissances générales** à sourcer avant de les citer. Les règles d'usage appliquées dans ce dépôt sont, elles, vérifiées (voir « Où trouver quoi »).

- **Token** : unité de texte traitée par un modèle ; la **fenêtre de contexte** est le nombre maximal de tokens (entrée + sortie) qu'un modèle peut considérer à la fois. Un document plus long doit être lu par morceaux ou résumé.
- **Hallucination** : réponse plausible mais fausse ; d'où la règle du dépôt : toute commande, syntaxe ou message doit être vérifié (wiki, job-i.fr, puis ibm.com) et chaque élément porte un statut vérifié / non vérifié / hypothèse.
- **Température** : paramètre qui règle la part d'aléatoire de la génération (bas = plus déterministe).
- **Prompt engineering** : formuler le contexte, la tâche, le format attendu et les contraintes ; voir les prompts de test du dépôt (grille de réussite).
- **RAG** (génération augmentée par recherche) : fournir au modèle des extraits d'une base de connaissances au moment de la question ; c'est le rôle de `llms.txt`, `llms-full.txt` et des sommaires de ce dépôt.
- **Fine-tuning** : réentraîner un modèle sur des données spécifiques ; différent du RAG, qui n'altère pas le modèle.
- **Confidentialité** : ne jamais envoyer à un service externe de noms réels de bibliothèques, de profils, de personnes, de secrets ni de données personnelles (RGPD) ; anonymiser (`BIBnn`) avant tout partage.
- **Assistant BOB** : non documenté dans ce dépôt (aucune source lue).
## Cours détaillé

> Cette partie ne relève pas de la documentation IBM i. Sources lues pour la compléter : le **glossaire**, la page **context windows** et la page **prompt engineering** de la documentation Claude (pages lues en partie, **éditeur d'un modèle précis : à ne pas généraliser à tous les modèles**), la page produit **IBM Bob** (bob.ibm.com, début de page), la page « Intelligence artificielle » de la **CNIL** (page d'accueil thématique), et le wiki ([ASSISTANT-ET-AUTOMATISATION](../ASSISTANT-ET-AUTOMATISATION.md), [CLAUDE.md](../../CLAUDE.md)). Les anciennes définitions « non sourcées » de cette page sont remplacées ci-dessous par des définitions sourcées quand c'est possible ; le reste reste **non vérifié**. Aucun prompt n'a été testé par l'assistant sur d'autres outils.

### 1. Les concepts fondamentaux

| Terme | Définition (synthèse de la documentation citée) |
|---|---|
| **LLM** | modèle de langage « avec de nombreux paramètres », entraîné sur de grandes quantités de texte, capable de générer du texte, répondre à des questions, résumer ; l'assistant évoqué est lui-même un LLM affiné (*fine-tuned*) et entraîné par RLHF |
| **Pré-entraînement** | entraînement initial sur un grand corpus non étiqueté, pour prédire le mot suivant ; un modèle seulement pré-entraîné ne suit pas bien les instructions |
| **Fine-tuning** | poursuivre l'entraînement d'un modèle pré-entraîné avec des données supplémentaires pour qu'il reproduise leurs motifs ; utile pour adapter à un domaine, une tâche ou un style, mais demande un jeu de données soigné (risque sur les performances et les biais) |
| **RLHF** | apprentissage par renforcement à partir de retours humains (classement de textes) pour rapprocher le comportement du modèle des préférences humaines |
| **Fenêtre de contexte** | tout le texte que le modèle peut consulter pour générer une réponse, **réponse comprise** ; c'est une « mémoire de travail », distincte du corpus d'entraînement ; comptent dans la fenêtre : prompt système, tous les messages (outils, images, documents compris), définitions d'outils et sortie du modèle |
| **Context rot** | plus le nombre de tokens grandit, plus la précision et le rappel se dégradent : **curer ce qui est dans le contexte** compte autant que sa taille |
| **Token** | plus petite unité traitée par le modèle (mot, sous-mot, caractère, octet) ; le nombre de caractères par token dépend du modèle et de la langue (la doc cite environ 3,5 caractères anglais par token pour des modèles anciens, ~30 % de tokens en plus avec un tokenizer plus récent) ; pour un compte exact, utiliser le comptage de tokens du modèle utilisé |
| **Température** | paramètre qui règle le hasard des prédictions : haute = sorties plus variées/créatives, basse = plus conservatrices et déterministes ; **même à 0, les résultats ne sont pas totalement déterministes** (appels identiques, sorties possiblement différentes) |
| **RAG** | génération augmentée par recherche : une base de connaissances externe est interrogée à l'exécution et les extraits sont passés dans la fenêtre de contexte avec la question ; utile pour l'actualité, un domaine, la citation de sources ; l'efficacité dépend de la qualité de la base et de la recherche |
| **MCP** | protocole ouvert qui standardise la façon de fournir du contexte (données, outils) à des applications d'IA |
| **Hallucination** | la doc cite l'idée d'une IA « honnête » qui ne ment pas ni n'invente (*not hallucinate or confabulate*) et reconnaît ses limites ; définition formelle de « hallucination » : **non lue** (usage : réponse plausible mais fausse, constat général) |
| **Les trois ères de l'IA** | **aucune source lue** |

**Application au wiki** : `llms.txt`, `llms-full.txt` (~260 Ko) et les sommaires jouent le rôle de **RAG manuel** : le modèle lit un extrait pertinent plutôt que tout le dépôt ; et comme la fenêtre est limitée, la règle du dépôt impose de **lire par morceaux ou chercher par mot-clé** plutôt que de répondre sur une lecture partielle ([CLAUDE.md, 0 bis](../../CLAUDE.md)).

| Élément | Statut | Source |
|---|---|---|
| LLM, pré-entraînement, fine-tuning, RLHF, RAG, MCP, token, température, fenêtre de contexte | vérifié (glossaire lu en grande partie) ; **source = un éditeur de modèle, pas une norme** | [Glossaire (Claude Platform Docs)](https://platform.claude.com/docs/en/about-claude/glossary) |
| Fenêtre de contexte : contenu, réponse comprise, context rot | vérifié (début de page) | [Context windows](https://platform.claude.com/docs/en/build-with-claude/context-windows) |
| Taille des fenêtres, nombre de caractères par token (valeurs chiffrées) | **spécifique à un modèle et daté** : à ne pas retenir comme règle | pages ci-dessus |
| Hallucination (définition), trois ères de l'IA, histoire de l'IA | **non vérifié** | à sourcer |

### 2. Le prompting

Ce que la documentation citée établit : avant de retoucher un prompt, il faut (1) une **définition claire des critères de réussite**, (2) des **moyens de tester** empiriquement ces critères, (3) un **premier brouillon**. Le prompt engineering ne résout pas tout : certains critères (latence, coût) se règlent plus simplement en changeant de modèle. Les techniques (clarté, exemples, structuration par balises XML, rôle, réflexion, enchaînement de prompts) sont dans une page « Prompting best practices » (**non lue** ici).

**Application aux prompts du dépôt** (constats du wiki) : les 7 prompts de test de [ASSISTANT-ET-AUTOMATISATION, partie 2](../ASSISTANT-ET-AUTOMATISATION.md#partie-2--tester-que-lassistant-applique-les-règles) correspondent exactement à cette méthode : un critère par prompt (lecture complète + PRTCTL, information absente de job-i → ibm.com, prémisse fausse → contredire, cas non documenté → « non vérifié », anonymisation, remontée automatique, refus de remontée) et un **barème** pour juger. Un prompt complet de programmation IBM i, tel que le demande [CLAUDE.md, section 0](../../CLAUDE.md), contient : version cible (RPG III / IV / libre, IBM i 7.5 ou 7.6), type d'objet et bibliothèque, le besoin, le format de livraison (code + hypothèses + tableau `Élément | Statut | Source` + compilation/test).

| Élément | Statut | Source |
|---|---|---|
| Critères de réussite avant optimisation, tests empiriques, premier brouillon | vérifié (page lue) | [Prompt engineering overview](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview) |
| Techniques détaillées (balises, rôle, exemples, chaînage) | **non lu** | [Prompting best practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview) (lien depuis la page) |
| Prompts de test du dépôt et barème | vérifié (wiki) | [ASSISTANT-ET-AUTOMATISATION](../ASSISTANT-ET-AUTOMATISATION.md) |
| Format d'un prompt complet IBM i | vérifié (règle du dépôt) | [CLAUDE.md](../../CLAUDE.md) |

### 3. Les modes d'utilisation

- **Discussion** : un chat où l'on colle le contexte ; le wiki propose un **texte à coller une fois** (claude.ai, valable pour tous les chats), un **projet** claude.ai et **Claude Code** ([partie 1 de ASSISTANT-ET-AUTOMATISATION](../ASSISTANT-ET-AUTOMATISATION.md#partie-1--donner-le-wiki-à-nimporte-quel-chat-claude)). Dans ce dépôt, Claude Code lit `CLAUDE.md` et applique les règles (rigueur de lecture, tableau de statuts, remontée automatique).
- **Agents et workflows** : un agent agit sur son environnement (outils, fichiers, commandes) ; le wiki en a deux exemples vérifiés : l'**exécution quotidienne** (GitHub Actions) et la **remontée automatique** (`Report-ToWiki.ps1`) ([partie 3](../ASSISTANT-ET-AUTOMATISATION.md#partie-3--faire-tourner-le-wiki-depuis-nimporte-quel-appareil)). Définition générale d'« agent » et de « workflow » : non lue.
- **IBM Bob** (page produit IBM lue en partie) : « partenaire de développement » assisté par IA, **intégré à l'IDE** et utilisable en ligne de commande (*Bob Shell*, pour scripter et s'intégrer à une chaîne CI/CD) ; décrit : **agents et sous-agents** (chacun avec son contexte, ses outils et ses compétences, travaillant en parallèle), **« Literate Coding »** (expliquer en langage naturel, l'implémentation est générée en contexte), **suivi de l'impact** (« Bobalytics »), **packages premium** pour la modernisation d'entreprise, dont **mainframe et IBM i**, connexions à l'écosystème IBM (Red Hat, Instana). Un témoignage cité sur la page évoque l'aide à l'interprétation de **code RPG ancien** et à la documentation. **Prix, prérequis, versions IBM i et fonctionnement de ces packages : non lus.** Le plan de formation parle d'« assistant BOB » : l'**identification avec IBM Bob est probable mais non confirmée** par le formateur.

| Élément | Statut | Source |
|---|---|---|
| Modes d'usage du wiki (chat, projet, Claude Code) | vérifié (wiki) | [ASSISTANT-ET-AUTOMATISATION](../ASSISTANT-ET-AUTOMATISATION.md) |
| IBM Bob : description, agents, Bob Shell, Literate Coding, packages mainframe/IBM i | vérifié (début de la page produit, **texte marketing**) | [IBM Bob](https://bob.ibm.com/) |
| Bob = « l'assistant BOB » du plan | **hypothèse** | à confirmer avec le formateur |
| Documentation technique de Bob (installation, droits, sécurité des données) | **non lue** | à chercher |
| Définitions d'agent / workflow, comparaison des outils | **non vérifié** | à sourcer |

### 4. Cadre d'usage : confidentialité, RGPD, responsabilité

**Règles du dépôt (vérifiées)** : ne jamais envoyer à un service externe de **noms réels de bibliothèques, de profils, de personnes, d'organismes, de machines**, de **secrets** ni de **données personnelles** ; **anonymiser** (`BIBnn`) avant tout partage ; la correspondance avec les vrais noms reste **privée** ; les contenus de TP/examen ne sont pas remontés pendant l'épreuve ; les épreuves **interdisent l'IA pendant l'épreuve** ([CLAUDE.md](../../CLAUDE.md), [README](../../README.md), [enonces/README](../enonces/README.md)). Le prompt de test n° 5 du wiki vérifie l'anonymisation.

**RGPD et autorité** : la **CNIL** publie une rubrique thématique « Intelligence artificielle » (page d'accueil lue : actualités de 2026 sur l'IA générative et la vie privée, l'IA agentique et les données personnelles — note exploratoire —, les lignes directrices du CEPD sur l'**anonymisation** et le **moissonnage** pour l'IA générative, l'éducation) : c'est le **point d'entrée officiel** à consulter ; **aucun contenu détaillé** (obligations, base légale, durées de conservation, droits des personnes) n'a été lu pour ce cours.

**Limites, éthique, responsabilité, débat** : aucune source lue. Constats **dans le dépôt** : l'assistant évalué a produit des réponses à partie lue, sans recherche ibm.com, avec un correctif incomplet (cas analysé pendant la construction du wiki ; les règles qui en découlent sont dans [CLAUDE.md](../../CLAUDE.md)) ; ce qui a conduit aux règles « lire en entier », « ne jamais dire que ça compile », « tableau de statuts ». Responsabilité : **l'utilisateur relit, compile et teste** ; l'assistant ne compile rien.

| Élément | Statut | Source |
|---|---|---|
| Règles d'anonymisation, secrets, épreuves | vérifié (règles du dépôt) | [CLAUDE.md](../../CLAUDE.md) · [README](../../README.md) |
| CNIL : rubrique IA (existence, thèmes récents) | vérifié (page thématique, titres seulement) | [CNIL : Intelligence artificielle](https://www.cnil.fr/fr/intelligence-artificielle) |
| Obligations RGPD pour l'usage d'un LLM (base légale, minimisation, droits) | **non lu** | [CNIL](https://www.cnil.fr/fr/intelligence-artificielle) à approfondir ; texte du RGPD non lu |
| Éthique, limitations, débat | **non vérifié** | à sourcer |

### 5. Mise en situation sur un cas IBM i

Cas du dépôt, montrant la méthode « IA + sources + vérification » (**résultats confirmés par toi**, sauf mention) :

1. **Impression en full free** (spool comparé à la référence RPG III) : l'assistant a d'abord produit un programme dont le spool était faux (structure `PRTCTL` mal construite : mélange du format `*COMPAT` de 9 octets et du format étendu de 15 octets) ; l'analyse des spools a abouti à **CYCLEQSYS : spool identique, validé** ([IMPRESSION-RPG](../IMPRESSION-RPG.md)).
2. **Service web ILE** : l'exemple BONBON (4 membres, ordre de création) a été **compilé par toi** ; son comportement à l'exécution (JSON brut ou échappé) reste à confirmer ([ILE-ET-SERVICES-WEB](../ILE-ET-SERVICES-WEB.md)).
3. **Programmes non testés** : `CYCLEPRTCTL`, `SQLIMPRIME`, `CYCLEIMP` : statut « non compilé » jusqu'à ta confirmation.

**Méthode** appliquée (règles du dépôt) : (a) cadrer version et objets ; (b) chercher dans le wiki puis sur job-i, puis sur ibm.com (version citée) ; (c) livrer code + hypothèses + tableau `Élément | Statut | Source` ; (d) l'utilisateur compile et teste ; (e) ce qui est confirmé est **remonté** au wiki ([CLAUDE.md, section 8](../../CLAUDE.md)).

| Élément | Statut | Source |
|---|---|---|
| CYCLEQSYS : spool identique, validé par l'utilisateur ; cause de l'échec PRTCTL | vérifié (wiki) | [IMPRESSION-RPG](../IMPRESSION-RPG.md) |
| BONBON compilé ; exécution non confirmée | vérifié (wiki) | [ILE-ET-SERVICES-WEB](../ILE-ET-SERVICES-WEB.md) |
| CYCLEPRTCTL, SQLIMPRIME, CYCLEIMP | **non compilé / non testé** | wiki |
| Efficacité de l'IA sur la maintenance (ex. interprétation de RPG ancien par IBM Bob) | **non vérifié** (témoignage marketing seulement) | [IBM Bob](https://bob.ibm.com/) |

### Ce qui reste à vérifier pour cette partie

Définitions formelles (hallucination, trois ères de l'IA, agent, workflow) ; page « Prompting best practices » ; documentation technique d'**IBM Bob** (confirmer qu'il s'agit bien de l'assistant du plan, prérequis, confidentialité des données, packages IBM i) ; contenu détaillé de la CNIL et du RGPD sur l'usage d'un LLM ; éthique et limites. **Rappel de portée** : les sources techniques lues émanent d'un éditeur de modèle et d'IBM : ce sont des descriptions de produits, pas des normes. Manques à signaler : aucune page job-i sur l'IA ; aucune page du wiki sur le RGPD ni sur Bob.

## Plan détaillé (index des sujets)

### Les concepts fondamentaux

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Qu'est-ce que l'IA, les trois ères

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les LLM, les tokens et les limites de contexte

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Glossaire essentiel, hallucination, température, prompt engineering, fine-tuning, RAG

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Le prompting

- **Dans le wiki** : [Prompts de test de l'assistant (grille)](../ASSISTANT-ET-AUTOMATISATION.md#partie-2--tester-que-lassistant-applique-les-règles)

#### Les règles du prompting efficace

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Construction d'un prompt complet

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Les modes d'utilisation

- **Dans le wiki** : [Donner le wiki à un assistant](../ASSISTANT-ET-AUTOMATISATION.md#partie-1--donner-le-wiki-à-nimporte-quel-chat-claude)

#### Discussions, Projets, Agents, Workflows

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### L'utilisation de l'assistant BOB

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Cadre d'usage et responsabilité

- **Dans le wiki** : [Règles d'anonymisation (README)](../../README.md)

#### Confidentialité, RGPD, anonymisation des prompts

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Limitations de l'IA, éthique et responsabilité, débat

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Mise en situation

- **Dans le wiki** : [Exemples réels dans le dépôt (PRTCTL, cycle, IWS)](../IMPRESSION-RPG.md)

#### Mise en situation sur un cas IBM i

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).
