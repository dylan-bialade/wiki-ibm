---
bibliotheque: BIB18
fichier_source: QRPGLESRC
membre: TP3MOD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 97
modifie: 2026-11-16
---

# BIB18/QRPGLESRC/TP3MOD

```rpg
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
