---
bibliotheque: BIB01
fichier_source: QCBLLESRC
membre: STATCBL003
type: COBOL
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-16
---

# BIB01/QCBLLESRC/STATCBL003

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. STATCBL003.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
        77 PARAM01   PIC X(10).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            MOVE "<-------->" TO PARAM01.
            CALL "STATCBL004" USING PARAM01.
            STOP RUN.
```
