---
bibliotheque: BIB13
fichier_source: QSRVSRC
membre: TP02BND
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB13/QSRVSRC/TP02BND

```text

/*---------------------------------------------------------*/
/*          Version *Current                             */
/*---------------------------------------------------------*/
             STRPGMEXP  SIGNATURE('TP02SRV_V2')
             EXPORT     SYMBOL(ESTDISPONIBLE)
             EXPORT     SYMBOL(STOCKARTICLE)
             EXPORT     SYMBOL(VALEURSTOCK)
             EXPORT     SYMBOL(NBLECTURE)
             EXPORT     SYMBOL(TEST)
             ENDPGMEXP

/*--------------------------------------------------------*/
/*          Version Precedentes                         */
/*--------------------------------------------------------*/

             STRPGMEXP  PGMLVL(*PRV) SIGNATURE('TP02SRV_V1')
             EXPORT     SYMBOL(ESTDISPONIBLE)
             EXPORT     SYMBOL(STOCKARTICLE)
             EXPORT     SYMBOL(VALEURSTOCK)
             EXPORT     SYMBOL(NBLECTURE)
             ENDPGMEXP

/************/
```
