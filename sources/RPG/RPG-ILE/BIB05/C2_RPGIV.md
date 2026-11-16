---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: C2_RPGIV
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 9
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/C2_RPGIV

```text
     H DFTACTGRP(*NO) ACTGRP(*CALLER)
     FCLIENT    IF   E           K DISK
     DNMCLI            S              5S 0
     C                   EVAL      NMCLI = 2
     C     NMCLI         CHAIN     CLIENT
     C                   IF        %FOUND()
     C     PRECLI        DSPLY
     C                   ENDIF
     C                   EVAL      *INLR = *ON
```
