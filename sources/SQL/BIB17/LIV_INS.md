---
bibliotheque: BIB17
fichier_source: QSQLSRC
membre: LIV_INS
type: SQL
longueur_enregistrement: 100
lignes: 17
modifie: 2026-11-16
---

# BIB17/QSQLSRC/LIV_INS

```sql
SELECT *
    FROM BIB17.livres;

INSERT INTO BIB17.livres (
            isbn,
            titre,
            auteur,
            dispo
        )
    VALUES
        (
            10014,
            'test titre',
            'test auteur',
            'O'
        )
;
```
