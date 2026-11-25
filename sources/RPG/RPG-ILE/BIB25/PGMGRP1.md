---
bibliotheque: BIB25
fichier_source: QILESRC
membre: PGMGRP1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-25
---

# BIB25/QILESRC/PGMGRP1

```rpg
**free
CTL-OPT DFTACTGRP(*NO);
DCL-F BONBON usage(*input);

dcl-pr PGMRPG2 EXTPGM('PGMRPG2');
END-PR;

read rbonbon;
dow not %eof;
  dsply %char(cle);
  if cle = 3;
    callp PGMRPG2();
  ENDIF;
  read rbonbon;
ENDDO;


*inlr = *on;
```
