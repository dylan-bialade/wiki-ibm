---
bibliotheque: BIB05
fichier_source: QRPGLESRC3
membre: LOGISTOCK
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 7
modifie: 2026-11-16
---

# BIB05/QRPGLESRC3/LOGISTOCK

```text
     A*  PF LOGISTOCK -      A*  PF LOGISTOCK - Articles stockes LogiStock
     A          R ENTREPOTF
     A            CODPRO         5A         TEXT('Code produit')
     A            NOMPRO        30A         TEXT('Nom du produit')
     A            QTPRO          3S 0       TEXT('Quantite en stock')
     A            DTDINV          L         DATFMT(*ISO)
     A                                      TEXT('Date dernier inventaire')
```
