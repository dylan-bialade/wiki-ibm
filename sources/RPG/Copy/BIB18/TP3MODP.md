---
bibliotheque: BIB18
fichier_source: QCPYSRC
membre: TP3MODP
type: RPG/Copy
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-16
---

# BIB18/QCPYSRC/TP3MODP

```rpg
**free
/if not defined(TP3MODP)
/define TP3MODP
dcl-pr lireClient ind;
    num packed(5:0) const;
end-pr;

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
    num packed(5:0) const;
    montant packed(9:2) const;
end-pr;

dcl-pr villeClient varchar(20);
    num packed(5:0) const;
end-pr;

/endif
```
