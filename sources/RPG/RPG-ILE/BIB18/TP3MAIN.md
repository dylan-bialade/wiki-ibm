---
bibliotheque: BIB18
fichier_source: QRPGLESRC
membre: TP3MAIN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 31
modifie: 2026-11-16
---

# BIB18/QRPGLESRC/TP3MAIN

```rpg
**free
ctl-opt option(*srcstmt : *nodebugio);

/copy QCPYSRC,TP3MODP

dcl-s num packed(5 : 0);

for-each num in %list(1 : 2 : 3);
    afficher(num);
endfor;

*inlr = *on;

dcl-proc afficher;
    dcl-pi *n ;
        num packed(5:0) const;
    end-pi;

    dcl-s montant packed(9:2) const inz(500.00);
    dcl-s msg varchar(8);

    if peutCommander(num:montant) = *on;
        msg = 'acceptee';
    else;
        msg = 'refusee';
    endif;

    dsply (nomClient(num) + villeClient(num));
    // dsply (%char(encoursClient(num)) + %char(creditDispo(num)));
    dsply ('Commande de' + %char(montant) + msg);
end-proc;
```
