---
bibliotheque: BIB13
fichier_source: QCPYSRC
membre: TP03MODP
type: RPG/Copy
longueur_enregistrement: 114
lignes: 53
modifie: 2026-11-16
---

# BIB13/QCPYSRC/TP03MODP

```rpg
**free



/if not defined(TP03MODP)

/define TP03MODP



dcl-pr nomClient varchar(30);

  num packed(5:0) const;

end-pr;

dcl-pr encoursClient packed(9:2);

  num packed(5:0) const;

end-pr;



dcl-pr creditDispo packed(9:2);

  num packed(5:0) const;

end-pr;



dcl-pr peutCommander ind;

  num packed(5:0)const;

  montant packed(9:2)const;

end-pr;



dcl-pr villeclient varchar(20);

  num packed(5:0)const;

end-pr;





/endif
```
