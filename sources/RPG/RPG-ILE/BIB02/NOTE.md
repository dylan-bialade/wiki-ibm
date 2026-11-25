---
bibliotheque: BIB02
fichier_source: QPARMFOR
membre: NOTE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB02/QPARMFOR/NOTE

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO);

       DCL-PR MOYENNE EXTPGM('MOYENNE');
         note1    packed(2:0) ;
         note2    packed(2:0);
         note3    packed(2:0);
         moyenneT packed(2:0);
       END-PR;

       DCL-S N1        packed(2:0) inz(0);
       DCL-S N2        packed(2:0) inz(0);
       DCL-S N3        packed(2:0) inz(0);
       DCL-S MY        packed(2:0) inz(0);
       DCL-S reponse   char(1)     inz(*blanks);

       N1 = 15;
       N2 = 10;
       N3 = 5;

       callp MOYENNE(N1:N2:N3:MY);

       Dsply MY '' reponse;

       *INLR = *ON;
```
