---
bibliotheque: BIB25
fichier_source: QMODSRC
membre: PROC2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-25
---

# BIB25/QMODSRC/PROC2

```rpg
**free
// Appel via Java par exemple
ctl-opt PGMINFO(*PCML : *MODULE) copyright('(C) ORGFORM 2025.')
        DATFMT(*ISO);


return;

DCL-PROC addition;
    DCL-PI *N packed(7:2);
        num1 packed(5:2);
        num2 packed(5:2);
    END-PI;
    return num1 + num2;
END-PROC;
```
