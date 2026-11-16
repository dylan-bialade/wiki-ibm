---
bibliotheque: BIALADE2
fichier_source: QDDSSRC
membre: CLIENTS
type: DDS
longueur_enregistrement: 80
lignes: 5
modifie: 2026-11-16
---

# BIALADE2/QDDSSRC/CLIENTS

```text
                                            REF(EMPLOYES)
                R CLIENTS
     A            NOMCLI        20A
     A            NRTRANS       30S 0       COLHDG('NUM TRANSACTION')
     A            IDEMPL    R               REFFLD(IDEMP EMPLOYES)
```
