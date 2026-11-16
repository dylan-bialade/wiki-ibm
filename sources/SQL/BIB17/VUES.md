---
bibliotheque: BIB17
fichier_source: QSQLSRC
membre: VUES
type: SQL
longueur_enregistrement: 100
lignes: 34
modifie: 2026-11-16
---

# BIB17/QSQLSRC/VUES

```sql
CREATE TABLE BIB17.exo_table (
            age INT NOT NULL,
            dt_nai DATE NOT NULL,
            mat INT NOT NULL,
            is_red BOOLEAN DEFAULT FALSE
        )
;

INSERT INTO BIB17.exo_table
    VALUES
        (
            15,
            '2026-01-01',
            1,
            true
        )
;

ALTER TABLE BIB17.exo_table
    ADD COLUMN accepte CHAR(1);

SELECT *
    FROM BIB17.exo_table;

CREATE VIEW BIB17.exo_view AS
        SELECT DISTINCT r.*
            FROM qf_sql.realisateurs r
                 JOIN qf_sql.acteurs a
                     ON r.nom = a.nom
                         AND r.prenom = a.prenom
                         AND r.date_naissance = a.date_naissance;

SELECT *
    FROM BIB17.exo_view;
```
