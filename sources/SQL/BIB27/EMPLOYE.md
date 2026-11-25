---
bibliotheque: BIB27
fichier_source: QSQLSRC
membre: EMPLOYE
type: SQL
longueur_enregistrement: 80
lignes: 7
modifie: 2026-11-25
---

# BIB27/QSQLSRC/EMPLOYE

```sql
CREATE TABLE EMPLOYE (
    ID NUMERIC(5, 0) GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1)
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Age NUMERIC(3, 0),
    Poste VARCHAR(50)
);
```
