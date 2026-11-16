---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: CLICRUD
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 104
modifie: 2026-11-16
---

# BIB10/QRPGSRC/CLICRUD

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

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
