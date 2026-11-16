---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: BECRUD
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 71
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/BECRUD

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
     FBEERSF  CF  E                    WORKSTN
     FBEERKR  UF  E           K        DISK                      A
     IBEERF
     I              TXTVAPR                         TXTVA
     C                     SETON                     LR
     C           *ENTRY    PLIST
     C                     PARM           OPT     1
     C                     PARM           PRIDPR  60
     C           *IN03     DOWEQ*OFF
      *DEBUT MODIF
     C           OPT       IFEQ '2'
     C                     MOVE 'MODIF'   MSG
     C           PRIDPR    CHAINBEERF                90
     C                     MOVELPRIDPR    ID
     C                     MOVELPRREPR    REF
     C                     MOVELPRNOPR    PROD
     C                     MOVE TXTVA     TVA
     C                     MOVE PRUNVE    UNIT
     C                     MOVE PRSTPR    ACTU
     C                     MOVE STMIPR    STOKMI
     C                     EXFMTFMT1
     C                     MOVELID        PRIDPR
     C                     MOVELREF       PRREPR
     C                     MOVELPROD      PRNOPR
     C                     MOVE TVA       TXTVA
     C                     MOVE UNIT      PRUNVE
     C                     MOVE ACTU      PRSTPR
     C                     MOVE STOKMI    STMIPR
     C                     EXFMTFMT1
     C                     UPDATBEERF
     C                     SETON                     03
     C                     ENDIF
      *CEBUT SUPP
     C           OPT       IFEQ '3'
     C                     EXFMTWIN1
     C           VALOUI    IFEQ 'OUI'
     C                     MOVE 'DELETE'  MSG
     C                     MOVE PRIDPR    VALWIN
     C           PRIDPR    CHAINBEERF                90
     C                     DELETBEERF
     C                     ENDIF
     C                     ELSE
     C                     SETON                     03
     C                     ENDIF
      *DEBUT CRÉATION
     C           OPT       IFEQ '4'
     C                     MOVE 'CREATE'  MSG
     C           *HIVAL    SETGTBEERF
     C                     READPBEERF                    90
     C                     ADD  1         STOKMI
     C                     MOVEL*BLANK    PRIDPR
     C                     MOVEL*BLANK    PRREPR
     C                     MOVEL*BLANK    PRNOPR
     C                     MOVEL*BLANK    PRUNVE
     C                     MOVEL*BLANK    PRSTPR
     C                     MOVEL*BLANK    STMIPR
     C                     EXFMTFMT1
     C                     MOVELID        STOKMI
     C                     MOVELREF       PRIDPR
     C                     MOVELPROD      PRREPR
     C                     MOVE TVA       PRNOPR
     C                     MOVE UNIT      PRUNVE
     C                     MOVE ACTU      PRSTPR
     C                     MOVE STOKMI    STMIPR
     C                     WRITEBEERF
     C                     ENDIF
     C                     ENDDO
```
