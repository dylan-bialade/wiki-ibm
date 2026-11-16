---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: TESTALTER
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 10
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/TESTALTER

```text
     FLFBONBON  IF   E           K DISK
     DTEXT             S             50
     C                   READ      LFBONBON
     C                   DOW       NOT %EOF
     C                   EVAL      text = 'Le numéro est : ' + %char(NUMBB)
     C     TEXT          dsply
     C                   READ      LFBONBON
     C                   enddo
     C
     C                   eval      *inlr = *on
```
