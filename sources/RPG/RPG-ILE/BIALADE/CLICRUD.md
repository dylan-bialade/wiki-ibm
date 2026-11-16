---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: CLICRUD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 69
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/CLICRUD

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIALADE
     FCLIENSF   CF   E             WORKSTN
     FCLIENF    UF A E           K DISK
     C                   SETON                                        LR
     C     *ENTRY        PLIST
     C                   PARM                    OPT               1
     C                   PARM                    CLIDCL            6 0
      *DEBUT MODIF
     C     OPT           IFEQ      '2'
     C                   MOVE      'MODIF'       MSG
     C     CLIDCL        CHAIN     CLIENTSF                           90
     C                   MOVEL     CLNOCL        VAL1
     C*                    MOVELCLADCL    VAL
     C                   MOVEL     CLCPCL        VAL2
     C                   MOVEL     CLVICL        VAL3
     C                   TESTN                   CLTECL               55
     C     *IN55         IFEQ      *ON
     C                   MOVEL     CLTECL        VAL4
     C                   ENDIF
     C                   MOVEL     CLMACL        VAL50
     C*                    MOVELCLSICL    VAL
     C                   EXFMT     FMT1
     C                   MOVEL     VAL1          CLNOCL
     C*                    MOVELVAL       CLADCL
     C                   MOVEL     VAL2          CLCPCL
     C                   MOVEL     VAL3          CLVICL
     C                   MOVEL     VAL4          CLTECL
     C                   MOVEL     VAL50         CLMACL
     C*                    MOVELVAL       CLSICL
     C                   UPDATE    CLIENTSF
     C                   ENDIF
      *DEBUT SUPP
     C     OPT           IFEQ      '3'
     C                   EXFMT     WIN1
     C     VALOUI        IFEQ      'OUI'
     C                   MOVE      'DELETE'      MSG
     C                   MOVE      CLIDCL        VALWIN
     C     CLIDCL        CHAIN     CLIENTSF                           90
     C                   DELETE    CLIENTSF
     C                   ENDIF
     C                   ELSE
     C                   SETON                                        03
     C                   ENDIF
      *DEBUT CRÉATION
     C     OPT           IFEQ      '4'
     C                   MOVE      'CREATE'      MSG
     C     *HIVAL        SETGT     CLIENTSF
     C                   READP     CLIENTSF                               90
     C                   ADD       1             CLIDCL
     C                   MOVEL     *BLANK        CLNOCL
     C                   MOVEL     *BLANK        CLADCL
     C                   MOVEL     *BLANK        CLCPCL
     C                   MOVEL     *BLANK        CLVICL
     C                   MOVEL     *BLANK        CLTECL
     C                   MOVEL     *BLANK        CLMACL
     C*                    MOVEL*BLANK    CLSICL
     C                   EXFMT     FMT1
     C                   MOVEL     VAL1          CLNOCL
     C*                    MOVELVAL       CLADCL
     C                   MOVEL     VAL2          CLCPCL
     C                   MOVEL     VAL3          CLVICL
     C                   MOVEL     VAL4          CLTECL
     C                   MOVEL     VAL50         CLMACL
     C*                    MOVELVAL       CLSICL
     C                   WRITE     CLIENTSF
     C                   ENDIF
```
