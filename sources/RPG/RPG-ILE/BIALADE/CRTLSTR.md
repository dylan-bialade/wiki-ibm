---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: CRTLSTR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 46
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/CRTLSTR

```rpg
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIALADE
     FLSTSF     CF   E             WORKSTN
     F                                     SFILE(SFL1:RRN)
     FLSTKF     IF   E           K DISK
     C*          CRUD      PLIST
     C*                    PARM           OPT     1
     C*                    PARM           NUMBER  60
     C     DEBUT         TAG
     C     *IN03         DOWEQ     *OFF
     C                   SETON                                        LR
     C                   Z-ADD     0             RRN               4 0
     C                   SETON                                        3233
     C                   WRITE     CTL1
     C                   SETOFF                                       32
     C     VAL6          IFEQ      *BLANK
     C     *LOVAL        SETLL     FMTDBX
     C                   ELSE
     C     VAL6          SETLL     FMTDBX
     C                   ENDIF
     C                   READ      FMTDBX                                 90
     C     *IN90         DOWEQ     '0'
     C                   SETOFF                                       32
     C                   ADD       1             RRN
     C                   MOVEL     DBXLIB        LIB
     C                   MOVEL     DBXFIL        FIL
     C                   MOVEL     DBXMBR        MBR
     C                   MOVEL     DBXTYP        TYP
     C                   MOVEL     DBXTXT        TXT
     C                   ADD       DBXNBL        NBL
     C                   WRITE     SFL1
     C                   READ      FMTDBX                                 90
     C                   ENDDO
     C                   SETON                                            31
     C     RRN           IFGT      0
     C                   SETON                                            30
     C                   SETON                                            31
     C                   WRITE     CTL1
     C                   ENDIF
     C                   WRITE     FOOTER
     C                   EXFMT     CTL1
      *======================================================*
     C   05              GOTO      DEBUT
     C                   ENDDO
```
