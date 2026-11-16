---
bibliotheque: BIB17
fichier_source: QSQLSRC
membre: TP_QUINCA
type: SQL
longueur_enregistrement: 100
lignes: 395
modifie: 2026-11-16
---

# BIB17/QSQLSRC/TP_QUINCA

```sql
-- ======================================================
-- TP2 : Procédures stockées SQL sur IBM i (DB2)
-- Script d'initialisation : création des tables et des données
-- ======================================================
-- Thème : gestion de stock d'une quincaillerie.
--
-- À lancer AVANT le TP, et à relancer pour remettre les données
-- dans leur état de départ.
--
-- Remplacez POEIP7 par votre schéma (une seule ligne à modifier :
-- toutes les tables sont créées dans le schéma courant).
--
-- Au premier lancement, les DROP TABLE renvoient l'erreur SQL0204
-- (table inexistante) : c'est normal, continuez l'exécution.
CREATE SCHEMA TPQUINCA;
SET SCHEMA TPQUINCA;
-- =========================
-- Suppression (ordre inverse des dépendances)
-- =========================
DROP TABLE ALERTES;
DROP TABLE MOUVEMENTS;
DROP TABLE ARTICLES;

-- =========================
-- Table ARTICLES
-- =========================
CREATE TABLE ARTICLES (
            ID_ARTICLE INTEGER NOT NULL,
            LIBELLE VARCHAR(50) NOT NULL,
            PRIX DECIMAL(9, 2) NOT NULL,
            STOCK INTEGER NOT NULL DEFAULT 0,
            STOCK_MINI INTEGER NOT NULL DEFAULT 0,
            CONSTRAINT PK_ARTICLES PRIMARY KEY (ID_ARTICLE),
            CONSTRAINT CK_ARTICLES_STOCK CHECK (STOCK >= 0)
        );

LABEL ON TABLE ARTICLES IS 'Articles en stock';

-- =========================
-- Table MOUVEMENTS (entrées / sorties de stock)
-- =========================
CREATE TABLE MOUVEMENTS (
            ID_MVT INTEGER GENERATED ALWAYS AS IDENTITY,
            ID_ARTICLE INTEGER NOT NULL,
            TYPE_MVT CHAR(1) NOT NULL, -- 'E' = entrée, 'S' = sortie
            QUANTITE INTEGER NOT NULL,
            DATE_MVT TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP,
            CONSTRAINT PK_MOUVEMENTS PRIMARY KEY (ID_MVT),
            CONSTRAINT FK_MVT_ARTICLE FOREIGN KEY (ID_ARTICLE) REFERENCES ARTICLES (ID_ARTICLE),
            CONSTRAINT CK_MVT_TYPE CHECK (TYPE_MVT IN ('E', 'S')),
            CONSTRAINT CK_MVT_QTE CHECK (QUANTITE > 0)
        );

LABEL ON TABLE MOUVEMENTS IS 'Mouvements de stock';

-- =========================
-- Table ALERTES (articles sous le stock minimum)
-- =========================
CREATE TABLE ALERTES (
            ID_ALERTE INTEGER GENERATED ALWAYS AS IDENTITY,
            ID_ARTICLE INTEGER NOT NULL,
            MANQUANT INTEGER NOT NULL, -- STOCK_MINI - STOCK
            DATE_ALERTE TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP,
            CONSTRAINT PK_ALERTES PRIMARY KEY (ID_ALERTE),
            CONSTRAINT FK_ALERTE_ARTICLE FOREIGN KEY (ID_ARTICLE) REFERENCES ARTICLES (ID_ARTICLE)
        );

LABEL ON TABLE ALERTES IS 'Alertes de stock';

-- =========================
-- Données : ARTICLES
-- =========================
-- Le STOCK de chaque article est cohérent avec ses MOUVEMENTS
-- (somme des entrées - somme des sorties).
INSERT INTO ARTICLES (
            ID_ARTICLE,
            LIBELLE,
            PRIX,
            STOCK,
            STOCK_MINI
        )
    VALUES
        (
            1,
            'Vis inox M6 (boîte de 100)',
            12.50,
            25,
            20
        ),
        (
            2,
            'Écrou M6 (boîte de 100)',
            6.90,
            15,
            20
        ),
        (
            3,
            'Rondelle plate M6 (boîte de 200)',
            4.20,
            25,
            15
        ),
        (
            4,
            'Perceuse visseuse 18V',
            189.00,
            2,
            3
        ),
        (
            5,
            'Foret béton 8 mm',
            5.40,
            8,
            10
        ),
        (
            6,
            'Cheville nylon 8 mm (boîte de 50)',
            7.80,
            16,
            10
        ),
        (
            7,
            'Gants de protection (paire)',
            3.95,
            10,
            25
        ),
        (
            8,
            'Mètre ruban 5 m',
            9.90,
            10,
            5
        );

-- =========================
-- Données : MOUVEMENTS
-- =========================
INSERT INTO MOUVEMENTS (
            ID_ARTICLE,
            TYPE_MVT,
            QUANTITE,
            DATE_MVT
        )
    VALUES
        (
            1,
            'E',
            50,
            '2026-09-01-08.00.00'
        ),
        (
            2,
            'E',
            40,
            '2026-09-01-08.10.00'
        ),
        (
            7,
            'E',
            100,
            '2026-09-01-08.20.00'
        ),
        (
            3,
            'E',
            30,
            '2026-09-02-09.00.00'
        ),
        (
            4,
            'E',
            5,
            '2026-09-02-09.15.00'
        ),
        (
            5,
            'E',
            30,
            '2026-09-03-10.00.00'
        ),
        (
            6,
            'E',
            20,
            '2026-09-03-10.30.00'
        ),
        (
            8,
            'E',
            10,
            '2026-09-04-11.00.00'
        ),
        (
            1,
            'S',
            15,
            '2026-09-05-14.00.00'
        ),
        (
            2,
            'S',
            25,
            '2026-09-08-15.00.00'
        ),
        (
            7,
            'S',
            40,
            '2026-09-09-09.30.00'
        ),
        (
            3,
            'S',
            5,
            '2026-09-10-16.00.00'
        ),
        (
            5,
            'S',
            12,
            '2026-09-11-10.45.00'
        ),
        (
            1,
            'S',
            10,
            '2026-09-12-11.20.00'
        ),
        (
            4,
            'S',
            2,
            '2026-09-15-14.10.00'
        ),
        (
            6,
            'S',
            4,
            '2026-09-16-08.40.00'
        ),
        (
            5,
            'S',
            10,
            '2026-09-18-17.00.00'
        ),
        (
            4,
            'S',
            1,
            '2026-09-20-09.05.00'
        ),
        (
            7,
            'S',
            30,
            '2026-09-22-13.30.00'
        ),
        (
            7,
            'S',
            20,
            '2026-09-25-15.50.00'
        );

-- =========================
-- Vérifications
-- =========================
SELECT *
    FROM ARTICLES
    ORDER BY ID_ARTICLE;
SELECT *
    FROM MOUVEMENTS
    ORDER BY DATE_MVT;

-- Contrôle de cohérence : aucune ligne attendue
SELECT A.ID_ARTICLE,
       A.STOCK,
       SUM(
           CASE
               WHEN M.TYPE_MVT = 'E' THEN M.QUANTITE
               ELSE -M.QUANTITE
           END) AS STOCK_CALCULE
    FROM ARTICLES A
         JOIN MOUVEMENTS M
             ON M.ID_ARTICLE = A.ID_ARTICLE
    GROUP BY A.ID_ARTICLE,
             A.STOCK
    HAVING A.STOCK <> SUM(
            CASE
                WHEN M.TYPE_MVT = 'E' THEN M.QUANTITE
                ELSE -M.QUANTITE
            END);

select * from BIB17.articles where id_article =1;

select * from BIB17.mouvements;
--============================================================================
--=============================================================================
CREATE OR REPLACE PROCEDURE BIB17.SORTIE_STOCK (
                IN p_article INTEGER,
                IN p_quantite INTEGER,
                OUT p_nouveau_stock INTEGER
            )
        LANGUAGE sql
        SET OPTION COMMIT = *NONE
BEGIN
    DECLARE v_stock_actuel INTEGER;
    IF p_quantite <= 0 THEN
        SIGNAL SQLSTATE '75001'
            SET MESSAGE_TEXT = 'La quantité doit être positive';
    END IF;
    SELECT stock
        INTO v_stock_actuel
        FROM TPQUINCA.articles
        WHERE id_article = p_article;
    IF v_stock_actuel IS null THEN
        SIGNAL SQLSTATE '75002'
            SET MESSAGE_TEXT = 'Article inconnu';
    END IF;
    IF v_stock_actuel < p_quantite THEN
        SIGNAL SQLSTATE '75003'
            SET MESSAGE_TEXT = 'Stock insuffisant';
    END IF;
    INSERT INTO TPQUINCA.mouvements (
                id_article,
                type_mvt,
                quantite
            )
        VALUES
            (
                p_article,
                'S',
                p_quantite
            );
    UPDATE TPQUINCA.articles
        SET stock = v_stock_actuel - p_quantite
        WHERE id_article = p_article;
    SET p_nouveau_stock = v_stock_actuel - p_quantite;
END;

CALL BIB17.SORTIE_STOCK(1, 5, ?);

CALL BIB17.SORTIE_STOCK(1, 50, ?);


/*========================== EXO 2 =======================================
 ========================================================================== */
CREATE OR REPLACE PROCEDURE TPQUINCA.CONTROLE_STOCK (
                OUT p_nb_alertes INTEGER
            )
        LANGUAGE sql
BEGIN
    DECLARE v_fin INTEGER DEFAULT 0;
    DECLARE v_id_article INTEGER;
    DECLARE v_manquant INTEGER;
    DECLARE c CURSOR FOR
        SELECT id_article,
               (stock_mini - stock)
            FROM TPQUINCA.articles
            WHERE STOCK < STOCK_MINI;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = 1;
    DELETE FROM TPQUINCA.alertes;
    SET v_fin = 0;
    SET p_nb_alertes = 0;
    OPEN c;
    FETCH c
        INTO v_id_article,
             v_manquant;
    WHILE v_fin = 0 DO
        INSERT INTO TPQUINCA.alertes (
                    ID_ARTICLE,
                    MANQUANT
                )
            VALUES
                (
                    v_id_article,
                    v_manquant
                );
        SET p_nb_alertes = p_nb_alertes + 1;
        FETCH c
            INTO v_id_article,
                 v_manquant;
    END WHILE;
    CLOSE c;
END;

CALL TPQUINCA.CONTROLE_STOCK(?);

select * from rouchon.ARTICLES;
```
