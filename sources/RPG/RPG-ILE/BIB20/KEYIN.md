---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: KEYIN
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 16
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/KEYIN

```rpg
**free
ctl-opt dftactgrp(*no) actgrp(*new);

dcl-s CLAUDEKEY char(200) dtaara;

in CLAUDEKEY;

CLAUDEKEY =
  'sk-ant-api03-8uQrD_nORexdL1y1h' +
  'ruwGUU_63p-fFZWM8ridnWHA0Y1El3Y' +
  'kRbNLdvW-3ERh7bK1_6hAbiK8xIGJP5' +
  'mw3ChcA-FdSWWgAA';

out CLAUDEKEY;

*inlr = *on;
```
