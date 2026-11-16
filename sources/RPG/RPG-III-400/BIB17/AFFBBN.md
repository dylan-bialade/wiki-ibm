---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: AFFBBN
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 40
modifie: 2026-11-16
---

# BIB17/QRPGSRC/AFFBBN

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FBBNLF2  IF  E           K        DISK
     FBBNDSP  CF  E                    WORKSTN
      *
     E                    STRIN   1   2 15
      *
     IFBONBON
     I              COULEUR                         COLOR
     ISFL1
     I              COULEUR                         COLOR
     IMODBBN
     I              COULEUR                         COLOR
      *
      *
     C           *ENTRY    PLIST
     C                     PARM           NUMBER
      *
     C                     SETON                     50
     C           NUMBER    CHAINFBONBON              90
     C           *IN90     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C           *IN12     ANDEQ'0'
     C                     MOVELSTRIN,2   MODMOD
     C                     EXFMTMODBBN
      *
     C                     SELEC
     C           *IN03     WHEQ '1'
     C           *IN12     OREQ '1'
     C           *IN20     OREQ '1'
      *
     C                     OTHER
     C                     SETOF                     49
     C                     LEAVE
      *
     C                     ENDSL
     C                     ENDDO
     C                     SETON                     LR
      *
**
MODIFICATION
AFFICHAGE
```
