---
bibliotheque: BIB02
fichier_source: QCBLLESRC
membre: RACERCBL
type: COBOL
longueur_enregistrement: 100
lignes: 82
modifie: 2026-11-16
---

# BIB02/QCBLLESRC/RACERCBL

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SFLCBL.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
     *
            SELECT FICHIER1 ASSIGN TO DATABASE-SFL001LF
            ORGANIZATION INDEXED
            RECORD KEY DBLNAM OF PFR
            FILE STATUS ST1
            ACCESS DYNAMIC.
     *
            SELECT ECRAN ASSIGN TO WORKSTATION-SFL001SD
            ORGANIZATION TRANSACTION
            FILE STATUS ST2
            RELATIVE KEY RANG
            ACCESS DYNAMIC
            CONTROL-AREA WFTOUCHE.
     *
       DATA DIVISION.
       FD FICHIER1 LABEL RECORD STANDARD.
       01 ENREG-PFR.
       COPY DDS-ALL-FORMATS OF SFL001LF.
       FD ECRAN.
       01 LIGNEECRAN.
       COPY DDS-ALL-FORMATS OF SFL001SD.
     ******************************************************************
       WORKING-STORAGE SECTION.
     ******************************************************************
       77 RANG PIC 9999.
       77 ST1 PIC XX.
          88 EOF1 VALUE "10".
       77 ST2 PIC XX.
          88 EOF2 VALUE "10".
       77 WFTOUCHE PIC XX.
          88 END-PGM VALUE "03".
          88 RTN-PGM VALUE "12".
          88 AJOUTER VALUE "06".

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            OPEN INPUT FICHIER1.
            OPEN I-O ECRAN.
            PERFORM DEBUT-INIT THRU FIN-INIT.
            PERFORM DEBUT-CHRG THRU FIN-CHRG.
            PERFORM UNTIL END-PGM OR RTN-PGM
               READ ECRAN FORMAT "SF1CTL" INDIC SF1CTL-O-INDIC
            END-PERFORM.
            CLOSE FICHIER1.
            CLOSE ECRAN.
            STOP RUN.

      ********************************************************
      * Initialisation
      ********************************************************
        DEBUT-INIT.
            MOVE B"0" TO IN32 OF SF1CTL-O
            MOVE B"0" TO IN31 OF SF1CTL-O
            MOVE ZERO TO RANG
            MOVE SPACE TO DBLNAM OF ENREG-PFR
            START FICHIER1
                  KEY > DBLNAM OF ENREG-PFR
            END-START.
            WRITE LIGNEECRAN FORMAT "FKEY1".

        FIN-INIT.

      ********************************************************
      * Chargement sous-fichier
      ********************************************************
        DEBUT-CHRG.
           READ FICHIER1 NEXT
           PERFORM UNTIL EOF1
              MOVE CORR PFR TO SFL1-O
              WRITE SUBFILE LIGNEECRAN FORMAT "SFL1"
              ADD 1 TO RANG
              READ FICHIER1 NEXT
           END-PERFORM.
           MOVE B"0" TO IN32 OF SF1CTL-O
           MOVE B"0" TO IN31 OF SF1CTL-O
           WRITE LIGNEECRAN FORMAT "SF1CTL".
        FIN-CHRG.
```
