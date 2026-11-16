---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: TESTALTER2
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 10
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/TESTALTER2

```text
     FINDEXCLI  IF   E           K DISK
     DTEXT             S             50
     C                   READ      INDEXCLI
     C                   DOW       NOT %EOF
     C                   EVAL      text = 'Le nom est : ' + NOM
     C     TEXT          dsply
     C                   READ      INDEXCLI
     C                   enddo
     C
     C                   eval      *inlr = *on
```
