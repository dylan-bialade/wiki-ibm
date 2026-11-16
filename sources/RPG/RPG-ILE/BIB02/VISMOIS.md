---
bibliotheque: BIB02
fichier_source: QILE
membre: VISMOIS
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 26
modifie: 2026-11-16
---

# BIB02/QILE/VISMOIS

```text
        CTL-OPT NOMAIN;

         DCL-S VisusMois CHAR(9) DIM(12) CTDATA PERRCD(1);
        //DCL-S LIBMOIS CHAR(9);

        DCL-PROC VISMOIS EXPORT;
        DCL-PI *N CHAR(9);
          DTRACE DATE;
        END-PI;

        RETURN VisusMois(%int(%subst(%char(DTRACE):6:2)));
        END-PROC;

** CTDATA VisusMois
Janvier
Fevrier
Mars
Avril
Mai
Juin
Juillet
Aout
Septembre
Octobre
Novembre
Decembre
```
