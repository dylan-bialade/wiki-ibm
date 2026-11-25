---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: TESTINV
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 36
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/TESTINV

```rpg
**free
CTL-OPT  ACTGRP(*CALLER) DFTACTGRP(*NO)  STGMDL(*INHERIT) BNDDIR('REPMOD');


dcl-s stock_poke zoned(5:0);
dcl-s qu_retire zoned(5:0);
dcl-s qu_ajout zoned(5:0);
dcl-s resultat char(52);


dcl-pr AjouterAuStock zoned(5:0);
  stock zoned(5:0);
  qu_ajout zoned(5:0);
END-PR;

dcl-pr RetirerDuiStock zoned(5:0);
  stock zoned(5:0);
  qu_retire zoned(5:0);
END-PR;


stock_poke = 100 ;
qu_retire = 15;
qu_ajout = 25;

// Ajout
stock_poke = AjouterAuStock(stock_poke:qu_ajout);
resultat = 'le stock est de ' + %char(stock_poke);
dsply resultat;

// retirer
stock_poke = RetirerDuiStock(stock_poke:qu_retire);
resultat = 'le stock est mtn de ' + %char(stock_poke);
dsply resultat;

*inlr = *on;
```
