# TP3MODP : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB18 | QCPYSRC | RPG/Copy | 29 | 100 % | full free, prototypes (dcl-pr) | [TP3MODP.md](../../sources/RPG/Copy/BIB18/TP3MODP.md) |
| BIB03 | QCPYSRC | RPG/Copy | 26 | 64 % | full free, prototypes (dcl-pr) | [TP3MODP.md](../../sources/RPG/Copy/BIB03/TP3MODP.md) |

## Differences

- Techniques communes : full free, prototypes (dcl-pr)

## Codes

### BIB18 (RPG/Copy, 29 lignes)

```text
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

### BIB03 (RPG/Copy, 26 lignes)

```text
**free
/if not defined(TP3MODP)
/define TP3MODP

dcl-pr nomClient varchar(30);
    num packed(5:0) const;
end-pr;

dcl-pr encoursClient packed(9:2);
    num packed(5:0) const;
end-pr;

dcl-pr creditDispo packed(9:2);
    num packed(5:0) const;
end-pr;

dcl-pr peutCommander ind;               // NOUVEAU (ex. 2)
    num packed(5:0) const;
    montant packed(9:2) const;
end-pr;

dcl-pr villeClient varchar(20);         // NOUVEAU (ex. 2)
    num packed(5:0) const;
end-pr;

/endif
```
