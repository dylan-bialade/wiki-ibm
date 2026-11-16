---
bibliotheque: BIB02
fichier_source: QCBLLESRC
membre: FILMCBL
type: COBOL
longueur_enregistrement: 100
lignes: 47
modifie: 2026-11-16
---

# BIB02/QCBLLESRC/FILMCBL

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILMCBL.
       AUTHOR. Sylvain BIB02

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FILMS ASSIGN TO DATABASE-FILMS
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS WS-FILE-STATUS.

       DATA DIVISION.
       FILE SECTION.
       FD FILMS.
       01 FILM-RECORD.
          05 NUMFILM PIC 9(5).
          05 TITREFILM PIC X(50).

       WORKING-STORAGE SECTION.
       01 WS-FILE-STATUS PIC XX.
       01 EOF-SWITCH PIC X VALUE 'N'.
          88 EOF VALUE 'Y'.

       PROCEDURE DIVISION.
       OPEN-FILE.
           OPEN INPUT FILMS.

       READ-AND-DISPLAY.
           PERFORM UNTIL EOF
               MOVE SPACES TO TITREFILM
               READ FILMS
                   AT END
                       SET EOF TO TRUE
                   NOT AT END
                       PERFORM VARYING I FROM 1 BY 1 UNTIL I > 50
                           IF TITREFILM(I:1) < SPACE
                              MOVE SPACE TO TITREFILM(I:1)
                           END-IF
                       END-PERFORM
                       DISPLAY TITREFILM
                   END-READ
           END-PERFORM.

       CLOSE-FILE.
           CLOSE FILMS.
           STOP RUN.
```
