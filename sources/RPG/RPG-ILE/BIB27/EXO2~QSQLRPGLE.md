---
bibliotheque: BIB27
fichier_source: QSQLRPGLE
membre: EXO2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 61
modifie: 2026-11-25
---

# BIB27/QSQLRPGLE/EXO2

```rpg
**free

// déclaration de mon écran

dcl-f e_exo2 workstn;


// debut du programme

// *in70 === gestion blanks dans e_name
// *in71 === pokemon non trouvé
// *in60 === zone protégé (name , pokenum , id , type1 , type2)

// obligatoire !! permet de ne pas avoir une logique transctionnelle (banques ...)
exec SQL
SET OPTION COMMIT=*NONE;


// boucle sur le f3
dow *in03 = *off;

  *in60 = *on;
  clear e_name;
  clear valid;
  exfmt fmt1;
  *in72 = *off;

  if e_name = *blanks;
    *in70 = *on;
    iter;
  ENDIF;

  exec sql
  select name, id , hp , speed , attack , defense , type1 , ifnull(type2 , ' ') , special_attack ,
   special_defense , pokedex_number
  into :e1_name , :e_id , :e_hp , :e_speed , :e_attack , :e_defense , :e_type1 ,
   :e_type2 , :e_spattack , :e_spdefens , :e_pokenum
  from pokemon2g where name=:e_name;

  if sqlcod = 0;
     exfmt fmt2;
     if *in08 = *on;
       exfmt fmt3;
       if valid = 'YES';
         exec SQL
         update pokemon2g
         set hp = :e_hp , speed = :e_speed , attack = :e_attack , defense = :e_defense,
         special_attack = :e_spattack , special_defense = :e_spdefens
         where id = :e_id;
       ENDIF;
     ENDIF;
  else;
     *in71 = *on;
  ENDIF;

ENDDO;


// sortie du programme

*inlr = *on;
```
