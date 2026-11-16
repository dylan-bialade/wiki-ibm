---
bibliotheque: BIB02
fichier_source: QMOD
membre: LESNOTES
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB02/QMOD/LESNOTES

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO);

       DCL-PR LAMOYENNE EXTPGM('LAMOYENNE');
         note1   zoned(2:0);
         note2   zoned(2:0);
         note3   zoned(2:0);
         moyenne zoned(2:0);
       END-PR;

       DCL-S reponse char(1)    inz(*blanks);
       DCL-S N1      zoned(2:0) inz(0);
       DCL-S N2      zoned(2:0) inz(0);
       DCL-S N3      zoned(2:0) inz(0);
       DCL-S MY      zoned(2:0) inz(0);

       N1 = 15;
       N2 = 20;
       N3 = 4;

       callp LAMOYENNE(N1:N2:N3:MY);

       dsply MY ''  reponse;

       *INLR = *ON;
```
