---
bibliotheque: BIB25
fichier_source: QCLLESRC
membre: CAPTUREPOK
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 4
modifie: 2026-11-25
---

# BIB25/QCLLESRC/CAPTUREPOK

```cl
             PGM
             RUNSQL     SQL('call BIB27.pokerand()') COMMIT(*NONE)
             SNDPGMMSG  MSG('pokemon ajouté')
             ENDPGM
```
