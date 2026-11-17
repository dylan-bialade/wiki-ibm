# LIVRES : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB09 | QSOURCES | DDS | 5 | 0 % | DDS (R/K/PFILE) | [LIVRES.md](../../sources/DDS/BIB09/LIVRES.md) |
| BIB17 | QSQLSRC | SQL | 97 | 100 % | curseur SQL, boucle DOW/DOU/FOR | [LIVRES.md](../../sources/SQL/BIB17/LIVRES.md) |

## Differences

- **BIB09** en propre : DDS (R/K/PFILE)
- **BIB17** en propre : curseur SQL, boucle DOW/DOU/FOR
- Langages / types differents : SQL, DDS

## Codes

### BIB09 (DDS, 5 lignes)

```text
     A          R LIVRESF
     A            ISBN           5P 0       COLHDG('ISBN')
     A            TITRE         30A         COLHDG('TITRE')
     A            AUTEUR        30A         COLHDG('AUTEUR')
     A          K ISBN
```

### BIB17 (SQL, 97 lignes)

```text
SELECT DAYS(COALESCE(DT_RETOUR, CURRENT DATE)) retour,
       DAYS(DT_PREVUE) prevue,
       dt_retour,
       dt_prevue
    FROM TKT01BIB.prets;
SELECT *
    FROM TKT01BIB.prets;
SELECT *
    FROM TKT01BIB.livre;

SELECT *
    FROM TKT01BIB.statmois;
SELECT *
    FROM TKT01BIB.adhcpy;


CREATE OR REPLACE PROCEDURE PRC_CLOTURE ()
        LANGUAGE SQL
        MODIFIES SQL DATA
        SET OPTION COMMIT = *CHG
BEGIN
    DECLARE V_DEB DATE;
    DECLARE V_FIN DATE;
    -- Premier et dernier jour du mois précédent
    SET V_DEB = CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS - 1 MONTH;
    SET V_FIN = V_DEB + 1 MONTH - 1 DAY;
    DELETE FROM STATMOIS WHERE SMANNEE = YEAR(V_DEB)
    AND SMMOIS = MONTH(V_DEB);
    INSERT INTO STATMOIS (
                SMANNEE,
                SMMOIS,
                SMNBPRET,
                SMNBRETARD,
                SMPENAL,
                SMDTCALC
            )
        SELECT YEAR(V_DEB),
               MONTH(V_DEB),
               COUNT(*),
               SUM(
                   CASE
                       WHEN COALESCE(DT_RETOUR, CURRENT DATE) > DT_PREVUE THEN 1
                       ELSE 0
                   END),
               COALESCE(SUM(PENALITE), 0),
               CURRENT TIMESTAMP
            FROM PRETS
            WHERE DT_PRET BETWEEN V_DEB AND V_FIN;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PRC_PENALITES ()
        LANGUAGE SQL
        MODIFIES SQL DATA
        SET OPTION COMMIT = *NONE
BEGIN
    DECLARE V_ID INTEGER;
    DECLARE V_PREVUE DATE;
    DECLARE V_RETOUR DATE;
    DECLARE V_RETARD INTEGER;
    DECLARE V_FIN INTEGER DEFAULT 0;
    DECLARE C_PRETS CURSOR FOR
        SELECT PRET_ID,
               DT_PREVUE,
               COALESCE(DT_RETOUR, CURRENT DATE)
            FROM PRETS
            FOR UPDATE OF PENALITE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET V_FIN = 1;
    OPEN C_PRETS;
    FETCH C_PRETS
        INTO V_ID,
             V_PREVUE,
             V_RETOUR;
    WHILE V_FIN = 0 DO
        -- Nombre de jours de retard
        SET V_RETARD = DAYS(V_retour) - DAYS(V_prevue);
        IF V_RETARD > 0 THEN
            UPDATE PRETS
                SET PENALITE = V_RETARD * 0.50
                WHERE CURRENT OF C_PR;
        ELSE
            UPDATE PRETS
                SET PENALITE = 0
                WHERE CURRENT OF C_PRETS;
        END IF;
        FETCH C_PRETS
            INTO V_ID,
                 V_PREVUE,
                 V_RETOUR;
    END WHILE;
    CLOSE C_PRETS;
END;


SELECT *
    FROM BIB17.livres;
```
