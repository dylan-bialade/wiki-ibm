---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXOALGO7
type: DDS
longueur_enregistrement: 100
lignes: 28
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXOALGO7

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-S REPONSE char(1);
       DCL-S NB    packed(2:0);
       DCL-S compteur  packed(2:0);

       NB = 14;

       compteur = 0;

       DOW nb <> 1;
         if %rem(nb:2) = 0;
           nb = nb/2;
           compteur += 1;
         else;
           nb = (nb * 3)  + 1;
           compteur += 1 ;
         ENDIF;
       enddo;

       dsply Compteur  '' reponse;





       *INLR = *ON;
```
