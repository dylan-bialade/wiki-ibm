---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: CHG_DEVISE
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 9
modifie: 2026-11-25
---

# BIB25/QRPGSRC/CHG_DEVISE

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**FREE
CTL-OPT NOMAIN;
DCL-PROC CHG_DEVISE EXPORT;
  DCL-PI CHG_DEVISE packed(6:2);
    montant packed(6:2);
  END-PI;
  // taux de change à 1.13 (suceptible de changer avec le temps)
  return montant * 1.13;
END-PROC;
```
