---
bibliotheque: BIB17
fichier_source: QSQLSRC
membre: JOURNAL
type: SQL
longueur_enregistrement: 100
lignes: 36
modifie: 2026-11-16
---

# BIB17/QSQLSRC/JOURNAL

```sql
SELECT CURDATE() AS dat,
       CHAR(CURDATE(), EUR),
       WEEK(CURDATE()),
       YEAR(CURDATE()),
       YEAR(CURDATE() - '28.09.1991') AS age
    FROM sysibm.sysdummy1;

CREATE TABLE BIB17.test_jrn (
            ID INTEGER GENERATED ALWAYS AS IDENTITY,
            QUANTITE INTEGER NOT NULL,
            NOM CHAR(30),
            DATE TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP
        );

INSERT INTO BIB17.test_jrn (
            quantite,
            nom
        )
    VALUES
        (
            15,
            'test1'
        ),
        (
            12,
            'test2'
        ),
        (
            56,
            'test3'
        );

SELECT *
    FROM BIB17.test_jrn;

DELETE FROM BIB17.test_jrn WHERE id IN (4, 5, 6);
```
