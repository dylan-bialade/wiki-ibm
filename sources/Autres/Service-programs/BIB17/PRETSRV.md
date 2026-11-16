---
bibliotheque: BIB17
fichier_source: QSRVSRC
membre: PRETSRV
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 22
modifie: 2026-11-16
---

# BIB17/QSRVSRC/PRETSRV

```text
             STRPGMEXP  PGMLVL(*CURRENT)
             EXPORT     SYMBOL(CALCTOTAUX)
             EXPORT     SYMBOL(CALCMENSUALITE)
             EXPORT     SYMBOL(CALCECHEANCE)
             EXPORT     SYMBOL(CALCTOTAUXAMORTCONST)
             EXPORT     SYMBOL(CALCECHEANCEAMORTCONST)
             EXPORT     SYMBOL(CALCCAPITALCONSTANT)
             ENDPGMEXP

             STRPGMEXP  PGMLVL(*PRV)
             EXPORT     SYMBOL(CALCTOTAUX)
             EXPORT     SYMBOL(CALCMENSUALITE)
             EXPORT     SYMBOL(CALCECHEANCE)
             EXPORT     SYMBOL(CALCTOTAUXAMORTCONST)
             EXPORT     SYMBOL(CALCECHEANCEAMORTCONST)
             ENDPGMEXP

             STRPGMEXP  PGMLVL(*PRV)
             EXPORT     SYMBOL(CALCTOTAUX)
             EXPORT     SYMBOL(CALCMENSUALITE)
             EXPORT     SYMBOL(CALCECHEANCE)
             ENDPGMEXP
```
