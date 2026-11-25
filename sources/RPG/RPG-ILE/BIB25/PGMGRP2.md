---
bibliotheque: BIB25
fichier_source: QILESRC
membre: PGMGRP2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 9
modifie: 2026-11-25
---

# BIB25/QILESRC/PGMGRP2

```rpg
**free
CTL-OPT DFTACTGRP(*NO);
DCL-F BONBON usage(*input);

read rbonbon;

dsply %char(cle);

*inlr = *on;
```
