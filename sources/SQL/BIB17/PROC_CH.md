---
bibliotheque: BIB17
fichier_source: QSQLSRC
membre: PROC_CH
type: SQL
longueur_enregistrement: 100
lignes: 67
modifie: 2026-11-16
---

# BIB17/QSQLSRC/PROC_CH

```sql
SELECT *
    FROM BIB17.entete where client = 677;

/*
 -- =========================
-- 2. Syntaxe générale (non exécutable - modèle)
-- =========================
-- CREATE OR REPLACE PROCEDURE nom_schema.nom_procedure (
--     IN    param1 TYPE,
--     OUT   param2 TYPE,
--     INOUT param3 TYPE
-- )
-- LANGUAGE SQL
-- BEGIN
--     -- instructions SQL
-- END;
-- Types de paramètres :
-- IN     : entrée
-- OUT    : sortie
-- INOUT  : entrée / sortie
*/
CREATE OR REPLACE PROCEDURE BIB17.NB_COMMANDES_CLIENT (
                p_client INTEGER,
                OUT p_nb INTEGER
            )
        LANGUAGE sql
BEGIN
    SELECT COUNT(*)
        INTO p_nb
        FROM BIB17.ENTETE
        WHERE CLIENT = p_client;
END;

CALL BIB17.NB_COMMANDES_CLIENT(677, ?);

CREATE OR REPLACE PROCEDURE BIB17.CATEGORIE_CLIENT (
                IN p_client INTEGER,
                OUT p_total DECIMAL(12, 2),
                OUT p_categorie CHAR(20)
            )
        LANGUAGE sql
BEGIN
    DECLARE cmd_total DECIMAL(12, 2) DEFAULT 0;
    SELECT COALESCE(SUM(total), 0)
        INTO cmd_total
        FROM BIB17.ENTETE
        WHERE CLIENT = p_client;
    SET p_total = cmd_total;
    IF cmd_total = 0 THEN
        SET p_categorie = 'Aucune commande';
    ELSEIF cmd_total < 1000 THEN
        SET p_categorie = 'Petit client';
    ELSEIF cmd_total >= 1000
        AND cmd_total <= 10000 THEN
        SET p_categorie = 'Client moyen';
    ELSE
        SET p_categorie = 'Gros client';
    END IF;
END;

CALL BIB17.CATEGORIE_CLIENT(677, ?, ?);


SELECT *
    FROM QSYS2.SYSROUTINES
    WHERE ROUTINE_TYPE LIKE 'PROCEDURE'
          AND SPECIFIC_SCHEMA = 'BIB17'
```
