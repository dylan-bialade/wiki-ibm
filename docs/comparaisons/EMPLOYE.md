# EMPLOYE : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QSQLSRC | SQL | 8 | 0 % | CREATE TABLE/VIEW | [EMPLOYE.md](../../sources/SQL/BIB02/EMPLOYE.md) |
| BIB20 | QDDSSRC | DDS | 3 | 100 % |  | [EMPLOYE.md](../../sources/DDS/BIB20/EMPLOYE.md) |

## Differences

- **BIB02** en propre : CREATE TABLE/VIEW
- Langages / types differents : DDS, SQL

## Codes

### BIB02 (SQL, 8 lignes)

```text
CREATE TABLE BIBO.EMPLOYE1 (
    ID NUMERIC(5, 0) GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1)
    PRIMARY KEY NOT NULL,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Age NUMERIC(3, 0),
    Poste VARCHAR(50)
);
```

### BIB20 (DDS, 3 lignes)

```text
                R EMPLOYE
                  NOMEMP       100A
                  AGEEMP         3P 0
```
