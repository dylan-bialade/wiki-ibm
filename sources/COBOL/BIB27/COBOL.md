---
bibliotheque: BIB27
fichier_source: QCOBOLSRC
membre: COBOL
type: COBOL
longueur_enregistrement: 80
lignes: 166
modifie: 2026-11-25
---

# BIB27/QCOBOLSRC/COBOL

```text
      *En-tête du programme COBOL (1ère division)
      *PROGRAM-ID obligatoire
      *Autres : DATE-COMPILED | AUTHOR | DATE-WRITTEN

       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST_COBOL.


      *Environnement logique du programme (2ème division)
      *ORGANIZATION IS TRANSACTION : typique pour fichier d'affichage
      *Accés au fichier de manière séquentiel
      *Variable pour stocket le status du fichier aprés opération
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ECRAN ASSIGN TO WORKSTATION-COBOLDSPF
              ORGANIZATION TRANSACTION
              CONTROL-AREA WFTOUCHE.

           SELECT PLAYERNBA-FILE ASSIGN TO 'PLAYERNBA'
           ORGANIZATION IS SEQUENTIAL
           ACCESS IS SEQUENTIAL.


      *Manipulation des données par le programme (3ème division)
      *FILE SECTION | WORKING STORAGE SECTION | LINKAGE SECTION
       DATA DIVISION.
       FILE SECTION.
       FD  ECRAN.
       01  LIGNEECRAN.
       COPY DDS-ALL-FORMATS OF COBOLDSPF.

       FD  PLAYERNBA-FILE.
       01  PLAYERNBA-RECORD.
           05 JOUEUR-ID PIC 9(2) COMP.
           05 JOUEUR-PRENOM PIC X(50).
           05 JOUEUR-NOM PIC X(50).
           05 JOUEUR-TAILLE PIC S9(3) COMP.
           05 JOUEUR-TEAM PIC X(50).
           05 JOUEUR-TITLE PIC 9(1) COMP.
           05 JOUEUR-AGE PIC 9(2) COMP.


       WORKING-STORAGE SECTION.
       77  WFTOUCHE PIC XX.
           88 END-PGM VALUE "03".
           88 CREATE-ENREG VALUE "06".
           88 INSERT-ENREG VALUE "22".
           88 PREVIUS-ECRAN VALUE "12".
           88 DELETE-ENREG VALUE "23".
       77  ST2 PIC XX.
           88 EOF1 VALUE "10".

       01  JOUEUR-TAILLE-DISPLAY PIC 9(1)V9(2).
       01  JOUEUR-TAILLE-INSERT PIC 9(3).
       01  MAX-ID PIC 9(2) COMP VALUE 0.
       01  TEST_T PIC X(50) VALUE 'TEST'.
       01  PARA1 PIC X(50).

      *Indicateur de fin de fichier + Condition de fin de fichier
       01 WS-EOF PIC X VALUE 'N'.
          88 END-OF-FILE VALUE 'Y'.
          88 NOT-END-OF-FILE VALUE 'N'.


      *Corps du programme (4ème division)
      *Étiquettes en Marge A (LABEL en RPG)
      *Instructions en Marge B
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM UNTIL END-PGM
               OPEN I-O ECRAN
               OPEN INPUT PLAYERNBA-FILE
               SET NOT-END-OF-FILE TO TRUE
               WRITE LIGNEECRAN FORMAT 'FMT1'
               READ ECRAN FORMAT 'FMT1'
               PERFORM CHECK-FUNCTION-KEYS
               PERFORM UNTIL END-OF-FILE
               READ PLAYERNBA-FILE
               AT END
                   SET END-OF-FILE TO TRUE
               NOT AT END
                DIVIDE JOUEUR-TAILLE BY 100 GIVING JOUEUR-TAILLE-DISPLAY
                   MOVE JOUEUR-NOM TO NOM
                   MOVE JOUEUR-PRENOM TO PRENOM
                   MOVE JOUEUR-TEAM TO EQUIPE
                   MOVE JOUEUR-TAILLE-DISPLAY TO TAILLE
                   MOVE JOUEUR-TITLE TO NBR_TITRE
                   MOVE JOUEUR-AGE TO AGE
                   WRITE LIGNEECRAN FORMAT "FMT2"
                   READ ECRAN FORMAT "FMT2"
                   NOT AT END
                     PERFORM CHECK-FUNCTION-KEYS
               END-READ
               END-READ
               END-PERFORM
               CLOSE ECRAN
               CLOSE PLAYERNBA-FILE
           END-PERFORM
           STOP RUN.

      *Sous routines
       CHECK-FUNCTION-KEYS.
           IF WFTOUCHE = '03'
               CLOSE ECRAN
               STOP RUN
           END-IF.
           IF WFTOUCHE = '06'
               PERFORM CREATE-FUNCTION
           END-IF.
           IF WFTOUCHE = '22'
               PERFORM INSERT-FUNCTION
           END-IF.
           IF WFTOUCHE = '23'
               PERFORM DELETE-FUNCTION
           END-IF.
           IF WFTOUCHE = '12'
               CLOSE ECRAN
               CLOSE PLAYERNBA-FILE
               GO TO MAIN-PROCEDURE
           END-IF.



       CREATE-FUNCTION.
           WRITE LIGNEECRAN FORMAT 'FMT3'
           READ ECRAN FORMAT 'FMT3'
           PERFORM CHECK-FUNCTION-KEYS.

       INSERT-FUNCTION.
           PERFORM UNTIL END-OF-FILE
               READ PLAYERNBA-FILE
               AT END
                   SET END-OF-FILE TO TRUE
               NOT AT END
                   MOVE JOUEUR-ID TO MAX-ID
               END-READ
           END-PERFORM.


           CLOSE PLAYERNBA-FILE

           ADD 1 TO MAX-ID

           OPEN EXTEND PLAYERNBA-FILE
           INITIALIZE PLAYERNBA-RECORD
           MULTIPLY TAILLE2 BY 100 GIVING JOUEUR-TAILLE-INSERT
           MOVE MAX-ID TO JOUEUR-ID
           MOVE PRENOM2 TO JOUEUR-PRENOM
           MOVE NOM2 TO JOUEUR-NOM
           MOVE JOUEUR-TAILLE-INSERT TO JOUEUR-TAILLE
           MOVE EQUIPE2 TO JOUEUR-TEAM
           MOVE NBR_TITRE2 TO JOUEUR-TITLE
           MOVE AGE2 TO JOUEUR-AGE
           WRITE PLAYERNBA-RECORD
           CLOSE PLAYERNBA-FILE
           CLOSE ECRAN
           GO TO MAIN-PROCEDURE.


       DELETE-FUNCTION.
           MOVE NOM TO PARA1
           CLOSE PLAYERNBA-FILE
           CLOSE ECRAN
           CALL 'COBOL1' USING PARA1
           GO TO MAIN-PROCEDURE.
```
