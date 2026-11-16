---
bibliotheque: BIB13
fichier_source: QCPYSRC
membre: TP02MODP
type: RPG/Copy
longueur_enregistrement: 120
lignes: 37
modifie: 2026-11-16
---

# BIB13/QCPYSRC/TP02MODP

```rpg
**free


                                                                                                /if not defined(TP02MODP
)
                                                                                    /define TP02MODP





                                                dcl-pr stockArticle packed(7:0);

                                      code char(6) const;

                        end-pr;



dcl-pr valeurStock packed(11:2);
                                                                                                              code char(
6) const;
                                                                                                end-pr;



                                                                        dcl-pr estDisponible ind;

                                                              code char(6) const;

                                                  qte packed(7:0) const;

                                    end-pr;



            /endif
```
