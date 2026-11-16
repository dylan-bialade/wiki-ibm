---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: PARAPGM
type: DDS
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB02/QDDSRC/PARAPGM

```text
       Ctl-Opt Option (*NoDebugio) datfmt(*eur) timfmt(*hms) datedit(*dmy);

       DCL-PI PARAPGM ;
         MONPARAM char(10);
       END-PI;

       // La date du jour
       DCL-S DATE_JOUR date(*eur) inz(*job);

       // MONPARAM = la date du jour ('17.03.2023')
       MONPARAM = %char(DATE_JOUR);

       *inlr = *on;
```
