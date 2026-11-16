---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXOALGO
type: DDS
longueur_enregistrement: 100
lignes: 21
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXOALGO

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-S A      PACKED(4:0) INZ(3);
       DCL-S B      PACKED(4:0) INZ(5);
       DCL-S C      PACKED(4:0) INZ(4);
       DCL-S D      PACKED(4:0) ;
       DCL-S REPONSE char(1);

       D =  B*B - 4*A*C;
       IF D < 0 ;
         dsply 'pas de solution réel' '' REPONSE;
       ENDIF;
       IF D = 0;
         dsply 'a une unique solution' '' REPONSE;
       ENDIF;
       IF D > 0;
         dsply 'a deux solution distincte' '' REPONSE;
       ENDIF;

       *INLR = *ON;
```
