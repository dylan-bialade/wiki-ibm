---
bibliotheque: BIB25
fichier_source: QFALTER
membre: CVTP1_1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 26
modifie: 2026-11-25
---

# BIB25/QFALTER/CVTP1_1

```rpg
**free
//-------------------------------------------//
//TP 1 Contrôle de validation                //
//Programme: CV2 / BIB25                  //
//Contrôle de validation : SQLRPGLE          //
//10/12/2024                                 //
//-------------------------------------------//
ctl-opt dftactgrp(*no) actgrp(*new);

// Définition du niveau d'isolement à UR puis RR
exec sql
  SET TRANSACTION ISOLATION LEVEL RR;

// Mise à jour d'un enregistrement de notre fichier
// Passage du nombre de titres à 8
exec sql
  UPDATE CVSCHEMA.NBA SET NB_TITLE = 8 WHERE ID = 1;

dsply 'En attente de validation';

// Validation
exec sql
  COMMIT;

// Arret du programme
*INLR = *ON;
```
