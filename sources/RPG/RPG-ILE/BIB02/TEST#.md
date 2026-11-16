---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: TEST#
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 12
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/TEST#

```rpg
**FREE
ctl-opt copyright('(C) ARMONIE 2023.') usrprf(*owner)
option(*srcstmt) dftactgrp(*no) optimize(*full)
actgrp(*caller) datfmt(*iso) timfmt(*iso) alloc(*stgmdl)
stgmdl(*inherit) thread(*serialize);


dcl-s a varchar(50) inz('vscode');

dsply a;

*inlr = *on;
```
