---
bibliotheque: BIB02
fichier_source: QPARMFOR
membre: MOYENNE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 12
modifie: 2026-11-16
---

# BIB02/QPARMFOR/MOYENNE

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO);

       DCL-PI MOYENNE;
         note1  packed(2:0) OPTIONS(*NOPASS);
         note2  packed(2:0);
         note3  packed(2:0);
         moyenneT packed(2:0);
       END-PI;


       MoyenneT = (note1 + note2 + note3)/3;
       *INLR = *ON;
```
