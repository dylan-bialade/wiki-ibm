---
bibliotheque: BIB12
fichier_source: QRPGLESRC
membre: VINVX100
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 47
modifie: 2026-11-16
---

# BIB12/QRPGLESRC/VINVX100

```rpg
**free

dcl-s p1 char(6);
dcl-s p2 date(*iso);
dcl-s p3 int(10);
dcl-s p4 int(10);
dcl-s p5 packed(7:2);
dcl-s p6 packed(4:1);
dcl-s p7 char(3);
dcl-s p8 char(2);
dcl-s p9 char(40);

dcl-pr vx100 extpgm('TPVIN/VX100');
    p1 char(6) const;
    p2 date(*iso)const;
    p3 int(10)const;
    p4 int(10)const;
    p5 packed(7:2);
    p6 packed(4:1);
    p7 char(3);
    p8 char(2);
    p9 char(40);
end-pr;

*inlr=*on;

p1='PA01';
p2=%date('2026-09-07');
p3=1000;
p4= 10000;
// p5= 1000;
// p6=500 ;
// p7='DEC';
// p8='ON';
// p9=' ';


vx100(p1:p2:p3:p4:p5:p6:p7:p8:p9);
dsply p1;
dsply p2;
dsply p3;
dsply p4;
dsply p5;
dsply p6;
dsply p7;
dsply p8;
dsply p9;
```
