---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: C1_SQLRPG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 33
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/C1_SQLRPG

```rpg
**free
CTL-OPT COPYRIGHT('(C) ORGFORM 2025.')
OPTION(*SRCSTMT) DFTACTGRP(*NO)
ACTGRP(*CALLER) DATFMT(*ISO);

//*****************************************************************
// Programme : C1_SQLRPG
// Formation SQL dans RPGLE
// Copyright - ORGFORM
//*****************************************************************

dcl-s nom char(20);
dcl-s prenom char(20);

//**********************************************************************//
// Traitement principal                                                 //
//**********************************************************************//
EXEC SQL
SET OPTION COMMIT = *NONE,DATFMT = *ISO ,alwcpydta = *optimize,
closqlcsr = *endmod;


EXEC SQL
  select  nomcli, precli
   into  :nom, :prenom
  from client
  where numcli = 2;

dsply nom;
dsply prenom;


*INLR = *ON;
```
