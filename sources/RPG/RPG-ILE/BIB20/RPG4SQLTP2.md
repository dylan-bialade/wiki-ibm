---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: RPG4SQLTP2
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 61
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/RPG4SQLTP2

```text
F    FECRPROD   CF   E             WORKSTN
     DINDQTESTK        S              5i 0
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
     c
     c
     c                   IF        *in05
     c
     c/exec sql
     c+ declare c1 cursor for
     c+   SELECT ORDER_NUM, ORDER_DATE, SHIP_DATE, LINEPRICE
     c+   FROM tpsql.commandes
     c+   WHERE PROD_NUM = :productnum
     c/end-exec
     c
     c/exec sql
     c+ open c1
     c/end-exec
     c                   DOW       SQLCODE = 0
     c
     c/exec sql
     c+ fetch c1
     c+ into :ORDER_NUM, :ORDER_DATE, :SHIP_DATE, :LINEPRICE
     c/end-exec
     c
     c                   EXFMT     FMT3
     c
     c                   IF        *in03 or *in12
     c                   leave
     c                   ENDIF
     c
     c                   ENDDO
     c
     c/exec sql
     c+ close c1
     c/end-exec
     c                   eval      *in12 = *off
     c                   eval      *in05 = *off
     c                   ENDIF
     c
     c
     c                   EXFMT     FMT2
     c                   ENDDO
     c                   ELSE
     c                   EVAL      MSGERR = 'Le numéro n''existe pas.'
     c                   EVAL      *IN50 = *ON
     c                   ENDIF
     c                   ENDDO
     c                   EVAL      *INLR = *ON
```
