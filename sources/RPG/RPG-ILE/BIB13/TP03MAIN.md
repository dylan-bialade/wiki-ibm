---
bibliotheque: BIB13
fichier_source: QRPGLESRC
membre: TP03MAIN
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 35
modifie: 2026-11-16
---

# BIB13/QRPGLESRC/TP03MAIN

```rpg
**free
                                                                                                            ctl-opt opti
on(*srcstmt:*nodebugio);


                                                                                    /include QCPYSRC,TP03MODP





                                                afficher(1);

                                    afficher(2);

                        afficher(9);

            *inlr=*on;




                                                                                                dcl-proc afficher;

                                                                                      dcl-pi *n ;

                                                                            num packed(5:0)const;

                                                              end-pi;

                                                  dsply (%char(num)+' '+nomClient(num));

                                      dsply ('Encours: '+%char(encoursClient(num))+'- crédit: '+%char(creditDispo(num)))
;
                        end-proc;
```
