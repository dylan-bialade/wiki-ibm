---
bibliotheque: BIB02
fichier_source: QSQLSRC
membre: INSERTSQL
type: SQL
longueur_enregistrement: 100
lignes: 44
modifie: 2026-11-16
---

# BIB02/QSQLSRC/INSERTSQL

```sql
       CTL-OPT COPYRIGHT('(C) ARMONIE 2023.') USRPRF(*OWNER)
       OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
       ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE);

       //*****************************************************************
       // Programme : SFRSQL
       // BIB02 SYLVAIN - EXEMPLE DE SOUS-FICHIER DYNAMIQUE EN SQL
       // Date      - 04/07/2022
       // Mise à jour - 18/01/2022
       // IMPORTANT !!- CHANGEZ LE OPTIMIZE(*FULL) EN *NONE POUR DEBUG
       // POUR DEBUGGER   !!!!!!!!!
       // Copyright - ARMONIE
       //*****************************************************************

       //**********************************************************************//
       // Déclaration des fichiers                                             //
       //**********************************************************************//


        DCL-S i  zoned(6:0) inz(0);
        DCL-S j  char(5);
        DCL-S Ncodpro char(4) inz('0');
        DCL-S Nnmpro char(5) inz('patou');
        dcl-s ncodnum zoned(6:0);

       EXEC SQL
         SET option commit = *none , ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;


        DOW i < 100000 ;

         ncodnum = %dec(Ncodpro:4:0) + i;
         ncodpro = %char(ncodnum);
          i = i + 1;
          j = %char(i);
        EXEC SQL
          insert into entrepotv (codpro, nmpro, qtpro, dtdinv)
             values ( :j, 'patou', 15 , current date);



        ENDDO;
        *Inlr = *On;
```
