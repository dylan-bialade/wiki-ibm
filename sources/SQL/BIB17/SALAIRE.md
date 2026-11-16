---
bibliotheque: BIB17
fichier_source: QSQLSRC
membre: SALAIRE
type: SQL
longueur_enregistrement: 100
lignes: 83
modifie: 2026-11-16
---

# BIB17/QSQLSRC/SALAIRE

```sql
DROP TABLE BIB17.SALAIRES;
DROP TABLE BIB17.SALAIRES_HAUT;
DROP TABLE BIB17.Moyennes_Salaires_haut;


CREATE TABLE BIB17.SALAIRES (
    ID_EMPLOYE INTEGER GENERATED ALWAYS AS IDENTITY,
    NOM_EMPLOYE VARCHAR(50),
    SALAIRE_EMPLOYE DECIMAL(10, 2)
);

CREATE TABLE BIB17.SALAIRES_HAUT (
    ID_EMPLOYE INTEGER,
    NOM_EMPLOYE VARCHAR(50),
    SALAIRE_EMPLOYE DECIMAL(10, 2),
    DATEENREGISTREMENT TIMESTAMP
);

CREATE TABLE BIB17.Moyennes_Salaires_haut (
    MOYENNESALAIRES DECIMAL(10, 2),
    SEUIL DECIMAL(10, 2),
    DATEENREGISTREMENT TIMESTAMP
);


CREATE OR REPLACE TRIGGER BIB17.trg_salaire_haut
        AFTER INSERT ON BIB17.salaires
        REFERENCING NEW ROW AS NROW FOR EACH ROW MODE DB2SQL
    BEGIN
        IF NROW.SALAIRE_EMPLOYE > 50000 THEN
            INSERT INTO BIB17.SALAIRES_HAUT (
                        ID_EMPLOYE,
                        NOM_EMPLOYE,
                        SALAIRE_EMPLOYE,
                        DATEENREGISTREMENT
                    )
                VALUES
                    (
                        NROW.ID_EMPLOYE,
                        NROW.NOM_EMPLOYE,
                        NROW.SALAIRE_EMPLOYE,
                        NOW()
                    );
        END IF;
    END;


SELECT * FROM BIB17.SALAIRES;
SELECT * FROM BIB17.SALAIRES_HAUT;
SELECT * FROM BIB17.Moyennes_Salaires_haut;

INSERT INTO BIB17.SALAIRES (
            NOM_EMPLOYE,
            SALAIRE_EMPLOYE
        )
    VALUES
        (
            'remy',
            70000.00
        );

CREATE OR REPLACE TRIGGER BIB17.update_moy_sal
        AFTER INSERT ON BIB17.salaires
        REFERENCING NEW ROW AS NROW FOR EACH ROW MODE DB2SQL
    BEGIN
        DECLARE v_moyenne DECIMAL(10, 2);
        SELECT AVG(SALAIRE_EMPLOYE)
            INTO v_moyenne
            FROM BIB17.SALAIRES;
        IF v_moyenne > 50000 THEN
            INSERT INTO BIB17.Moyennes_Salaires_haut (
                        MOYENNESALAIRES,
                        SEUIL,
                        DATEENREGISTREMENT
                    )
                VALUES
                    (
                        v_moyenne,
                        50000,
                        NOW()
                    );
        END IF;
    END;
```
