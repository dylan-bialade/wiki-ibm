---
bibliotheque: BIB05
fichier_source: QWEBSRC
membre: POKEDEX
type: Autres/Web
longueur_enregistrement: 114
lignes: 91
modifie: 2026-11-16
---

# BIB05/QWEBSRC/POKEDEX

```text
**FREE

//--------------------------------------------------------------*

// POKEDEX - Pokédex : liste des Pokémon (table POKEMON.POKEMON1G)

// Ecran PHL : DB1W3FM (format de contrôle FC1, sous-fichier SF1)

// Source de type SQLRPGLE (SQL embarqué)

//--------------------------------------------------------------*

ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt:*nodebugio);



dcl-f DB1W3FM workstn sfile(SF1:rrn1);



dcl-s rrn1 packed(5:0);



exec sql set option commit = *none, closqlcsr = *endmod;



exec sql declare C1 cursor for

  select pokedex_number, coalesce(name, ' '), coalesce(type1, ' '),

         coalesce(type2, ' '), hp, attack, defense,

         special_attack, special_defense, speed

    from pokemon.pokemon1g

   order by pokedex_number;



//* Effacement du sous-fichier

*In01 = *On;

Write FC1;

*In01 = *Off;

rrn1 = 0;



//* Chargement du sous-fichier : une ligne par Pokémon

exec sql open C1;

exec sql fetch C1 into :POKED00001, :NAME, :TYPE1, :TYPE2, :HP, :ATTACK,

                       :DEFENSE, :SPECI00001, :SPECI00002, :SPEED;

DoW SQLCODE = 0;

  rrn1 += 1;

  Write SF1;

  exec sql fetch C1 into :POKED00001, :NAME, :TYPE1, :TYPE2, :HP, :ATTACK,

                         :DEFENSE, :SPECI00001, :SPECI00002, :SPEED;

EndDo;

exec sql close C1;



//* Affichage du sous-fichier jusqu'à F3

DoW Not *InKC;

  Exfmt FC1;

EndDo;



*InLR = *On;

Return;
```
