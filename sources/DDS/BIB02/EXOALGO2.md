---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXOALGO2
type: DDS
longueur_enregistrement: 100
lignes: 34
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXOALGO2

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-S A       VARCHAR(10);
       DCL-S REPONSE char(1);
       DCL-S Long    packed(5:0);
       DCL-S I       packed(5:0);
       DCL-S Pal     packed(2:0);

       I = 1;
       A = 'KAYAK';
       Long = %LEN(A);
       pal = 0;


       DOW I < LONG ;
         IF %subst(A:I:1) = %subst(A : LONG : 1);
           pal = 1;
           I = I + 1;
           LONG  -= 1;
         ELSE;
           Leave;
         ENDIF;

       ENDDO;

       IF pal = 1;
         dsply ( A  + ' est un palindrome') '' REPONSE;
       ELSE;
         dsply ( A  + ' pas un palindrome') '' REPONSE;
       ENDIF;


       *INLR = *ON;
```
