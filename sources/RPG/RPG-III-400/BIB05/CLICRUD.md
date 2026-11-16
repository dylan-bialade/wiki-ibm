---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: CLICRUD
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 69
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/CLICRUD

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

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
