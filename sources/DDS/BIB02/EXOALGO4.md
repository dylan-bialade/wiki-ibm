---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXOALGO4
type: DDS
longueur_enregistrement: 100
lignes: 21
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXOALGO4

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-S REPONSE char(1);
       DCL-S montab  packed(5:0) DIM(5);
       DCL-S I       packed(5:0);
       DCL-S Sum     packed(5:0);
       dcl-s long packed(5:0);


       montab = %list(55:1:20:5:45);

       FOR-EACH i IN montab;
         Sum += i;
       endfor;

       DSPLY SUM '' REPONSE ;



       *INLR = *ON;
```
