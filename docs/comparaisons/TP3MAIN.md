# TP3MAIN : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB03 | QRPGLESRC | RPG/RPG-ILE | 19 | 100 % | full free, procedures (dcl-proc), prototypes (dcl-pr) | [TP3MAIN.md](../../sources/RPG/RPG-ILE/BIB03/TP3MAIN.md) |
| BIB18 | QRPGLESRC | RPG/RPG-ILE | 31 | 18 % | full free, boucle DOW/DOU/FOR, procedures (dcl-proc), prototypes (dcl-pr) | [TP3MAIN.md](../../sources/RPG/RPG-ILE/BIB18/TP3MAIN.md) |

## Differences

- Techniques communes : full free, procedures (dcl-proc), prototypes (dcl-pr)
- **BIB18** en propre : boucle DOW/DOU/FOR

## Codes

### BIB03 (RPG/RPG-ILE, 19 lignes)

```text
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

### BIB18 (RPG/RPG-ILE, 31 lignes)

```text
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
