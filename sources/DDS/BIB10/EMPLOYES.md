---
bibliotheque: BIB10
fichier_source: QDDSSRC
membre: EMPLOYES
type: DDS
longueur_enregistrement: 80
lignes: 8
modifie: 2026-11-16
---

# BIB10/QDDSSRC/EMPLOYES

```text
                                            UNIQUE
                R EMPLOYES
                  IDEMP         10S 0       COLHDG('ID EMPLOYE')
                  NOMEMP       100A         COLHDG('NOM EMPLOYES')
                                            DFT('DUPONT')
                  AGEEMP         3P 0       COLHDG('AGE EMPLOYE')
                                            DFT(18)
                K IDEMP
```
