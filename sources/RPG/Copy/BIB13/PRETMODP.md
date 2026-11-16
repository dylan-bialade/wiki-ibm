---
bibliotheque: BIB13
fichier_source: QCPYSRC
membre: PRETMODP
type: RPG/Copy
longueur_enregistrement: 120
lignes: 92
modifie: 2026-11-16
---

# BIB13/QCPYSRC/PRETMODP

```rpg
**free


                                                                                                /if not defined(PRETMODP
)
                                                                                    /define PRETMODP



                                                            dcl-pr nbmois packed(4:0);

                                                  annee packed(3:0)const;

                                    end-pr;





dcl-pr calcTotInteret packed(12:2);
                                                                                                              annee pack
ed(3:0)const;
                                                                                                  taux  packed(4:2)const
;
                                                                                      montant packed(10:0)const;

                                                                        end-pr;



                                                dcl-pr calcMensualite packed(6:2);

                                      montant packed(10:2)const;

                          taux packed(4:2)const;

              annee packed(3:0)const;

end-pr;


                                                                                                dcl-pr interetsMois pack
ed(6:2);
                                                                                      taux packed(4:2)const;

                                                                          capital packed(12:2)const;

                                                            end-pr;



                                    dcl-pr ammotismois packed(6:2);

                          interet packed(6:2) const;

              mens packed(6:2) const;

end-pr;


                                                                                                dcl-pr capitalRestant pa
cked(12:2);
                                                                                      capital packed(12:2) const;

                                                                          ammortis packed(6:2) const;

                                                            end-pr;



                                    dcl-pr calcammorti packed(6:2);

                          montant packed(12:2)const;

              annee packed(3:0)const;

end-pr;


                                                                                                dcl-pr mensualite packed
(6:2);
                                                                                      ammorti packed(6:2) const;

                                                                          interet packed(6:2)const;

                                                            end-pr;





                        /endif
```
