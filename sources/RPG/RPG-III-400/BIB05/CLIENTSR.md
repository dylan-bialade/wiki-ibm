---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: CLIENTSR
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 128
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/CLIENTSR

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
     F                                        RRN   KSFILE SFL1
     FCLIENF  IF  E           K        DISK
     C           CRUD      PLIST
     C                     PARM           OPT     1
     C                     PARM           CLIDCL  60
     C           IDCLI     PLIST
     C                     PARM           CLIDCL  60
     C           DEBUT     TAG
     C           *IN03     DOWEQ*OFF
     C                     SETON                     LR
     C                     Z-ADD0         RRN     40
     C                     SETON                     3233
     C                     WRITECTL1
     C                     SETOF                     32
     C           *LOVAL    SETLLCLIENTSF
     C                     READ CLIENTSF                 90
     C           *IN90     DOWEQ'0'
     C                     SETOF                     32
     C                     ADD  1         RRN
     C                     MOVELCLIDCL    ID
     C                     MOVELCLNOCL    VAL1
     C*                    MOVELCLADCL    VAL
     C                     MOVELCLCPCL    VAL2
     C                     MOVELCLVICL    VAL3
      *===================================================*
      *SUBSTRING
     C                     SUBSTCLCPCL    VAL5
      *===================================================*
      *VERIF SI NUM
     C                     TESTN          CLTECL     55
     C           *IN55     IFEQ *ON
     C                     MOVELCLTECL    VAL4
     C                     ENDIF
      *====================================================*
     C*          *IN11     IFEQ *ON
     C                     MOVELCLMACL    VAL50
     C*                    ENDIF
     C*                    MOVELCLSICL    VAL
      *==================FILTRE SEARCH=====================*
     C           VAL6      COMP *BLANK               4545
     C           *IN45     IFEQ *ON
     C           VAL6      IFEQ VAL5
     C                     WRITESFL1
     C                     ENDIF
     C                     ELSE
     C                     WRITESFL1
     C                     ENDIF
      *========================================================*
     C                     READ CLIENTSF                 90
     C                     ENDDO
     C                     SETON                         31
     C           RRN       IFGT 0
     C                     SETON                         30
     C                     SETON                         31
     C                     WRITECTL1
     C                     ENDIF
     C                     WRITEFOOTER
     C                     EXFMTCTL1
      *====================================================*
     C           *IN06     IFEQ *ON
     C                     MOVEL'4'       OPT
     C                     Z-ADD0         CLIDCL
     C                     SETON                         81
     C                     GOTO PROG2
     C                     ENDIF
     C           *IN24     IFEQ *ON
     C                     SETON                         85
     C                     GOTO PROG3
     C                     ENDIF
      *=====================================================*
     C                     READCSFL1                     76
     C           *IN76     DOWEQ*OFF
     C           OPT       IFEQ '2'
     C           OPT       OREQ '3'
     C                     SETON                         81
     C                     ENDIF
     C           OPT       IFEQ '6'
     C                     SETON                         86
     C                     ENDIF
     C*                    Z-ADD0         ID      60
      *======================================================*
     C                     MOVELOPT       OPT
     C                     MOVELID        CLIDCL
      *======================================================*
     C           PROG2     TAG
     C           *IN81     IFEQ *ON
     C                     CALL 'CLICRUD' CRUD
     C                     ENDIF
     C                     READCSFL1                     76
     C*                    MOVEL*BLANK    OPT
     C*ENDO FIN DE LEC     ENDDO
      *======================================================*
     C           PROG3     TAG
     C           *IN85     IFEQ *ON
     C                     CALL 'CLIMPF'
     C                     ENDIF
     C                     READCSFL1                     76
      *======================================================*
     C           *IN22     IFEQ *ON
     C                     Z-ADD0         CLIDCL
     C                     SETON                         86
     C                     GOTO PROG4
     C                     ENDIF
      *======================================================*
     C*                    READCSFL1                     76
     C*          *IN66     DOWEQ*OFF
     C*          OPT       IFEQ '6'
     C*                    SETON                         86
     C*                    GOTO PROG4
     C*                    ENDIF
      *prog4 in86 with parm
      *======================================================*
     C                     MOVELID        CLIDCL
     C           PROG4     TAG
     C           *IN86     IFEQ *ON
     C                     CALL 'CLIPRI'  IDCLI
     C                     ENDIF
     C                     READCSFL1                     66
     C                     MOVEL*BLANK    OPT
     C                     ENDDO                           LECTURE OPT
      *======================================================*
     C   05                GOTO DEBUT
     C                     ENDDO
```
