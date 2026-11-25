---
bibliotheque: BIB25
fichier_source: QRPGLESRC
membre: CYCLERPG
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 34
modifie: 2026-11-25
---

# BIB25/QRPGLESRC/CYCLERPG

```text
     H*---------------------------------------------------------------------
     H* Test Cycle + Rupture RPG                                           |
     H*---------------------------------------------------------------------
     H*
     F* Déclaration de fichiers
     F*
     FCYCLELF   IP   E           K disk    Prefix(RD_)
     FCYCLEO    O    E             disk    Prefix(OUT_)
     F*
     D* Déclaration variable montant total
     DMTOTAL           S              9s 0 INZ(0)
     D*
     I* Détermination du fichier lu
     I*
     IFCYCLEPF
     I                                          RD_DATE       L1
     I*
     C*
     C* Logique du programme
     C*
     C*
     C                   IF        *INL1
     C                   EVAL      OUT_DATE = RD_DATE
     C                   EVAL      OUT_TOTAL = MTOTAL
     C                   EVAL      OUT_TOTAL = MTOTAL
     C                   WRITE     FCYCLEO
     C                   EVAL      MTOTAL = *ZERO
     C                   END
     C*
     C                   EVAL      CTL = 1
     C*
     C                   IF        RD_DATE <> *LOVAL
     C                   EVAL      MTOTAL = MTOTAL + RD_MONTANT
     C                   END
```
