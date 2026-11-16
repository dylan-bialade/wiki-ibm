---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: RPGTP4
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 25
modifie: 2026-11-16
---

# BIB20/QRPGSRC/RPGTP4

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FECRTP4  CF  E                    WORKSTN
     C           *IN03     DOWEQ'0'
     C                     EXFMTCALC
     C                     SETOF                         49
     C                     SELEC
     C           OPE       WHEQ '+'
     C           FAC1      ADD  FAC2      RESULT
     C           OPE       WHEQ '-'
     C           FAC1      SUB  FAC2      RESULT
     C           OPE       WHEQ '*'
     C           FAC1      MULT FAC2      RESULT
     C           OPE       WHEQ '/'
     C           FAC1      DIV  FAC2      RESULT
     C           OPE       WHNE '+'
     C                     SETON                         49
     C                     ENDSL
     C  N49                SETON                         50
     C           *IN05     IFEQ '1'
     C                     MOVE *ZERO     FAC1
     C                     MOVE *ZERO     FAC2
     C                     MOVE *BLANKS   OPE
     C                     SETOF                         50
     C                     ENDIF
     C                     ENDDO
     C                     SETON                         LR
```
