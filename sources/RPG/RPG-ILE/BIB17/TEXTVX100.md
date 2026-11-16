---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: TEXTVX100
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 46
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/TEXTVX100

```rpg
**FREE
ctl-opt dftactgrp(*no);

dcl-pr VX100 extpgm('TPVIN/VX100');
   P1 char(6);
   P2 date(*ISO);
   P3 int(10);
   P4 int(10);
   P5 packed(7:2);
   P6 packed(4:1);
   P7 char(3);
   P8 char(2);
   P9 char(40);
end-pr;

dcl-s v_P1 char(6)     inz('PA08');
dcl-s v_P2 date(*ISO)  inz(d'2026-09-05');
dcl-s v_P3 int(10)     inz(2200);
dcl-s v_P4 int(10)     inz(2200);
dcl-s v_P5 packed(7:2) inz(0);
dcl-s v_P6 packed(4:1) inz(0);
dcl-s v_P7 char(3)     inz(*blanks);
dcl-s v_P8 char(2)     inz(*blanks);
dcl-s v_P9 char(40)    inz(*blanks);

afficherParams('AVANT');
VX100(v_P1 : v_P2 : v_P3 : v_P4 : v_P5 : v_P6 : v_P7 : v_P8 : v_P9);
afficherParams('APRES');

*inlr = *on;

dcl-proc afficherParams;
    dcl-pi *n;
        etape varchar(5) const;
    end-pi;
    snd-msg etape
          + ' P1=[' + v_P1 + ']'
          + ' P2=' + %char(v_P2)
          + ' P3=' + %char(v_P3)
          + ' P4=' + %char(v_P4)
          + ' P5=' + %char(v_P5)
          + ' P6=' + %char(v_P6)
          + ' P7=[' + v_P7 + ']'
          + ' P8=[' + v_P8 + ']'
          + ' P9=[' + %trimr(v_P9) + ']';
end-proc;
```
