---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXOALGO3
type: DDS
longueur_enregistrement: 100
lignes: 30
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXOALGO3

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-S REPONSE char(1);
       DCL-S A       packed(5:0);
       DCL-S B       packed(5:0);
       DCL-S C       packed(5:0);
       DCL-S D       packed(5:0);
       DCL-S I       packed(5:0);

       A = 0;
       B = 1;
       C = 1;

       dsply A;
       dsply B;

       DOW I < 7;

         D = B + C;
         B = C;
         C = D;

         I = I + 1;
         dsply B '' REPONSE;

       ENDDO;


       *INLR = *ON;
```
