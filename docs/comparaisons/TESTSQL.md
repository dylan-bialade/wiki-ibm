# TESTSQL : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB17 | QRPGLESRC | RPG/RPG-ILE | 31 | 100 % | full free, SQL embarque, curseur SQL, boucle DOW/DOU/FOR | [TESTSQL.md](../../sources/RPG/RPG-ILE/BIB17/TESTSQL.md) |
| BIB02 | QSQLSRC | SQL | 8 | 0 % | CREATE TABLE/VIEW | [TESTSQL.md](../../sources/SQL/BIB02/TESTSQL.md) |

## Differences

- **BIB17** en propre : full free, SQL embarque, curseur SQL, boucle DOW/DOU/FOR
- **BIB02** en propre : CREATE TABLE/VIEW
- Langages / types differents : RPG/RPG-ILE, SQL

## Codes

### BIB17 (RPG/RPG-ILE, 31 lignes)

```text
**free

dcl-s name char(52) inz(*blanks);

//exercice 1 : selection d'une valeur dans une table
// exec sql
// select uniname into :name from anime.universv2 where univer = 197;

//exercice 2 : utilisation d'un curseur pour boucler sur bonbon
exec sql
    declare c1 cursor for
        select nom from BIB17.bonbon;

exec sql
    open c1;

dow sqlcode = 0;

    exec sql
    fetch c1 into :name;

    dsply name;

enddo;

exec sql
    close c1;


*inlr
 = *on;
```

### BIB02 (SQL, 8 lignes)

```text
CREATE OR REPLACE TABLE BIB02.ANIMAUX9 (
	NOM CHAR(20) CCSID 297 NOT NULL DEFAULT '' ,
	RACE CHAR(20) CCSID 297 NOT NULL DEFAULT '' ,
	ESPECE CHAR(20) CCSID 297 NOT NULL DEFAULT '' ,
	DATENAIS DATE NOT NULL DEFAULT CURRENT_DATE ,
	CODE CHAR(1) CCSID 297 NOT NULL DEFAULT '' ,
	SEXE CHAR(1) CCSID 297 NOT NULL DEFAULT '' ,
	COULEUR CHAR(20) CCSID 297 NOT NULL DEFAULT '' );
```
