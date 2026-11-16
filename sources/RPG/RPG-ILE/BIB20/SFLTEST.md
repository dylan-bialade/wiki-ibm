---
bibliotheque: BIB20
fichier_source: QSQLRPGLE
membre: SFLTEST
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 100
modifie: 2026-11-16
---

# BIB20/QSQLRPGLE/SFLTEST

```text
       CTL-OPT DFTACTGRP(*NO);
       dcl-f sfltest workstn sfile(sfl:rrang);

       dcl-s i zoned(2:0) inz(1);
       dcl-s on ind inz('1');
       dcl-s off ind inz('0');
       dcl-s sortir ind based(ptrSortir);
       dcl-s annuler ind based(ptrAnnuler);
       dcl-s indNettoyer ind based(ptrNettoyer);
       dcl-s finSfl ind based(ptrFinSfl);
       dcl-s rollUp ind based(ptrRollUp);
       DCL-S LASTRANK zoned(4:0) INZ(0);


       ptrSortir = %addr(*in03);
       ptrAnnuler = %addr(*in12);
       ptrNettoyer = %addr(*in32);
       ptrFinSfl = %addr(*in33);
       ptrRollUp = %addr(*in29);

       nettoyer();
       cursor();
       remplir();

       dow not sortir;
         exfmt ctl;

         select;
           when sortir or annuler;
           leave;
           when rollUp;
             rollUp = off;
             remplir();
           other;
             readc sfl;

             dow not %eof();
               if opt <> *zeros;
                 select;
                   when opt = 2;
                     *in50 = on;
                   when opt = 4;
                   when opt = 5;
                 ENDSL;
               ENDIF;
             clear opt;
             readc sfl;
             *in50 = off;
             affichage_variable();
             enddo;
         ENDSL;
       ENDDO;
       *inlr = on;

       // PROC NETTOYER
       //
       dcl-proc nettoyer;
         rrang = 0;
         indNettoyer = on;
         write ctl;
         indNettoyer = off;
       END-PRoc;

       // proc remplissage
       //
       dcl-proc remplir;
         rrang = lastrank;
         for i = 1 to 5;
           exec sql
           fetch c1 into
           :numbb, :nom, :marque, :prix, :couleu;

           if SQLCODE = 100;
             finSfl = on;
             leave;
           ENDIF;

           rrang += 1;
           write sfl;

           finSfl = off;
         ENDFOR;
         lastrank = rrang;
         affichage_variable();
       END-PROC;

       dcl-proc cursor;
         exec sql
           declare c1 cursor for
             SELECT numbb, nom, marque, prix, couleu
             from BIB20.bonbon
             order by numbb;
         exec sql open c1;
       END-PROC;

       dcl-proc affichage_variable;

         rang = rrang;
         scroll = sscroll;
       END-PROC;
```
