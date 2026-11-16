---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: ASYNTAX4
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 233
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/ASYNTAX4

```text
     * --------------------------------------------------------------+
     * H - SPECIFICATION D'ENVIRONNEMENT                             |
     * F - DECLARATION DES FICHIERS                                  |
     * D - DECLARATION DE VARIABLES                                  |
     * I - DESCRIPTION DES BUFFERS D'ENTREE                          |
     * C - COMPUTE - LIGNES DE PROGRAMMATION                         |
     * O - DESCRIPTION DES BUFFERS DE SORTIE                         |
     * --------------------------------------------------------------+

     * --------------------------------------------------------------+
     * H - SPECIFICATION D'ENVIRONNEMENT
     * --------------------------------------------------------------+
     H Datfmt(*ISO) Timfmt(*HMS) dftactgrp(*no)

     * --------------------------------------------------------------+
     *F - DECLARATION DES FICHIERS
     * --------------------------------------------------------------+
     * DESCRIPTION D'UN FICHIER DISK EXTERNE EN LECTURE
     FCLIENT    IF   E           K DISK

     * DESCRIPTION D'UN FICHIER EN LECTURE ET MAJ
     FCLIENT    UF   E           K DISK

     * DESCRIPTION D'UN FICHIER EN LECTURE, MAJ ET AJOUT
     FCLIENT    UF A E           K DISK

     * DESCRIPTION D'UN FICHIER ECRAN (WORKSTATION)
     FECRANCLI  CF   E             WORKSTN

     * DESCRIPTION D'UN FICHIER IMPRIMANTE
     FIMPRICLI  O    E             PRINTER OFLIND(*IN25)

     * --------------------------------------------------------------+
     * D - DECLARATION DE VARIABLES
     * --------------------------------------------------------------+
     * Déclaration de variables
     DDecimal          S              6s 0 INZ(0)
     DPacked           S              6P 2 INZ(*ZERO)
     DALPHA            S             10A   INZ(*BLANKS)
     * DESCRIPTION DES TABLES ET TABLEAUX CHARGÉS A L'EXECUTION
     * TABLE NUMERIQUE DE 10 POSTES DE 2 ENTIERS ET 2 DECIMALES
     D TVA             S              4  2 DIM(10)
     * TABLEAU ALPHANUMERIQUE DE 12 POSTES DE 70 CARACTERES
     D TXT             S             70    DIM(12)

     * DESCRIPTION DES TABLES ET TABLEAUX CHARGÉS A LA COMPILATION
     D MSG             S             70    DIM(5) CTDATA PERRCD(1)
     D FM              S              2    DIM(12) CTDATA PERRCD(12)

     * DECLARATION TYPE DATE HEURE HORODATE
     DDATE_DEBUT       S               D   INZ(D'2000-04-23')
     DDATE_JOUR        S               D   INZ

     * DESCRIPTION D'UNE DATA STRUCTURE
     D DATINV          DS
     D  AA                     1      4
     D  MM                     5      6
     D  JJ                     7      8

     D DATANG          DS
     D  MM                     1      2
     D  JJ                     3      4
     D  AA                     5      8

     *  DTAARA : zone chargé par la LDA
     Ddslda           UDS                  dtaara(*LDA)
     D zone1                   1     10
     D zone2                  11     20

     *  DS Systeme
     DsystemeDS       SDS
     DNom_Pgm                  1     10
     DCurrent_User           358    367                                         .....

     * --------------------------------------------------------------+
     * I - DESCRIPTION DES BUFFERS D'ENTREE
     * --------------------------------------------------------------+
     * Déclaration de format avec indicateur(33)et indicateur rupture(L1)
     IFmtFichier    33
     I                                          RUPTURE       L1

     * --------------------------------------------------------------+
     * C - COMPUTE - LIGNES DE PROGRAMMATION
     * --------------------------------------------------------------+
     * Opérations sur les données de type Date, Heure et Horodatage
     **DATEpermets de récupérer la date du jour
     C                   MOVE      *DATE         DATE_JOUR

     ** ADDDUR ajoute une durée
     C     DATE_JOUR     ADDDUR    NB_ANS:*Y     NEW_DATE
     C     DATE_JOUR     ADDDUR    NB_ANS:*M     NEW_DATE
     C     DATE_JOUR     ADDDUR    NB_ANS:*D     NEW_DATE

     ** SUBDUR permet 2 opérations :
     *-- Soustraire une durée
     C     DATE_JOUR     SUBDUR    NBA:*Y        NEW_DATE
     C     DATE_JOUR     SUBDUR    NBM:*M        NEW_DATE
     C     DATE_JOUR     SUBDUR    NBJ:*D        NEW_DATE

     *-- Calcul d'une durée à partir de 2 valeurs
     C     DATE_JOUR     SUBDUR    DATE_DEBUT    NBA:*Y
     C     DATE_JOUR     SUBDUR    DATE_DEBUT    NBM:*M
     C     DATE_JOUR     SUBDUR    DATE_DEBUT    NBJ:*D

     ** EXTRACT permet l'extraction l'année, mois, jours, heure ...
     C                   EXTRCT    DATE:*Y       ANNEE

     ** TEST controle de date
     *-- l'indicateur passe à *ON s'il y a une erreur
     C                   TEST                    DATE                   10
     C     *ISO          TEST(D)                 DATE                   11

     *----------------+
     *| *Y  | Année   |
     *| *M  | Mois    |
     *| *D  | Jour    |
     *| *H  | Heure   |
     *| *MN | Minute  |
     *| *S  | Seconde |
     *+---------------+
     *--------------------------------------------------------------------*
     ** EVAL ****************
     *-----------------------
     C                   EVAL(H)   MONT_TTC = MONT_HT + (MONT_HT * 20)/100
     *                  (H) pour l'arrondi
     C                   EVAL      ZONE_ALPH = 'AS' + '/' + '400'
     C                   EVAL      *INLR = *ON
     C                   EVALR     ZONE_ALPH = 'AS400'
     *                  EVALR pour Cadrage à droite

     *TRANSFERT DE CARACTERES DANS TABLE OU TABLEAU
     C                   MOVEA     *ZEROS        TVA
     C                   MOVEA     *ZEROS        TVA(X)
     C                   MOVEA     *BLANKS       TXT
     C                   MOVEA     *BLANKS       TXT(3)
     C                   MOVEA     '1234'        TXT(8)

     * INDICATEURS ET TOUCHES DE FONCTIONS
     * BOOLÉENS FOURNIS PAR LE SYSTÉME ET PROPRE AU PROGRAMME
     * 01 À 99 BOOLÉENS ET *INKA À *INKY POUR LES TOUCHES DE FONCTIONS
     C                   SETON                                        10
     C                   SETON                                        10  14
     C                   SETOFF                                       050788
     C                   MOVE      '0'           *INKD
     C                   MOVE      '1'           *IN99
     C                   MOVE      *ON           *IN25
     C                   MOVE      *OFF          *IN03
     C                   MOVEA     '1111'        *IN(90)
     C                   MOVEA     '10011101'    *IN(10)
     C                   MOVEA     *ZEROS        *IN
     * CODES OPERATIONS FICHIERS
     * LECTURE SEQUENTIELLE
     C                   READ      ENRCLI                                 30
     C     *IN30         IFEQ      '1'
     * 30 = FIN DE FICHIER ATTEINTE LA TETE DE LECTURE EST AU FOND
     * DU FICHIER
     * LECTURE SEQUENTIELLE ARRIERE P=PRIOR
     C                   READP     ENRCLI                                 30
     C     *IN30         IFEQ      '1'
     * 30 = DEBUT DE FICHIER ATTEINT

     C     CODCLI        READE     ENRFAC                                 31
     * 31 = FIN DU CODCLI

     C     CODCLI        READPE    ENRFAC                                 31
     * 31 = FIN DU CODCLI EN LECTURE ARRIERE

     * DANS TOUS LES CAS UN INDICATEUR DE FIN DE FICHIER
     * EN LECTURE SEQUENTIELLE NE S'ETEINT PAS TOUT SEUL
     * ON DOIT L'ETEINDRE SOIT MEME
     * REPOSITIONNER LA TETE DE LECTURE SUR UN FICHIER LU EN SEQUENTIEL
     C     *LOVAL        SETLL     CLIENT                                       DEBUT FICHIER
     C     *HIVAL        SETGT     CLIENT                                       FIN FICHIER R
     C     CODCLI        SETLL     CLIENT                                       SUR CODCLI

     * LECTURE D'UN ENREGISTREMENT SUR CLEF
     C     CODCLI        CHAIN     ENRCLI                             50

     * ECRITURES FICHIERS
     * AJOUT
     C                   WRITE     ENRCLI                                       SUR NOM DU FORMAT

     * MODIFICATION
     C                   UPDATE    ENRCLI                                       SUR NOM DU FORMAT

     * SUPPRESSION
     C                   DELETE    CLIENT                                       SUR NOM FICHIER

     * APPEL D'UN SOUS PROGRAMME
     C                   EXSR      CTL                                                      IER
     C                   SETON                                        LR

     * DEBUT DES SOUS PROGRAMMES
     C     CTL           BEGSR
     C     NOMCLI        IFEQ      *BLANKS
     C                   SETON                                        1099
     C                   MOVEL     TXT(1)        MES
     C                   ENDIF
     C                   ENDSR

     *--------------------------------------------------------------------*
     * Fonction intégrées identique au language de controle %xxxxxxxx     *
     *--------------------------------------------------------------------*
     * %ADDR  |Adresse mémoire, pointeur de zone dans une variable      *
     * %ELEM  |Nombre d'éléments d'une structure                        *
     * %PADDR |Adresse mémoire, pointeur de procédure(ILE) dans une var *
     * %SIZE  |Taille d'une zone                                        *
     * %SUBST |Sous-chaine de caractères                                *
     * %TRIM  |Suppression des blancs d'une chaine de caractères        *
     * %TRIML |Suppression des blancs DEVANT une chaine de caractères   *
     * %TRIMR |Suppression des blancs DERRIERE une chaine de caractères *
     *--------------------------------------------------------------------*

     ** %SUBST(chaine:position début:longueur)
     C                   EVAL      zone_alph = %subst(chaine:1:10)
     * Extraction de la zone chaine à partir de la position 1 sur 10

     ** %TRIM(zone)
     C                   EVAL      zone = %TRIM('  BIB01   ')

      ** Nouvelle condition en RPG IV
     C                   IF        COUNT =  10  AND count2 = 8
     C                   ENDIF
     *--------------------------------------------------------------------*
     * Tableau chargé à la compilation
** MSG
Le nom est obligatoire
Le cp est obligatoire
La ville obligatoire
Le travail c'est la santé
Le mobile est obligatoire
** FM
312831303130313130313031
```
