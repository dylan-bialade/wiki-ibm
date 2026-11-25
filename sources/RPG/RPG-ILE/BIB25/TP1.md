---
bibliotheque: BIB25
fichier_source: QILESRC
membre: TP1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-25
---

# BIB25/QILESRC/TP1

```rpg
**free

// Déclaration de notre répertoire de liage
CTL-OPT ACTGRP(*CALLER) STGMDL(*INHERIT) BNDDIR('REP1');

DCL-S ID int(10);

DCL-DS DSClients QUALIFIED;
  id int(10);
  nom varchar(50);
  prenom varchar(50);
  age packed(2:0);
  email varchar(100);
END-DS;

// Déclaration de notre procédure (elle se situe dans notre module)
DCL-PR ReturnInfoClients LIKEDS(DSClients) ;
   id int(10);
END-PR;

id = 1;

DSClients = ReturnInfoClients(id);

dsply DSClients.nom;



return;
```
