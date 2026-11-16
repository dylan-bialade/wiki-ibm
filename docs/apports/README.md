# Apports personnels

Déposez ici ce que vous voulez ajouter aux fiches (notes, extraits de code, captures, sujets de TP).

## Format conseillé (un fichier .md par apport)
```
---
fiche: 03-rpg-par-version      # 01 à 05, voir ../cheatsheets/README.md
titre: Ma gestion de sous-fichier
---
Ce que j'ai fait, le contexte, l'extrait de code ou le lien vers ../../sources/...
```

La tâche d'automatisation copie chaque apport dans la section « Mes exemples » de la fiche indiquée par `fiche:`, puis le marque comme intégré (`integre: oui`).

## Évaluation automatique

Chaque document déposé ici est évalué automatiquement (pertinence pour IBM i, doublon, apport par rapport aux fiches) : résultat dans [EVALUATION-APPORTS](../EVALUATION-APPORTS.md). Formats acceptés : texte (.md, .txt, .sql, sources .rpgle .clp .dds…) ; pas de PDF, archive ni binaire.
