---
bibliotheque: BIB02
fichier_source: QSQLSRC
membre: SFRDS
type: SQL
longueur_enregistrement: 100
lignes: 229
modifie: 2026-11-16
---

# BIB02/QSQLSRC/SFRDS

```sql
       CTL-OPT COPYRIGHT('(C) ORGFORM 2023.') USRPRF(*OWNER)
       OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
       ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE);

       //*****************************************************************
       // Programme : SFRFD
       // BIB02 SYLVAIN - EXEMPLE DE SOUS-FICHIER DYNAMIQUE EN SQL AVEC DS
       // Date      - 15/01/2022
       // IMPORTANT !!- CHANGEZ LE OPTIMIZE(*FULL) EN *NONE POUR DEBUG
       // POUR DEBUGGER   !!!!!!!!!
       // Copyright - ORGFORM
       //*****************************************************************

       //**********************************************************************//
       // Déclaration des fichiers                                             //
       //**********************************************************************//
       DCL-F SFDSPFD WORKSTN SFILE(SFL1:RANG);

       //**********************************************************************//
       // Déclaration des variables                                            //
       //**********************************************************************//
       DCL-S LAST_RANG ZONED(4:0) INZ(*ZERO);
       DCL-S i         ZONED(4:0) INZ(*ZERO);
       DCL-S datejour  DATE(*ISO) INZ(*JOB);

       //**********************************************************************//
       // Déclaration des constantes                                           //
       //**********************************************************************//
       DCL-C SflPag    CONST(12);   // Nombre de ligne à afficher par page ...
       DCL-C Afficher  CONST('5');
       DCL-C Supprimer CONST('4');
       DCL-C Modifier  CONST('2');

       //**********************************************************************//
       // Déclaration des DS                                                   //
       //**********************************************************************//
       DCL-DS FicEcr EXTNAME('SFDSPFD');
       END-DS;

       //**********************************************************************//
       // Traitement pricipale                                                 //
       //**********************************************************************//
       *Inlr = *On;
       EXEC SQL
         SET option commit = *none , ALWCPYDTA = *OPTIMIZE;

       // A - Initialisation du sous-fichier
       Initialisation_sous_fichier();

       // B - Fabrication du sous-fichier
       Fabrication_sous_fichier();
       scodpro = *blank;

       DOU *IN03;  // Sortie F3
         Write Fkey1;
         Exfmt Sf1ctl;

         // Et là, on se pose la question : Qu'à fait l'utilisateur ?
         SELECT;
         WHEN *IN39;    // a-t-il paginé ? (Pagedown)
           Fabrication_sous_fichier();
         WHEN scodpro <> *blank; // a-t-il touché à la zone "Afficher à partir de" ?
           EXEC SQL close C1;
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();
           clear Scodpro;
         WHEN *IN05; // F5=Réafficher
           EXEC SQL close C1;
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();
         WHEN *IN06; // F6=Création
           creation();

         OTHER;
           EXEC SQL
           select codpro into :e1codpro from BIB02.entrepot;
           IF SQLCODE <> 100;  // si SQLCODE est différent de vide
             trt_readc();  // on fait un readc seulement s'il y a des données
           ENDIF;
           EXEC SQL close C1;
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();
         ENDSL;
       ENDDO;

       EXEC SQL close C1;

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
         EXEC SQL
               DECLARE C1 CURSOR FOR
               (SELECT codpro, nmpro, qtpro, dtdinv  FROM entrepot)
               FOR READ ONLY OPTIMIZE FOR ALL ROWS;
         EXEC SQL
               open C1;
       END-PROC;

       //************************************************************************
       // Fabrication du sous fichier                                          //
       //************************************************************************
       DCL-PROC Fabrication_sous_fichier;
         RANG = LAST_RANG;        // Le "relative record number"
         FOR i=1 to Sflpag;  // Tantque i est inférieur à sflpag
           EXEC SQL Fetch C1 into :FicEcr.e1codpro, :FicEcr.e1nmpro,
           :FicEcr.e1qtpro,
           :FicEcr.e1dtdinv;
           IF sqlcode = 100;
             *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
             leave;
           ENDIF;

           // Gere le "Afficher à partir de..."
           IF e1codpro >= scodpro;
             RANG += 1;  // Incrémentation du compteur de ligne
             write Sfl1;
           ENDIF;
         ENDFOR;

         IF RANG = *ZERO;
           *IN32 = *ON;
         ENDIF;
         LAST_RANG = RANG;

       END-PROC;

       //******************************************************************
       // Traitement du READC                                            //
       //******************************************************************
       DCL-PROC TRT_READC;
         Readc Sfl1;
         DOW NOT %eof;
           SELECT;
           WHEN OPT = Afficher;  // Option 5 Afficher
             affiche();
           WHEN OPT = Supprimer;  // Option 4 Supprimer
             suppression();
           WHEN OPT = Modifier;  // Option 2 Modifier
             modification();
           ENDSL;
           Readc Sfl1;
         ENDDO;
       END-PROC;

       //************************************************************************
       // Créer                                                                //
       //************************************************************************
       DCL-PROC creation;
         E6DTDINV = datejour;
         EXFMT FMT6;
         IF *IN23;
           EXEC SQL
             insert into BIB02.entrepot (codpro, nmpro, qtpro, dtdinv)
             values ( :E6CODPRO, :E6NMPRO, :E6QTPRO, :datejour);
           IF sqlcode = 0;
             Initialisation_sous_fichier();
             Fabrication_sous_fichier();
           ENDIF;
         ENDIF;
       END-PROC;

       //************************************************************************
       // Afficher                                                             //
       //************************************************************************
       DCL-PROC affiche;

         EXEC SQL
         SELECT codpro, nmpro, qtpro, dtdinv
           INTO :e5codpro, :e5nmpro, :e5qtpro, :e5dtdinv
         FROM BIB02.entrepot
         WHERE codpro = :e1codpro;
         EXFMT FMT5;
         OPt = *blank;        // Remise à blanc de l'option saisie
         Update Sfl1;
       END-PROC;

       //************************************************************************
       // Modifier                                                             //
       //************************************************************************
       DCL-PROC modification;
         E2CODPRO = E1CODPRO;
         E2NMPRO  = E1NMPRO;
         E2QTPRO  = E1QTPRO ;
         E2DTDINV = E1DTDINV;
         DOU *IN03;
           EXFMT FMT2;
           SELECT;
           WHEN *IN03;
             iter;
           WHEN *IN12;
             leave;
           WHEN *IN23;
             EXEC SQL
             update BIB02.entrepot
             set codpro = :E2CODPRO, nmpro = :E2NMPRO,
             qtpro = :E2QTPRO, dtdinv = :E2DTDINV
             where codpro = :e2codpro;
             leave;
           ENDSL;
         ENDDO;
         OPT = *blank;
         Update Sfl1;
       END-PROC;

       //************************************************************************
       // Supprimer                                                            //
       //************************************************************************
       DCL-PROC suppression;
         E4CODPRO = E1CODPRO;
         E4NMPRO  = E1NMPRO;
         E4QTPRO  = E1QTPRO;
         E4DTDINV = E1DTDINV;
         EXFMT FMT4 ;
         OPT = *blank;        // Remise à blanc de l'option saisie
         IF *IN23; // Si F23 on active le delete
           EXEC SQL
             delete from BIB02.entrepot where codpro = :e4codpro;
         ENDIF;
         Update Sfl1;
       END-PROC;
```
