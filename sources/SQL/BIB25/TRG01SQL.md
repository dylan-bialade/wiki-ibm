---
bibliotheque: BIB25
fichier_source: QF_PFLF
membre: TRG01SQL
type: SQL
longueur_enregistrement: 80
lignes: 125
modifie: 2026-11-25
---

# BIB25/QF_PFLF/TRG01SQL

```sql
/******************************************************************************/
-- Triggers sur fichier CLIENTS1
-- Libellé    : Trigger pour table d'historisation
-------------------------------------------------------------------------------
--  Projet     : FORMATION
--  Auteur     : LEO BIB27
--  Date       : 28/10/2024
/******************************************************************************/
/*                                                                            */
/******************************************************************************/


CREATE OR REPLACE TRIGGER BIB25.TRG_CLI1
    AFTER INSERT OR UPDATE OR DELETE ON BIB25.CLIENTS1
    REFERENCING NEW AS NEW_N
                OLD AS OLD_O
    FOR EACH ROW
    BEGIN
        -- Déclaration de variables
        DECLARE username char(10);
        DECLARE currentdate DATE;
        -- Récupération de l'utilisateur
        SET username = SESSION_USER;
        -- Récupération de la date du jour
        SET currentdate = CURRENT DATE;
        -- Vérification du trigger en DEV
        IF (SELECT COUNT(*)
            FROM BIB25.TRIGGERACTIF
            WHERE nomtrigger = 'SpyClients'
                  AND devactif = '1') = 1 THEN -- Trigger actif
            -- Lors de l'insertion
            IF INSERTING THEN
                INSERT INTO BIB25.HS_CLIENTS1 (
                    id,
                    new_nom,
                    new_prenom,
                    new_codepostal,
                    new_date_a,
                    new_date_c,
                    new_pays,
                    operation,
                    date_o,
                    user
                )
                VALUES (
                    NEW_N.id,
                    NEW_N.nom,
                    NEW_N.prenom,
                    NEW_N.codepostal,
                    NEW_N.date_a,
                    NEW_N.date_c,
                    NEW_N.pays,
                    'I',
                    currentdate,
                    username
                );
            END IF;
            -- Lors d'une mise à jour
            IF UPDATING THEN
                INSERT INTO BIB25.HS_CLIENTS1 (
                    id,
                    new_nom,
                    new_prenom,
                    new_codepostal,
                    new_date_a,
                    new_date_c,
                    new_pays,
                    old_nom,
                    old_prenom,
                    old_codepostal,
                    old_date_a,
                    old_date_c,
                    old_pays,
                    operation,
                    date_o,
                    user
                )
                VALUES (
                    NEW_N.id,
                    NEW_N.nom,
                    NEW_N.prenom,
                    NEW_N.codepostal,
                    NEW_N.date_a,
                    NEW_N.date_c,
                    NEW_N.pays,
                    OLD_O.nom,
                    OLD_O.prenom,
                    OLD_O.codepostal,
                    OLD_O.date_a,
                    OLD_O.date_c,
                    OLD_O.pays,
                    'U',
                    currentdate,
                    username
                );
            END IF;
            -- Lors d'une suppression
            IF DELETING THEN
                INSERT INTO BIB25.HS_CLIENTS1 (
                    id,
                    old_nom,
                    old_prenom,
                    old_codepostal,
                    old_date_a,
                    old_date_c,
                    old_pays,
                    operation,
                    date_o,
                    user
                )
                VALUES (
                    OLD_O.id,
                    OLD_O.nom,
                    OLD_O.prenom,
                    OLD_O.codepostal,
                    OLD_O.date_a,
                    OLD_O.date_c,
                    OLD_O.pays,
                    'D',
                    currentdate,
                    username
                );
            END IF;
        END IF;
    END;
```
