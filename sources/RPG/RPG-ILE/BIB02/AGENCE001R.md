---
bibliotheque: BIB02
fichier_source: QTMABUG
membre: AGENCE001R
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 78
modifie: 2026-11-16
---

# BIB02/QTMABUG/AGENCE001R

```text
     F************************************************************
     F* SAISIE DES AGENCES
     F************************************************************
     FAGENCEL01 IF   E           K DISK    PREFIX(AG_)
     FAGENCETMA IF A E           K DISK    RENAME(AGENCEF : AF)
     FAGENCE001DCF   E             WORKSTN
     C*---Constitution de la clef
     C     CLEAGN        KLIST
     C                   KFLD                    AG_CODCLI
     C                   KFLD                    AG_CODAGN
      ************************************************************
      *                  DEBUT PROG
      ************************************************************
     C                   SETON                                            LR
     C                   DOW       NOT *IN03
     C                   EXFMT     FMT1
     C                   SELECT
     C                   WHEN      *IN03
     C                   LEAVE
     C                   WHEN      *IN06
     C                   EXSR      TRT_FMT6
     C                   OTHER
     C                   EXSR      TRT_FMT5
     C                   ENDSL
     C                   ENDDO
      ************************************************************
      *  Routine de traitement du format 6 -> Création
      ************************************************************
     C     TRT_FMT6      BEGSR
     C                   DOW       NOT *IN03 OR NOT *IN12
     C                   EXFMT     FMT6
     C                   SELECT
     C                   WHEN      *IN03
     C                   LEAVE
     C                   WHEN      *IN12
     C                   LEAVE
     c                   other
     C                   MOVE      E6CODCLI      codcli
     C                   MOVE      E6CODAGN      codagn
     c                   MOVE      E6TNOM        nom
     c                   MOVE      E6RUE         rue
     c                   MOVE      E6CP          cp
     c                   MOVE      E6VILLE       ville
     c                   MOVE      E6REGION      region
     C                   WRITE     AF
     C                   ENDSL
     C                   ENDDO
     C                   ENDSR
     C
      ************************************************************
      *  Routine de traitement du format 5 -> Affichage données
      ************************************************************
     C     TRT_FMT5      BEGSR
     C                   EVAL      AG_CODCLI = E1CODCLI
     C                   EVAL      AG_CODAGN = E1CODAGN
     C     CLEAGN        CHAIN     AGENCEL01
     C                   IF        %FOUND
     C                   MOVE      AG_CODCLI     E5CODCLI
     C                   MOVE      AG_CODAGN     E5CODAGN
     c                   MOVE      AG_NOM        E5TNOM
     c                   MOVE      AG_RUE        E5RUE
     c                   MOVE      AG_CP         E5CP
     c                   MOVE      AG_VILLE      E5VILLE
     c                   MOVE      AG_REGION     E5REGION
     C                   ELSE
     C                   SETON                                            03
     C                   ENDIF
     C                   DOW       NOT *IN03 OR NOT *IN12
     C                   EXFMT     FMT5
     C                   SELECT
     C                   WHEN      *IN03
     C                   LEAVE
     C                   WHEN      *IN12
     C                   LEAVE
     C                   ENDSL
     C                   ENDDO
     C                   ENDSR
      ************************************************************
```
