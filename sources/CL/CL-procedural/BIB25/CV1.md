---
bibliotheque: BIB25
fichier_source: QFALTER
membre: CV1
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-25
---

# BIB25/QFALTER/CV1

```cl
             PGM

             STRCMTCTL  LCKLVL(*ALL) NFYOBJ(CVSCHEMA/PRODUCTS (*FILE)) +
                          CMTSCOPE(*JOB) TEXT('Contrôle de validation +
                          PRODUCTS') OMTJRNE(*NONE) /* Début du contrôle +
                          de validation */

             CALL       PGM(BIB25/CV2)

             ENDCMTCTL  /* fin du contrôle de validation */




             ENDPGM
```
