# BONCRUD : 4 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGSRC2 | RPG/RPG-III-400 | 57 | 6 % | ecran (WORKSTN) | [BONCRUD.md](../../sources/RPG/RPG-III-400/BIB05/BONCRUD.md) |
| BIB05 | QRPGLESRC | RPG/RPG-ILE | 57 | 5 % | ecran (WORKSTN), CHAIN | [BONCRUD.md](../../sources/RPG/RPG-ILE/BIB05/BONCRUD.md) |
| BIB10 | QRPGSRC | RPG/RPG-III-400 | 111 | 100 % | ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc) | [BONCRUD.md](../../sources/RPG/RPG-III-400/BIB10/BONCRUD.md) |
| BIB10 | QDSPSRC | DDS | 35 | 0 % | DDS (R/K/PFILE) | [BONCRUD.md](../../sources/DDS/BIB10/BONCRUD.md) |

## Differences

- **BIB05** en propre : ecran (WORKSTN)
- **BIB05** en propre : ecran (WORKSTN), CHAIN
- **BIB10** en propre : ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc)
- **BIB10** en propre : DDS (R/K/PFILE)
- Langages / types differents : RPG/RPG-III-400, RPG/RPG-ILE, DDS

## Codes

### BIB05 (RPG/RPG-III-400, 57 lignes)

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIB05
     FBONBONSFCF  E                    WORKSTN
     FBONBKNU UF  E           K        DISK                      A
     IFBONBON
     I              COULEUR                         COUL
     C                     SETON                     LR
     C           *ENTRY    PLIST
     C                     PARM           OPT     1
     C                     PARM           NUMBER  60
      *DEBUT MODIF
     C           OPT       IFEQ '2'
     C                     MOVE 'MODIF'   MSG
     C           NUMBER    CHAINFBONBON              90
     C                     MOVELNOM       VAL1
     C                     MOVELMARQUE    VAL2
     C                     MOVELCOUL      VAL3
     C                     MOVELPRIX      VAL4
     C                     EXFMTFMT1
     C                     MOVELVAL1      NOM
     C                     MOVELVAL2      MARQUE
     C                     MOVELVAL3      COUL
     C                     MOVELVAL4      PRIX
     C                     UPDATFBONBON
     C                     ENDIF
      *DEBUT SUPP
     C           OPT       IFEQ '3'
     C                     EXFMTWIN1
     C           VAL7      IFEQ 'OUI'
     C                     MOVE 'DELETE'  MSG
     C                     MOVE NUMBER    VAL8
     C           NUMBER    CHAINFBONBON              90
     C                     DELETFBONBON
     C                     ENDIF
     C                     ELSE
     C                     SETON                     03
     C                     ENDIF
      *DEBUT CRÉATION
     C           OPT       IFEQ '4'
     C                     MOVE 'CREATE'  MSG
     C           *HIVAL    SETGTFBONBON
     C                     READPFBONBON                  90
     C                     ADD  1         NUMBER
     C                     MOVEL*BLANK    NOM
     C                     MOVEL*BLANK    MARQUE
     C                     MOVEL*BLANK    COUL
     C                     MOVEL*BLANK    PRIX
     C                     EXFMTFMT1
     C                     MOVELVAL1      NOM
     C                     MOVELVAL2      MARQUE
     C                     MOVELVAL3      COUL
     C                     MOVELVAL4      PRIX
     C                     WRITEFBONBON
     C                     ENDIF
      *CALL PGM(BIB05/BONCRUD) PARM((000001 (*DEC 6 0)) (2 (*CHAR 1)))
