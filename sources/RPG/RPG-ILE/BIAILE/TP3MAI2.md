---
bibliotheque: BIAILE
fichier_source: QRPGLESRC
membre: TP3MAI2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 25
modifie: 2026-11-16
---

# BIAILE/QRPGLESRC/TP3MAI2

```rpg
**free
/copy QCPYSRC,TP3MODP

afficherV2(1);
afficherV2(2);
afficherV2(3);
*inlr = *on;

dcl-proc afficherV2;
    dcl-pi *n;
        num packed(5:0) const;
    end-pi;
    dcl-s msg char(50);
    dcl-s commande packed(9:2) inz(500.00);

    msg = %char(num) + ' ' + nomClient(num) + ' - ' + villeClient(num);
    dsply msg;

    if peutCommander(num : commande);
        msg = '  Commande de 500.00 : acceptee';
    else;
        msg = '  Commande de 500.00 : refusee';
    endif;
    dsply msg;
end-proc;
```
