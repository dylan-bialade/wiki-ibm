---
bibliotheque: BIB25
fichier_source: QILETP
membre: TP2ILE
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 22
modifie: 2026-11-25
---

# BIB25/QILETP/TP2ILE

```rpg
**FREE

CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER) STGMDL(*INHERIT) BNDDIR('TP1BND');

// Insertion des prototypes
/COPY BIB25/QILETP,TP1PRO

DCL-PI *N;
  chaine char(20);
END-PI;

DCL-S result IND;

result = CheckNumeric(chaine);

IF result;
   DSPLY 'Contient que du numéric';
ELSE;
  DSPLY 'Contient des caractères Alphanuméric';
ENDIF;

*INLR = *ON;
```
