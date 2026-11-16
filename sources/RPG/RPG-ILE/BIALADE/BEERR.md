---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: BEERR
type: RPG\RPG-ILE
longueur_enregistrement: 100
lignes: 122
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/BEERR

```rpg
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIALADE
     FBEERSF    CF   E             WORKSTN
     F                                     SFILE(SFL1:RRN)
     FBEERKR    IF   E           K DISK
     IBEERF
     I              TXTVAPR                     TXTVA
     C     CRUD          PLIST
     C                   PARM                    OPT               1
     C                   PARM                    PRIDPR            6 0
     C     IDIMP         PLIST
     C                   PARM                    PRIDPR            6 0
     C     DEBUT         TAG
     C     *IN03         DOWEQ     *OFF
     C                   SETON                                        LR
     C                   Z-ADD     0             RRN               4 0
     C                   SETON                                        3233
     C                   WRITE     CTL1
     C                   SETOFF                                       32
     C     *LOVAL        SETLL     BEERF
     C                   READ      BEERF                                  90
     C     *IN90         DOWEQ     '0'
     C     RRN           COMP      9998                                   90
     C   90              LEAVE
     C                   SETOFF                                       32
     C                   ADD       1             RRN
     C                   MOVEL     PRIDPR        ID
     C                   MOVEL     PRREPR        REF
     C                   MOVEL     PRNOPR        PROD
     C                   MOVE      TXTVA         TVA
     C                   MOVE      PRUNVE        UNIT
     C                   MOVE      PRSTPR        ACTU
     C                   MOVE      STMIPR        STOKMI
      *====================================================*
     C     STOKMI        COMP      ACTU                               69
      *==================FILTRE SEARCH=====================*
     C     SEARC         COMP      *BLANK                             4545
     C     *IN45         IFEQ      *ON
     C     SEARC         IFEQ      ID
     C                   WRITE     SFL1
     C                   ENDIF
     C                   ELSE
     C                   WRITE     SFL1
     C                   ENDIF
      *========================================================*
     C                   READ      BEERF                                  90
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
     C                   Z-ADD     0             PRIDPR
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
     C                   MOVEL     ID            PRIDPR
      *======================================================*
     C     PROG2         TAG
     C     *IN81         IFEQ      *ON
     C                   CALL      'BECRUD'      CRUD
     C                   ENDIF
     C                   READC     SFL1                                   76
     C*                    MOVEL*BLANK    OPT
     C*ENDO FIN DE LEC     ENDDO
      *======================================================*
     C     PROG3         TAG
     C     *IN85         IFEQ      *ON
     C                   CALL      'BEERPF'
     C                   ENDIF
     C                   READC     SFL1                                   76
      *======================================================*
     C     *IN22         IFEQ      *ON
     C                   Z-ADD     0             PRIDPR
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
     C                   MOVEL     ID            PRIDPR
     C     PROG4         TAG
     C     *IN86         IFEQ      *ON
     C                   CALL      'BEERRI'      IDIMP
     C                   ENDIF
     C                   READC     SFL1                                   66
     C                   MOVEL     *BLANK        OPT
     C                   ENDDO                                                  LECTURE OPT
      *======================================================*
     C   05              GOTO      DEBUT
     C                   ENDDO
```
