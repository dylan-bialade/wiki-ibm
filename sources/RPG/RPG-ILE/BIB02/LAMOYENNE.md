---
bibliotheque: BIB02
fichier_source: QMOD
membre: LAMOYENNE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB02/QMOD/LAMOYENNE

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO);

       DCL-PI LAMOYENNE;
         note1   zoned(2:0);
         note2   zoned(2:0);
         note3   zoned(2:0);
         moyenne zoned(2:0);
       END-PI;

       moyenne = (note1 + note2 + note3)/3;


       *INLR = *ON;
```
