---
bibliotheque: BIB02
fichier_source: QMOD
membre: MODULE1_P
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB02/QMOD/MODULE1_P

```text

       DCL-S MODULO packed(4:0);

       DCL-PR SubProcedure1 packed(4:0);
         *n packed(4:0) value;
         *n packed(4:0) value;
       END-PR;

       MODULO = 0;
       MODULO = SubProcedure1(5:10);
       DSPLY MODULO;

       *INLR = *ON;
```
