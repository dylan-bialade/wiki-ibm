---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: MODULE1
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 13
modifie: 2026-11-25
---

# BIB25/QRPGSRC/MODULE1

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
// Module Addition

CTL-OPT NOMAIN;

DCL-PROC addition EXPORT;
  DCL-PI *N packed(6:0);
    num1 packed(4:0);
    num2 packed(4:0);
  END-PI;
  // Retourne l'Addition
  return num1 + num2;
END-PROC;
```
