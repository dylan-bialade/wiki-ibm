# Donner le wiki à n'importe quel chat Claude

But : qu'un chat Claude (site claude.ai, application, Claude Code, sur n'importe quel appareil) connaisse ce wiki et vos règles dès la première question. Trois niveaux, du plus simple au plus complet.

## 1. Texte à coller une fois dans claude.ai (valable pour tous vos chats)
Où : claude.ai > Paramètres > Profil > « Préférences personnelles » (ou « Instructions personnalisées »). Réglage du compte : à faire par vous, je ne peux pas le modifier à votre place.

```text
Je suis étudiant en développement IBM i (RPG III / IV / full free, CL, DDS, SQL Db2 for i). J'ai un wiki public, base de vérité de mes cours et de mon code : https://github.com/dylan-bialade/wiki-ibm
Pour toute question IBM i, lis d'abord https://raw.githubusercontent.com/dylan-bialade/wiki-ibm/main/llms-full.txt (règles, fiches, énoncés, manques). Index plus détaillé : https://raw.githubusercontent.com/dylan-bialade/wiki-ibm/main/llms.txt
Règles : réponds en français ; ne donne aucune commande, instruction, message ou service SQL que tu n'as pas vérifié dans ce wiki ou sur job-i.fr ; cite tes sources (fichier du wiki ou URL job-i.fr) ; lis le fichier en entier (par morceaux s'il est tronqué) et cherche chaque mot-clé technique dans le wiki puis sur job-i.fr avant d'écrire du code ; livre un tableau « Élément | Statut (vérifié / non vérifié / hypothèse) | Source » ; distingue fait documenté, constat dans mon code et hypothèse ; tu ne peux pas compiler, ne dis jamais « ça compile » ; termine par « Vérifié : … · Non vérifié : … ». Les noms de bibliothèques du dépôt sont anonymisés (BIBnn) : ne cherche pas à les deviner. Pendant un TP surprise ou un examen, l'IA est interdite : n'aide qu'en révision.
```

## 2. Projet claude.ai
Créer un **Projet** « Wiki IBM i », coller le texte ci-dessus dans ses instructions et ajouter le fichier [`llms-full.txt`](../llms-full.txt) (ou le dépôt GitHub si l'intégration GitHub est active sur votre compte) aux connaissances du projet. Le fichier est régénéré chaque jour par l'Action GitHub.

## 3. Claude Code
- Dans le dépôt cloné : [`CLAUDE.md`](../CLAUDE.md) est chargé automatiquement (règles du projet).
- Dans un dossier quelconque : un fichier global `~/.claude/CLAUDE.md` renvoie vers le wiki (voir ci-dessous). Les sessions Claude Code de cet ordinateur le lisent.

```text
# Wiki IBM i (base de vérité pour tout sujet IBM i / RPG / CL / DDS / SQL Db2)
Dépôt public : https://github.com/dylan-bialade/wiki-ibm  (contexte complet : llms-full.txt à la racine, brut : https://raw.githubusercontent.com/dylan-bialade/wiki-ibm/main/llms-full.txt)
Pour toute question ou tout code IBM i : lire ce contexte, appliquer ses règles (vérifier sur job-i.fr, citer les sources, répondre en français, ne jamais prétendre avoir compilé), et signaler dans le chat ce qui manque au wiki.
```

## Ce qui est automatique
- `llms-full.txt` est regénéré par `scripts/Build-Contexte.ps1` (à chaque `Run-All.ps1` et chaque jour par l'Action) ; il contient les règles, les fiches 01-06, les énoncés résumés, les manques, les exemples du cycle et la portabilité. Il ne contient **aucun nom réel de bibliothèque** (contrôlé à chaque génération).
- La **mémoire** d'un chat claude.ai n'est pas accessible depuis Claude Code : pour un chat sans accès à Internet, collez `llms-full.txt` en pièce jointe.
