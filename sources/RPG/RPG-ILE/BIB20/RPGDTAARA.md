---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: RPGDTAARA
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 8
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/RPGDTAARA

```text
     dDATAAREA         DS                  DTAARA(DTATPRPG)
     d IGNORE                        20
     d PRENDRE                       12
     C     *LOCK         IN        *DTAARA
     C                   EVAL      PRENDRE = 'toto'
     C     *LOCK         OUT       *DTAARA
     c     DATAAREA      DSPLY
     c                   EVAL      *INLR = *ON
```
