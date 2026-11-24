---
bibliotheque: BIB02
fichier_source: QSFSRC
membre: SFRSQLRDO
type: DDS
longueur_enregistrement: 100
lignes: 212
modifie: 2026-11-16
---

# BIB02/QSFSRC/SFRSQLRDO

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL);

       //*****************************************************************
       // BIB02 SYLVAIN - EXEMPLE DE SOUS FICHIER EN SQL
       // POUR LA FORMATION RDO - RACEPROD
       // Copyright - ORGFORM
       //*****************************************************************

       //**********************************************************************//
       // Déclaration des fichiers                                             //
       //**********************************************************************//
       DCL-F SFDSPSQLRO WORKSTN SFILE(SFL1:RANG);


       //**********************************************************************//
       // Déclaration des prototypes                                           //
       //**********************************************************************//
       DCL-PR PRINTSQLRO EXTPGM;
       END-PR;


       //**********************************************************************//
       // Déclaration des variables                                             //
       //**********************************************************************//
       DCL-S LAST_RANG ZONED(4:0) INZ(0);    // Dernier rrn écrit avant pagination
       DCL-S i         ZONED(4:0) INZ(0);
       DCL-S datejour  DATE(*EUR) INZ(*JOB);

       //----------------------------------------------------------------------//
       // Déclaration des constantes                                           //
       //----------------------------------------------------------------------//
       DCL-C SflPag    CONST(12);   // Nombre de ligne à afficher par page ...
       DCL-C Afficher  CONST('5');
       DCL-C Supprimer CONST('4');
       DCL-C Modifier  CONST('2');

       *Inlr = *On;
       EXEC SQL
         SET option commit = *none;

       // A - Initialisation du sous-fichier
       Initialisation_sous_fichier();

       // B - Fabrication du sous-fichier
       Fabrication_sous_fichier();
       scodpro = ' ';

       DOW NOT *IN03;  // Sortie F3
         RANG = 1;

         Write Fkey1;
         Exfmt Sf1ctl;

         // Et là, on se pose la question : Qu'à fait l'utilisateur ?
         SELECT;

         WHEN *IN39 AND (NOT *IN90);    // a-t-il paginé ?
           Fabrication_sous_fichier();
         WHEN scodpro <> ' '; // a-t-il touché à la zone "Afficher à partir de" ?
           EXEC SQL close C1;
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();
           clear Scodpro;
         WHEN *IN06; // F6
           creation();
         WHEN *IN08; // F8
            impression();
         OTHER;
           TRT_READC();
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();
         ENDSL;

       ENDDO;

       EXEC SQL close C1;

       //************************************************************************
       // Initialisation du sous fichier
       //************************************************************************
       DCL-PROC Initialisation_sous_fichier;
         RANG = *Zero;   // Initialisat° du compteur d'enregistrement.
         LAST_RANG = *zero;
         *In31 = *On;    // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
         Write Sf1ctl;   // Vidage du sous-fichier
         *In31 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
         *In32 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
         *In90 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLEND)
         i = 1;
       END-PROC;

       //************************************************************************
       // Fabrication du sous fichier
       //************************************************************************
       DCL-PROC Fabrication_sous_fichier;
         RANG = LAST_RANG;        // Le "relative record number" reçoit la valeur du dernier
         EXEC SQL
               Declare c1 CURSOR FOR
                 select codpro, nmpro, qtpro, dtdinv
                 from raceprod/entrepot
                 order by codpro;

         EXEC SQL
               open C1;

         FOR i to Sflpag;  // Tantque i est inférieur à sflpag

           DOW SQLCODE = 0;
             EXEC SQL Fetch C1 into  :e1codpro, :e1nmpro, :e1qtpro, :e1dtdinv;
             IF sqlcode = 100;
               *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
               leave;
             ENDIF;

             // Gere le "Afficher à partir de..."
             IF E1codpro >= scodpro;
               RANG += 1;  // Incrémentation du compteur de ligne
               write Sfl1;
             ENDIF;
           ENDDO;

         ENDFOR;

         IF RANG = *Zero;
           *IN32 = *on;
         ENDIF;
         LAST_RANG = RANG;

         EXEC SQL CLOSE c1;
       END-PROC;


       // ******************************************************************
       //  Traitement du READC
       // ******************************************************************
       DCL-PROC TRT_READC;
         Readc Sfl1;
         DOW NOT %eof;

           SELECT;
           WHEN OPT = Afficher;  // Option 5 Afficher
             E5CODPRO = E1CODPRO;
             E5NMPRO  = E1NMPRO;
             E5QTPRO  = E1QTPRO ;
             E5DTDINV = E1DTDINV;
             EXFMT FMT5;
             OPt = ' ';        // Remise à blanc de l'option saisie
             Update Sfl1;
           WHEN OPT = Supprimer;  // Option 4 Supprimer
             E4CODPRO = E1CODPRO;
             E4NMPRO  = E1NMPRO;
             E4QTPRO  = E1QTPRO;
             E4DTDINV = E1DTDINV;
             EXFMT FMT4 ;
             OPT = ' ';        // Remise à blanc de l'option saisie
             IF *IN23; // Si F23 on active le delete
               EXEC SQL
                 delete from raceprod/entrepot where codpro = :e4codpro;
             ENDIF;
             Update Sfl1;
           WHEN OPT = Modifier;  // Option 2 Modifier
             E2CODPRO = E1CODPRO;
             E2NMPRO  = E1NMPRO;
             E2QTPRO  = E1QTPRO ;
             E2DTDINV = E1DTDINV;
             DOW NOT *IN03;
               EXFMT FMT2 ;
               SELECT;
               WHEN *IN03;
                 leave;
               WHEN *IN12;
                 return;
               WHEN *IN23;
                 EXEC SQL
                   update raceprod/entrepot
                   set codpro = :E2CODPRO, nmpro = :E2NMPRO,
                   qtpro = :E2QTPRO, dtdinv = :E2DTDINV
                   where codpro = :e2codpro;
                 leave;
               ENDSL;
             ENDDO;
             OPT = ' ';
             Update Sfl1;
           ENDSL;
           Readc Sfl1;
         ENDDO;
       END-PROC;

       //************************************************************************
       // Création
       //************************************************************************
       DCL-PROC creation;
         E6DTDINV = datejour;
         EXFMT FMT6;
         IF *IN23;
           EXEC SQL
             insert into raceprod.entrepot (codpro, nmpro, qtpro, dtdinv)
             values ( :E6CODPRO, :E6NMPRO, :E6QTPRO, :datejour);
           IF sqlcode = 0;
             Initialisation_sous_fichier();
             Fabrication_sous_fichier();
           ENDIF;
         ENDIF;
       END-PROC;


       //************************************************************************
       // Impression
       //************************************************************************
       DCL-PROC impression;
            CallP PRINTSQLRO() ;
       END-PROC;
```
