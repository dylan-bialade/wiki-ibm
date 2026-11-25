---
bibliotheque: BIB27
fichier_source: QCBLLESRC
membre: STATCBL001
type: COBOL
longueur_enregistrement: 100
lignes: 12
modifie: 2026-11-25
---

# BIB27/QCBLLESRC/STATCBL001

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. STATCBL001.
       ENVIRONMENT DIVISION.

       WORKING-STORAGE SECTION.
          01 PARAM01   PIC X(10).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            MOVE '<-------->'      TO PARAM01.
            CALL 'STATCBL002' USING PARAM01.
            STOP RUN.
```
