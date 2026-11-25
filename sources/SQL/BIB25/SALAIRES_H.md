---
bibliotheque: BIB25
fichier_source: QSQLSRC
membre: SALAIRES_H
type: SQL
longueur_enregistrement: 80
lignes: 6
modifie: 2026-11-25
---

# BIB25/QSQLSRC/SALAIRES_H

```sql
CREATE TABLE Salaires_haut (
    ID_Employe INT,
    Nom_Employe VARCHAR(50) NOT NULL,
    Salaire_Employe DECIMAL(10, 2) NOT NULL,
    DateEnregistrement TIMESTAMP
);
```
