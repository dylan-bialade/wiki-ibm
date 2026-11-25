---
bibliotheque: BIB25
fichier_source: QRPG3
membre: TP3C
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 35
modifie: 2026-11-25
---

# BIB25/QRPG3/TP3C

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H* Saisie de 2 nombre + calcul
     H*
     FTP3DSPF CF  E                    WORKSTN
     F*
     E                    ERR     1   1 50
     C                     SETON                         LR
     C           *IN03     DOWEQ'0'
     C                     Z-ADD0         FLD001
     C                     Z-ADD0         FLD002
     C                     MOVE *BLANKS   FLD003
     C                     EXFMTFMT1
     C                     MOVE *BLANKS   MSG
     C                     SETON                         30
     C           FLD003    IFEQ *BLANKS
     C                     SETOF                         30
     C                     MOVELERR,1     MSG
     C                     ITER
     C                     ENDIF
     C                     Z-ADD0         FLD004
     C                     SELEC
     C           FLD003    WHEQ '*'
     C           FLD001    MULT FLD002    FLD004
     C           FLD003    WHEQ '/'
     C           FLD001    DIV  FLD002    FLD004
     C           FLD003    WHEQ '+'
     C                     ADD  FLD001    FLD004
     C                     ADD  FLD002    FLD004
     C           FLD003    WHEQ '-'
     C                     ADD  FLD001    FLD004
     C                     SUB  FLD002    FLD004
     C                     ENDSL
     C                     EXFMTFMT2
     C                     ENDDO
**
Veuillez rentrer une opération
```
