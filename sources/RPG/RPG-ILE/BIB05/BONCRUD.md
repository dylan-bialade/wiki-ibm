---
bibliotheque: BIB05
fichier_source: QRPGLESRC
membre: BONCRUD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 57
modifie: 2026-11-16
---

# BIB05/QRPGLESRC/BONCRUD

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIB05
     FBONBONSF  CF   E             WORKSTN
     FBONBKNU   UF A E           K DISK
     IFBONBON
     I              COULEUR                     COUL
     C                   SETON                                        LR
     C     *ENTRY        PLIST
     C                   PARM                    OPT               1
     C                   PARM                    NUMBER            6 0
      *DEBUT MODIF
     C     OPT           IFEQ      '2'
     C                   MOVE      'MODIF'       MSG
     C     NUMBER        CHAIN     FBONBON                            90
     C                   MOVEL     NOM           VAL1
     C                   MOVEL     MARQUE        VAL2
     C                   MOVEL     COUL          VAL3
     C                   MOVEL     PRIX          VAL4
     C                   EXFMT     FMT1
     C                   MOVEL     VAL1          NOM
     C                   MOVEL     VAL2          MARQUE
     C                   MOVEL     VAL3          COUL
     C                   MOVEL     VAL4          PRIX
     C                   UPDATE    FBONBON
     C                   ENDIF
      *DEBUT SUPP
     C     OPT           IFEQ      '3'
     C                   EXFMT     WIN1
     C     VAL7          IFEQ      'OUI'
     C                   MOVE      'DELETE'      MSG
     C                   MOVE      NUMBER        VAL8
     C     NUMBER        CHAIN     FBONBON                            90
     C                   DELETE    FBONBON
     C                   ENDIF
     C                   ELSE
     C                   SETON                                        03
     C                   ENDIF
      *DEBUT CRÉATION
     C     OPT           IFEQ      '4'
     C                   MOVE      'CREATE'      MSG
     C     *HIVAL        SETGT     FBONBON
     C                   READP     FBONBON                                90
     C                   ADD       1             NUMBER
     C                   MOVEL     *BLANK        NOM
     C                   MOVEL     *BLANK        MARQUE
     C                   MOVEL     *BLANK        COUL
     C                   MOVEL     *BLANK        PRIX
     C                   EXFMT     FMT1
     C                   MOVEL     VAL1          NOM
     C                   MOVEL     VAL2          MARQUE
     C                   MOVEL     VAL3          COUL
     C                   MOVEL     VAL4          PRIX
     C                   WRITE     FBONBON
     C                   ENDIF
      *CALL PGM(BIB05/BONCRUD) PARM((000001 (*DEC 6 0)) (2 (*CHAR 1)))
```
