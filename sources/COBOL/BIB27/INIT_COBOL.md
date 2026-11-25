---
bibliotheque: BIB27
fichier_source: QCOBOLSRC
membre: INIT_COBOL
type: COBOL
longueur_enregistrement: 80
lignes: 89
modifie: 2026-11-25
---

# BIB27/QCOBOLSRC/INIT_COBOL

```text
      *En-tête du programme COBOL (1ère division)
      *PROGRAM-ID obligatoire
      *Autres : DATE-COMPILED | AUTHOR | DATE-WRITTEN

       IDENTIFICATION DIVISION.
       PROGRAM-ID. INITCOBOL.

      *Environnement logique du programme (2ème division)
       ENVIRONMENT DIVISION.
      *Déclaration de mon fichier physique BDD
      *Lecture séquentiel
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT JOUEURSNBA-FILE ASSIGN TO 'JOUEURSNBA'
           ORGANIZATION IS SEQUENTIAL.

      *Manipulation des données par le programme (3ème division)
      *FILE SECTION | WORKING STORAGE SECTION | LINKAGE SECTION
       DATA DIVISION.
       FILE SECTION.
      *Structure du fichier déclaré ci-dessus JOUEURSNBA
       FD  JOUEURSNBA-FILE.
       01  JOUEURSNBA-RECORD.
           05 JOUEUR-ID PIC 9(9).
           05 JOUEUR-NOM PIC X(50).
           05 JOUEUR-PRENOM PIC X(50).
           05 JOUEUR-TAILLE PIC 9(9).
           05 JOUEUR-TEAM PIC X(50).
           05 JOUEUR-TITLE PIC 9(9).
           05 JOUEUR-AGE PIC 9(9).

       WORKING-STORAGE SECTION.
      *Déclarations variables numériques avec affectation de valeurs
      *Niveau de numérotation : 01 pour variables indépendantes
      *PIC = Picture : 9 -> Numérique | X -> char
       01  I PIC 9 VALUE 4.
       01  A PIC 99 VALUE 12.
       01  B PIC 999 VALUE 999.
       01  HW PIC X(25) VALUE 'Hello World!'.
       01  MY-NAME.
           02 FIRST-NAME PIC X(10) VALUE 'Léo'.
           02 LAST-NAME PIC X(10) VALUE 'BIB27'.
       01  var PIC X(100) VALUE 'Chaine de caractères beaucoup trop
      -    'longue'.
      *Stockage en mémoire en format binaire
       01  myid PIC 99999 USAGE IS COMP VALUE 12345.
      *Stockage en mémoire en packed
      *longueur de 4 ==> valeur de 3 ==> 0 devant
       01  myid2 PIC 9(4) USAGE IS COMP-3 VALUE 452.
      *Numérique Signé
      *Longueur max d'une zone numérique : 18
       01  dollars PIC S9(4) VALUE -1234.
      *Numérique Virgule
       01  EUROS PIC 9(4)V99 VALUE 4321.57.
       01  nbr PIC 9(4) VALUES ZERO.
       01  var1 PIC X(12) VALUES SPACE.

      *Indicateur de fin de fichier + Condition de fin de fichier
       01 WS-EOF PIC X VALUE 'N'.
          88 END-OF-FILE VALUE 'Y'.



      *Corps du programme (4ème division)
      *Étiquettes en Marge A (LABEL en RPG)
      *Instructions en Marge B
       PROCEDURE DIVISION.
      *    DISPLAY 'Hello, World!'.
      *    DISPLAY HW.
      *    DISPLAY MY-NAME.
      *    DISPLAY 'Contenu de la variable I : ' I.
      *    DISPLAY 'Contenu de la variable B : ' B.
      *    DISPLAY var.
      *    DISPLAY myid.
      *    DISPLAY myid2.
      *    DISPLAY var1.
      *    DISPLAY 'Saisir l' QUOTE 'intitulé'.
      *Provoque l'arret définitif du programme
           OPEN INPUT JOUEURSNBA-FILE
           PERFORM UNTIL END-OF-FILE
               READ JOUEURSNBA-FILE
               AT END
                   SET END-OF-FILE TO TRUE
               NOT AT END
                   DISPLAY 'Joueur Nom :' JOUEUR-PRENOM
               END-READ
           END-PERFORM
           CLOSE JOUEURSNBA-FILE
           STOP RUN.
```
