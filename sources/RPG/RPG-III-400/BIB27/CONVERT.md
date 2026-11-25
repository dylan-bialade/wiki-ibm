---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: CONVERT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 44
modifie: 2026-11-25
---

# BIB27/QRPGSRC/CONVERT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
ctl-opt DFTACTGRP(*NO);

dcl-f LOG_HST usage(*input);

dcl-s hexvalue char(142);
dcl-s charvalue char(142);
dcl-s dspvalue char(49);
dcl-s tempvalue char(2);
dcl-s hexresult char(65534);
dcl-s charinp char(32767);
dcl-s charnibbles int(10);
dcl-s testhex char(50);



dcl-pr tohex extproc('cvthc');
  hexresult char(65534) options(*varsize);
  charinp char(32767) const options(*varsize);
  charnibbles int(10) value;
end-pr;

read QHST24233A;

dow not %eof;
    hexvalue = SYSLOGFLD;

    //hexinp = %trim(hexvalue);
    //hexlen = %len(hexinp);

    testhex = 'LEO';
    charinp = %trim(testhex);
    charnibbles = %len(%trim(charinp));

    tohex( hexresult : charinp : charnibbles);

    dspvalue = %subst(hexresult : 1 : 49);
    dsply dspvalue;

    read QHST24233A;
enddo;


*inlr = *on;
```
