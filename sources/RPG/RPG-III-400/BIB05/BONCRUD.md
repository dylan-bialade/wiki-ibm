---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: BONCRUD
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 57
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/BONCRUD

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
     FBONBONSFCF  E                    WORKSTN
     FBONBKNU UF  E           K        DISK                      A
     IFBONBON
     I              COULEUR                         COUL
     C                     SETON                     LR
     C           *ENTRY    PLIST
     C                     PARM           OPT     1
     C                     PARM           NUMBER  60
      *DEBUT MODIF
     C           OPT       IFEQ '2'
     C                     MOVE 'MODIF'   MSG
     C           NUMBER    CHAINFBONBON              90
     C                     MOVELNOM       VAL1
     C                     MOVELMARQUE    VAL2
     C                     MOVELCOUL      VAL3
     C                     MOVELPRIX      VAL4
     C                     EXFMTFMT1
     C                     MOVELVAL1      NOM
     C                     MOVELVAL2      MARQUE
     C                     MOVELVAL3      COUL
     C                     MOVELVAL4      PRIX
     C                     UPDATFBONBON
     C                     ENDIF
      *DEBUT SUPP
     C           OPT       IFEQ '3'
     C                     EXFMTWIN1
     C           VAL7      IFEQ 'OUI'
     C                     MOVE 'DELETE'  MSG
     C                     MOVE NUMBER    VAL8
     C           NUMBER    CHAINFBONBON              90
     C                     DELETFBONBON
     C                     ENDIF
     C                     ELSE
     C                     SETON                     03
     C                     ENDIF
      *DEBUT CRÉATION
     C           OPT       IFEQ '4'
     C                     MOVE 'CREATE'  MSG
     C           *HIVAL    SETGTFBONBON
     C                     READPFBONBON                  90
     C                     ADD  1         NUMBER
     C                     MOVEL*BLANK    NOM
     C                     MOVEL*BLANK    MARQUE
     C                     MOVEL*BLANK    COUL
     C                     MOVEL*BLANK    PRIX
     C                     EXFMTFMT1
     C                     MOVELVAL1      NOM
     C                     MOVELVAL2      MARQUE
     C                     MOVELVAL3      COUL
     C                     MOVELVAL4      PRIX
     C                     WRITEFBONBON
     C                     ENDIF
      *CALL PGM(BIB05/BONCRUD) PARM((000001 (*DEC 6 0)) (2 (*CHAR 1)))
```
