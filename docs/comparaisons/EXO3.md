# EXO3 : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGLESRC2 | RPG/RPG-ILE | 16 | 100 % | full free, ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR | [EXO3.md](../../sources/RPG/RPG-ILE/BIB05/EXO3.md) |
| BIB27 | QFREESRC | RPG/RPG-ILE | 57 | 5 % | full free, boucle DOW/DOU/FOR, indicateurs *INxx | [EXO3.md](../../sources/RPG/RPG-ILE/BIB27/EXO3.md) |

## Differences

- Techniques communes : full free, boucle DOW/DOU/FOR
- **BIB05** en propre : ecran (WORKSTN), CHAIN
- **BIB27** en propre : indicateurs *INxx

## Codes

### BIB05 (RPG/RPG-ILE, 16 lignes)

```text
**free
ctl-opt  dftactgrp(*no) actgrp(*caller);
dcl-f livdsp workstn;
dcl-f livresl  usage(*input) keyed;
dow not *inkc;
exfmt fmt1;
if *inkc = *off;
chain isbn livresl;
if %found();
dow *inkc = *off and *inkl =*off;
exfmt fmt2;
enddo;
endif;
endif;
enddo;
*inlr =*on;
```

### BIB27 (RPG/RPG-ILE, 57 lignes)

```text
**free

// déclaratives
dcl-s array packed(3:0) dim(9);
dcl-s i int(3);
dcl-s p int(3);
dcl-s temp packed(3:0);

array(1)=12;
array(2)=58;
array(3)=-6;
array(4)=12;
array(5)=6;
array(6)=400;
array(7)=56;
array(8)=5;
array(9)=-1;

dou *in50 = *off;
  *in50 = *off;
  for i=1 to 8;
    if array(i) > array(i+1);
      temp = array(i);
      array(i) = array(i+1);
      array(i+1) = temp;
      *in50 = *on;
    ENDIF;
  ENDFOR;
ENDDO;

//for p=1 to 9;
//  for i=1 to 8;
//    if array(i) > array(i+1);
//      temp = array(i);
//      array(i) = array(i+1);
//      array(i+1) = temp;
//    ENDIF;
//  ENDFOR;
//ENDFOR;

dsply ('start new programme');
dsply array(1);
dsply array(2);
dsply array(3);
dsply array(4);
dsply array(5);
dsply array(6);
dsply array(7);
dsply array(8);
dsply array(9);

*inlr = *on;
```
