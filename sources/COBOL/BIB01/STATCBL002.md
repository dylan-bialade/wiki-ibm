---
bibliotheque: BIB01
fichier_source: QCBLLESRC
membre: STATCBL002
type: COBOL
longueur_enregistrement: 80
lignes: 255
modifie: 2026-11-16
---

# BIB01/QCBLLESRC/STATCBL002

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. STATCBL002.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
     ***************************(Cartes F)*****************************
       FILE-CONTROL.
     ******************************************************************
            SELECT FICHIER1 ASSIGN TO DATABASE-SFL001LF
            ORGANIZATION INDEXED
            RECORD KEY DBLNAM OF PFR
            FILE STATUS ST1
            ACCESS DYNAMIC.
     *

            SELECT ECRAN ASSIGN TO WORKSTATION-SFL001CBLD
            ORGANIZATION TRANSACTION
            FILE STATUS ST2
            ACCESS DYNAMIC
            RELATIVE KEY NORANG
            CONTROL-AREA WFTOUCHE.

     ****************************(Cartes I)****************************
       DATA DIVISION.

       FD FICHIER1 LABEL RECORD STANDARD.
       01 ENREG-PFR.
       COPY DDS-ALL-FORMATS OF SFL001LF.


       FD ECRAN.
       01 LIGNEECRAN.
       COPY DDS-ALL-FORMATS OF SFL001CBLD.

     ****************************(*ENTRY ... PLIST)**ou DCL-I**********
       LINKAGE SECTION.
          01 PARAM01 PIC X(10).

     ****************************(Cartes D)****************************
       WORKING-STORAGE SECTION.
     ******************************************************************
       77 PTNAME-IN PIC X(10).
       77 NORANG PIC 9999.
       77 FIN_FIC  PIC 9.
       77 ST1 PIC XX.
          88 EOF1 VALUE "10".
       77 ST2 PIC XX.
          88 EOF2 VALUE "10".
       77 WFTOUCHE PIC XX.
          88 TROIS   VALUE "03".
          88 AJOUTER VALUE "06".
          88 DOUZE   VALUE "12".
          88 CONFIRM VALUE "23".
          88 CHANGE  VALUE "51".
       77 GOTOU PIC 9.

       77 FLAGEOSFL PIC 1.
          88 EOSFL     value B'1'.
          88 NOT-EOSFL value B'0'.

       01 TINDIC.
          05 IND OCCURS 99 PIC 1 INDICATOR 01.

       77 MOIS PIC X(20) OCCURS 12.

     **************************************(Cartes C avec USING = *ENTRY)
       PROCEDURE DIVISION USING PARAM01.
     ******************************************************************
       MAIN-PROCEDURE.
            OPEN I-O   FICHIER1.
            OPEN I-O ECRAN.

               PERFORM DEBUT-INIT THRU FIN-INIT
               MOVE 2 TO GOTOU
      * Setll ...
               MOVE SPACES TO DBLNAM OF ENREG-PFR
               START FICHIER1
                  KEY >= DBLNAM OF ENREG-PFR
                  INVALID KEY GO TO FINPGM DEPENDING ON GOTOU
                  NOT INVALID KEY CONTINUE
               END-START

      * Remplissage sous-fichier:
               PERFORM DEBUT-REMP-SFL THRU FIN-REMP-SFL

      * Do While not F3:
            PERFORM UNTIL TROIS OR DOUZE
      * Affichage/lecture écran:
               MOVE 1 TO NORANG
               MOVE SPACES TO PTNAME OF SF1CTL-O
               WRITE LIGNEECRAN FORMAT "FKEY1"

      * Write+Read = EXFMT !
               MOVE PARAM01 TO FLD001 OF SF1CTL-O
               WRITE LIGNEECRAN FROM SF1CTL-O FORMAT "SF1CTL"
               READ ECRAN INTO SF1CTL-I FORMAT "SF1CTL"
               INDIC SF1CTL-I-INDIC
               EVALUATE TRUE
      *           Afficher à partir de ...
                  WHEN IN51 OF SF1CTL-I = B'1'
                     PERFORM DEBUT-INIT THRU FIN-INIT
                     MOVE PTNAME OF SF1CTL-I TO DBLNAM OF ENREG-PFR
                     START FICHIER1
                        KEY >= DBLNAM OF ENREG-PFR
                        INVALID KEY GO TO FINPGM DEPENDING ON GOTOU
                        NOT INVALID KEY CONTINUE
                     END-START
                     PERFORM DEBUT-REMP-SFL THRU FIN-REMP-SFL
      *           Créat°
                  WHEN AJOUTER
                     PERFORM DEBUT-E6
      *           Sortie
                  WHEN TROIS  GO TO FINPGM
      *           TRT_READC
                  WHEN OTHER
                     PERFORM DEB-READC THRU FIN-READC
                     PERFORM DEBUT-INIT THRU FIN-INIT
                     MOVE SPACES TO DBLNAM OF ENREG-PFR
                     START FICHIER1
                        KEY >= DBLNAM OF ENREG-PFR
                        INVALID KEY GO TO FINPGM DEPENDING ON GOTOU
                        NOT INVALID KEY CONTINUE
                     END-START
                     PERFORM DEBUT-REMP-SFL THRU FIN-REMP-SFL
               END-EVALUATE

            END-PERFORM.
       FINPGM.
            CLOSE FICHIER1.
            CLOSE ECRAN.
            STOP RUN.

      ********************************************************
      * Gestion du READC ...
      ********************************************************
        DEB-READC.
           READ SUBFILE ECRAN NEXT MODIFIED INTO SFL1-I
                FORMAT IS "SFL1" AT END SET EOSFL TO TRUE.
           PERFORM UNTIL EOSFL
               IF OPT = "5"
                    PERFORM DEBUT-E5 THRU FIN-E5
               END-IF
               If OPT OF LIGNEECRAN = "2"
                    PERFORM DEBUT-E2 THRU FIN-E2
               END-IF
               If OPT OF LIGNEECRAN = "4"
                    PERFORM DEBUT-SUPP THRU FIN-SUPP
               END-IF
               PERFORM DEB-LECT-NEXT THRU FIN-LECT-NEXT
           END-PERFORM.
        FIN-READC. EXIT.
      ********************************************************
      * Gestion Lecture de l'enreg suivant du sous-fichier
      ********************************************************
        DEB-LECT-NEXT.
            MOVE SPACES TO OPT
            REWRITE SUBFILE LIGNEECRAN FROM LIGNEECRAN FORMAT "SFL1"
            READ SUBFILE ECRAN NEXT MODIFIED INTO LIGNEECRAN
              FORMAT "SFL1" AT END SET EOSFL TO TRUE.
        FIN-LECT-NEXT. EXIT.
      ********************************************************
      * Gestion Ecran d'affichage E5 - Mode affichage
      ********************************************************
        DEBUT-E5.
           MOVE DBLNAM OF SFL1-I OF LIGNEECRAN
            TO DBLNAM OF FMT5-O OF LIGNEECRAN.
           MOVE DBFNAM OF SFL1-I OF LIGNEECRAN OF ECRAN
            TO DBFNAM OF FMT5-O OF LIGNEECRAN OF ECRAN.
           MOVE DBCIVI OF SFL1-I OF LIGNEECRAN OF ECRAN
            TO DBCIVI OF FMT5-O OF LIGNEECRAN OF ECRAN.
           MOVE DBTELP OF SFL1-I OF LIGNEECRAN OF ECRAN
            TO DBTELP OF FMT5-O OF LIGNEECRAN OF ECRAN.

                    WRITE LIGNEECRAN FROM FMT5-O FORMAT "FMT5"
                    READ ECRAN INTO FMT5-I   FORMAT "FMT5"
                         INDIC TINDIC.
                    CONTINUE.
        FIN-E5.  EXIT.
      ********************************************************
      * Gestion Ecran d'affichage E6 - Mode  mise à jour
      ********************************************************
        DEBUT-E2.
           MOVE DBLNAM OF SFL1-I OF LIGNEECRAN
             TO DBLNAM OF FMT2-O OF LIGNEECRAN.
           MOVE DBFNAM OF SFL1-I OF LIGNEECRAN
             TO DBFNAM OF FMT2-O OF LIGNEECRAN.
           MOVE DBCIVI OF SFL1-I OF LIGNEECRAN
             TO DBCIVI OF FMT2-O OF LIGNEECRAN.
           MOVE DBTELP OF SFL1-I OF LIGNEECRAN
             TO DBTELP OF FMT2-O OF LIGNEECRAN.

                    WRITE LIGNEECRAN FROM FMT2-O FORMAT "FMT2".
                    READ ECRAN INTO FMT2-I  FORMAT "FMT2"
                         INDIC TINDIC.
                  IF DBLNAM OF FMT2-I NOT = SPACES
                     AND IN23 OF FMT2-I = B"1"

                     MOVE CORR FMT2-I TO PFR
                     REWRITE ENREG-PFR
                  END-IF;
                     MOVE SPACES TO PTNAME OF SF1CTL-I

        FIN-E2.  EXIT.
      ********************************************************
      * Initialisation
      ********************************************************
        DEBUT-INIT.
            MOVE B"0" TO IN32 OF SF1CTL-O.
            MOVE B"1" TO IN31 OF SF1CTL-O.
            WRITE LIGNEECRAN FORMAT "SF1CTL".
            MOVE B"0" TO IN31 OF SF1CTL-O.
            MOVE ZERO TO NORANG.
            SET NOT-EOSFL TO TRUE.
        FIN-INIT. EXIT.

      ********************************************************
      * Chargement sous-fichier
      ********************************************************
        DEBUT-REMP-SFL.
           READ FICHIER1 NEXT RECORD AT END MOVE 1 TO FIN_FIC
           NOT AT END MOVE 0 TO FIN_FIC END-READ
           PERFORM UNTIL FIN_FIC = 1 OR NORANG > 9998
              MOVE CORR PFR TO SFL1-O
              ADD 1 TO NORANG
              WRITE SUBFILE LIGNEECRAN FORMAT "SFL1"
           READ FICHIER1 NEXT RECORD AT END MOVE 1 TO FIN_FIC
           NOT AT END MOVE 0 TO FIN_FIC END-READ
           END-PERFORM.
           MOVE B"0" TO IN32 OF SF1CTL-O.
      * Si SFL vide:
           IF NORANG = 0
                  MOVE B"1" TO IN32 OF SF1CTL-O
           END-IF.
        FIN-REMP-SFL. EXIT.
      ********************************************************
      * Création d'un enregistrement
      ********************************************************
        DEBUT-E6.
                MOVE SPACES TO LIGNEECRAN.

               WRITE LIGNEECRAN FROM FMT6-O FORMAT "FMT6".
               READ ECRAN INTO FMT6-I   FORMAT "FMT6".
                  IF DBLNAM OF FMT6-I NOT = SPACES
                     AND IN23 OF FMT2-I = B"1"
                     MOVE CORR FMT6-I TO PFR
                     WRITE ENREG-PFR END-IF
                     MOVE SPACES TO PTNAME OF SF1CTL-I
        FIN-E6. EXIT.
      ********************************************************
      * Suppréssion d'un enregistrement
      ********************************************************
       DEBUT-SUPP.
           MOVE DBLNAM OF SFL1-I OF LIGNEECRAN
             TO DBLNAM OF ENREG-PFR.
           DELETE FICHIER1.
       FIN-SUPP. EXIT.
```
