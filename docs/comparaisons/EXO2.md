# EXO2 : 3 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGLESRC2 | RPG/RPG-ILE | 23 | 100 % | full free, CHAIN | [EXO2.md](../../sources/RPG/RPG-ILE/BIB05/EXO2.md) |
| BIB27 | QFREESRC | RPG/RPG-ILE | 61 | 2 % | full free, ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR, indicateurs *INxx | [EXO2.md](../../sources/RPG/RPG-ILE/BIB27/EXO2.md) |
| BIB27 | QSQLRPGLE | RPG/RPG-ILE | 61 | 3 % | full free, ecran (WORKSTN), SQL embarque, boucle DOW/DOU/FOR, indicateurs *INxx | [EXO2~QSQLRPGLE.md](../../sources/RPG/RPG-ILE/BIB27/EXO2~QSQLRPGLE.md) |

## Differences

- Techniques communes : full free
- **BIB05** en propre : CHAIN
- **BIB27** en propre : ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR, indicateurs *INxx
- **BIB27** en propre : ecran (WORKSTN), SQL embarque, boucle DOW/DOU/FOR, indicateurs *INxx

## Codes

### BIB05 (RPG/RPG-ILE, 23 lignes)

```text
**free

// Options de contrôle : désactivation du groupe d'activation par défaut,
// utilisation du groupe d'activation de l'appelant
ctl-opt  dftactgrp(*no) actgrp(*caller);

// Déclaration du fichier CLIENT en lecture seule avec accès par clé
dcl-f CLIENT  Usage(*Input) Keyed;

// Déclaration de la variable numéro client (packed 5,0)
dcl-s nmcli packed(5:0);

// Recherche du client numéro 2
nmcli = 2;
chain nmcli client ;

// Si le client est trouvé, afficher son prénom
if %found();
  dsply precli;
endif;

// Fin du programme - libération des ressources
*inlr = *on;
```

### BIB27 (RPG/RPG-ILE, 61 lignes)

```text
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

### BIB27 (RPG/RPG-ILE, 61 lignes)

```text
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
