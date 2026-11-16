---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: BECRUD
type: RPG\RPG-ILE
longueur_enregistrement: 100
lignes: 71
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/BECRUD

```rpg
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIALADE
     FBEERSF    CF   E             WORKSTN
     FBEERKR    UF A E           K DISK
     IBEERF
     I              TXTVAPR                     TXTVA
     C                   SETON                                        LR
     C     *ENTRY        PLIST
     C                   PARM                    OPT               1
     C                   PARM                    PRIDPR            6 0
     C     *IN03         DOWEQ     *OFF
      *DEBUT MODIF
     C     OPT           IFEQ      '2'
     C                   MOVE      'MODIF'       MSG
     C     PRIDPR        CHAIN     BEERF                              90
     C                   MOVEL     PRIDPR        ID
     C                   MOVEL     PRREPR        REF
     C                   MOVEL     PRNOPR        PROD
     C                   MOVE      TXTVA         TVA
     C                   MOVE      PRUNVE        UNIT
     C                   MOVE      PRSTPR        ACTU
     C                   MOVE      STMIPR        STOKMI
     C                   EXFMT     FMT1
     C                   MOVEL     ID            PRIDPR
     C                   MOVEL     REF           PRREPR
     C                   MOVEL     PROD          PRNOPR
     C                   MOVE      TVA           TXTVA
     C                   MOVE      UNIT          PRUNVE
     C                   MOVE      ACTU          PRSTPR
     C                   MOVE      STOKMI        STMIPR
     C                   EXFMT     FMT1
     C                   UPDATE    BEERF
     C                   SETON                                        03
     C                   ENDIF
      *CEBUT SUPP
     C     OPT           IFEQ      '3'
     C                   EXFMT     WIN1
     C     VALOUI        IFEQ      'OUI'
     C                   MOVE      'DELETE'      MSG
     C                   MOVE      PRIDPR        VALWIN
     C     PRIDPR        CHAIN     BEERF                              90
     C                   DELETE    BEERF
     C                   ENDIF
     C                   ELSE
     C                   SETON                                        03
     C                   ENDIF
      *DEBUT CRÉATION
     C     OPT           IFEQ      '4'
     C                   MOVE      'CREATE'      MSG
     C     *HIVAL        SETGT     BEERF
     C                   READP     BEERF                                  90
     C                   ADD       1             STOKMI
     C                   MOVEL     *BLANK        PRIDPR
     C                   MOVEL     *BLANK        PRREPR
     C                   MOVEL     *BLANK        PRNOPR
     C                   MOVEL     *BLANK        PRUNVE
     C                   MOVEL     *BLANK        PRSTPR
     C                   MOVEL     *BLANK        STMIPR
     C                   EXFMT     FMT1
     C                   MOVEL     ID            STOKMI
     C                   MOVEL     REF           PRIDPR
     C                   MOVEL     PROD          PRREPR
     C                   MOVE      TVA           PRNOPR
     C                   MOVE      UNIT          PRUNVE
     C                   MOVE      ACTU          PRSTPR
     C                   MOVE      STOKMI        STMIPR
     C                   WRITE     BEERF
     C                   ENDIF
     C                   ENDDO
```
