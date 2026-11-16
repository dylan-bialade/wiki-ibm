---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: C1_RPG_R
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 9
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/C1_RPG_R

```text
     H OPTION(*NODEBUGIO:*SRCSTMT) DFTACTGRP(*NO) ACTGRP(*CALLER)
     FPRODUIT   IF   E           K DISK
     C     *LOVAL        SETLL     PRODUIT
     C                   READ      PRODUIT
     C                   DOW       NOT %EOF()
     C     NOMPRO        DSPLY
     C                   READ      PRODUIT
     C                   ENDDO
     C                   EVAL      *INLR = *ON
```
