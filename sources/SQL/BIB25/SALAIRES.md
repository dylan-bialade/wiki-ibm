---
bibliotheque: BIB25
fichier_source: QSQLSRC
membre: SALAIRES
type: SQL
longueur_enregistrement: 80
lignes: 5
modifie: 2026-11-25
---

# BIB25/QSQLSRC/SALAIRES

```sql
CREATE TABLE Salaires (
    ID_Employe INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCRE
    Nom_Employe VARCHAR(50) NOT NULL,
    Salaire_Employe DECIMAL(10, 2) NOT NULL
);
```
