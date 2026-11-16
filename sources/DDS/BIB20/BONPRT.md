---
bibliotheque: BIB20
fichier_source: QPRTSRC
membre: BONPRT
type: DDS
longueur_enregistrement: 80
lignes: 19
modifie: 2026-11-16
---

# BIB20/QPRTSRC/BONPRT

```text
                R TITRE
                                        2 50'LISTE DES BONBONS'
                R ENTETE
                                            SPACEB(001)
                                          10'N°'
                                          25'NOM'
                                          55'MARQUE'
                                          85'PRIX EXPORT'
                R DETAILS
                                            SPACEB(001)
                  NUMBB          6S 0      5
                  NOM           20A       20
                  MARQUE        20A       50
                  PRIX           5S 2     89
                R ETOILE
                                          50'********************'
                R EJECT
                                            SKIPA(1)
                                         105'A SUIVRE......'
```