```

### BIB05 (RPG/RPG-ILE, 57 lignes)

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIB05
     FBONBONSF  CF   E             WORKSTN
     FBONBKNU   UF A E           K DISK
     IFBONBON
     I              COULEUR                     COUL
     C                   SETON                                        LR
     C     *ENTRY        PLIST
     C                   PARM                    OPT               1
     C                   PARM                    NUMBER            6 0
      *DEBUT MODIF
     C     OPT           IFEQ      '2'
     C                   MOVE      'MODIF'       MSG
     C     NUMBER        CHAIN     FBONBON                            90
     C                   MOVEL     NOM           VAL1
     C                   MOVEL     MARQUE        VAL2
     C                   MOVEL     COUL          VAL3
     C                   MOVEL     PRIX          VAL4
     C                   EXFMT     FMT1
     C                   MOVEL     VAL1          NOM
     C                   MOVEL     VAL2          MARQUE
     C                   MOVEL     VAL3          COUL
     C                   MOVEL     VAL4          PRIX
     C                   UPDATE    FBONBON
     C                   ENDIF
      *DEBUT SUPP
     C     OPT           IFEQ      '3'
     C                   EXFMT     WIN1
     C     VAL7          IFEQ      'OUI'
     C                   MOVE      'DELETE'      MSG
     C                   MOVE      NUMBER        VAL8
     C     NUMBER        CHAIN     FBONBON                            90
     C                   DELETE    FBONBON
     C                   ENDIF
     C                   ELSE
     C                   SETON                                        03
     C                   ENDIF
      *DEBUT CRÉATION
     C     OPT           IFEQ      '4'
     C                   MOVE      'CREATE'      MSG
     C     *HIVAL        SETGT     FBONBON
     C                   READP     FBONBON                                90
     C                   ADD       1             NUMBER
     C                   MOVEL     *BLANK        NOM
     C                   MOVEL     *BLANK        MARQUE
     C                   MOVEL     *BLANK        COUL
     C                   MOVEL     *BLANK        PRIX
     C                   EXFMT     FMT1
     C                   MOVEL     VAL1          NOM
     C                   MOVEL     VAL2          MARQUE
     C                   MOVEL     VAL3          COUL
     C                   MOVEL     VAL4          PRIX
     C                   WRITE     FBONBON
     C                   ENDIF
      *CALL PGM(BIB05/BONCRUD) PARM((000001 (*DEC 6 0)) (2 (*CHAR 1)))
```

### BIB10 (RPG/RPG-III-400, 111 lignes)

```text

      *============================================*
      *              C.R.U.D                       *
      * CRUD OPERATION FOR BONBONS                 *
      *============================================*
      *FICHIERS:
      *DSPF:
      * -BONCRUD
      * - FMT1
      *
      *LF:BONBONF
      * - FBONBON
      *============================================*
     FBONBONF UF  E           K        DISK                      A
     FBONCRUD CF  E                    WORKSTN
     E                    MOD     1   4 20
     IFBONBON
     I              COULEUR                         COUL
      *
     C                     SETON                         LR
     C           *ENTRY    PLIST
     C                     PARM           IND     1
     C                     PARM           NUM     60
     C                     PARM           CRUD    1
     C*
     C           CRUD      CASEQ'6'       SBRCRT
     C           CRUD      CASEQ'5'       SBRDSP
     C           CRUD      CASEQ'2'       SBRUPD
     C           CRUD      CASEQ'4'       SVRDLT
     C                     ENDCS
     C*
     C           INDTA     BEGSR
     C           NUM       CHAINFBONBON              91
     C                     MOVE NUMBER    CNUM
     C                     MOVELNOM       CNOM
     C                     MOVELMARQUE    CMRQ
     C                     MOVELCOUL      CCOUL
     C                     MOVE PRIX      CPRX
     C                     ENDSR
     C           VALDTA    BEGSR
     C           CNOM      COMP *BLANK                   81
     C           CMRQ      COMP *BLANK                   82
     C           CPRX      COMP *ZEROS                 8383
     C                     ENDSR
     C*
     C           SBRDSP    BEGSR
     C                     SETON                     50
     C                     MOVELMOD,2     CMOD
     C                     EXSR INDTA
     C                     EXFMTFMT1
     C   03                MOVE '1'       IND
     C                     ENDSR
      *
     C           SBRUPD    BEGSR
     C                     SETOF                     50
     C                     MOVELMOD,3     CMOD
     C                     EXSR INDTA
     C           1         DOWEQ1
     C                     EXFMTFMT1
     C   03                LEAVE
     C   12                LEAVE
     C                     EXSR VALDTA
     C  N81N82N83          MOVELCNOM      NOM
     C  N81N82N83          MOVELCMRQ      MARQUE
     C  N81N82N83          MOVELCCOUL     COUL
     C  N81N82N83          MOVE CPRX      PRIX
     C  N81N82N83          UPDATFBONBON
     C  N81N82N83          LEAVE
     C                     ENDDO
     C   03                MOVEL'1'       IND
     C                     ENDSR
      *
     C           SBRCRT    BEGSR
     C           *HIVAL    SETLLFBONBON
     C                     READPFBONBON                  91
     C                     ADD  1         NUMBER
     C                     MOVE NUMBER    CNUM
     C                     SETOF                         50
     C                     MOVELMOD,1     CMOD
     C           1         DOWEQ1
     C                     EXFMTFMT1
     C   03                LEAVE
     C   12                LEAVE
     C                     EXSR VALDTA
     C  N81N82N83          MOVELCNOM      NOM
     C  N81N82N83          MOVELCMRQ      MARQUE
     C  N81N82N83          MOVELCCOUL     COUL
     C  N81N82N83          MOVE CPRX      PRIX
     C  N81N82N83          WRITEFBONBON
     C  N81N82N83          LEAVE
     C                     ENDDO
     C   03                MOVEL'1'       IND
     C                     ENDSR
      *
     C           SVRDLT    BEGSR
     C                     EXSR INDTA
     C           1         DOWEQ1
     C                     EXFMTWFMT1
     C           CVER      COMP 'OUI'                    42
     C           CVER      COMP 'NON'                    41
     C   42                DELETFBONBON
     C   42                LEAVE
     C   41                LEAVE
     C                     ENDDO
     C   03                MOVE '1'       IND
     C                     ENDSR
**
   MODE CREATION
  MODE AFFICHAGE
 MODE MODIFICATION
 MODE SUPPRESSION
```

