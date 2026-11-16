---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: RPGIMPR
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 31
modifie: 2026-11-16
---

# BIB20/QRPGSRC/RPGIMPR

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FIMPR    O   E             60     PRINTER
     FMARBON  IF  E           K        DISK
     FLFBONBONIF  E           K        DISK
     C                     WRITETITRE
     C                     WRITEENTETE
     C           *LOVAL    CHAINLFBONBON             90
     C*
     C           *IN90     DOWEQ'0'
     C                     SETOF                         91
     C                     SETOF                         50
     C                     MOVE MARQUE    MK     20
     C*
     C           *IN91     DOWEQ'0'
     C           *IN50     OREQ '0'
     C           *LOVAL    CHAINMABONF               91
     C*
     C           MARQUE    IFEQ MK
     C                     SETON                         50
     C                     ENDIF
     C*
     C                     ENDDO
     C                     MULT 5         PRIX
     C                     WRITEDETAILS
     C           *IN50     IFEQ '0'
     C                     WRITEETOILE
     C                     ELSE
     C                     WRITEMARK
     C                     ENDIF
     C                     READ FBONBON                  90
     C                     ENDDO
     C                     SETON                         LR
```
