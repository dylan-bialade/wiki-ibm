---
bibliotheque: BIB02
fichier_source: QSQLSRC
membre: EMPLOYE
type: SQL
longueur_enregistrement: 100
lignes: 8
modifie: 2026-11-16
---

# BIB02/QSQLSRC/EMPLOYE

```sql
CREATE TABLE BIBO.EMPLOYE1 (
    ID NUMERIC(5, 0) GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1)
    PRIMARY KEY NOT NULL,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Age NUMERIC(3, 0),
    Poste VARCHAR(50)
);
```
