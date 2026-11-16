---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: RPGFRSQLTP
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 28
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/RPGFRSQLTP

```text
       DCL-F ecrprod WORKSTN;
       // DELCARATION VARIABLE //
       dcl-s null int(5:0);

       // code //

       dow not *in03;
         exfmt fmt1;
         *in50 = *off;
         *in12 = *off;

         exec sql
          SELECT PRODTYPE, PRODCAT, PRODNAME, MODEL, QTY_IN_STK
           into :PRODTYPE, :PRODCAT, :PRODNAME, :MODEL :null, :QTY_IN_STK :null
          FROM TPSQL.produits
          WHERE productnumber = :productnum;

          if sqlcode = 0;
            dow not *in03 and not *in12;
              exfmt fmt2;
            ENDDO;
          else;
            msgerr = 'Le numéro n''existe pas.';
            *in50 = *on;
          ENDIF;
       ENDDO;

       *inlr = *on;
```
