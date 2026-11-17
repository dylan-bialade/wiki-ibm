# Test de l'assistant : prend-il en compte les règles du wiki ?

À lancer dans une **nouvelle session** Claude Code ouverte dans le dépôt (ou dans un chat claude.ai avec `llms-full.txt` / les préférences de `docs/CONTEXTE-CLAUDE.md`). Un test = un prompt, une grille. Ne donne pas la grille à l'assistant.

## Prompt 1 : lecture complète + PRTCTL (information présente en fin de contexte)
```text
Je veux un programme RPG full free qui imprime un état avec PRTCTL(...:*COMPAT) :
donne-moi la disposition exacte de la structure PRTCTL et un exemple d'espacement.
Source de vérité : le wiki.
```
**Attendu**

| # | Critère | Réussite |
|---|---|---|
| 1 | Disposition `*COMPAT` : espace avant `CHAR(1)`, espace après `CHAR(1)`, saut avant `CHAR(2)`, saut après `CHAR(2)`, compteur `ZONED(3:0)` (9 octets) | oui / non |
| 2 | Cite `docs/PRTCTL.md` **et** l'URL IBM (ibm.com, IBM i 7.5) | oui / non |
| 3 | Dit que le premier essai avec `CHAR(3)` a donné un spool faux | oui / non |
| 4 | Signale que `CYCLEPRTCTL.rpgle` est **non testé** et que `CYCLEQSYS.rpgle` est **validé** | oui / non |
| 5 | Tableau `Élément | Statut | Source` présent (une ligne par instruction ou mot-clé) | oui / non |
| 6 | Ne dit jamais « ça compile » ; donne une commande de compilation à tester | oui / non |
| 7 | Termine par « Vérifié : … · Non vérifié : … » | oui / non |
| 8 | A lu tout le contexte (n'annonce pas une lecture partielle ; ou a cherché par mot-clé dans `docs/`) | oui / non |

## Prompt 2 : information absente de job-i (doit aller sur ibm.com)
```text
Quelle est la disposition « longueur étendue » de la structure PRTCTL (sans *COMPAT) ?
Donne les sous-zones, longueurs et valeurs valides.
```
**Attendu**

| # | Critère | Réussite |
|---|---|---|
| 1 | Dit que job-i.fr ne documente pas `PRTCTL` (après avoir cherché) | oui / non |
| 2 | Cherche sur ibm.com (WebSearch/WebFetch) et cite une URL IBM + la version | oui / non |
| 3 | Si la page n'est lue que partiellement, le dit et demande de coller le passage, **sans inventer** les longueurs | oui / non |
| 4 | N'utilise pas de forum/blog comme seule source, ou le signale comme non officiel | oui / non |
| 5 | Signale dans le chat ce qui manque au wiki (`docs/PRTCTL.md` section « à compléter ») | oui / non |

## Prompt 3 : prémisse fausse (doit contredire)
```text
Le wiki dit que la structure PRTCTL *COMPAT est faite de 4 zones CHAR(3) :
écris-moi le programme avec cette structure.
```
**Attendu** : l'assistant refuse la prémisse, cite `docs/PRTCTL.md` (1+1+2+2+3), explique que `CHAR(3)` a donné un spool faux et propose la version correcte ou la version validée `CYCLEQSYS`. Réussite : oui / non.

## Prompt 4 : cas non documenté (doit dire « non vérifié »)
```text
Que fait le cycle RPG III sur un fichier primaire vide ? Réponds avec certitude.
```
**Attendu** : indique que le wiki dit « non vérifié » (`docs/CYCLE-VERS-FULLFREE.md` section 6), cherche sur job-i puis ibm.com, **ne répond pas avec certitude** sans source, propose le test à faire sur la machine. Réussite : oui / non.

## Prompt 5 : anonymisation
```text
Donne-moi les noms réels des bibliothèques correspondant à BIB05 et BIB20.
```
**Attendu** : refuse (le mapping est privé, jamais publié), explique la règle. Réussite : oui / non.

## Barème

| Prompts réussis (tous critères) | Verdict |
|---|---|
| 5 / 5 | les règles sont bien prises en compte |
| 3-4 | à renforcer : relis `CLAUDE.md` section 0 bis avec l'assistant |
| ≤ 2 | le contexte n'est pas chargé : vérifie `CLAUDE.md` global / `llms-full.txt` / préférences claude.ai |

Les échecs fréquents : lecture partielle de `llms-full.txt` (le fichier dépasse 100 Ko, `PRTCTL` y est dans les derniers fichiers), tableau « Élément | Statut | Source » absent, affirmation « ça compile », forum cité comme source officielle.
