---
bibliotheque: BIB18
fichier_source: QSRVSRC
membre: TP3SRV
type: Autres/Service-programs
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-16
---

# BIB18/QSRVSRC/TP3SRV

```text
             STRPGMEXP
             EXPORT     SYMBOL(NOMCLIENT)
             EXPORT     SYMBOL(ENCOURSCLIENT)
             EXPORT     SYMBOL(CREDITDISPO)
             EXPORT     SYMBOL(PEUTCOMMANDER)
             EXPORT     SYMBOL(VILLECLIENT)
             ENDPGMEXP
             STRPGMEXP  PGMLVL(*PRV)
             EXPORT     SYMBOL(NOMCLIENT)
             EXPORT     SYMBOL(ENCOURSCLIENT)
             EXPORT     SYMBOL(CREDITDISPO)
             ENDPGMEXP
```
