---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: BONBONR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 73
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/BONBONR

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIALADE
     FBONBONSF  CF   E             WORKSTN
     F                                     SFILE(SFL1:RRN)
     FBONBONKN  IF   E           K DISK
     IBONBONL
     I              COULEUR                     COUL
     C     CRUD          PLIST
     C                   PARM                    OPT               1
     C                   PARM                    NUMBER            6 0
     C     DEBUT         TAG
     C     *IN03         DOWEQ     *OFF
     C                   SETON                                        LR
     C                   Z-ADD     0             RRN               4 0
     C                   SETON                                        3233
     C                   WRITE     CTL1
     C                   SETOFF                                       32
     C     VAL6          IFEQ      *BLANK
     C     *LOVAL        SETLL     BONBONKN
     C                   ELSE
     C     VAL6          SETLL     BONBONKN
     C                   ENDIF
     C                   READ      BONBONKN                               90
     C     *IN90         DOWEQ     '0'
     C                   SETOFF                                       32
     C                   ADD       1             RRN
     C                   MOVEL     NOM           VAL1
     C                   MOVEL     MARQUE        VAL2
     C                   MOVEL     COUL          VAL3
     C                   MOVEL     PRIX          VAL4
     C     VAL4          CAT       ' €':1        VAL4
     C                   MOVEL     NUMBER        VAL5
     C                   WRITE     SFL1
     C                   READ      BONBONKN                               90
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
     C                   Z-ADD     0             NUMBER
     C                   SETON                                            81
     C                   GOTO      PROG2
     C                   ENDIF
      *=====================================================*
     C                   READC     SFL1                                   76
     C     *IN76         DOWEQ     *OFF
     C     OPT           IFEQ      '2'
     C     OPT           OREQ      '3'
     C                   SETON                                            81
     C                   ENDIF
      *======================================================*
     C                   MOVEL     OPT           OPT
     C                   MOVEL     VAL5          NUMBER
      *======================================================*
     C     PROG2         TAG
     C     *IN81         IFEQ      *ON
     C                   CALL      'BONCRUD'     CRUD
     C                   ENDIF
     C                   READC     SFL1                                   76
     C                   MOVEL     *BLANK        OPT
     C                   ENDDO
      *======================================================*
     C   05              GOTO      DEBUT
     C                   ENDDO
```
