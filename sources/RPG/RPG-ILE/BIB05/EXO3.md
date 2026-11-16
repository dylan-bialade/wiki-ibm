---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: EXO3
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 16
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/EXO3

```rpg
**free
ctl-opt  dftactgrp(*no) actgrp(*caller);
dcl-f livdsp workstn;
dcl-f livresl  usage(*input) keyed;
dow not *inkc;
exfmt fmt1;
if *inkc = *off;
chain isbn livresl;
if %found();
dow *inkc = *off and *inkl =*off;
exfmt fmt2;
enddo;
endif;
endif;
enddo;
*inlr =*on;
```
