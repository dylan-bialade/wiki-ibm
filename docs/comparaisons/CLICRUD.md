# CLICRUD : 3 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGSRC2 | RPG/RPG-III-400 | 69 | 100 % | ecran (WORKSTN), indicateurs *INxx | [CLICRUD.md](../../sources/RPG/RPG-III-400/BIB05/CLICRUD.md) |
| BIB10 | QRPGSRC | RPG/RPG-III-400 | 104 | 4 % | ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc) | [CLICRUD.md](../../sources/RPG/RPG-III-400/BIB10/CLICRUD.md) |
| BIB05 | QRPGLESRC | RPG/RPG-ILE | 69 | 32 % | ecran (WORKSTN), CHAIN, indicateurs *INxx | [CLICRUD.md](../../sources/RPG/RPG-ILE/BIB05/CLICRUD.md) |

## Differences

- Techniques communes : ecran (WORKSTN)
- **BIB05** en propre : indicateurs *INxx
- **BIB10** en propre : boucle DOW/DOU/FOR, procedures (dcl-proc)
- **BIB05** en propre : CHAIN, indicateurs *INxx
- Langages / types differents : RPG/RPG-III-400, RPG/RPG-ILE

## Codes

### BIB05 (RPG/RPG-III-400, 69 lignes)

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIB05
     FCLIENSF CF  E                    WORKSTN
     FCLIENF  UF  E           K        DISK                      A
     C                     SETON                     LR
     C           *ENTRY    PLIST
     C                     PARM           OPT     1
     C                     PARM           CLIDCL  60
      *DEBUT MODIF
     C           OPT       IFEQ '2'
     C                     MOVE 'MODIF'   MSG
     C           CLIDCL    CHAINCLIENTSF             90
     C                     MOVELCLNOCL    VAL1
     C*                    MOVELCLADCL    VAL
     C                     MOVELCLCPCL    VAL2
     C                     MOVELCLVICL    VAL3
     C                     TESTN          CLTECL     55
     C           *IN55     IFEQ *ON
     C                     MOVELCLTECL    VAL4
     C                     ENDIF
     C                     MOVELCLMACL    VAL50
     C*                    MOVELCLSICL    VAL
     C                     EXFMTFMT1
     C                     MOVELVAL1      CLNOCL
     C*                    MOVELVAL       CLADCL
     C                     MOVELVAL2      CLCPCL
     C                     MOVELVAL3      CLVICL
     C                     MOVELVAL4      CLTECL
     C                     MOVELVAL50     CLMACL
     C*                    MOVELVAL       CLSICL
     C                     UPDATCLIENTSF
     C                     ENDIF
      *DEBUT SUPP
     C           OPT       IFEQ '3'
     C                     EXFMTWIN1
     C           VALOUI    IFEQ 'OUI'
     C                     MOVE 'DELETE'  MSG
     C                     MOVE CLIDCL    VALWIN
     C           CLIDCL    CHAINCLIENTSF             90
     C                     DELETCLIENTSF
     C                     ENDIF
     C                     ELSE
     C                     SETON                     03
     C                     ENDIF
      *DEBUT CRÉATION
     C           OPT       IFEQ '4'
     C                     MOVE 'CREATE'  MSG
     C           *HIVAL    SETGTCLIENTSF
     C                     READPCLIENTSF                 90
     C                     ADD  1         CLIDCL
     C                     MOVEL*BLANK    CLNOCL
     C                     MOVEL*BLANK    CLADCL
     C                     MOVEL*BLANK    CLCPCL
     C                     MOVEL*BLANK    CLVICL
     C                     MOVEL*BLANK    CLTECL
     C                     MOVEL*BLANK    CLMACL
     C*                    MOVEL*BLANK    CLSICL
     C                     EXFMTFMT1
     C                     MOVELVAL1      CLNOCL
     C*                    MOVELVAL       CLADCL
     C                     MOVELVAL2      CLCPCL
     C                     MOVELVAL3      CLVICL
     C                     MOVELVAL4      CLTECL
     C                     MOVELVAL50     CLMACL
     C*                    MOVELVAL       CLSICL
     C                     WRITECLIENTSF
     C                     ENDIF