### BIB10 (DDS, 35 lignes)

```text
     A*%%TS  SD  20261013  134220  XUAN        REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R FMT1
     A*%%TS  SD  20261013  115114  XUAN        REL-V7R5M0  5770-WDS                  A                                      CF03(03)
     A                                      CF12(12)                                 A                                  1  3'SYS'
     A                                      COLOR(BLU)                               A                                  1  7SYSNAME
     A                                  1 67'DATE'                                   A                                      COLOR(BLU)
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2  3'USR'                                    A                                      COLOR(BLU)
     A                                  2  7USER                                     A                                  2 67'TIME'
     A                                      COLOR(BLU)                               A                                  2 72TIME
     A                                 24  4'F3=Exit'                                A                                      COLOR(BLU)
     A                                 24 13'F12=Annuler'                            A                                      COLOR(BLU)
     A                                 24 26'F23=Valider'                            A                                      COLOR(BLU)
     A                                  9 13'NOM:'                                   A            CNOM      R        B  9 20REFFLD(FBONBON/NOM BIB10/BONBONF)
     A  50                                  DSPATR(PR)                               A                                      CHECK(LC)
     A  81                                  ERRMSG('Nom Obligatoire !!' 81)         A                                 11 10'MARQUE:'
     A            CMRQ      R        B 11 20REFFLD(FBONBON/MARQUE BIB10/BONBONF)      A  50                                  DSPATR(PR)
     A  82                                  ERRMSG('Marque obligatoire' 82)         A                                      CHECK(LC)
     A                                 13  9'COULEUR:'                               A            CCOUL     R        B 13 20REFFLD(FBONBON/COULEUR BIB10/BONBONF)
     A  50                                  DSPATR(PR)                               A                                      CHECK(LC)
     A                                 15 12'PRIX:'                                  A            CPRX      R        B 15 20REFFLD(FBONBON/PRIX BIB10/BONBONF)
     A                                      EDTCDE(N)                                A  50                                  DSPATR(PR)
     A  83                                  ERRMSG('Prix Obligatoire !!' 83)        A                                  7 10'NUMBER:'
     A            CNUM      R        O  7 20REFFLD(FBONBON/NUMBER BIB10/BONBONF)      A                                  1 35'Fiche bonbon'
     A                                      COLOR(BLU)                               A            CMOD          20A  O  2 31COLOR(WHT)
     A                                 23  3'F3=exit'                                A                                      COLOR(BLU)
     A                                 23 27'Entree=Valider  F12=Annuler'            A                                      COLOR(BLU)
     A                                 23 65'F20=impression'                         A                                      COLOR(BLU)
     A          R WFMT1                                                              A*%%TS  SD  20261013  134220  XUAN        REL-V7R5M0  5770-WDS
     A                                      WINDOW(6 12 10 50)                       A                                  1 21'Suppression'
     A                                  4  4'Vous etes sur le point de supprime-     A                                      r:'
     A            CNOM          20A  O  5  4                                         A                                  9  4'Confirmer la suppression:'
     A            CVER           3   B  9 31                                         A                                  9 35'(OUI/NON)'
     A          R DUMMY                                                              A*%%TS  SD  20261013  132108  XUAN        REL-V7R5M0  5770-WDS
     A                                      ASSUME                                   A                                  1  3' '
```
