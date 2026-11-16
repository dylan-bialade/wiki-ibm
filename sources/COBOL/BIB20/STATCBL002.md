---
bibliotheque: BIB20
fichier_source: QCBLLESRC
membre: STATCBL002
type: COBOL
longueur_enregistrement: 100
lignes: 245
modifie: 2026-11-16
---

# BIB20/QCBLLESRC/STATCBL002

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
       77 ST1 PIC XX.
          88 EOF1 VALUE "10".
       77 ST2 PIC XX.
          88 EOF2 VALUE "10".
       77 WFTOUCHE PIC XX.
          88 END-PGM VALUE "03".
          88 TRT-F6  VALUE "06".
          88 RTN-PGM VALUE "12".
          88 AJOUTER VALUE "06".
       77 GOTOU PIC 9.

       77 FLAGEOSFL PIC 1.
          88 EOSFL     value B'1'.
          88 NOT-EOSFL value B'0'.

       01 TINDIC.
          05 IND OCCURS 99 PIC 1 INDICATOR 01.

          77 MOIS PIC X(20) OCCURS 12.

       77 JAITROUVE PIC 1.
          88 TROUVE    value B'1'.
          88 NON-TROUVE value B'0'.

       77 JERESET PIC 1.
          88 RESETOUI    value B'1'.
          88 RESETNON    value B'0'.

       77 RANGACTUELLE PIC 99.
       77 LASTNAME PIC X(10).



     **************************************(Cartes C avec USING = *ENTRY)
       PROCEDURE DIVISION USING PARAM01.
     ******************************************************************
       MAIN-PROCEDURE.
            OPEN I-O   FICHIER1.
            OPEN I-O ECRAN.
            MOVE PARAM01 TO PTNAME OF SF1CTL-I.
            SET RESETOUI TO TRUE.

       DEBUT.
      * Do While not F3:
            PERFORM UNTIL END-PGM
               IF RESETNON
                   PERFORM DEBUT-INIT THRU FIN-INIT
                   MOVE PTNAME-IN          TO DBLNAM OF ENREG-PFR
                   MOVE 1 TO GOTOU



      * Setll ...
               START FICHIER1
                  KEY >= DBLNAM OF ENREG-PFR
                  INVALID KEY GO TO MAIN-PROCEDURE DEPENDING ON GOTOU
                  NOT INVALID KEY CONTINUE
               END-START

               else

      * Setll ...
               START FICHIER1
                  KEY > DBLNAM OF ENREG-PFR
                  INVALID KEY GO TO MAIN-PROCEDURE DEPENDING ON GOTOU
                  NOT INVALID KEY CONTINUE
               END-START
               END-IF

               READ FICHIER1 NEXT



      * Remplissage sous-fichier:
               PERFORM DEBUT-REMP-SFL THRU FIN-REMP-SFL

      * Si SFL vide:
               IF NORANG = 0
                  MOVE B"1" TO IN32 OF SF1CTL-O
               END-IF

      * Affichage/lecture écran:
      *         MOVE 1 TO NORANG
               WRITE LIGNEECRAN FORMAT "FKEY1"
               MOVE SPACES TO PTNAME OF SF1CTL-O

      * Write+Read = EXFMT !
               WRITE LIGNEECRAN FROM SF1CTL-O FORMAT "SF1CTL"
               READ ECRAN INTO SF1CTL-I FORMAT "SF1CTL"
               INDIC TINDIC

               IF IND(29) = B'1'
                  MOVE LASTNAME TO DBLNAM OF ENREG-PFR
                  SET RESETNON TO TRUE
                  PERFORM DEBUT
               END-IF

               SET RESETOUI TO TRUE

               EVALUATE WFTOUCHE
                  WHEN "06"
                     PERFORM DEBUT-E6 THRU FIN-E6
                  WHEN other
                     PERFORM DEB-READC THRU FIN-READC
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
           READ SUBFILE ECRAN NEXT MODIFIED INTO LIGNEECRAN
                FORMAT "SFL1" AT END SET EOSFL TO TRUE.
           PERFORM UNTIL EOSFL
               IF OPT = "5"
                    PERFORM DEBUT-E5 THRU FIN-E5
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
      * Gestion Ecran d'affichage E5
      ********************************************************
        DEBUT-E5.
           MOVE DBLNAM OF SFL1-I OF LIGNEECRAN OF ECRAN
            TO DBLNAM OF FMT5-O OF LIGNEECRAN OF ECRAN.
           MOVE DBFNAM OF SFL1-I OF LIGNEECRAN OF ECRAN
            TO DBFNAM OF FMT5-O OF LIGNEECRAN OF ECRAN.
           MOVE DBCIVI OF SFL1-I OF LIGNEECRAN OF ECRAN
            TO DBCIVI OF FMT5-O OF LIGNEECRAN OF ECRAN.
           MOVE DBTELP OF SFL1-I OF LIGNEECRAN OF ECRAN
            TO DBTELP OF FMT5-O OF LIGNEECRAN OF ECRAN.

                    WRITE LIGNEECRAN FROM FMT5-O FORMAT "FMT5"
                    READ ECRAN INTO FMT5-O   FORMAT "FMT5"
                         INDIC TINDIC.
                    CONTINUE.
        FIN-E5.  EXIT.
      ********************************************************
      * Gestion Ecran de création E6
      ********************************************************
        DEBUT-E6.
               WRITE LIGNEECRAN FROM FMT6-O FORMAT "FMT6".
               READ ECRAN INTO FMT6-I   FORMAT "FMT6".
               EVALUATE WFTOUCHE
                  WHEN "23"
                      IF DBLNAM OF FMT6-I not = SPACES and
                         DBFNAM OF FMT6-I not = SPACES and
                         DBCIVI OF FMT6-I not = SPACES and
                         DBTELP OF FMT6-I not = SPACES
                        MOVE CORR FMT6-I TO PFR
                        WRITE ENREG-PFR
                        PERFORM FIN-E6
                     ELSE
                        PERFORM DEBUT-E6
                     end-if
                  WHEN "12"
                     PERFORM FIN-E6
                  WHEN "03"
                     PERFORM FIN-E6
                  WHEN other
                     PERFORM DEBUT-E6
               END-EVALUATE.
        FIN-E6. EXIT.
      ********************************************************
      * Initialisation
      ********************************************************
        DEBUT-INIT.
            MOVE PTNAME OF SF1CTL-I TO PTNAME-IN.
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
           MOVE ZERO TO RANGACTUELLE
           PERFORM UNTIL EOF1 or RANGACTUELLE >= 15
              MOVE CORR PFR TO SFL1-O
              ADD 1 TO NORANG
              ADD 1 TO RANGACTUELLE
              WRITE SUBFILE LIGNEECRAN FORMAT "SFL1"
              READ FICHIER1 NEXT
           END-PERFORM.
           MOVE DBLNAM OF PFR TO LASTNAME
           MOVE B"0" TO IN32 OF SF1CTL-O.
        FIN-REMP-SFL. EXIT.
```
