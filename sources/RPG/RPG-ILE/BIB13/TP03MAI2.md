---
bibliotheque: BIB13
fichier_source: QRPGLESRC
membre: TP03MAI2
type: RPG/RPG-ILE
longueur_enregistrement: 96
lignes: 53
modifie: 2026-11-16
---

# BIB13/QRPGLESRC/TP03MAI2

```rpg
**free

                                    ctl-opt option(*srcstmt:*nodebugio);




            /include QCPYSRC,TP03MODP






                        afficher(1);

                                                            afficher(2);


afficher(3);

                                    *inlr=*on;






                                                dcl-proc afficher;

                                                                                      dcl-pi *n
;

                            num packed(5:0)const;

                                                              end-pi;


  dsply (%trim(nomClient(num))+'- '+%trim(villeclient(num)));

                                      if peutCommander(num:500);

                                                                            dsply 'Commande de 5
00.00 € : Acceptée';

              else;

                                                    dsply 'Commande de 500.00 € : Refusée';

                                                                                      endif;


                        end-proc;
```
