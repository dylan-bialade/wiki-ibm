---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXOALGO6
type: DDS
longueur_enregistrement: 100
lignes: 41
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXOALGO6

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);


       DCL-DS ligne DIM(5) qualified;
         col  char(5) dim(5);
       END-DS;

       DCL-S REPONSE char(1);
       DCL-S I  packed(2:0);
       DCL-S J  packed(2:0);


       FOR i = 1 to 5;
         FOR j = 1 to 5;
           IF %rem(i:2) <> 0 ;
             IF %rem(j:2) <> 0 ;
               ligne(i).col(j) = 'N';
             ENDIF;
             IF %rem(j:2) = 0 ;
               ligne(i).col(j) = 'B';
             ENDIF;
           ELSE;
             IF %rem(j:2) <> 0 ;
               ligne(i).col(j) = 'B';
             ENDIF;
             IF %rem(j:2) = 0 ;
               ligne(i).col(j) = 'N';
             ENDIF;
           ENDIF;
         ENDFOR;
       ENDFOR;



       // Affichage du damier
       FOR i = 1 to 5;
         dsply ligne(i) '' REPONSE;
       ENDFOR;

       *INLR = *ON;
```
