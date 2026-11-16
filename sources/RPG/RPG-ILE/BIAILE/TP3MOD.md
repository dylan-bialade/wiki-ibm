---
bibliotheque: BIAILE
fichier_source: QRPGLESRC
membre: TP3MOD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 92
modifie: 2026-11-16
---

# BIAILE/QRPGLESRC/TP3MOD

```rpg
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
