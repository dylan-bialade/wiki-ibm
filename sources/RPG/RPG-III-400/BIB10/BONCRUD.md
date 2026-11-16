---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: BONCRUD
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 111
modifie: 2026-11-16
---

# BIB10/QRPGSRC/BONCRUD

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
