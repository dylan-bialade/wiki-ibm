---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: EXO5
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 53
modifie: 2026-11-25
---

# BIB27/QFREESRC/EXO5

```rpg
**free

// déclaratives
dcl-f e_exo5 workstn;
dcl-f topscore usage(*update:*input:*output) keyed;


dcl-s nombre packed(3:0);
dcl-s var char(20);
dcl-s compteur packed(3:0) inz(1);

// programmation
// *in50 = plus grand
// *in51 = plus petit
var = %subst(%char(%timestamp()):24:2) ;
nombre = %int(var);
dow *in03 = *off;
  exfmt record1;
  *in50 = *off;
  *in51 = *off;
  if nbr = nombre;
    compt = compteur;
    result = nombre;
    compt = compteur;
    setll *loval topf;
    read topf;
    if not %found;
      score = compteur;
      write topf;
    else;
      if score > compteur;
        score = compteur;
        update topf;
      ENDIF;
    ENDIF;
    best = score;
    exfmt record2;
    compteur = 1;
  elseif nbr > nombre ;
    *in51 = *on;
    compteur = compteur + 1;
  else;
    *in50 = *on;
    compteur = compteur + 1;
  ENDIF;
ENDDO;




// sortie du programme

*inlr = *on;
```
