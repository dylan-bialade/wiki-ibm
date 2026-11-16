---
bibliotheque: BIB01
fichier_source: QRPGSRC
membre: SYNTAX3
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 98
modifie: 2026-11-16
---

# BIB01/QRPGSRC/SYNTAX3

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     ***** Specification d'Environnement
     *** Declaration format Date Y (Annee/Mois/Jour)
     H            Y
     *** Declaration des Fichiers
     *** Description d'un fichier Externe en Lecture
     FBONBON  IF  E           K        DISK
     *** RENOMMER UN FORMAT DE FICHIER
     FFICHIER IF  E           K        DISK
     F            OLDFMT                            KRENAMENEWFMT
     *** Description d'un fichier Externe en Lecture et Mise à Jour
     FBONBON  UF  E           K        DISK
     *** Desc.fichier Externe en Lecture, Mise à Jour et Ajout
     FBONBON  UF  E           K        DISK                      A
     ** Description d'un fichier CYCLE PRIMAIRE (Cycle GAP)
     FBONBON  IP  E                    DISK
     ** Description d'un fichier ECRAN (Workstation)
     FECRAN   CF  E                    WORKSTN
     ** Description d'un fichier IMPRIMANTE
     FIMPRESS O   E                    PRINTER
     ** SPECIFICATION D'EXTENSION
     *** TABLEAU CHARGÉ À LA COMPILATION
     E                    MES     1   3 25
     *** TABLEAU CHARGÉ PENDANT L'EXECUTION
     E                    TB          3 10
      *
     *** SPECIFICATION DE LIGNE
     LIMPRESS  66FL 60OL
      *
     **** SPECIFICATION D'ENTREE (CARTE I)
     ***  Renommer une zone d'un fichier COULEUR renomer en COLOR
     IFBONBON
     I              COULEUR                         COLOR
     *
     IDATINV      DS
     I                                        1   4 AA
     I                                        5   6 MM
     I                                        7   8 JJ
     I                                        1   80DATNUM
      *
     **** Carte C = Compute
     C           *ENTRY    PLIST
     C                     PARM           PARM1   60
     C                     PARM           PARM2  10
     * Repositionner la tete de lecture sur un fichier
     C           *LOVAL    SETLLBONBON                     Debut Fichier
     C           *HIVAL    SETGTBONBON                     Fin Fichier r
     C           MARQUE    SETLLBONBON                     Sur marque  r
     * Lecture d'un fichier sequentielle
     C                     READ BONBON                   80
     * Lecture d'un fichier sur clé
     C           MARQUE    READEBONBON                   80
     * Lecture d'un enregistrement sur clé
     C           ID        CHAINBONBON               50
     C           *IN50     IFEQ '0'                        TROUVÉ
     C           *IN50     IFEQ '1'                        NON TROUVÉ
     *** TRANSFERT DE CARACTERE DANS UN TABLEAU
     C                     MOVEA*BLANKS   TB,1
     C                     MOVEA*BLANKS   TB
     C                     MOVEA'TOTO'    TB,1
     *** CODES OPERATIONS +,-,* ET /
     *** ADDITION
     C                     Z-ADD*ZERO     Y       20
     C           5         ADD  3         Y                Y=8
     C                     ADD  2         Y                Y=10
     *** SOUSTRACTION
     C                     Z-ADD*ZERO     J       20
     C           10        SUB  2         J                 J=8
     *** MULTIPLICATION
     C                     Z-ADD*ZERO     H       20
     C           5         MULT 3         H                 H=15
     *** DIVISION
     C                     Z-ADD*ZERO     D       20
     C           10        DIV  3         D                 D=3
     C           99        DIV  10        D                 D=9
     C                     MVR            RESTE   42
     *** SELEC WHXX OTHER
     C                     SELEC
     C           COP       WHEQ '+'
     C                     OTHER
     C                     ENDSL
     ***
     C                     CALL 'NOMPGM'
     C                     PARM           PARM1
     ***
     *** SOUS ROUTINE
     ** SR *INZSR S'EXECUTE AUTOMATIQUEMENT AU LANCEMENT DU PGM
     C                     EXSR *INZSR
     C           *INZSR    BEGSR
     C                     ENDSR
     ** COMPARE
     C           NUM       COMP *ZERO                    99
     **** SPECIFICATION OUTPUT
      *--- EXCEPT
     OIMPRES  E 1
** MES
---- CREATION ----
---- MODIFICATION ----
---- SUPPRESSION ----
```
