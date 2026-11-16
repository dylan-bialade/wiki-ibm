---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: DLTBBN
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 51
modifie: 2026-11-16
---

# BIB17/QRPGSRC/DLTBBN

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FBBNLF2  UF  E           K        DISK
     FWDWBBN  CF  E                    WORKSTN
      *
     E                    OPTDLT  1   2  3
      *
     IFBONBON
     I              COULEUR                         COLOR
      *
      *
     C           *ENTRY    PLIST
     C                     PARM           NUMBER
      *
     C           NUMBER    CHAINFBONBON              90
     C           *IN90     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C           *IN12     ANDEQ'0'
     C                     EXFMTWDWDLT
      *
     C                     SELEC
     C           *IN03     WHEQ '1'
     C           *IN12     OREQ '1'
     C           *IN01     OREQ '1'
      *
     C                     OTHER
     C                     SETOF                     49
     C                     EXSR VALDLT
     C   49                DELETFBONBON
     C                     LEAVE
      *
     C                     ENDSL
     C                     ENDDO
     C                     SETON                     LR
      *
     * CONTROLE OPTION DELETE
     C           VALDLT    BEGSR
     C           CONFIR    LOKUPOPTDLT                   79
     C           *IN79     IFEQ '0'
     * GÉRER ERRERU OPTION NON EXISTANTE
     C                     ELSE
      *
     C           CONFIR    IFEQ OPTDLT,1
     C                     SETON                     49
     C                     ELSE
     C                     SETOF                     49
     C                     ENDIF
      *
     C                     ENDIF
     C                     ENDSR
**
OUI
NON
```
