---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: ENTREPOT
type: DDS
longueur_enregistrement: 80
lignes: 6
modifie: 2026-11-16
---

# BIB17/QDDSSRC/ENTREPOT

```text
                R ENTREPOTF
                  CODPRO         5A         COLHDG('CODE_PRODUIT')
                  NOMPROD       30A         COLHDG('NOM_PRODUIT')
                  QUANTSTOCK     3S 0       COLHDG('QUANTITE_EN_STOCK')
                  DINVDATE        L         DATFMT(*ISO)
                                            COLHDG('DTE_DERNIER_INVENT')
```
