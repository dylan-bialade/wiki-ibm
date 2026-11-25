---
bibliotheque: BIB27
fichier_source: QCOBOLSRC
membre: TEST1
type: COBOL
longueur_enregistrement: 80
lignes: 23
modifie: 2026-11-25
---

# BIB27/QCOBOLSRC/TEST1

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. WELCOME.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-ISERIES.
       OBJECT-COMPUTER. IBM-ISERIES.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-USER-NAME PIC X(30).
       01 WS-DISPLAY-MESSAGE PIC X(50).

       PROCEDURE DIVISION.
           DISPLAY 'Please enter your name: ' WITH NO ADVANCING.
           ACCEPT WS-USER-NAME.

           STRING 'Welcome, ' WS-USER-NAME '!'
               DELIMITED BY SIZE
               INTO WS-DISPLAY-MESSAGE.

           DISPLAY WS-DISPLAY-MESSAGE.
           STOP RUN.
```
