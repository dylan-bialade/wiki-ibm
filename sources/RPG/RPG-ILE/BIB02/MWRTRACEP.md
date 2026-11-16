---
bibliotheque: BIB02
fichier_source: QILE
membre: MWRTRACEP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 60
modifie: 2026-11-16
---

# BIB02/QILE/MWRTRACEP

```text
       // Principal
       //

       CTL-OPT OPTION (*srcstmt) DFTACTGRP (*NO);
       //CTL-OPT NOMAIN ;
       *InLR = *On ;

       // ______________________________________________
       //
       // Procedure
       //
       DCL-PROC Write_Racep EXPORT;
         DCL-PI *n ind;
           NORACE packed (4:0);
           DTRACE DATE;
           TPRACE CHAR (3);
           NMRACE CHAR (30);
           GRRACE CHAR (1);
           DSRACE packed(3:0);
           T1RACE TIME;
           P3RACE packed(4:0);
           AVRACE    packed(4:2)   ;
           FORME     CHAR(3)  ;
           VAINQUEUR CHAR(10) ;
         END-PI;

       //  DCL-S  AVRACE    packed(4:2) INZ(0)  ;
       //  DCL-S  FORME     CHAR(3) INZ('') ;
       //  DCL-S  VAINQUEUR CHAR(10) INZ('');


         EXEC SQL
           SET OPTION COMMIT =*NONE ,
           CLOSQLCSR=*ENDMOD;

         // CONTROLE DES DONNEES SI BESOIN


         // REQUETE
         EXEC SQL
         INSERT INTO races/racep
           (NORACE, DTRACE, TPRACE,
           NMRACE, GRRACE, DSRACE,
           T1RACE, P3RACE, AVRACE,
           FORME, VAINQUEUR)
           VALUES (:NORACE, :DTRACE, :TPRACE,
           :NMRACE, :GRRACE, :DSRACE,
           :T1RACE, :P3RACE, :AVRACE,
           :FORME, 'moi')
           ;

         // CONTROLE ERREUR
         IF SQLCODE = 0 ;
           dsply sqlcode;
           return *ON;
         ELSE ;
           dsply sqlcode;
           Return *OFF;
         ENDIF;
       END-PROC;
```
