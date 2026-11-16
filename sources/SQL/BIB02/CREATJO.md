---
bibliotheque: BIB02
fichier_source: QSQLSRC
membre: CREATJO
type: SQL
longueur_enregistrement: 100
lignes: 7
modifie: 2026-11-16
---

# BIB02/QSQLSRC/CREATJO

```sql
CREATE OR REPLACE TABLE BIB02.Joueurs (
    Joueur_ID DECIMAL(5, 0) PRIMARY KEY,
    Nom_joueur CHAR(50),
    Position CHAR(20),
    Numero DECIMAL(3, 0),
    Club_ID DECIMAL(5, 0)
);
```
