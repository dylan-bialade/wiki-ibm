---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: ENTRETP
type: DDS
longueur_enregistrement: 100
lignes: 43
modifie: 2026-11-16
---

# BIB02/QDDSRC/ENTRETP

```text
     Fentredsp  CF   E             workstn
     FentrepotlfUF A E           K disk
     C     kentrep       klist
     C                   kfld                    codpro
     C                   DOW       NOT *IN03
     C                   exfmt     fmt1
     C                   SELECT
     C                   WHEN      *IN03
     C                   EVAL      *inlr=*on
     C                   LEAVE
     C                   WHEN      *IN06
     C                   EVAL      *inlr=*on
     C                   EXSR      F6
     C                   WHEN      *IN12
     C                   EXFMT     fmt1
     C                   EVAL      *inlr=*on
     C                   ENDSL
     C                   move      CODPROS       CODPRO
     C     codpros       chain     entrepotlf
     C                   IF        %Found
     c                   move      codpro        FMT2CODP
     c                   move      nmpro         fmt2nom
     c                   move      qtpro         fmt2qtp
     c                   move      dtdinv        fmt2date
     C                   EXFMT     fmt2
     C                   IF        *IN50
     c                   move      FMT2CODP      codpro
     c                   move      fmt2nom       nmpro
     c                   move      fmt2qtp       qtpro
     c                   move      fmt2date      dtdinv
     C                   UPDATE    entrepotf
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C                   SETON                                            LR
     C     F6            BEGSR
     C                   EXFMT     fmt6
     c                   move      FMT6CODP      codpro
     c                   move      fmt6nom       nmpro
     c                   move      fmt6qtp       qtpro
     c                   move      fmt6date      dtdinv
     C                   WRITE     entrepotf
     C                   ENDSR
```
