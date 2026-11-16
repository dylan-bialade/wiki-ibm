---
bibliotheque: BIB03
fichier_source: QRPGLESRC
membre: TP3MAIN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 19
modifie: 2026-11-16
---

# BIB03/QRPGLESRC/TP3MAIN

```rpg
**free
/copy QCPYSRC,TP3MODP

afficher(1);
afficher(2);
afficher(9);
*inlr = *on;

dcl-proc afficher;
    dcl-pi *n;
        num packed(5:0) const;
    end-pi;
    dcl-s msg char(50);

    msg = %char(num) + ' ' + nomClient(num);
    dsply msg;
    msg = '  Encours : ' + %char(encoursClient(num)) + ' - credit : ' + %char(creditDispo(num));
    dsply msg;
end-proc;
```
