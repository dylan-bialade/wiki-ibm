---
bibliotheque: BIB13
fichier_source: QRPGLESRC
membre: TP02MAIN
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 55
modifie: 2026-11-16
---

# BIB13/QRPGLESRC/TP02MAIN

```rpg
**free

ctl-opt copyright('Copyright (c) 2026, BIB10 Xuân-Lâm');





/copy qcpysrc,tp02modp

dcl-s code char(6) inz('A00003');

dcl-s nbLecture int(10) import;



dsply ('Article: ' + code);

dsply ('stock: ' +%char(stockArticle(code)));

dsply ('VAleure: ' + %editw(valeurStock(code):'   &   & 0 ,  &€'));





dsply ('Article: A00009');

dsply ('stock: '+%char(stockArticle('A00009')));



dsply ('A00003 - 35 dispo: ');

if estDisponible(code:35);

  dsply 'Oui';

else;

  dsply 'Non';

endif;



dsply ('NbLecture: '+%char(nbLecture));





*inlr=*on;

// traitement articles
```
