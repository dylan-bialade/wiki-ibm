---
bibliotheque: BIB05
fichier_source: QCLPSRC
membre: CLIENTCRL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 13
modifie: 2026-11-16
---

# BIB05/QCLPSRC/CLIENTCRL

```cl
PGM
             RUNSQL    SQL('Create table BIB05.clients( id smallint +
                          GENERATED ALWAYS AS IDENTITY (START WITH +
                          1 INCREMENT BY 1), nom char(20), prenom +
                          char(20), age smallint)') NAMING(*SQL)







ENDPGM
```
