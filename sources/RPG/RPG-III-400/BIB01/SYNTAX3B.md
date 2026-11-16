---
bibliotheque: BIB01
fichier_source: QRPGSRC
membre: SYNTAX3B
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 261
modifie: 2026-11-16
---

# BIB01/QRPGSRC/SYNTAX3B

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     * --------------------------------------------------------------+
     * H - SPECIFICATION D'ENVIRONNEMENT                             |
     * F - DECLARATION DES FICHIERS                                  |
     * E - DECLARATION DES TABLES ET TABLEAUX                        |
     * L - DECLARATION CARACTERISTIQUE IMPRIMANTE                    |
     * I - DESCRIPTION DES BUFFERS D'ENTREE - DATA STRUCTURE ETC ... |
     * C - COMPUTE - LIGNES DE PROGRAMMATION                         |
     * O - DESCRIPTION DES BUFFERS DE SORTIE                         |
     * --------------------------------------------------------------+
     * DESCRIPTION D'UN FICHIER DISK EXTERNE EN LECTURE
     FCLIENT  IF  E           K        DISK
     * DESCRIPTION D'UN FICHIER EN LECTURE ET MAJ
     FCLIENT  UF  E           K        DISK
     * DESCRIPTION D'UN FICHIER EN LECTURE, MAJ ET AJOUT
     FCLIENT  UF  E           K        DISK                      A
     * DESCRIPTION D'UN FICHIER ECRAN (WORKSTATION)
     FECRANCLICF  E                    WORKSTN
     * DESCRIPTION D'UN FICHIER IMPRIMANTE
     FIMPRICLIO   E             25     PRINTER
      *
     * DESCRIPTION DES TABLES ET TABLEAUX CHARGÉS A L'EXECUTION
     * TABLE NUMERIQUE DE 10 POSTES DE 2 ENTIERS ET 2 DECIMALES
     E                    TVA        10  4 2
     * TABLEAU ALPHANUMERIQUE DE 12 POSTES DE 70 CARACTERES
     E                    TXT        12 70
     * DESCRIPTION DES TABLES ET TABLEAUX CHARGÉS A LA COMPILATION
     E                    MSG     1   5 70
     E                    FM     12  12  2
     * DESCRIPTION D'UNE DATA STRUCTURE
     IDATINV      DS
     I                                        1   4 AA
     I                                        5   6 MM
     I                                        7   8 JJ
     IDATANG      DS
     I                                        1   2 MM
     I                                        3   4 JJ
     I                                        5   8 AA
     * DEBUT DU COMPUTE DONC LE PROGRAMME
     * INITIALISATION DE VARIABLES NUMERIQUES
     C                     Z-ADD0         I                I=0
     C                     Z-ADD3         I                I=3
     C                     Z-SUB0         I                I=0
     C                     Z-SUB8         I       52       I=-8
     * CODES OPERATIONS +,-,* ET /
     * ADDITION
     C           5         ADD  3         X                X=8
     C                     ADD  3         X       82       X=11
     C                     ADD  I         X                X=3
     C           X         ADD  3         X                X=6
     * SOUSTRACTION
     C                     SUB  3         J       42       J=-3
     C                     SUB  I         J                J=5
     C           X         SUB  3         J                J=3
     * MULTIPLICATION
     C           5         MULT 3         J
     C           X         MULT 2         J
     C           X         MULT I         J
     * DIVISION
     C           5         DIV  3         J
     C           X         DIV  2         J
     *
     * LE CODE OPERATION MVR DOIT SUIVRE IMMEDIATEMENT LE CALCUL DIV
     C           X         DIV  I         J
     C                     MVR            RESTE   82
     * LE CODE OPERATION IF (SI) SOUS LA FORME IFXX
     * XX = EQ, NE, LE, LT, GE, GT
     C           J         IFEQ 6
     C                     ADD  4         J
     C                     ENDIF
     *
     C           J         IFGT 10
     C                     Z-ADD0         J
     C                     ELSE
     C                     ADD  1         J
     C                     ENDIF
     *
     C           J         IFGT 10
     C                     Z-ADD0         J
     C                     ELSE
     C           J         IFNE 0
     C                     ADD  1         J
     C                     ENDIF
     C                     ENDIF
      *
     C           *INKC     IFEQ '1'
     C           *IN99     ANDNE'0'
     C                     Z-ADD0         J
     C                     ADD  1         J
     C                     ENDIF
     *
     C           TELEP     IFEQ *BLANKS
     C           MOBIL     OREQ *BLANKS
     C                     Z-ADD0         J
     C                     ENDIF
     * LES CODES OPERATIONS DO, DOWXX (DOWHILE), DOUXX (DOUNTIL)
     * XX = EQ, NE, LE, LT, GE, GT
     C           *INKC     DOWEQ'0'
     C                     Z-ADD0         X
     C                     ENDDO
     *
     C           *IN99     DOUEQ'0'
     C           J         ANDLE10
     C                     ADD  1         J
     C                     ENDDO
     *
     C                     DO
     C                     Z-ADD0         X
     C                     ENDDO
     *
     C                     DO   8
     C                     ADD  1         X
     C                     ENDDO
     *
     C                     DO   10        K       20
     C                     Z-ADD0         TVA,K
     C                     ENDDO
     *
     C           *INKC     DOWEQ'0'
     C           *IN99     ANDNE'1'
     C                     EXFMTIMA1
     C                     ENDDO
     *
     C           *INKC     DOWEQ'0'
     C                     EXFMTIMA1
     C                     ENDDO
     *
     C           *INKC     DOUEQ'0'
     C           *IN99     OREQ '1'
     C                     EXFMTIMA1
     C                     ENDDO
     *
     C                     SELEC
     C           OPT       WHEQ 'C'
     C                     ADD  1         I
     C                     SUB  8         X
     C           OPT       WHEQ 'M'
     C                     ADD  2         I
     C                     SUB  3         X
     C                     OTHER
     C                     Z-ADD0         X
     C                     ENDSL
     *
     C           OPT       CASEQ'C'       CREER
     C           OPT       CASEQ'M'       MODIF
     C           OPT       CASEQ'S'       SUPP
     C                     CAS            ERREUR
     C                     ENDCS
     * CHAINES DE CARACTÈRES
     C                     MOVE 'TOTO'    ZON15
     *   ZON15 = '___________TOTO'
     C                     MOVE *BLANKS   ZON15
     *
     C                     MOVEL'TOTO'    ZON15
     *   ZON15 = 'TOTO___________'
     C                     MOVE 'TOTO'    ZON15  15
     *   ZON15 = 'TOTO_______TOTO'
     C                     MOVEL'TI'      ZON15
     *   ZON15 = 'TITO_______TOTO'
     *TRANSFERT DE CARACTERES DANS TABLE OU TABLEAU
     C                     MOVEA*ZEROS    TVA
     C                     MOVEA*ZEROS    TVA,X
     C                     MOVEA*BLANKS   TXT
     C                     MOVEA*BLANKS   TXT,3
     C                     MOVEA'1234'    TXT,8
     * AFFICHAGE FORMATS FICHIER ECRAN
     C                     EXFMTIMA2
     C                     WRITEIMA3
     * INDICATEURS ET TOUCHES DE FONCTIONS
     * BOOLÉENS FOURNIS PAR LE SYSTÉME ET PROPRE AU PROGRAMME
     * 01 À 99 BOOLÉENS ET *INKA À *INKY POUR LES TOUCHES DE FONCTIONS
     C                     SETON                     10
     C                     SETON                     10  14
     C                     SETOF                     050788
     C                     MOVE '0'       *INKD
     C                     MOVE '1'       *IN99
     C                     MOVE *ON       *IN25
     C                     MOVE *OFF      *IN03
     C                     MOVEA'1111'    *IN,90
     C                     MOVEA'10011101'*IN,10
     C                     MOVEA*ZEROS    *IN
     * CODES OPERATIONS FICHIERS
     * LECTURE SEQUENTIELLE
     C                     READ ENRCLI                   30
     C           *IN30     IFEQ '1'
     * 30 = FIN DE FICHIER ATTEINTE LA TETE DE LECTURE EST AU FOND
     * DU FICHIER
     * LECTURE SEQUENTIELLE ARRIERE P=PRIOR
     C                     READPENRCLI                   30
     C           *IN30     IFEQ '1'
     * 30 = DEBUT DE FICHIER ATTEINT
     C           CODCLI    READEENRFAC                   31
     * 31 = FIN DU CODCLI
     C           CODCLI    REDPEENRFAC                   31
     * 31 = FIN DU CODCLI EN LECTURE ARRIERE
     * DANS TOUS LES CAS UN INDICATEUR DE FIN DE FICHIER
     * EN LECTURE SEQUENTIELLE NE S'ETEINT PAS TOUT SEUL
     * ON DOIT L'ETEINDRE SOIT MEME
     * REPOSITIONNER LA TETE DE LECTURE SUR UN FICHIER LU EN SEQUENTIEL
     C           *LOVAL    SETLLCLIENT                     DEBUT FICHIER
     C           *HIVAL    SETGTCLIENT                     FIN FICHIER R
     C           CODCLI    SETLLCLIENT                     SUR CODCLI
     * LECTURE D'UN ENREGISTREMENT SUR CLEF
     C           CODCLI    CHAINENRCLI               50
     C           *IN50     IFEQ '0'                        TROUVÉ
     C           *IN50     IFEQ '1'                        NON TROUVÉ
     * ECRITURES FICHIERS
     * AJOUT
     C                     WRITEENRCLI                     SUR NOM DU FORMAT
     * MODIFICATION
     C                     UPDATENRCLI                     SUR NOM DU FORMAT
     * SUPPRESSION
     C                     DELETCLIENT                     SUR NOM FICHIER
     * APPEL D'UN SOUS PROGRAMME
     C                     EXSR CTL                                    IER
     C                     SETON                     LR
     * DEBUT DES SOUS PROGRAMMES
     C           CTL       BEGSR
     C           NOMCLI    IFEQ *BLANKS
     C                     SETON                     1099
     C                     MOVELTXT,1     MES
     C                     ENDIF
     C                     ENDSR
     *
     C           ECRIT     BEGSR
     C           *IN50     IFEQ '0'
     C                     UPDATENRCLI
     C                     ELSE
     C                     WRITEENRCLI
     C                     ENDIF
     C                     ENDSR
     *
     *** OUTPUT ******************************************************
     * H/D/T correspondent à des phases du cycle logique
     *-------Header ----------------------------*
     OQPRINT  H  1 1   1P
     O       OR        OF
     O                                      'HEADER - EN TÊTE'
     *------ Detail -----------------------------*
     O        D        33
     O                                      '|'
     O                         NOM     +  1
     O                                      '|'
     O                         PRIX  4 +  1
     O                                 +  1 '|'
     *------ Total ------------------------------*
     O        T        L1
     O                                      '| TOTAL :'
     O                         TOTP  4
     *------ Exceptionnelle ---------------------*
     * Sortie provoqué par le code EXCPT
     O        E  1             DET
     O                                   14 'Num. Client :'
     O                         CLIDCL4   21
**
Le nom est obligatoire
Le cp est obligatoire
La ville obligatoire
Le travail c'est la santé
Le mobile est obligatoire
**
312831303130313130313031
```
