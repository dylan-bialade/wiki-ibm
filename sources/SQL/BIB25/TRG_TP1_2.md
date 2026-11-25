---
bibliotheque: BIB25
fichier_source: QF_PFLF
membre: TRG_TP1_2
type: SQL
longueur_enregistrement: 80
lignes: 23
modifie: 2026-11-25
---

# BIB25/QF_PFLF/TRG_TP1_2

```sql
-- Correction TP 1 - Exercice 2

CREATE TABLE BIB25.PROJECT_TRACKING (
            PROJECT_ID INT PRIMARY KEY,
            PROJECT_NAME CHAR(25),
            START_DATE DATE,
            END_DATE DATE,
            CURRENT_PROGRESS DECIMAL(3, 0), -- Zone numérique avec 2 chiffres et
            STATUS CHAR(20)
            CHECK (STATUS IN ('IN_PROGRESS', 'ON_HOLD', 'COMPLETED', 'LATE'))
        );

INSERT INTO BIB25.PROJECT_TRACKING
( PROJECT_ID , PROJECT_NAME , START_DATE , END_DATE , CURRENT_PROGRESS , STATUS)
 VALUES
( 1 , 'Projet A' , '2023-05-01' , '2023-12-01' , 100 , 'COMPLETED' ),
( 2 , 'Projet B' , '2024-11-01' , '2025-04-15' , 50 , 'IN_PROGRESS'),
( 3 , 'Projet C' , '2024-03-01' , '2024-12-31' , 75 , 'IN_PROGRESS'),
( 4 , 'Projet D' , '2024-04-01' , '2024-10-31' , 90 , 'LATE' ),
( 5 , 'Projet E' , '2024-02-01' , '2024-11-18' , 70 , 'IN_PROGRESS'),
( 6 , 'Projet F' , '2024-07-01' , '2024-11-20' , 55 , 'IN_PROGRESS'),
( 7 , 'Projet G' , '2024-06-15' , '2024-11-12' , 75 , 'IN_PROGRESS'),
( 8 , 'Projet H' , '2024-05-17' , '2024-11-12' , 87 , 'IN_PROGRESS');
```
