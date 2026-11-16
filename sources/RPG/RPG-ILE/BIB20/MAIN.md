---
bibliotheque: BIB20
fichier_source: QILESRC
membre: MAIN
type: RPG/RPG-ILE
longueur_enregistrement: 92
lignes: 31
modifie: 2026-11-16
---

# BIB20/QILESRC/MAIN

```rpg
**free

                                                                        ctl-opt bnddir('BNDD
IR1');

                                                    dcl-pr checkMail ind;

mail char(100) const;
                                end-pr;


            dcl-pr checkSecu ind;
                                                    secu char(100) const;
                                                                                    end-pr;


                                                                dcl-pr calculTVA ind;

            nb zoned(5:0) const;
                                            end-pr;


                        dsply checkMail('toto@armonie.group');


    dsply checkSecu('85485475fhgfheyfg89548654fd');

                                                                            dsply ('TVA de 1
3€ : ' + %char(calculTVA(13)));

                                                        *inlr = *on;
```
