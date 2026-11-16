---
bibliotheque: BIB02
fichier_source: QSRC
membre: PROGFORMA
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 202
modifie: 2026-11-16
---

# BIB02/QSRC/PROGFORMA

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-F ECRANFORMA WORKSTN SFILE(SFL1:RANG);

       DCL-C SFLPAG CONST(13);   // NOMBRE DE LIGNE à AFFICHER PAR PAGE ...

       DCL-S LAST_RANG PACKED(4:0) INZ(0);     // DERNIER RRN ÉCRIT AVANT PAGINATION ...
       DCL-S I      PACKED(4:0) INZ(0);

       DCL-C SUPPRIMER CONST('4');
       DCL-C MODIFIER CONST('2');

       DCL-PR PRINTPAR EXTPGM;

       END-PR;

       *INLR = *ON;
       SNUMFOR = 0;
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

         WHEN SNUMFOR <> 0;// A-T-IL TOUCHÉ à LA ZONE "Afficher à partir de" ?

           EXEC SQL CLOSE C1;
           INITIALISATION_SOUS_FICHIER();
           FABRICATION_SOUS_FICHIER();
           CLEAR SNUMFOR;

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
               SELECT NUMFOR, CODFOR,
               LIBFOR, DETFOR, NBJFOR
              FROM BIB02.FORMA
              ORDER BY NUMFOR;

         EXEC SQL
         OPEN C1;

         FOR I TO SFLPAG;
           DOW SQLCODE = 0;
             EXEC SQL FETCH C1 INTO :E1NUMFOR,:E1CODFOR,
              :E1LIBFOR, :E1DETFOR, :E1NBJFOR;
             IF SQLCODE = 100;
               *IN90=*ON;
               LEAVE;
             ENDIF;
             IF E1NUMFOR >= SNUMFOR;
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
           When OPT = Supprimer;  // Option 4 Supprimer
             E4NUMFOR = E1NUMFOR;
             E4CODFOR = E1CODFOR;
             E4LIBFOR     = E1LIBFOR;
             E4DETFOR    = E1DETFOR;
             E4NBJFOR    = E1NBJFOR;
             EXFMT FMT4 ;
             OPT = ' ';        // Remise à blanc de l'option saisie
             if *in23; // Si F23 on active le delete
               EXEC SQL
                delete from BIB02/FORMA where NUMFOR = :E1NUMFOR ;
             ENDIF;
             Update Sfl1;
           When OPT = Modifier;     // Option 2 saisie
            E2NUMFOR = E1NUMFOR;
             E2CODFOR = E1CODFOR;
             E2LIBFOR     = E1LIBFOR;
             E2DETFOR    = E1DETFOR;
             E2NBJFOR    = E1NBJFOR;
             DOW NOT *IN03;
               EXFMT FMT2 ;
               SELECT;
               WHEN *IN03;
                 leave;
               WHEN *IN12;
                 leave;
               WHEN *IN23;
                 EXEC SQL
                 update BIB02/FORMA
                 set NUMFOR = :E2NUMFOR, CODFOR = :E2CODFOR,
                 LIBFOR = :E2LIBFOR,
                 NBJFOR = :E2NBJFOR
                 where NUMFOR = :E2NUMFOR;

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
           select max(NUMFOR)+1 INTO :E1NUMFOR
           from BIB02.forma ;
         E6NUMFOR = E1NUMFOR;
         EXFMT FMT6;
         IF *IN23;

           EXEC SQL
             insert into BIB02.FORMA  (NUMFOR, CODFOR, LIBFOR, DETFOR,
             NBJFOR)
             values (:E6NUMFOR, :E6CODFOR,
             :E6LIBFOR, :E6DETFOR, :E6NBJFOR);

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
