# TP3MOD : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB03 | QRPGLESRC | RPG/RPG-ILE | 92 | 25 % | full free, SQL embarque, procedures (dcl-proc), prototypes (dcl-pr) | [TP3MOD.md](../../sources/RPG/RPG-ILE/BIB03/TP3MOD.md) |
| BIB18 | QRPGLESRC | RPG/RPG-ILE | 97 | 100 % | full free, SQL embarque, procedures (dcl-proc), prototypes (dcl-pr), structure de donnees | [TP3MOD.md](../../sources/RPG/RPG-ILE/BIB18/TP3MOD.md) |

## Differences

- Techniques communes : full free, SQL embarque, procedures (dcl-proc), prototypes (dcl-pr)
- **BIB18** en propre : structure de donnees

## Codes

### BIB03 (RPG/RPG-ILE, 92 lignes)

```text
**free
ctl-opt nomain;

/include QCPYSRC,TP3MODP

dcl-s w_nom char(30);
dcl-s w_ville char(20);
dcl-s w_plafond packed(9:2);
dcl-s w_encours packed(9:2);

dcl-proc lireClient;                    // interne : pas de "export"
    dcl-pi *n ind;
        num packed(5:0) const;
    end-pi;

    w_nom = '';
    w_ville = '';
    w_plafond = 0;
    w_encours = 0;

    exec sql
        select CLNOM, CLVILLE, CLPLAF, CLENC
        into :w_nom, :w_ville, :w_plafond, :w_encours
        from CLIENT
        where CLNUM = :num;

    if sqlcode = 0;
        return *on;
    else;
        return *off;
    endif;
end-proc;

dcl-proc nomClient export;
    dcl-pi *n varchar(30);
        num packed(5:0) const;
    end-pi;
    if lireClient(num);
        return %trim(w_nom);
    else;
        return 'Client inconnu';
    endif;
end-proc;

dcl-proc encoursClient export;
    dcl-pi *n packed(9:2);
        num packed(5:0) const;
    end-pi;
    if lireClient(num);
        return w_encours;
    else;
        return -1;
    endif;
end-proc;

dcl-proc creditDispo export;
    dcl-pi *n packed(9:2);
        num packed(5:0) const;
    end-pi;
    if lireClient(num);
        return w_plafond - w_encours;
    else;
        return 0;
    endif;
end-proc;

dcl-proc peutCommander export;          // NOUVEAU (ex. 2)
    dcl-pi *n ind;
        num packed(5:0) const;
        montant packed(9:2) const;
    end-pi;
    if lireClient(num);
        if montant <= (w_plafond - w_encours);   // le montant rentre dans le crédit dispo
            return *on;
        else;
            return *off;
        endif;
    else;
        return *off;                    // client inconnu : refusé
    endif;
end-proc;

dcl-proc villeClient export;            // NOUVEAU (ex. 2)
    dcl-pi *n varchar(20);
        num packed(5:0) const;
    end-pi;
    if lireClient(num);
        return %trim(w_ville);
    else;
        return 'Ville inconnue';
    endif;
end-proc;
```

### BIB18 (RPG/RPG-ILE, 97 lignes)

```text
**free
ctl-opt nomain option(*srcstmt);

/include QCPYSRC,TP3MODP

exec sql set option commit = *none;

dcl-ds cli qualified;
    num     packed(5:0);
    nom     char(30);
    ville   char(20);
    plafond packed(9:2);
    encours packed(9:2);
end-ds;

//on si le client existe ; charge nom, ville, plafond et encours
// dans des zones globales du module
dcl-proc lireClient;
    dcl-pi *n ind;
        num packed(5:0) const;
    end-pi;

    clear cli;

    exec sql select * into :cli from BIB18.CLIENT where CLNUM = :num;

    return sqlcode = 0;
end-proc;

//retour le nom, ou Client inconnu
dcl-proc nomClient export;
    dcl-pi *n varchar(30);
        num packed(5:0) const;
    end-pi;

    if not lireClient(num);
        return 'Client inconnu';
    endif;

    return cli.nom;
end-proc;

//retour l'encours, ou -1 si inconnu
dcl-proc encoursClient export;
    dcl-pi *n packed(9:2);
        num packed(5:0) const;
    end-pi;

    if not lireClient(num);
        return -1;
    endif;

    return cli.encours;

end-proc;

//retour plafond - encours, ou 0 si inconnu
dcl-proc creditDispo export;
    dcl-pi *n packed(9:2);
        num packed(5:0) const;
    end-pi;

    if not lireClient(num);
        return 0;
    endif;

    return cli.plafond - cli.encours;
end-proc;


dcl-proc peutCommander export;
    dcl-pi *n ind;
        num packed(5:0) const;
        montant packed(9:2) const;
    end-pi;

    dcl-s credDisp packed(9:2);
    credDisp = creditDispo(num);


    return montant <= credDisp ;

end-proc;


dcl-proc villeClient export;
    dcl-pi *n  varchar(20);
        num packed(5:0) const;
    end-pi;

    if not lireClient(num);
        return 'Ville inconnue';
    endif;

    return cli.ville;

end-proc;
```
