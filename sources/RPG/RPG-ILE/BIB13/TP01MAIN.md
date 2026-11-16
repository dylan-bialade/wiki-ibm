---
bibliotheque: BIB13
fichier_source: QRPGLESRC
membre: TP01MAIN
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 73
modifie: 2026-11-16
---

# BIB13/QRPGLESRC/TP01MAIN

```rpg
**free

ctl-opt copyright('Copyright (c) 2026, BIB10 Xuân-Lâm');

dcl-f article usage(*input) keyed;

dcl-f artpromo usage(*input) keyed rename(ARTICF:promo);



/copy qcpysrc,tp01modp



dcl-s nbCalcul int(10) import;

dcl-s totalttc packed(10:2);

dcl-s totalht packed(10:2);

dcl-s rep char(1);



*inlr=*on;

// traitement articles

read ARTICF;

dow not %eof;

  totalht += ARPXHT;

  totalttc += calcttc(ARPXHT:ARCTVA);

  read ARTICF;

enddo;

dsply ('total ht   : ' + %editw(totalht:'  &   & 0 ,  &€'));

dsply ('total ttc  : ' + %editw(totalttc:'  &   & 0 ,  &€'));



totalht=0;

totalttc=0;

read PROMO;

dow not %eof;

  totalht += ARPXHT;

  totalttc += calcttc(ARPXHT:ARCTVA);

  read PROMO;

enddo;

dsply ('total ht   : ' + %editw(totalht:'  &   & 0 ,  &€'));

dsply ('total ttc  : ' + %editw(totalttc:'  &   & 0 ,  &€'));



dsply ('Nombre operation: ' + %editc(nbCalcul:'3'));



dsply 'pile : Maj+Echap, option 3 puis 11' ''rep;
```
