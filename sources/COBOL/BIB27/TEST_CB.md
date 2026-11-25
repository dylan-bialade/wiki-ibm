---
bibliotheque: BIB27
fichier_source: QCOBOLSRC
membre: TEST_CB
type: COBOL
longueur_enregistrement: 80
lignes: 45
modifie: 2026-11-25
---

# BIB27/QCOBOLSRC/TEST_CB

```text
      *En-tête du programme COBOL (1ère division)
      *PROGRAM-ID obligatoire
      *Autres : DATE-COMPILED | AUTHOR | DATE-WRITTEN

       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST_cb.


      *Environnement logique du programme (2ème division)
      *ORGANIZATION IS TRANSACTION : typique pour fichier d'affichage
      *Accés au fichier de manière séquentiel
      *Variable pour stocket le status du fichier aprés opération
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.


           SELECT MY-FILE ASSIGN TO 'TEST_CB'
           ORGANIZATION IS SEQUENTIAL
           ACCESS IS SEQUENTIAL.


       DATA DIVISION.
       FILE SECTION.
       FD  MY-FILE.
       01  MYFILE-RECORD.
           05 FILE-NOM PIC X(10).
           05 FILE-PRENOM PIC X(10).

       WORKING-STORAGE SECTION.
       01 WS-EOF PIC X VALUE 'N'.
          88 END-OF-FILE VALUE 'Y'.



       PROCEDURE DIVISION.
       MAIN-PROCEDURE.


           OPEN EXTEND MY-FILE
           MOVE 'TEST' TO FILE-PRENOM
           WRITE MYFILE-RECORD
           CLOSE MY-FILE

           STOP RUN.
```
