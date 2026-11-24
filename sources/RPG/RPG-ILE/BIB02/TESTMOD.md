---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: TESTMOD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 32
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/TESTMOD

```rpg
**FREE
CTL-OPT COPYRIGHT('(C) ORGFORM 2023.')
OPTION(*SRCSTMT) DFTACTGRP(*NO)
ACTGRP(*CALLER) DATFMT(*ISO) ALLOC(*STGMDL)
STGMDL(*INHERIT) THREAD(*SERIALIZE) OPTIMIZE(*FULL) BNDDIR('LIAGE1');


dcl-pr modulo int(3) ;
  num1 int(3);
  num2 int(3);
END-PR;

dcl-pr calculTVA int(10);
  ht int(10);
  taxe int(3);
END-PR;



// Variable
dcl-s ht int(10) inz(100);
dcl-s tva int(3) inz(20);
dcl-s prixTotal int(10) inz(*zero);
dcl-s nb1 packed(3)inz(8);


// Traitement principal
prixTotal = calculTVA(ht:tva);

dsply %char(prixTotal);

*inlr = *on;
```
