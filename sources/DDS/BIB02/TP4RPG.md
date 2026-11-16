---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: TP4RPG
type: DDS
longueur_enregistrement: 100
lignes: 54
modifie: 2026-11-16
---

# BIB02/QDDSRC/TP4RPG

```text
     Fsaisagn   CF   E             workstn
     Fagencel1  UF A E           K disk
     C     kagence       klist
     C                   kfld                    CODCLI
     C                   kfld                    CODAGN
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
     C                   move      CODCLIS       CODCLI
     C                   move      CODAGNS       CODAGN
     C     kagence       CHAIN     agencel1
     C                   IF        %Found
     c                   move      codcli        codecli
     c                   move      codagn        codeagn
     c                   move      nom           fmt2nom
     c                   move      rue           fmt2rue
     c                   move      cp            fmt2cp
     c                   move      ville         fmt2ville
     c                   move      region        fmt2region
     C                   EXFMT     fmt2
     C                   IF        *IN50
     c                   move      codcli        codecli
     c                   move      codagn        codeagn
     c                   move      fmt2nom       nom
     c                   move      fmt2rue       rue
     c                   move      fmt2cp        cp
     c                   move      fmt2ville     ville
     c                   move      fmt2region    region
     C                   UPDATE    agencef
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C                   SETON                                            LR
     C     F6            BEGSR
     C                   EXFMT     fmt6
     c                   move      codcli        codecli
     c                   move      codagn        codeagn
     c                   move      fmt2nom       nom
     c                   move      fmt2rue       rue
     c                   move      fmt2cp        cp
     c                   move      fmt2ville     ville
     c                   move      fmt2region    region
     C                   WRITE     agencef
     C                   ENDSR
```
