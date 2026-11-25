---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: BNDRPG
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-25
---

# BIB25/QRPGSRC/BNDRPG

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
//Options
CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER) STGMDL(*INHERIT) BNDDIR('BND');
DCL-S result packed(9:0) INZ(*zero);
DCL-PI *N;
   file char(10);
   bib char(10);
END-PI;
DCL-PR NBR_ENREG packed(9:0);
  filename char(10);
  lib char(10);
END-PR;
result = NBR_ENREG(file:bib);
DSPLY %char(result);
*inlr = *on;
```
