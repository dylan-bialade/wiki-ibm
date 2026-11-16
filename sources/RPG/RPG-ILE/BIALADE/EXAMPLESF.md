---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: EXAMPLESF
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 46
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/EXAMPLESF

```rpg
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIALADE
     FEXAMPSSF  CF   E             WORKSTN
     F                                     SFILE(SFL1:RRN)
     FLIVRESL   IF   E           K DISK
     C     DEBUT         TAG
     C     *IN03         DOWEQ     *OFF
     C                   SETON                                        LR
     C                   SETON                                        32
     C                   WRITE     CTL1
     C                   SETOFF                                       32
     C                   Z-ADD     0             RRN               4 0
     C     *LOVAL        SETLL     LIVREF
     C                   READ      LIVREF                                 90
     C     *IN90         DOWEQ     '0'
     C                   SETOFF                                       32
     C                   ADD       1             RRN
      *AJOUTER LES MOVE
     C                   MOVEL     TITRE         VAL1
     C                   MOVEL     AUTEUR        VAL2
     C                   MOVEL     DISPO         VAL3
     C                   WRITE     SFL1
     C                   READ      LIVREF                                 90
     C                   ENDDO
     C                   SETON                                            31
     C     RRN           IFGT      0
     C                   SETON                                            30
     C                   SETON                                            31
      *ADD WRIT SUR CTL
     C                   WRITE     CTL1
     C                   ENDIF
     C                   WRITE     FOOTER
     C                   EXFMT     CTL1
     C   05              GOTO      DEBUT
     C                   ENDDO
     C*
     C*
     C*                    READCSFL1                     95
     C*          *IN95     DOWEQ*OFF
     C*          OPT       IFEQ '5'
     C*                    ... LOGIQUE POUR AFFICHER LE DÉTAIL ...
     C*                    ENDIF
     C*                    READCSFL1                     95
     C*                    ENDDO
```
