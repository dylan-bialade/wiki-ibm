---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: TP5INV
type: DDS
longueur_enregistrement: 100
lignes: 25
modifie: 2026-11-16
---

# BIB02/QDDSRC/TP5INV

```text
     F************************************************************
     F************************************************************
     FENTREPOT  UF A E           K DISK    PREFIX(ENT_)
     FINVENLF   IF   E           K DISK    PREFIX(INV_)
     DQT_CALC          S              4  0
      ************************************************************
      *                  DEBUT PROG
      ************************************************************
     C                   SETON                                            LR
     C                   READ      ENTREPOT
     C                   DOW       NOT %EOF(ENTREPOT)
     C     ENT_CODPRO    SETLL     INVENLF
     C     ENT_CODPRO    READE     INVENLF
     C                   DOW       NOT %EOF(INVENLF)
     C                   EVAL      QT_CALC = QT_CALC + INV_QTINV
     C     ENT_CODPRO    READE     INVENLF
     C                   ENDDO
     C                   IF        QT_CALC <> 0
     C                   EVAL      ENT_QTPRO = ENT_QTPRO + QT_CALC
     C                   MOVE      *DATE         ENT_DTDINV
     C                   UPDATE    ENTREPOTF
     C                   ENDIF
     C                   READ      ENTREPOT
     C                   Z-ADD     0             QT_CALC
     C                   ENDDO
```
