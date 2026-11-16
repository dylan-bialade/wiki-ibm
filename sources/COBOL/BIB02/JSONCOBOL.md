---
bibliotheque: BIB02
fichier_source: QCBLLESRC
membre: JSONCOBOL
type: COBOL
longueur_enregistrement: 100
lignes: 36
modifie: 2026-11-16
---

# BIB02/QCBLLESRC/JSONCOBOL

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. JSONCOBOL.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 JSONVAR.
          05 LENGTH OF JSONVAR PIC S9(4) COMP.
          05 JSONVAR-TEXT PIC X(100)
              VALUE '{"MATRIX", "SPIDERMAN", "INCEPTION", "GLADIATOR"}'.
       01 JSON-ELEMENT PIC X(50).
       01 I PIC S9(4) COMP VALUE 1.
       01 J PIC S9(4) COMP VALUE 1.
       01 IN-STRING PIC X VALUE 'N'.
       01 QUOTE-COUNTER PIC S9(4) COMP VALUE 0.

       PROCEDURE DIVISION.
       PARSE-JSON.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > LENGTH OF JSONVAR
               IF JSONSTR(I:1) = '"'
                   THEN
                       IF IN-STRING = 'N'
                           THEN
                               MOVE 'Y' TO IN-STRING
                               MOVE 0 TO J
                       ELSE
                           MOVE 'N' TO IN-STRING
                           DISPLAY JSON-ELEMENT (1:J)
                           MOVE SPACES TO JSON-ELEMENT
                       END-IF
                   ELSE IF IN-STRING = 'Y'
                       THEN
                           ADD 1 TO J
                           MOVE JSONSTR(I:1) TO JSON-ELEMENT(J:1)
                   END-IF
           END-PERFORM.

       END PROGRAM JSONPARSER.
```
