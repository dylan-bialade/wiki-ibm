---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: BONBONDSPL
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 9
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/BONBONDSPL

```text
     FBONBON    IF   E           K DISK
     DTEXT             S             50
     C                   READ      BONBON
     C                   DOW       NOT %EOF
     C                   EVAL      text = 'Le numéro est : ' + %char(NUMBB)
     C     TEXT          dsply
     C                   READ      BONBON
     C                   enddo
     C                   eval      *inlr = *on
```
