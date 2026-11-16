---
bibliotheque: BIB02
fichier_source: QSQLSRC
membre: CREATBL
type: SQL
longueur_enregistrement: 100
lignes: 7
modifie: 2026-11-16
---

# BIB02/QSQLSRC/CREATBL

```sql
-- Création des tables Club
CREATE OR REPLACE TABLE BIB02.Club (
    Club_ID DECIMAL(5, 0) PRIMARY KEY,
    Nom CHAR(50),
    Ville CHAR(50),
    Annee_fondation DECIMAL(4, 0)
);
```
