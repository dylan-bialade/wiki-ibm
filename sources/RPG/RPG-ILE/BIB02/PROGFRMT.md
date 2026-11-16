---
bibliotheque: BIB02
fichier_source: QSRC
membre: PROGFRMT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 209
modifie: 2026-11-16
---

# BIB02/QSRC/PROGFRMT

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-F ECRANFRMT WORKSTN SFILE(SFL1:RANG);

       DCL-C SFLPAG CONST(13);   // NOMBRE DE LIGNE à AFFICHER PAR PAGE ...

       DCL-S LAST_RANG PACKED(4:0) INZ(0);     // DERNIER RRN ÉCRIT AVANT PAGINATION ...
       DCL-S I      PACKED(4:0) INZ(0);

       DCL-C AFFICHER CONST('5');
       DCL-C SUPPRIMER CONST('4');
       DCL-C MODIFIER CONST('2');

       DCL-PR PRINTPAR EXTPGM;

       END-PR;

       *INLR = *ON;
       SCODFMT = 0;
       EXEC SQL
         SET OPTION COMMIT = *NONE,
           datfmt = *ISO;
       // A- INITIALISATION DU SOUS-FICHIER
       INITIALISATION_SOUS_FICHIER();
       FABRICATION_SOUS_FICHIER();


       DOW NOT *IN03;
         RANG = 1;
         WRITE FKEY1;

         EXFMT SF1CTL;

         SELECT;

         WHEN *IN03;
           LEAVE;

         WHEN *IN39;

           FABRICATION_SOUS_FICHIER();

         WHEN SCODFMT <> 0;// A-T-IL TOUCHÉ à LA ZONE "Afficher à partir de" ?

           EXEC SQL CLOSE C1;
           INITIALISATION_SOUS_FICHIER();
           FABRICATION_SOUS_FICHIER();
           CLEAR SCODFMT;

         WHEN *IN06;
           CREATION();
         WHEN *IN08;
           Impression();
         OTHER;
           TRT_READC();
         ENDSL;

       ENDDO;

       EXEC SQL CLOSE C1;

       //************************************************************************
       //  INITIALISATION DU SOUS FICHIER
       //************************************************************************
       DCL-PROC INITIALISATION_SOUS_FICHIER;
         RANG = *ZERO;   // INITIALISAT° DU COMPTEUR D'enregistrement.
         LAST_RANG = *ZERO;
         *IN31 = *ON;    // ACTIVAT° DE L'indic de vidage de SFL  (Associé au mot clé SFLCR)
         WRITE SF1CTL;      // VIDAGE DU SOUS-FICHIER
         *IN31 = *OFF;   // DÉSACTIVAT° DE L'indic de vidage de SFL (Associé au mot clé SFLCLR)
         *IN32 = *OFF;   // DÉSACTIVAT° DE L'indic de vidage de SFL (Associé au mot clé SFLDSP)
         *IN90 = *OFF;   // DÉSACTIVAT° DE L'indic de vidage de SFL (Associé au mot clé SFLEND)
         *IN63 = *OFF;
         I = 1;
       END-PROC;

       //************************************************************************
       // FABRICATION DU SOUS FICHIER
       //************************************************************************
       DCL-PROC FABRICATION_SOUS_FICHIER;
         RANG = LAST_RANG;        // LE "relative record number" REÇOIT LA VALEUR DU DERNIER
         EXEC SQL
               DECLARE C1 CURSOR FOR
               SELECT CODFMTEUR, NOMFMTEUR,
               PRNFMTEUR,NUMTELEUR
              FROM BIB02.FORMATEUR
              ORDER BY CODFMTEUR;

         EXEC SQL
         OPEN C1;

         FOR I TO SFLPAG;
           DOW SQLCODE = 0;
             EXEC SQL FETCH C1 INTO :E1CODFMT,:E1NM,
              :E1PRN, :E1NUMTEL;
             IF SQLCODE = 100;
               *IN90=*ON;
               LEAVE;
             ENDIF;
             IF E1CODFMT >= SCODFMT;
               RANG += 1;  // INCRÉMENTATION DU COMPTEUR DE LIGNE
               WRITE SFL1;
             ENDIF;
           ENDDO;
         ENDFOR;

         IF RANG = *ZERO;      // SI AUCUN ENREGISTREMENT DÉTECTÉ DANS LE SOUS-FICHIER
           *IN32 = *ON;            //   ACTIVER L'indicateur masquant le sous-fichier
         ENDIF;
         LAST_RANG = RANG;        // SAUVEGARDER LE DERNIER ENREGISTREMENT CHARGÉ
         EXEC SQL CLOSE C1;
       END-PROC;

       //************************************************************************
       // Traitement du READC
       //************************************************************************
       Dcl-Proc TRT_READC;
         Readc Sfl1;
         Dow Not %eof;

           // Tant que toutes les lignes modifiés n'ont pas été traitées
           Select;
           When OPT = Afficher;  // Option 5 Afficher
             E5CODFMT = E1CODFMT;
             E5NM     = E1NM;
             E5PRN    = E1PRN;
             E5NUMTEL    = E1NUMTEL;
             EXFMT FMT5;
             OPt = ' ';        // Remise à blanc de l'option
             Update Sfl1;
           When OPT = Supprimer;  // Option 4 Supprimer
             E4CODFMT = E1CODFMT;
             E4NM     = E1NM;
             E4PRN    = E1PRN;
             E4NUMTEL    = E1NUMTEL;
             EXFMT FMT4 ;
             OPT = ' ';        // Remise à blanc de l'option saisie
             if *in23; // Si F23 on active le delete
               EXEC SQL
                delete from BIB02/FORMATEUR where CODFMTEUR = :E1CODFMT ;
             ENDIF;
             Update Sfl1;
           When OPT = Modifier;     // Option 2 saisie
             E2CODFMT = E1CODFMT;
             E2NM     = E1NM;
             E2PRN    = E1PRN;
             E2NUMTEL    = E1NUMTEL;
             DOW NOT *IN03;
               EXFMT FMT2 ;
               SELECT;
               WHEN *IN03;
                 leave;
               WHEN *IN12;
                 leave;
               WHEN *IN23;
                 EXEC SQL
                 update BIB02/FORMATEUR
                 set CODFMTEUR = :E2CODFMT, NOMFMTEUR = :E2NM,
                 PRNFMTEUR = :E2PRN,
                 NUMTELEUR = :E2NUMTEL
                 where CODFMTEUR = :E2CODFMT;

                 leave;
               WHEN OPT = ' ';
               ENDSL;
             ENDDO;
             OPT = ' ';
             Update Sfl1;
           ENDSL;
           Readc Sfl1;
         enddo;
         Initialisation_sous_fichier();
         Fabrication_sous_fichier();

       End-Proc;

       //************************************************************************
       // Création
       //************************************************************************

       dcl-proc creation;
         EXEC SQL // Incrémentation du code sesssion
           select max(CODFMTEUR)+1 INTO :E1CODFMT
           from BIB02.formateur ;
         E6CODFMT = E1CODFMT;
         EXFMT FMT6;
         IF *IN23;

           EXEC SQL
             insert into BIB02.FORMATEUR  (codfmteur, nomfmteur, prnfmteur,
             numteleur)
             values (:E6CODFMT, :E6NM,
             :E6PRN,:E6NUMTEL);

         ENDIF;

         Initialisation_sous_fichier();
         Fabrication_sous_fichier();

       END-PROC;

       //************************************************************************
       // Impression
       //************************************************************************

       DCL-PROC Impression ;
         CallP Printpar()  ;
       END-PROC;
```
