---
bibliotheque: BIB25
fichier_source: QSQLSRC
membre: LOGPRD
type: SQL
longueur_enregistrement: 80
lignes: 7
modifie: 2026-11-25
---

# BIB25/QSQLSRC/LOGPRD

```sql
CREATE TABLE logprd (
    idProduit NUMERIC(6, 0),
    nomProduit VARCHAR(10),
    description VARCHAR(255),
    prix DECIMAL(10, 2),
    stock NUMERIC(6, 0)
);
```
