---
bibliotheque: BIALADE
fichier_source: QWEBSRC
membre: POKEDEX
type: Autres/Web
longueur_enregistrement: 92
lignes: 112
modifie: 2026-11-16
---

# BIALADE/QWEBSRC/POKEDEX

```text
**FREE

                                            //----------------------------------------------
----------------*
                                                                                        // P
OKEDEX - Pokédex : liste des Pokémon (table POKEMON.POKEMON1G)

                                        // Ecran PHL : DB1W3FM (format de contrôle FC1, sous
-fichier SF1)
                                                                                    // Sourc
e de type SQLRPGLE (SQL embarqué)

                                    //------------------------------------------------------
--------*
                                                                                ctl-opt dfta
ctgrp(*no) actgrp(*caller) option(*srcstmt:*nodebugio);



                                                                            dcl-f DB1W3FM wo
rkstn sfile(SF1:rrn1);



                                                                        dcl-s rrn1 packed(5:
0);



                                                                    exec sql set option comm
it = *none, closqlcsr = *endmod;



                                                                exec sql declare C1 cursor f
or

                  select pokedex_number, coalesce(name, ' '), coalesce(type1, ' '),

                                                                     coalesce(type2, ' '), h
p, attack, defense,

                     special_attack, special_defense, speed

                                                            from pokemon.pokemon1g


           order by pokedex_number;




    //* Effacement du sous-fichier

                                                *In01 = *On;


Write FC1;

                                            *In01 = *Off;

                                                                                        rrn1
 = 0;



                                                                                    //* Char
gement du sous-fichier : une ligne par Pokémon

                                    exec sql open C1;

                                                                                exec sql fet
ch C1 into :POKED00001, :NAME, :TYPE1, :TYPE2, :HP, :ATTACK,

                                                       :DEFENSE, :SPECI00001, :SPECI00002, :
SPEED;
                                                                            DoW SQLCODE = 0;


                              rrn1 += 1;

                                                                          Write SF1;


                          exec sql fetch C1 into :POKED00001, :NAME, :TYPE1, :TYPE2, :HP, :A
TTACK,

 :DEFENSE, :SPECI00001, :SPECI00002, :SPEED;

                    EndDo;

                                                                exec sql close C1;




                                                            //* Affichage du sous-fichier ju
squ'à F3

            DoW Not *InKC;

                                                          Exfmt FC1;


        EndDo;




    *InLR = *On;

                                                Return;
```
