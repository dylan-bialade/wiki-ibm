---
bibliotheque: BIB01
fichier_source: QSQLSRC
membre: DTAQACTIF
type: SQL
longueur_enregistrement: 100
lignes: 81
modifie: 2026-11-16
---

# BIB01/QSQLSRC/DTAQACTIF

```sql
/******************************************************************************/




-- Table       : TRIGGERACTIF




-- Libellé     : Table Gestion DTAQ




--------------------------------------------------------------------------------




--  Projet     :




--  Auteur     : AQU




--  Date       : 10/04/2024




--------------------------------------------------------------------------------




CREATE TABLE MAX.DTAQACTIF (




            BIB_DTAQ CHAR(10),




            NOM_DTAQ CHAR(10),




            DTAQ_ACTIF CHAR(1) DEFAULT '0',




            URL_API VARCHAR(1024),




            PRIMARY KEY (




            BIB_DTAQ,




            NOM_DTAQ)




        );
```
