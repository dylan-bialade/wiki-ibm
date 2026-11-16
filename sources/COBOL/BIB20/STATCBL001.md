---
bibliotheque: BIB20
fichier_source: QCBLLESRC
membre: STATCBL001
type: COBOL
longueur_enregistrement: 100
lignes: 11
modifie: 2026-11-16
---

# BIB20/QCBLLESRC/STATCBL001

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. STATCBL001.
       ENVIRONMENT DIVISION.

       WORKING-STORAGE SECTION.
          01 PARAM01   PIC X(10).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            CALL 'STATCBL002' USING PARAM01.
            STOP RUN.
```
