---
bibliotheque: BIB25
fichier_source: QMEP
membre: ERREUR
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 10
modifie: 2026-11-25
---

# BIB25/QMEP/ERREUR

```text
     **free
     ctl-opt dftactgrp(*no) actgrp(*caller)
     dcl-pi *n;
       mbname char(10);
     end-pi;

     exec sql
        insert into bib.fichier values ( :mbname );

     return;
```
