---
bibliotheque: BIAILE
fichier_source: QSRVSRC
membre: TP3SRV
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIAILE/QSRVSRC/TP3SRV

```text
STRPGMEXP PGMLVL(*CURRENT)
  EXPORT SYMBOL("NOMCLIENT")            /* n° 1 */
  EXPORT SYMBOL("ENCOURSCLIENT")        /* n° 2 */
  EXPORT SYMBOL("CREDITDISPO")          /* n° 3 */
  EXPORT SYMBOL("PEUTCOMMANDER")        /* n° 4 - NOUVEAU, à la fin */
  EXPORT SYMBOL("VILLECLIENT")          /* n° 5 - NOUVEAU, à la fin */
ENDPGMEXP

STRPGMEXP PGMLVL(*PRV)                  /* NOUVEAU : copie de l'ancien bloc (ex. 1) */
  EXPORT SYMBOL("NOMCLIENT")
  EXPORT SYMBOL("ENCOURSCLIENT")
  EXPORT SYMBOL("CREDITDISPO")
ENDPGMEXP
```
