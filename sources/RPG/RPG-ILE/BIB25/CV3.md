---
bibliotheque: BIB25
fichier_source: QFALTER
membre: CV3
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 19
modifie: 2026-11-25
---

# BIB25/QFALTER/CV3

```rpg
**free

ctl-opt dftactgrp(*no) actgrp(*new);


// Niveau d'isolement UR
// Voir les modifications non validées par d'autre processus : oui
// Mettre à jour des modifications non validées : non
//exec sql
  //SET TRANSACTION ISOLATION LEVEL RR;

exec sql
  update cvschema.products set price = 400
  where product_id = 1;

exec sql
  commit;

*inlr = *on;
```
