---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: RPGDTAARA2
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 11
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/RPGDTAARA2

```text
     dDATAAREA         DS           100    DTAARA(DT100)
     dARRAY                          10    DIM(10)
     dTEXT             S             10
     dboucle           S              1  0 INZ(1)
     c                   DOW       %trim(ARRAY(boucle)) <> 'FIN'
     C                   EVAL      Boucle += 1
     c                   EVAL      TEXT = %TRIM(ARRAY(boucle))
     C     *LOCK         IN        *DTAARA
     c     TEXT          dsply
     c                   enddo
     c                   EVAL      *INLR = *ON
```
