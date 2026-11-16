---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: RPGFRSQL2
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 63
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/RPGFRSQL2

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


            if *in05;

             exec sql
              declare c1 cursor for
               SELECT ORDER_NUM, ORDER_DATE, SHIP_DATE, LINEPRICE
               FROM tpsql.commandes
               WHERE PROD_NUM = :productnum;

             exec sql
              open c1;

               DOW SQLCODE = 0;

                 exec sql
                   fetch c1
                   into :ORDER_NUM, :ORDER_DATE, :SHIP_DATE, :LINEPRICE;

                 EXFMT FMT3;

                 IF *in03 or *in12;
                   leave;
                 ENDIF;

               enddo;

              exec sql
                close c1;

              *in12 = *off;
              *in05 = *off;
            ENDIF;

            exfmt fmt2;

            ENDDO;
          else;
            msgerr = 'Le numéro n''existe pas.';
            *in50 = *on;
          ENDIF;
       ENDDO;

       *inlr = *on;
```
