---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: OUTILS
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 15
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/OUTILS

```rpg
**free
ctl-opt nomain;

// Active l'indicateur Rouge si la quantité est inférieur à 20
dcl-proc red_alert export;
  dcl-pi *n ind;
    number_quantity packed(3:0);
  end-pi;

  if number_quantity < 20;
    return *on;
  else;
    return *off;
  endif;
end-proc;
```
