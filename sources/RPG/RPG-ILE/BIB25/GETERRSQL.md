---
bibliotheque: BIB25
fichier_source: QRPGLESRC
membre: GETERRSQL
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 40
modifie: 2026-11-25
---

# BIB25/QRPGLESRC/GETERRSQL

```rpg
**free

// Paramètre globaux du programme
ctl-opt dftactgrp(*no) actgrp(*caller);

// doc utilisée
// https://www.ibm.com/docs/en/i/7.5.0?topic=statements-get-diagnostics

// Déclarations de variables
dcl-s Wprix packed(11:2);
dcl-s Wqte packed(9:0);
// Option de format de date et de gestion de transaction SQL
exec sql
set option commit = *none , datfmt = *iso;

// Procédure Principale
// selection du prix et de la quantitée d'un article
// On simule une erreur
exec sql
select art_code , art_qte // char dans numérique
into :Wprix , :Wqte
from article
where art_CODE = 'VIS00001';

IF SQLCODE < 0; //Erreur SQL
    getErrSql();
ENDIF;

// Sortie du programme
*inlr = *on;

// Procédure Gestion d'érreur sql
dcl-proc getErrSql;
  dcl-s DB2_MESSAGE_TEXT varchar(32740);
  dcl-s DB2_ROW_NUMBER int(10);
  dcl-s DB2_SQLSTATE char(5);
  exec sql
  GET DIAGNOSTICS CONDITION 1
  :DB2_MESSAGE_TEXT = MESSAGE_TEXT;
end-proc;
```
