---
bibliotheque: BIB02
fichier_source: QSRC
membre: INFOLIB_P
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 260
modifie: 2026-11-16
---

# BIB02/QSRC/INFOLIB_P

```text
       CTL-OPT COPYRIGHT('(C) ARMONIE 2023.')
               USRPRF(*OWNER)
               OPTION(*SRCSTMT)
               DFTACTGRP(*NO)
               OPTIMIZE(*NONE)
               ACTGRP(*CALLER)
               ALLOC(*STGMDL)
               STGMDL(*INHERIT) THREAD(*SERIALIZE);

       //*****************************************************************
       //Déclaration des fichiers
       DCL-F INFOLIB_D WORKSTN SFILE(SFL1:RANG);

       //Déclaration des variables
       DCL-S RANG             packed(4:0) INZ(0);
       DCL-S i                packed(4:0) INZ(0) ;
       DCL-S LAST_RANG packed(4:0) INZ(0);     // Dernier rrn écrit avant pagina
       DCL-S pr_cmdstr     CHAR(4096)      INZ(*blanks);
       DCL-S pr_cmdstrlen  ZONED(15:5)     INZ(42);
       DCL-S Objet         CHAR(10) ;
       DCL-S LIB CHAR(10);
       DCL-S ObjLib char(21) ;
       DCL-S Requete VARCHAR(1000) ;

       //**********************************************************************/
       // Déclaration des prototypes                                           /
       //**********************************************************************/
       // API QCMDEXC : exécute une commande
       DCL-PR QCMDEXC extpgm('QCMDEXC');
         pr_cmdstr         CHAR(4096)      CONST OPTIONS(*VARSIZE);
         pr_cmdstrlen      PACKED(15:5)    CONST;
       END-PR;

       //Déclaration des constantes
       DCL-C SflPag CONST(15);   // Nombre de ligne à afficher par page ...
       DCL-C Supprimer     CONST('4');

       //**********************************************************************
       // Déclaration des DATA STRUCTURES  // PROGRAMME STATUS DATA STRUCTURE  /
       //**********************************************************************/
     D                SDS
     Dwk_NomPgm                1     10
     Dwk_PgmEri               40     46
     Dwk_PgmLib               81     90
     Dwk_PgmErM               91    170
     Dwk_PgmDt8              191    198
     Dwk_NomJOb              244    253
     Dwk_NomUser             254    263
     Dwk_NomNbr              264    269
       //**********************************************************************
       // Traitement pricipal                                                //
       //**********************************************************************/


       *Inlr = *On ;
       EXEC SQL
       SET option commit = *none, ALWCPYDTA = *OPTIMIZE;

       // Initialisation sous-fichier
       Initialisation_sous_fichier();

       // Fabrication du sous-fichier
       Fabrication_sous_fichier();
       z_lib = ' ';

       DOW NOT *IN03;
         RANG = 1;

         Write Fkey1;
         Exfmt Sf1ctl;

         SELECT;

         WHEN *IN39 AND (NOT *IN90);    // a-t-il paginé ?
           Fabrication_sous_fichier();

         WHEN z_lib <> ' '; // a-t-il touché à la zone "Afficher à partir de"
           EXEC SQL close C1;
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();
           clear z_lib;

         WHEN *IN05  ;  // Actualiser
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();

         OTHER;

           EXEC SQL
           select  ODOBNM into :E1LIBL from qtemp.infolib     ;

           IF SQLCODE <> 100;  // si SQLCODE est différent de vide
             trt_readc();  // on fait un readc seulement s'il y a des données
           ENDIF;

           Initialisation_sous_fichier();
           Fabrication_sous_fichier();
         ENDSL;

       ENDDO;

       EXEC SQL
       close C1;

       ////////////////////// ***** PROCEDURES ******* //////////////////////

       //Initialisation de sous fichier

       DCL-PROC Initialisation_sous_fichier;
         RANG = *Zero;   // Initialisat° du compteur d'enregistrement.
         LAST_RANG = *zero;
         *In31 = *On;    // Activat° de l'indic de vidage de SFL  (Associé au mo
         Write Sf1ctl;      // Vidage du sous-fichier
         *In31 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au
         *In32 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au
         *In90 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au
         i = 1 ;
       END-PROC;


       // Fabrication de sous fichier

       DCL-PROC Fabrication_sous_fichier;
         RANG = LAST_RANG;        // Le "relative record number" reçoit la valeu
         If z_lib = '';
           EXEC SQL
           DECLARE C1 cursor for (select ODOBNM, ODOBSZ, ODCTIM
            from qtemp.infolib where ODOBNM >= :z_lib
             Order by ODOBNM) FOR READ ONLY OPTIMIZE FOR ALL ROWS   ;
         ENDIF;

         EXEC SQL
         OPEN C1;

         FOR i to Sflpag;

           DOW SQLCODE = 0 ;
             EXEC SQL
             FETCH C1 into :E1LIBL, :E1SIZE, :E1DATE ;

            IF SQLCODE = 100 ;          // Fin de fichier ? On enclanche le joli
               *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
               leave;
             ENDIF;

             IF E1SIZE >= 999999  ;
               *IN88 = *ON;
             ELSE;
               *IN88 = *OFF;
             ENDIF;

             IF z_lib >= z_lib;
               RANG += 1;  // Incrémentation du compteur de ligne
               write Sfl1;

             ENDIF;


           ENDDO;

         ENDFOR;

         IF RANG = *ZERO;
           *IN32 = *ON;
         ENDIF;

         LAST_RANG = RANG;

         EXEC SQL CLOSE c1;
       END-PROC;

       // ******************************************************************
       // Traitement du READC
       // ******************************************************************
       DCL-PROC TRT_READC;
         Readc Sfl1;           // Lecture de toutes les lignes modifiées du SFL
         DOW NOT %eof;
           SELECT;

           WHEN OPT = Supprimer;  // Option 4 Supprimer
             Check();
             DLTLIB();
             leave;
           OTHER ;
             OPT = ' ';
             LEAVE;
           ENDSL;
           Readc Sfl1;
         ENDDO;
       END-PROC;


       //**********************************************************************
       //  DLTLIB                                                              /
      //************************************************************************
       DCL-PROC DLTLIB;
         pr_cmdstr=*blanks;
         pr_cmdstr='DLTLIB LIB('+%trim(E1LIBL)+')' ;

         callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));

         *InLR = (%error()) ;

         If *InLr;
           pr_cmdstr=*blanks;
           pr_cmdstr= 'DSPDBR FILE('+%trim(E1LIBL)+'/*ALL) +
           OUTPUT(*OUTFILE) OUTFILE(QTEMP/DBRINFO) ' ;
           callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));

           Exfmt SFL2 ;
           If *In23=*on ;

             EXEC SQL
             DECLARE C2 CURSOR FOR
             select  WHRLI, WHRFI FROM QTEMP.DBRINFO;

             EXEC SQL
             Open C2;

             DOW SQLCODE = 0;

               clear Objet;
               clear LIB;
               EXEC SQL
               Fetch C2 into :LIB, :Objet ;
                 ObjLib = %trim(LIB) +'.'+ %trim(Objet) ;
                 Requete = ' drop table ' + ObjLib + ' cascade' ;
               EXEC SQL
                 Prepare P2 from :Requete ;
               EXEC SQL
               EXECUTE P2;


               IF sqlcode = 100;
                 *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
                 leave;
               ENDIF;
             ENDDO;
           ENDIF;
           pr_cmdstr=*blanks;
         pr_cmdstr='DLTLIB LIB('+%trim(E1LIBL)+')' ;
         callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
           EXEC SQL
           delete from qtemp.infolib where ODOBNM = :E1LIBL;

           EXEC SQL
           Close C2 ;
         ENDIF;

       END-PROC;

       //**********************************************************************
       //  CHECK LF avec PF                                            /
      //************************************************************************
       DCL-PROC CHECK;
         pr_cmdstr=*blanks;
         pr_cmdstr='DSPDBR   FILE('+%trim(E1LIBL)+'/*ALL)' ;

         callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
       END-PROC;
```
