---
bibliotheque: BIB25
fichier_source: QFALTER
membre: CVTP1_2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 31
modifie: 2026-11-25
---

# BIB25/QFALTER/CVTP1_2

```rpg
**free
//-------------------------------------------//
//TP 1 Contrôle de validation                //
//Programme: CV2 / BIB25                  //
//Contrôle de validation : SQLRPGLE          //
//10/12/2024                                 //
//-------------------------------------------//
ctl-opt dftactgrp(*no) actgrp(*new);

dcl-s nbtitle int(10);


// Définition du niveau d'isolement à UR puis RR
exec sql
  SET TRANSACTION ISOLATION LEVEL RR;

// Récupération de la valeur du nombre de titre
// Aprés la modification en attente de validation depuis le premier prog
// NB_TITLE = 8 (modifcation effectué dans l'autre programme)
exec sql
  SELECT NB_TITLE INTO :nbtitle FROM CVSCHEMA.NBA WHERE ID = 1;

// Dans le fichier NBA le nombre de titre est de 6 avant la modification
dsply nbtitle;

// Validation
exec sql
  COMMIT;

// Arret du programme
*INLR = *ON;
```
