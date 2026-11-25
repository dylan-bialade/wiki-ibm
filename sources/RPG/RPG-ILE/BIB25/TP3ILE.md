---
bibliotheque: BIB25
fichier_source: QILETP
membre: TP3ILE
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 23
modifie: 2026-11-25
---

# BIB25/QILETP/TP3ILE

```rpg
**free

CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER) STGMDL(*INHERIT) BNDDIR('TP1BND');

// Insertion des prototypes
/COPY BIB25/QILETP,TP1PROV3


DCL-PI *N;
  email char(40);
END-PI;

DCL-S result IND;

result = CheckEmail(email);

IF result;
   DSPLY 'Email Valide';
ELSE;
  DSPLY 'Email non valide';
ENDIF;

*INLR = *ON;
```
