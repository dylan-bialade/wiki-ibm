---
bibliotheque: BIB25
fichier_source: QILESRC
membre: SIGN_FINAL
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 9
modifie: 2026-11-25
---

# BIB25/QILESRC/SIGN_FINAL

```rpg
**free
/COPY BIB25/QSRVSRC,SIGN_SRV1H
DCL-S montant packed(5:2);
DCL-S resultat packed(5:2);
montant = 10;
resultat = calculTVA(montant);
dsply 'appuyer sur entree pour le résultat';
dsply resultat;
*inlr = *on;
```
