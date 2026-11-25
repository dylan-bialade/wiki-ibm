---
bibliotheque: BIB25
fichier_source: QF_PFLF
membre: TRG_TP1_1
type: SQL
longueur_enregistrement: 80
lignes: 93
modifie: 2026-11-25
---

# BIB25/QF_PFLF/TRG_TP1_1

```sql
-- TP 1 - TRIGGER
-- Création d'un trigger de mise à jour de stock
-- On dispose d'une table PRODUCTS


-- Création de la table PRODUCTS
CREATE TABLE BIB25.PRODUCTS (
    PRODUCT_ID INT PRIMARY KEY,
    PRODUCT_NAME CHAR(20),
    QUANTITY INT,
    STOCK_STATUS CHAR(10)
);


-- Insertion de données dans la table PRODUCTS
INSERT INTO BIB25.PRODUCTS (
            PRODUCT_ID,
            PRODUCT_NAME,
            QUANTITY,
            STOCK_STATUS
        )
    VALUES
        (
            1,
            'Produit A',
            20,
            'IN_STOCK'
        ),
        (
            2,
            'Produit B',
            5,
            'LOW'
        ),
        (
            3,
            'Produit C',
            15,
            'IN_STOCK'
        ),
        (
            4,
            'Produit D',
            8,
            'LOW'
        ),
        (
            5,
            'Produit E',
            25,
            'IN_STOCK'
        );

-- L'objectif est de créer un trigger qui va mettre à jour automatiquement la
-- zone STOCK_STATUS lorsque la quantité modifié d'un produit est inférieur à 10

--Première solution
CREATE OR REPLACE TRIGGER BIB25.TRG_TP1_V1
        AFTER UPDATE OF QUANTITY ON BIB25.PRODUCTS
        REFERENCING NEW AS NEW_N FOR EACH ROW
    BEGIN
        IF NEW_N.QUANTITY < 10 THEN
            UPDATE BIB25.PRODUCTS SET STOCK_STATUS = 'LOW'
            WHERE PRODUCT_ID = NEW_N.PRODUCT_ID;
        ELSE
            UPDATE BIB25.PRODUCTS SET STOCK_STATUS = 'IN_STOCK'
            WHERE PRODUCT_ID = NEW_N.PRODUCT_ID;
        END IF;
    END;
-- Remarque : Ici on met à jour deux fois la table --> utilisation d'un trigger
-- cela empeche la surcharge de la base de donnée, il y a également un risque de
-- infinie (update sur update) --> ici on pointe sur la modification de la zone

--Deuxième solution
CREATE OR REPLACE TRIGGER BIB25.TRG_TP1_V2
        BEFORE UPDATE OF QUANTITY ON BIB25.PRODUCTS
        REFERENCING NEW AS NEW_N FOR EACH ROW
    BEGIN
        IF NEW_N.QUANTITY < 10 THEN
            SET NEW_N.STOCK_STATUS = 'LOW';
        ELSE
            SET NEW_N.STOCK_STATUS = 'IN_STOCK';
        END IF;
    END;
-- Remarque : TRIGGER plus simple à écrire + UPDATE effectué qu'une seule fois


-- Requêtes pour vérifier le bon fonctionnement du TRIGGER.
UPDATE BIB25.PRODUCTS
    SET QUANTITY = 9
    WHERE PRODUCT_NAME = 'Produit A';
-- Résultat attendu : Modification également de la zone STOCK_STATUS en 'LOW'
-- pour le produit A
```
