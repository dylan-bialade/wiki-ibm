---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: PROTOTYPES
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 11
modifie: 2026-11-25
---

# BIB25/QRPGSRC/PROTOTYPES

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**FREE

// prototype calcul Age
DCL-PR CALCUL_AGE packed(3:0);
  date_n date;
END-PR;

// prototype changement de devise
DCL-PR CHG_DEVISE packed(6:2);
  montant packed(6:2);
END-PR;
```
