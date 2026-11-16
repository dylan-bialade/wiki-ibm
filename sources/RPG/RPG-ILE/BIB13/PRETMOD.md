---
bibliotheque: BIB13
fichier_source: QRPGLESRC
membre: PRETMOD
type: RPG/RPG-ILE
longueur_enregistrement: 132
lignes: 168
modifie: 2026-11-16
---

# BIB13/QRPGLESRC/PRETMOD

```rpg
**free
                                                                                                ctl-opt nomain;



                        /include QCPYSRC,PRETMODP


                                                                                    dcl-proc nbMois export;

                                                  dcl-pi *n packed(4:0);

                annee packed(3:0)const;
                                                                                                              end-pi;

                                                                          return annee*12;

                                    end-proc;


                                                                                                dcl-proc tauxMensuel;

                                                              dcl-pi *n packed(6:4);

                            taux packed(4:2)const;
                                                                                                                          end-pi;

                                                                                      return (taux*0.01)/12;

                                                end-proc;




                                                                        dcl-proc calcTotInteret export;

                                      dcl-pi *n packed(12:2);

    annee packed(3:0)const;
                                                                                                    taux  packed(4:2)const;

                                                                montant packed(10:0)const;

                          end-pi;
                                                                                                                          dcl-s inte
rets packed(12:2);
                                                                                      dcl-s tx packed(6:4);

                                                  dcl-s mois packed(4:0);

              tx = taux*0.01;
                                                                                                              interets = montant * a
nnee * ((tx*(1+tx)**annee)/((1+tx)**annee - 1)) - montant;
                                                                          return interets;




                                                                                                end-proc;



                        dcl-proc calcMensualite export;
                                                                                                                          dcl-pi *n
packed(6:2);
                                                                                        montant packed(10:2)const;

                                                    taux packed(4:2)const;

                annee packed(3:0)const;
                                                                                                              end-pi;

                                                                          dcl-s mensualite packed(7:3);

                                      dcl-s txm packed(6:4);

  dcl-s mois packed(4:0);


                                                              txm = tauxMensuel(taux);

                          mois = nbMois(annee);


                                                                                      mensualite = montant*(txm/(1-(1+txm)**(-1 * mo
is)));
                                                  return %dech(mensualite:6:2);

            end-proc;


                                                                        dcl-proc interetsMois export;

                                      dcl-pi *n packed(6:2);

    taux packed(4:2)const;
                                                                                                    capital packed(12:2)const;

                                                              end-pi;

                          dcl-s txm  packed(6:4);
                                                                                                                          txm = taux
Mensuel(taux);


                                                  return capital*txm;

            end-proc;


                                                                        dcl-proc ammotismois export;

                                      dcl-pi *n packed(6:2);

    interet packed(6:2)const;
                                                                                                    mens    packed(6:2)const;

                                                              end-pi;

                          return mens-interet;
                                                                                                                        end-proc;






                                                                                                            dcl-proc capitalRestant
export;
                                                                          dcl-pi *n packed(12:2);

                                        capital packed(12:2)const;

    ammortis packed(6:2)const;
                                                                                                  end-pi;

                                                              return capital-ammortis;

                        end-proc;


                                                                                    dcl-proc calcammorti export;

                                                  dcl-pi *n packed(6:2);

                montant packed(12:2) const;
                                                                                                                annee packed(3:0) co
nst;
                                                                          end-pi;

                                      dcl-s mois packed(4:0);

  return %dech(montant/mois:6:2);
                                                                                                end-proc;



                        dcl-proc mensualite export;
                                                                                                                          dcl-pi *n
packed(6:2);
                                                                                        ammorti packed(6:2)const;

                                                    interet packed(6:2)const;

              end-pi;
                                                                                                              return ammorti + inter
et;
                                                                        end-proc;
```
