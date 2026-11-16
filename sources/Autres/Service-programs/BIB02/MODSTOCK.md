---
bibliotheque: BIB02
fichier_source: QBNDSRC
membre: MODSTOCK
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 11
modifie: 2026-11-16
---

# BIB02/QBNDSRC/MODSTOCK

```text
       CTL-OPT NOMAIN;
       dcl-proc color_red export;
        dcl-pi *n ind;
           fmt2qtp packed(3);
        END-PI;
         if fmt2qtp < 10;
          return *ON;
          else;
           return *OFF;
         ENDIF;
       END-PROC;
```
