---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: CAPTUREPOK
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 4
modifie: 2026-11-25
---

# BIB27/QCLSRC/CAPTUREPOK

```cl
             PGM
             RUNSQL     SQL('call BIB27.pokerand()') COMMIT(*NONE)
             SNDPGMMSG  MSG('pokemon ajouté')
             ENDPGM
```
