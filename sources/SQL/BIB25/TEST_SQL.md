---
bibliotheque: BIB25
fichier_source: QSQLSRC
membre: TEST_SQL
type: SQL
longueur_enregistrement: 80
lignes: 41
modifie: 2026-11-25
---

# BIB25/QSQLSRC/TEST_SQL

```sql
-- Catalogues dans QSYS --> les tables commençcant par QADB*
-- le système qui les maintient (non modifiable)
-- On peut intéroger directement en SQL
-- Quelques exemples
-- Zones d'un fichier
SELECT DBIFMT,
       DBIFLD,
       DBIILN,
       DBITYP,
       DBIREM
    FROM qadbifld
    WHERE DBILIB = 'BIB25'
          AND DBIFIL = 'USINES';

-- les contraintes sur un fichier base de donnée
SELECT *
    FROM QADBCCST
    WHERE dbccfn = 'EMPLOYEES'
          AND dbcckl = 'BIB25';

-- fichier logique dépendant dans des bibliothèque différentes
-- en ne prenant pas en compte les bibliothèque système
SELECT SUBSTR(DBFFIL, 1, 10) AS FICHIERL,
       DBFLIB,
       SUBSTR(DBFFDP, 1, 10) AS FICHIERP,
       DBFLDP
    FROM QSYS.QADBFDEP
    WHERE DBFLIB <> DBFLDP
          AND SUBSTR(DBFLIB, 1, 1) <> 'Q';

-- Information sur notre fichier base de donnée
SELECT *
    FROM qsys.QADBXREF
    WHERE dbxfil = 'USINES'
          AND dbxlib = 'BIB25';


-- clé primaire d'un fichier base de donnée
SELECT *
    FROM qsys.qadbkfld
    WHERE dbklib = 'BIB25';
```
