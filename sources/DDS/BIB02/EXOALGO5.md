---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXOALGO5
type: DDS
longueur_enregistrement: 100
lignes: 32
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXOALGO5

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-S REPONSE char(1);
       DCL-S montab  packed(5:0) DIM(6);
       DCL-S I       packed(5:0);
       DCL-S J       packed(5:0);
       DCL-S min     packed(5:0);

       montab = %list(55:1:20:5:45);

       FOR I = 1 to 5;
         for j = 1 to 5;
           IF montab(j) > montab(j + 1);
             min =  montab(j + 1) ;
             montab(j + 1)  = montab(j);
             montab(j) = min;
           ENDIF;
         ENDFOR;
       ENDFOR;

       FOR i =  1 to 6 ;
         dsply montab(i) '' reponse;
       ENDFOR;







       *INLR = *ON;
```
