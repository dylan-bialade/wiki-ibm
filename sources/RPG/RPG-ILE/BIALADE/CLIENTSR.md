---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: CLIENTSR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 128
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/CLIENTSR

```rpg
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIALADE
     FCLIENSF   CF   E             WORKSTN
     F                                     SFILE(SFL1:RRN)
     FCLIENF    IF   E           K DISK
     C     CRUD          PLIST
     C                   PARM                    OPT               1
     C                   PARM                    CLIDCL            6 0
     C     IDCLI         PLIST
     C                   PARM                    CLIDCL            6 0
     C     DEBUT         TAG
     C     *IN03         DOWEQ     *OFF
     C                   SETON                                        LR
     C                   Z-ADD     0             RRN               4 0
     C                   SETON                                        3233
     C                   WRITE     CTL1
     C                   SETOFF                                       32
     C     *LOVAL        SETLL     CLIENTSF
     C                   READ      CLIENTSF                               90
     C     *IN90         DOWEQ     '0'
     C                   SETOFF                                       32
     C                   ADD       1             RRN
     C                   MOVEL     CLIDCL        ID
     C                   MOVEL     CLNOCL        VAL1
     C*                    MOVELCLADCL    VAL
     C                   MOVEL     CLCPCL        VAL2
     C                   MOVEL     CLVICL        VAL3
      *===================================================*
      *SUBSTRING
     C                   SUBST     CLCPCL        VAL5
      *===================================================*
      *VERIF SI NUM
     C                   TESTN                   CLTECL               55
     C     *IN55         IFEQ      *ON
     C                   MOVEL     CLTECL        VAL4
     C                   ENDIF
      *====================================================*
     C*          *IN11     IFEQ *ON
     C                   MOVEL     CLMACL        VAL50
     C*                    ENDIF
     C*                    MOVELCLSICL    VAL
      *==================FILTRE SEARCH=====================*
     C     VAL6          COMP      *BLANK                             4545
     C     *IN45         IFEQ      *ON
     C     VAL6          IFEQ      VAL5
     C                   WRITE     SFL1
     C                   ENDIF
     C                   ELSE
     C                   WRITE     SFL1
     C                   ENDIF
      *========================================================*
     C                   READ      CLIENTSF                               90
     C                   ENDDO
     C                   SETON                                            31
     C     RRN           IFGT      0
     C                   SETON                                            30
     C                   SETON                                            31
     C                   WRITE     CTL1
     C                   ENDIF
     C                   WRITE     FOOTER
     C                   EXFMT     CTL1
      *====================================================*
     C     *IN06         IFEQ      *ON
     C                   MOVEL     '4'           OPT
     C                   Z-ADD     0             CLIDCL
     C                   SETON                                            81
     C                   GOTO      PROG2
     C                   ENDIF
     C     *IN24         IFEQ      *ON
     C                   SETON                                            85
     C                   GOTO      PROG3
     C                   ENDIF
      *=====================================================*
     C                   READC     SFL1                                   76
     C     *IN76         DOWEQ     *OFF
     C     OPT           IFEQ      '2'
     C     OPT           OREQ      '3'
     C                   SETON                                            81
     C                   ENDIF
     C     OPT           IFEQ      '6'
     C                   SETON                                            86
     C                   ENDIF
     C*                    Z-ADD0         ID      60
      *======================================================*
     C                   MOVEL     OPT           OPT
     C                   MOVEL     ID            CLIDCL
      *======================================================*
     C     PROG2         TAG
     C     *IN81         IFEQ      *ON
     C                   CALL      'CLICRUD'     CRUD
     C                   ENDIF
     C                   READC     SFL1                                   76
     C*                    MOVEL*BLANK    OPT
     C*ENDO FIN DE LEC     ENDDO
      *======================================================*
     C     PROG3         TAG
     C     *IN85         IFEQ      *ON
     C                   CALL      'CLIMPF'
     C                   ENDIF
     C                   READC     SFL1                                   76
      *======================================================*
     C     *IN22         IFEQ      *ON
     C                   Z-ADD     0             CLIDCL
     C                   SETON                                            86
     C                   GOTO      PROG4
     C                   ENDIF
      *======================================================*
     C*                    READCSFL1                     76
     C*          *IN66     DOWEQ*OFF
     C*          OPT       IFEQ '6'
     C*                    SETON                         86
     C*                    GOTO PROG4
     C*                    ENDIF
      *prog4 in86 with parm
      *======================================================*
     C                   MOVEL     ID            CLIDCL
     C     PROG4         TAG
     C     *IN86         IFEQ      *ON
     C                   CALL      'CLIPRI'      IDCLI
     C                   ENDIF
     C                   READC     SFL1                                   66
     C                   MOVEL     *BLANK        OPT
     C                   ENDDO                                                  LECTURE OPT
      *======================================================*
     C   05              GOTO      DEBUT
     C                   ENDDO
```
