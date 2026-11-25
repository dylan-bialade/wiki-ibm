---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: EXO3
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 57
modifie: 2026-11-25
---

# BIB27/QFREESRC/EXO3

```rpg
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
