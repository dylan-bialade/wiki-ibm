---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: CREABONBON
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 57
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/CREABONBON

```text
       CTL-OPT DFTACTGRP(*NO);
       DCL-F ecreabon WORKSTN ;
       dcl-f lfbonbon usage(*input:*output) keyed;

       // CODE
             1 = 1;
         DOW 1 = 1;

           EXFMT CREATION;
           *IN90 = *OFF;

           SELECT;
             WHEN *IN03 OR *IN12;
               LEAVE;
             WHEN *IN04;
               if fld = 'couleu';
                 invite_couleur();
               ENDIF;
             OTHER;
               CHAIN NUMBB LFBONBON;

               IF NOT %FOUND();
                 WRITE FBONBON;
                 MSGCREA = 'Le bonbon a été ajouté.';
                 VIDEZONE();

               ELSE;
                 MSGCREA = 'Le numéro du bonbon existe déjà.';
                 *IN90 = *ON;

               ENDIF;
           ENDSL;
         ENDDO;

         *inlr = *on;

       //********* PROC VIDAGE DE ZONES

       DCL-PROC VIDEZONE;
         CLEAR NUMBB;
         CLEAR NOM;
         CLEAR MARQUE;
         CLEAR PRIX;
         CLEAR COULEU;
       END-PROC;

       //********* PROC INVITE COULEUR

       DCL-PROC invite_couleur;


       //  DOW not *in03 or not *in12;
       //    exfmt inv_coul;


       //  ENDDO;
       END-PROC;
```
