---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: MODINV
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 28
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/MODINV

```rpg
**free
ctl-opt nomain;

dcl-proc AjouterAuStock export;
    dcl-pi *n ZONED(5:0);
      stock zoned(5:0);
      qu_ajout zoned(5:0);
    END-PI;

    stock = stock + qu_ajout;
    return stock;

END-PROC;

dcl-proc RetirerDuiStock export;
    dcl-pi *n ZONED(5:0);
      stock zoned(5:0);
      qu_retire zoned(5:0);
    END-PI;

    stock = stock - qu_retire ;

    if stock <= 0;
      stock = 0;
    ENDIF;
    return stock;

END-PROC;
```
