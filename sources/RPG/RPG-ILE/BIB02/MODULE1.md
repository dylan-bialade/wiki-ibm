---
bibliotheque: BIB02
fichier_source: QMOD
membre: MODULE1
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 32
modifie: 2026-11-16
---

# BIB02/QMOD/MODULE1

```text
       CTL-OPT nomain;
       DCL-PR SubProcedure1 packed(4:0);
         *n packed(4:0) value;
         *n packed(4:0) value;
       END-PR;

       DCL-PR SubProcedure2 packed(4:0);
         *n packed(4:0) value;
         *n packed(4:0) value;
          *n packed(4:0) value;
       END-PR;

       DCL-PROC SubProcedure1 export;
         DCL-PI SubProcedure1 packed(4:0);
          num1 packed(4:0) value;
          num2 packed(4:0) value;
         END-PI;

       DCL-S Modulo packed(4:0);

       Modulo = %rem(num1:num2);
       return Modulo;

       END-PROC;

        DCL-PROC SubProcedure2 export;
          DCL-PI SubProcedure2 packed(4:0);
            num1 packed(4:0) value;
            num2 packed(4:0) value;
          END-PI;

        END-PROC;
```
