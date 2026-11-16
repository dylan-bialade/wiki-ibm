---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: FOUND_MD
type: DDS
longueur_enregistrement: 100
lignes: 270
modifie: 2026-11-16
---

# BIB02/QDDSRC/FOUND_MD

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
       ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE);

       //*****************************************************************
       // Programme : FOUND_MD
       // BIB02 SYLVAIN - PGM POUR TROUVER PGM DE MODULE
       // Date      - 10/11/2022
       // Copyright - ARMONIE
       //*****************************************************************

       //**********************************************************************//
       // Déclaration des fichiers                                             //
       //**********************************************************************//
       DCL-F FMDSPF WORKSTN SFILE(SFL1:RANG);

       //**********************************************************************//
       // Déclaration des prototypes                                           //
       //**********************************************************************//
       DCL-PR QCMDEXC extpgm('QCMDEXC');
         pr_cmdstr         CHAR(4096)      CONST OPTIONS(*VARSIZE);
         pr_cmdstrlen      PACKED(15:5)    CONST;
       END-PR;

       DCL-PR QUSROBJD extpgm('QUSROBJD');
         OBJD0100      LIKEDS(OBJD0100) CONST;
         ObjLen        BINDEC(4:0)      CONST;
         ObjFmt        CHAR(8)          CONST;
         ObjNme        CHAR(20)         CONST;
         ObjTyp        CHAR(10)         CONST;
       END-PR;

       //**********************************************************************//
       // Déclaration des DS                                                   //
       //**********************************************************************//
       DCL-DS OBJD0100  len(90);
         crdate    char(13)   pos(65);   // Creation date and time
       END-DS;

       //**********************************************************************//
       // Déclaration des variables                                            //
       //**********************************************************************//
       DCL-S format        CHAR(15)     INZ('F1');
       DCL-S pr_cmdstr     CHAR(4096)   INZ(*blanks);
       DCL-S jj            CHAR(2)      INZ(*blanks);
       DCL-S mm            CHAR(2)      INZ(*blanks);
       DCL-S aa            CHAR(2)      INZ(*blanks);
       DCL-S mes           CHAR(60)     INZ(*blanks);
       DCL-S crdatep       CHAR(13)     INZ(*blanks);
       DCL-S crdate2       DATE(*ISO);
       DCL-S pr_cmdstrlen  ZONED(15:5)  INZ(42);
       DCL-S LAST_RANG     ZONED(4:0)   INZ(0);
       DCL-S i             ZONED(4:0)   INZ(0);

       // Pour l'API QUSROBJD
       DCL-S ObjLen        BINDEC(4:0);
       DCL-S ObjFmt        CHAR(8);
       DCL-S ObjNme        CHAR(20);
       DCL-S ObjTyp        CHAR(10);

       //**********************************************************************//
       // Déclaration des constantes                                           //
       //**********************************************************************//
       DCL-C SflPag        CONST(12);   // Nombre de ligne à afficher par page ...
       DCL-C update        CONST('1');
       DCL-C dsppgm        CONST('2');


       //**********************************************************************//
       // Traitement pricipale                                                 //
       //**********************************************************************//
       *Inlr = *On;
       EXEC SQL
       SET option commit = *none;


       DOW format ='F1';
         Exfmt F1;
         IF *IN03 = *ON;  // F3=Exit
           format ='*';
           LEAVE;
         ENDIF;

         IF *IN01 = *ON;   // F1=Validation
           gestion_date();

           // Si VIDE
           IF  mm <> '' and jj <> '' and aa <> '';   // Si date différent de vide
             MES = *blanks;
             DATEMD = crdatep; // affiche au format jj/mm/aa
             crdate2 = %date(crdate:*iso);
           ELSE;
             MES = 'Module non trouvée';
             iter;     // Sinon on iter
           ENDIF;


           // Initialisation Sous fichier
           format ='*';
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();

           DOW NOT *IN03;

             RANG = 1;

             Write Fkey1;
             Exfmt Sf1ctl;

             SELECT;
             WHEN *IN12=*ON;    // Retour
               format = 'F1';
               leave;
             WHEN *IN39 AND (NOT *IN90);    // a-t-il paginé ?
               Fabrication_sous_fichier();
             OTHER;
               TRT_READC();
               Initialisation_sous_fichier();
               Fabrication_sous_fichier();
             ENDSL;

           ENDDO;
         ENDIF;

       ENDDO;


       //************************************************************************
       // Initialisation du sous fichier                                       //
       //************************************************************************
       DCL-PROC Initialisation_sous_fichier;
         RANG = *ZERO;      // Initialisat° du compteur d'enregistrement.
         LAST_RANG = *ZERO; // Initialisat° du dernier rrn d'enregistrement.
         *In31 = *ON;       // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
         Write Sf1ctl;      // Vidage du sous-fichier
         *In31 = *OFF;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
         *In32 = *OFF;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
         *In90 = *OFF;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLEND)
         i = 1;
       END-PROC;

       //************************************************************************
       // Fabrication du sous fichier                                          //
       //************************************************************************
       DCL-PROC Fabrication_sous_fichier;
         INFMD = NMMD;

         RANG = LAST_RANG;        // Le "relative record number" reçoit la valeur du dernier
         EXEC SQL
            Declare c1 CURSOR FOR
            select PROGRAM_LIBRARY, PROGRAM_NAME,
              MODULE_CREATE_TIMESTAMP, MODULE_ATTRIBUTE
            from qsys2.bound_module_info
            where trim(module_attribute) = 'RPGLE'
            AND (program_library, program_name) in (
            select program_library, program_name from (
            select program_library, program_name, count(*)
            from qsys2.bound_module_info
            where program_library = :LIBMD
            group by program_library, program_name
            having count(*)>=1
            order by program_library, program_name)
            where bound_module= :NMMD);

         EXEC SQL
              open C1;

         FOR i to Sflpag;  // Tantque i est < Nombre de ligne à afficher par page
           DOW SQLCODE = 0;
             EXEC SQL Fetch C1 into :E1PGMLIB, :E1PGMNM, :E1PGMDT, :E1PGMATR;
             E1MAJ = 'Non';
             *IN88 =*OFF;
             IF E1PGMDT <> crdate2;
               E1MAJ = 'Oui';
               IF E1MAJ = 'Oui';
                 *IN88 =*ON;
               ENDIF;

             ENDIF;
             IF E1MAJ = 'Non';
               *IN88 =*OFF;
             ENDIF;

             IF sqlcode = 100;
               *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
               leave;
             ENDIF;
             RANG += 1;  // Incrémentation du compteur de ligne
             write Sfl1;
           ENDDO;
         ENDFOR;

         IF RANG = *ZERO;
           *IN32 = *ON;
         ENDIF;

         LAST_RANG = RANG;

         EXEC SQL CLOSE c1;
       END-PROC;

       //************************************************************************
       //  Traitement du READC                                                 //
       //************************************************************************
       DCL-PROC TRT_READC;
         Readc Sfl1;
         DOW NOT %eof;

           SELECT;
           WHEN OPT = update;  // Option 1 Update
             update_pgm();
             leave;
           WHEN OPT = dsppgm;
             DSPPGM_pgm();
             leave;
           ENDSL;
         ENDDO;
       END-PROC;

       //************************************************************************
       //  UPDPGM                                                              //
       //************************************************************************
       DCL-PROC update_pgm;
         pr_cmdstr=*blanks;
         pr_cmdstr='UPDPGM PGM('+%trim(E1PGMLIB)+'/' + %trim(E1PGMNM) +
         ') MODULE('+%trim(E1PGMLIB)+'/' + %trim(INFMD) + ')';

         callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));

       END-PROC;

       //************************************************************************
       // Gestion date                                                     //
       //************************************************************************
       DCL-PROC gestion_date;
         //Mise à blanc date
         crdate = *blanks;
         jj = *blanks;
         mm = *blanks;
         aa = *blanks;

         // Parametre de l'API QUSROBJD
         ObjLen = %size(OBJD0100);
         ObjFmt = 'OBJD0100';
         ObjNme =  NMMD + LIBMD;
         ObjTyp = '*MODULE';

         // Appel l'API QUSROBJD pour savoir la date d'un objet
         CallP(e) QUSROBJD(OBJD0100:ObjLen:ObjFmt:ObjNme:ObjTyp);

         // La gestion de la date
         jj = %subst(crdate : 6 : 7);
         mm = %subst(crdate : 4 : 5);
         aa = %subst(crdate : 2 : 3);
         crdatep =   jj  + '/' + mm + '/' + aa ;
         crdate = '20' + %trim(aa) + '-' +
         %trim(mm) + '-' + %trim(jj);
       END-PROC;


       //************************************************************************
       //  DSPPGM                                                              //
       //************************************************************************
       DCL-PROC DSPPGM_pgm;
         pr_cmdstr=*blanks;
         pr_cmdstr='DSPPGM PGM('+%trim(E1PGMLIB)+'/' + %trim(E1PGMNM)
         +') DETAIL(*MODULE)';

         callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
       END-PROC;
```
