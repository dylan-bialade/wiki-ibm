---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: EXO2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 61
modifie: 2026-11-25
---

# BIB27/QFREESRC/EXO2

```rpg
**FREE

ctl-opt alwnull(*usrctl);


// déclaratives

dcl-f e_exo2 workstn;
dcl-f lf_exo2 usage(*update) keyed;


////////// debut du prog
// *in70 === gestion blanks dans e_name
// *in71 === pokemon non trouvé
// *in60 === zone protégé (name , pokenum , id , type1 , type2)


dow *in03 = *off;
  *in60 = *on;
  clear e_name;
  exfmt fmt1;
  *in70 = *off;
  if e_name = *blanks;
    *in70 = *on;
    iter;
  ENDIF;

  // chain sur le nom du pokemon
  chain e_name pokemon;
  if %found ;
    e1_name = name;
    e_id = id;
    e_hp = hp;
    e_speed = speed;
    e_attack = attack;
    e_defense = defense;
    e_type1 = type1;
    e_type2 = type2;
    e_spattack = speci00001;
    e_spdefens = speci00002;
    e_pokenum = poked00001;
    exfmt fmt2;
    if *in08 = *on;
      exfmt fmt3;
      if valid = 'YES';
        hp = e_hp;
        speed = e_speed;
        attack = e_attack;
        defense = e_defense;
        speci00001 = e_spattack;
        speci00002 = e_spdefens;
        update pokemon;
      ENDIF;
    ENDIF;
  else;
    *in71 = *on;
  ENDIF;
ENDDO;

// fin du prog
*inlr = *on;
```
