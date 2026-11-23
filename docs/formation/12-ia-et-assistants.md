# Partie 12 : Intelligence artificielle et assistants de développement

> Plan de formation, partie 12 sur 14. Concepts de l'IA, LLM et tokens, prompting, modes d'utilisation, assistant BOB, cadre d'usage (confidentialité, RGPD), mise en situation IBM i.
>
> **Mots-clés** : IA, LLM, token, contexte, hallucination, température, prompt engineering, fine-tuning, RAG, agents, workflows, BOB, RGPD, anonymisation.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [L'essentiel (définitions générales, non sourcées)](#lessentiel-définitions-générales-non-sourcées)
- [Plan détaillé](#plan-détaillé)
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
## Plan détaillé

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
