---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: EXO1_C
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 37
modifie: 2026-11-25
---

# BIB27/QFREESRC/EXO1_C

```rpg
**free

// déclaratives

dcl-f e_exo1 workstn;
dcl-s i int(3);
dcl-s length int(3);
dcl-s demilength int(3);
dcl-s var varchar(35);



dow *in03 = *off;

  exfmt record1;
  if (chaine = *blank);
    *in72 = *on;
    iter;
  ENDIF;
  var = %scanrpl(' ':'':chaine);
  demilength = %len(VAR)/2;
  length = %len(VAR);


  for i = 1 to demilength;
    if %subst(var:i:1) <> %subst(var:length-i+1:1);
      *in71 = *on;
      LEAVE;
    ENDIF;

  ENDFOR;

    *in70 = not *in71;
ENDDO;

// sortie du programme
*inlr = *on;
```
