---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: CONVERT1
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 19
modifie: 2026-11-25
---

# BIB27/QRPGSRC/CONVERT1

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**FREE

dcl-s hexString char(50);
dcl-s outputstring char(50);
dcl-s ebcdicchars char(100);
dcl-s asciichars char(100);



hexString = 'AC30F3';

ebcdicchars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
asciichars = 'abcdefghijklmnopqrstuvwxyz0123456789';

outputstring = %xlate(ebcdicchars: asciichars : hexstring);

DSPLY outputstring;

*inlr = *on;
```
