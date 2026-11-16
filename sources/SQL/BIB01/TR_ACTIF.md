---
bibliotheque: BIB01
fichier_source: QSQLSRC
membre: TR_ACTIF
type: SQL
longueur_enregistrement: 100
lignes: 76
modifie: 2026-11-16
---

# BIB01/QSQLSRC/TR_ACTIF

```sql
/******************************************************************************/




-- Table       : TRIGGERACTIF




-- Libellé     :




--------------------------------------------------------------------------------




--




--  Projet     :




--  Auteur     : NBO




--  Date       : 10/04/2024




--------------------------------------------------------------------------------




CREATE TABLE MAX.TRIGGERACTIF FOR SYSTEM NAME TR_ACTIF (




 NOM_TRIGGER  FOR COLUMN  NOMTRIGGER VARCHAR(50) primary key,




 TRIGGER_ACTIF FOR COLUMN TR_ACTIF   CHAR(1) DEFAULT '0',




 BIB_DTAQ    CHAR(10),




 NOM_DTAQ    CHAR(10)




	)




RCDFMT TR_ACTIF;
```
