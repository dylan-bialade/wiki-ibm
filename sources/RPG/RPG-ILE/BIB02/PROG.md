---
bibliotheque: BIB02
fichier_source: QSRC
membre: PROG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 321
modifie: 2026-11-16
---

# BIB02/QSRC/PROG

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-F ECRAN WORKSTN SFILE(SFL1:RANG);
       DCL-PR PRINT EXTPGM;

       END-PR;

       DCL-PR PROGFORMA EXTPGM;
       END-PR;

       DCL-PR PROGPART EXTPGM;
       END-PR;

       DCL-C SFLPAG CONST(13);   // NOMBRE DE LIGNE à AFFICHER PAR PAGE ...

       DCL-S LAST_RANG PACKED(4:0) INZ(0);     // DERNIER RRN ÉCRIT AVANT PAGINATION ...
       DCL-S I      PACKED(4:0) INZ(0);
       DCL-S datejour date ;

       DCL-C AFFICHER CONST('5');
       DCL-C SUPPRIMER CONST('4');
       DCL-C MODIFIER CONST('2');


       datejour = %date();
       *INLR = *ON;
       EXEC SQL
         SET OPTION COMMIT = *NONE,
           datfmt = *ISO;
       // A- INITIALISATION DU SOUS-FICHIER
       INITIALISATION_SOUS_FICHIER();
       FABRICATION_SOUS_FICHIER();


       SDTDBT = %date('0001-01-01');


       DOW NOT *IN03;
         RANG = 1;
         WRITE FKEY1;

         EXFMT SF1CTL;

         SELECT;

         WHEN *IN03;
           LEAVE;

         WHEN *IN07;
           callp PROGPART();
         WHEN *IN09;
           callp PROGFORMA();

         WHEN *IN39;

           FABRICATION_SOUS_FICHIER();

         WHEN SDTDBT <> %date('0001-01-01');// A-T-IL TOUCHÉ à LA ZONE "Afficher à partir de" ?

           EXEC SQL CLOSE C1;
           INITIALISATION_SOUS_FICHIER();
           FABRICATION_SOUS_FICHIER();
           CLEAR SDTDBT;

         WHEN *IN06;
           CREATION();
         WHEN *IN08;
           IMPRESSION();
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
               SELECT CODSES, BIB02.PARTICIPA.CODPAR,
               BIB02.SESSIONSP.CODFOR,BIB02.FORMATEUR.CODFMTEUR,
               DTDBT, DTFIN, BIB02.PARTICIPA.NM,
               BIB02.PARTICIPA.PRN, BIB02.PARTICIPA.SCTE, ETAT, TPE,
                BIB02.PARTICIPA.ADR,  BIB02.PARTICIPA.NUMTEL ,
               BIB02.FORMA.NBJFOR, BIB02.FORMATEUR.PRNFMTEUR

              FROM BIB02.SESSIONSP
              INNER JOIN  BIB02.PARTICIPA
                ON BIB02.SESSIONSP.CODPAR = BIB02.PARTICIPA.CODPAR
              INNER JOIN BIB02.FORMA
                ON  BIB02.SESSIONSP.CODFOR = BIB02.FORMA.CODFOR
              INNER JOIN BIB02.FORMATEUR
                ON BIB02.SESSIONSP.CODFMTEUR = BIB02.FORMATEUR.CODFMTEUR
              ORDER BY DTDBT;

         EXEC SQL
         OPEN C1;

         FOR I TO SFLPAG;
           DOW SQLCODE = 0;
             EXEC SQL FETCH C1 INTO :E1CODSES,:E1CODPAR,
              :E1CODFOR, :E1CODFMTR, :E1DTDBT, :E1DTFIN, :E1NM,
               :E1PRN, :E1SCTE, :E1ETAT, :E1TPE , :E1ADR,
               :E1NUMTEL, :E1NBJFOR, :E1PRNFMTR;
             IF SQLCODE = 100;
               *IN90=*ON;
               LEAVE;
             ENDIF;
             IF E1DTDBT >= SDTDBT;
               *IN88 = *OFF;
               IF E1ETAT = 'N';  // SI LE PARTICIPANT N'A PAS PAYÉ ALORS ACTIVÉ(88) COLOR RED
                 *IN88 = *ON;
               ENDIF;

               *IN89 = *OFF;
               IF E1TPE = 'D';  // SI LE PARTICIPANT N'A PAS PAYÉ ALORS ACTIVÉ(88) COLOR RED
                 *IN89 = *ON;
               ENDIF;

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
             E5CODSES = E1CODSES;
             E5CODPAR = E1CODPAR;
             E5CODFOR = E1CODFOR;
             E5DTDBT  = E1DTDBT;
             E5DTFIN  = E1DTFIN;
             E5NM     = E1NM;
             E5PRN    = E1PRN;
             E5SCTE   = E1SCTE;
             E5ETAT   = E1ETAT;
             E5TPE    = E1TPE;
             E5PRNFMTR   = E1PRNFMTR;
             E5ADR    = E1ADR;
             E5NUMTEL = E1NUMTEL;
             EXFMT FMT5;
             OPt = ' ';        // Remise à blanc de l'option
             Update Sfl1;
           When OPT = Supprimer;  // Option 4 Supprimer
             E4CODSES = E1CODSES ;
             E4CODFOR = E1CODFOR;
             E4DTDBT  = E1DTDBT;
             E4DTFIN  = E1DTFIN ;
             E4NM     = E1NM;
             E4PRN    = E1PRN ;
             E4SCTE   = E1SCTE ;
             E4ETAT   = E1ETAT ;
             E4TPE    = E1TPE ;
             E4PRNFMTR  = E1PRNFMTR ;
             EXFMT FMT4 ;
             OPT = ' ';        // Remise à blanc de l'option saisie
             if *in23; // Si F23 on active le delete
               EXEC SQL
                delete from BIB02/SESSIONSP where CODSES = :E1CODSES ;
             ENDIF;
             Update Sfl1;
           When OPT = Modifier;     // Option 2 saisie
             E2CODSES = E1CODSES ;
             E2CODFOR = E1CODFOR;
             E2CODPAR = E1CODPAR;
             E2CODFMTR = E1CODFMTR;
             E2DTDBT  = E1DTDBT;
             E2NM     = E1NM;
             E2PRN    = E1PRN ;
             E2SCTE   = E1SCTE ;
             E2ETAT   = E1ETAT ;
             E2TPE    = E1TPE ;
             E2PRNFMTR   = E1PRNFMTR ;
             DOW NOT *IN03;
               EXFMT FMT2 ;
               SELECT;
               WHEN *IN03;
                 leave;
               WHEN *IN12;
                 leave;
               WHEN *IN23;
                 EXEC SQL
                   select nbjfor INTO :E1NBJFOR from BIB02.FORMA
                   where BIB02.FORMA.codfor = :E2CODFOR;

                 E2NBJFOR = E1NBJFOR; // LE NBJ DANS UNE FORMA
                 E2DTFIN  = E2DTDBT + %days(E2NBJFOR) - %days(1);

                 EXEC SQL
                 update BIB02/SESSIONSP
                 set codfor = :E2CODFOR, dtdbt = :E2DTDBT, dtfin = :E2DTFIN,
                 etat = :E2etat, nm = :E2NM, prn = :E2PRN,
                 scte = :E2SCTE,
                 tpe = :E2tpe,PRNFMTEUR = :E2PRNFMTR
                 where codses = :E2CODSES;

                 leave;
                 WHEN OPT = ' ';
                    *IN63 = *ON;
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
         E6DTDBT  = datejour;   // Ajoute la date du jour à la zone date debut
           EXEC SQL // Incrémentation du code sesssion
             select max(codses)+1 INTO :E1CODSES
             from BIB02.sessionsp ;
           E6CODSES = E1CODSES;
         EXFMT FMT6;
         IF *IN23;

           EXEC SQL
            select nbjfor INTO :E1NBJFOR
            from BIB02.FORMA
            where BIB02.FORMA.codfor = :E6CODFOR;

           E6NBJFOR = E1NBJFOR; // LE NBJ DANS UNE FORMA
           E6DTFIN  = E6DTDBT + %days(E6NBJFOR) - %days(1);


           EXEC SQL
            select codpar, nm, prn, scte INTO  :E1CODPAR, :E1NM, :E1PRN,
              :E1SCTE
             from BIB02.PARTICIPA
             where BIB02.PARTICIPA.codpar = :E6CODPAR ;

           EXEC SQL
             select CODFMTEUR, PRNFMTEUR INTO :E1CODFMTR, :E1PRNFMTR
             from BIB02.formateur
             where BIB02.formateur.CODFMTEUR = :E6CODFMTR;

           IF E1CODPAR = E6CODPAR AND E1NM = E6NM AND E1PRN = E6PRN AND
           E1SCTE = E6SCTE;
             EXEC SQL
               insert into BIB02.SESSIONSP  (codses, codpar,
               codfor,codfmteur,dtdbt, dtfin, nm, prn, scte,
               etat, tpe, prnfmteur)
               values (:E6CODSES, :E6CODPAR, :E6CODFOR, :E6CODFMTR ,
               :E6DTDBT,
               :E6DTFIN, :E6NM,
               :E6PRN, :E6SCTE,
                :E6ETAT, :E6TPE,  :E6PRNFMTR);
           ENDIF ;

           *IN61 = *ON;

           IF  sqlcode = -803 ;
             *IN60 = *On;
             exfmt FMT6 ;
             read fmt6;
           ENDIF;

           IF SQLCODE <> 0 ;
             *IN61 = *on;
             EXFMT FMT6;
           ENDIF;

         ENDIF;

         *IN60 = *Off;
         Initialisation_sous_fichier();
         Fabrication_sous_fichier();

       END-PROC;

       //************************************************************************
       // Impression
       //************************************************************************

       DCL-PROC Impression ;
         CallP Print()  ;
       END-PROC;
```
