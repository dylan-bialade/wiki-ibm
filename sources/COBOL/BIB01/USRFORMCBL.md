---
bibliotheque: BIB01
fichier_source: QCBLLESRC
membre: USRFORMCBL
type: COBOL
longueur_enregistrement: 80
lignes: 38
modifie: 2026-11-16
---

# BIB01/QCBLLESRC/USRFORMCBL

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. RACERCBL.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
     *
     *
            SELECT ECRAN ASSIGN TO WORKSTATION-USRFORMD
            ORGANIZATION TRANSACTION
            FILE STATUS ST2
            ACCESS DYNAMIC
            RELATIVE KEY NORANG
            CONTROL-AREA WFTOUCHE.
     *
       DATA DIVISION.
       FD ECRAN.
       01 LIGNEECRAN.
       COPY DDS-ALL-FORMATS OF USRFORMD.
     ******************************************************************
       WORKING-STORAGE SECTION.
     ******************************************************************
       77 NORANG PIC 9999.
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
            OPEN I-O ECRAN.
              READ ECRAN INTO USRFORMF01-I
                         FORMAT "USRFORMF01".
            CLOSE ECRAN.
            STOP RUN.
```
