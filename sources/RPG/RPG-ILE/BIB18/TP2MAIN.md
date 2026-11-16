---
bibliotheque: BIB18
fichier_source: QRPGLESRC
membre: TP2MAIN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB18/QRPGLESRC/TP2MAIN

```rpg
**free
ctl-opt option(*srcstmt : *nodebugio);

/copy QRPGLESRC,TP2MODP

dcl-c ART_CONNU   'A00003';
dcl-c ART_INCONNU 'A00009';

dcl-s nbLectures int(10) import;
dcl-s reponse    char(3);

dsply (ART_CONNU + ' - stock : ' + %char(stockArticle(ART_CONNU)));
dsply (ART_CONNU + ' - valeur : ' + %char(valeurStock(ART_CONNU)));
dsply (ART_INCONNU + ' - stock : ' + %char(stockArticle(ART_INCONNU)));

reponse = 'non';
if estDisponible(ART_CONNU : 35);
    reponse = 'oui';
endif;

dsply (ART_CONNU + ' - 35 disponibles : ' + reponse);
dsply ('Lectures ARTICLE : ' + %char(nbLectures));

*inlr = *on;
```
