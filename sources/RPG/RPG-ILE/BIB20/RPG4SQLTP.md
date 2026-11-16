---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: RPG4SQLTP
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 25
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/RPG4SQLTP

```text
F    FECRPROD   CF   E             WORKSTN
     DINDQTESTK        S              5i 0
     DTABLO            S              5  0 DIM(10)
    *** CODE **
     C                   DOW       NOT *IN03
     C                   EXFMT     FMT1
     C                   EVAL      *IN50 = *OFF
     C                   EVAL      *IN12 = *OFF
     C/EXEC SQL
     c+ SELECT PRODTYPE, PRODCAT, PRODNAME, MODEL, QTY_IN_STK
     c+  into :PRODTYPE, :PRODCAT, :PRODNAME, :MODEL, :QTY_IN_STK :INDQTESTK
     c+ FROM TPSQL.produits
     c+  WHERE productnumber = :productnum
     c/end-exec
     c
     c                   IF        SQLCODE = 0
     c                   DOW       NOT *IN03 and NOT *IN12
     c                   EXFMT     FMT2
     c                   ENDDO
     c                   ELSE
     c                   EVAL      MSGERR = 'Le numéro n''existe pas.'
     c                   EVAL      *IN50 = *ON
     c                   ENDIF
     c                   ENDDO
     c                   EVAL      *INLR = *ON
```
