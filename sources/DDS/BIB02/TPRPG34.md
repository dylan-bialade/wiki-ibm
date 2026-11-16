---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: TPRPG34
type: DDS
longueur_enregistrement: 100
lignes: 60
modifie: 2026-11-16
---

# BIB02/QDDSRC/TPRPG34

```text
     Fsaisagn   CF   E             workstn
     Fagencel1  UF A E           K disk
     C     kagence       klist
     C                   kfld                    CODCLI
     C                   kfld                    CODAGN
     C                   DOU       *IN03
     C                   EXFMT     fmt1
     C                   SELECT
     C                   WHEN      *IN03
     C                   ITER
     C                   WHEN      *IN06
     C                   EXSR      F6
     C                   ENDSL
     C                   EVAL      CODCLI = CODCLIS
     C                   EVAL      CODAGN = CODAGNS
     C     kagence       CHAIN     agencel1
     C                   IF        %Found
     c                   EVAL      codecli = codcli
     c                   EVAL      codeagn = codagn
     c                   EVAL      fmt2nom = nom
     c                   EVAL      fmt2rue = rue
     c                   EVAL      fmt2cp = cp
     c                   EVAL      fmt2ville = ville
     c                   EVAL      fmt2region = region
     C                   EXFMT     fmt2
     C                   If        *IN12
     C                   ITER
     C                   ENDIF
     C                   IF        *IN50
     c                   EVAL      codecli = codcli
     c                   EVAL      codeagn = codagn
     c                   EVAL      nom = fmt2nom
     c                   EVAL      rue = fmt2rue
     c                   EVAL      cp = fmt2cp
     c                   EVAL      ville = fmt2ville
     c                   EVAL      region = fmt2region
     C                   UPDATE    agencef
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C                   SETON                                            LR
     C     F6            BEGSR
     C                   EXFMT     fmt6
     C                   IF        *IN03
     C                   RETURN
     C                   ENDIF
     C     kagence       CHAIN     agencel1
     C                   IF        NOT %Found
     C                   IF        codcli <> 0
     c                   EVAL      codecli = codcli
     c                   EVAL      codeagn = codagn
     c                   EVAL      nom = fmt2nom
     c                   EVAL      rue = fmt2rue
     c                   EVAL      cp = fmt2cp
     c                   EVAL      ville = fmt2ville
     c                   EVAL      region = fmt2region
     C                   WRITE     agencef
     C                   ENDIF
     C                   ENDIF
     C                   ENDSR
```
