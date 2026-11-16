---
bibliotheque: BIB13
fichier_source: QSRVSRC
membre: TP03SRV
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB13/QSRVSRC/TP03SRV

```text
             STRPGMEXP  SIGNATURE('TP03_V2')
             EXPORT     SYMBOL(NOMCLIENT)
             EXPORT     SYMBOL(ENCOURSCLIENT)
             EXPORT     SYMBOL(CREDITDISPO)
             EXPORT     SYMBOL(PEUTCOMMANDER)
             EXPORT     SYMBOL(VILLECLIENT)
             ENDPGMEXP

             STRPGMEXP  PGMLVL(*PRV) SIGNATURE('TP03_V1')
             EXPORT     SYMBOL(NOMCLIENT)
             EXPORT     SYMBOL(ENCOURSCLIENT)
             EXPORT     SYMBOL(CREDITDISPO)
             ENDPGMEXP
```