```

### BIB10 (RPG/RPG-III-400, 104 lignes)

```text
      *============================================*
      *              C.R.U.D                       *
      * CRUD OPERATION FOR BONBONS                 *
      *============================================*
      *FICHIERS:
      *DSPF:
      * -CLICRUD
      * - FMT1
      *
      *PF:FICCLI
      * - CLIENTSF  K:CLIDCL
      *============================================*
     FFICCLI  UF  E           K        DISK                      A
     FCLIDSP  CF  E                    WORKSTN
     E                    MOD     1   4 20
      *
     C                     SETON                         LR
     C           *ENTRY    PLIST
     C                     PARM           IND     1
     C                     PARM           CRUD    1
     C                     PARM           CLIDCL
     C*
     C           PLPRT     PLIST
     C                     PARM           CLIDCL
     C           CRUD      CASEQ'1'       SBRCRT
     C           CRUD      CASEQ'5'       SBRDSP
     C           CRUD      CASEQ'2'       SBRUPD
     C           CRUD      CASEQ'4'       SVRDLT
     C           CRUD      CASEQ'6'       SBRPRT
     C                     ENDCS
     C*
     C           INDTA     BEGSR
     C           CLIDCL    CHAINCLIENTSF             91
     C                     TESTN          CLTECL     88
     C   88                MOVELCLTECL    TEL
     C  N88                MOVEL*ZEROS    TEL
     C                     ENDSR
     C           VALDTA    BEGSR
     C           CLNOCL    COMP *BLANK                   81
     C           CLCPCL    COMP *BLANK                   82
     C           TEL       COMP *ZEROS                   83
     C                     ENDSR
     C*
     C           SBRDSP    BEGSR
     C                     SETON                     45
     C                     MOVELMOD,2     CMOD
     C                     EXSR INDTA
     C                     EXFMTDTAI
     C   03                MOVE '1'       IND
     C                     ENDSR
      *
     C           SBRUPD    BEGSR
     C                     SETOF                     45
     C                     MOVELMOD,3     CMOD
     C                     EXSR INDTA
     C           1         DOWEQ1
     C                     EXFMTDTAI
     C   03                LEAVE
     C   12                LEAVE
     C                     EXSR VALDTA
     C  N81N82N83          UPDATCLIENTSF
     C  N81N82N83          LEAVE
     C                     ENDDO
     C   03                MOVEL'1'       IND
     C                     ENDSR
      *
     C           SBRCRT    BEGSR
     C           *HIVAL    SETGTCLIENTSF
     C                     READPCLIENTSF                 91
     C                     ADD  1         CLIDCL
     C                     SETOF                         45
     C                     MOVELMOD,1     CMOD
     C                     CLEARDTAI
     C           1         DOWEQ1
     C                     EXFMTDTAI
     C   03                LEAVE
     C   12                LEAVE
     C                     EXSR VALDTA
     C  N81N82N83          WRITECLIENTSF
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
     C   42                DELETCLIENTSF
     C   42                LEAVE
     C   41                LEAVE
     C                     ENDDO
     C   03                MOVE '1'       IND
     C                     ENDSR
     C           SBRPRT    BEGSR
     C                     CALL 'CLIPRT'  PLPRT
     C                     ENDSR
**
   MODE CREATION
  MODE AFFICHAGE
 MODE MODIFICATION
 MODE SUPPRESSION
```

### BIB05 (RPG/RPG-ILE, 69 lignes)

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIB05
     FCLIENSF   CF   E             WORKSTN
     FCLIENF    UF A E           K DISK
     C                   SETON                                        LR
     C     *ENTRY        PLIST
     C                   PARM                    OPT               1
     C                   PARM                    CLIDCL            6 0
      *DEBUT MODIF
     C     OPT           IFEQ      '2'
     C                   MOVE      'MODIF'       MSG
     C     CLIDCL        CHAIN     CLIENTSF                           90
     C                   MOVEL     CLNOCL        VAL1
     C*                    MOVELCLADCL    VAL
     C                   MOVEL     CLCPCL        VAL2
     C                   MOVEL     CLVICL        VAL3
     C                   TESTN                   CLTECL               55
     C     *IN55         IFEQ      *ON
     C                   MOVEL     CLTECL        VAL4
     C                   ENDIF
     C                   MOVEL     CLMACL        VAL50
     C*                    MOVELCLSICL    VAL
     C                   EXFMT     FMT1
     C                   MOVEL     VAL1          CLNOCL
     C*                    MOVELVAL       CLADCL
     C                   MOVEL     VAL2          CLCPCL
     C                   MOVEL     VAL3          CLVICL
     C                   MOVEL     VAL4          CLTECL
     C                   MOVEL     VAL50         CLMACL
     C*                    MOVELVAL       CLSICL
     C                   UPDATE    CLIENTSF
     C                   ENDIF
      *DEBUT SUPP
     C     OPT           IFEQ      '3'
     C                   EXFMT     WIN1
     C     VALOUI        IFEQ      'OUI'
     C                   MOVE      'DELETE'      MSG
     C                   MOVE      CLIDCL        VALWIN
     C     CLIDCL        CHAIN     CLIENTSF                           90
     C                   DELETE    CLIENTSF
     C                   ENDIF
     C                   ELSE
     C                   SETON                                        03
     C                   ENDIF
      *DEBUT CRÉATION
     C     OPT           IFEQ      '4'
     C                   MOVE      'CREATE'      MSG
     C     *HIVAL        SETGT     CLIENTSF
     C                   READP     CLIENTSF                               90
     C                   ADD       1             CLIDCL
     C                   MOVEL     *BLANK        CLNOCL
     C                   MOVEL     *BLANK        CLADCL
     C                   MOVEL     *BLANK        CLCPCL
     C                   MOVEL     *BLANK        CLVICL
     C                   MOVEL     *BLANK        CLTECL
     C                   MOVEL     *BLANK        CLMACL
     C*                    MOVEL*BLANK    CLSICL
     C                   EXFMT     FMT1
     C                   MOVEL     VAL1          CLNOCL
     C*                    MOVELVAL       CLADCL
     C                   MOVEL     VAL2          CLCPCL
     C                   MOVEL     VAL3          CLVICL
     C                   MOVEL     VAL4          CLTECL
     C                   MOVEL     VAL50         CLMACL
     C*                    MOVELVAL       CLSICL
     C                   WRITE     CLIENTSF
     C                   ENDIF
```
