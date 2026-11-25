---
bibliotheque: BIB25
fichier_source: QILESRC
membre: APPELANT
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 16
modifie: 2026-11-25
---

# BIB25/QILESRC/APPELANT

```rpg
**free
/COPY BIB25/QSRVSRC,SIGN_SRV1H
// Fonctionnement compatible OPM
//DCL-PR test_ile EXTPGM;
//END-PR;

DCL-S montant packed(5:2);
DCL-S resultat packed(5:2);
montant = 10;
resultat = calculTVA(montant);
// Appel d'un programme de type OPM
//callp test_ile();
// dsply 'appuyer sur entree pour le résultat';
dsply resultat;

*inlr = *on;
```
