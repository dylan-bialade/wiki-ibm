---
bibliotheque: BIB02
fichier_source: QCHATGPT
membre: TPS
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 15
modifie: 2026-11-16
---

# BIB02/QCHATGPT/TPS

```rpg
**FREE
ctl-opt dftactgrp(*no);

dcl-f FILMS usage(*input) keyed;

dcl-s titre char(50);

read FILMS;
dow not %eof(FILMS);
   titre = TITREFILM;
   dsply titre;
   read FILMS;
enddo;

*inlr = *on;
```
