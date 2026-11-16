---
bibliotheque: BIB13
fichier_source: QRPGLESRC
membre: TP03MOD
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 163
modifie: 2026-11-16
---

# BIB13/QRPGLESRC/TP03MOD

```rpg
**free

ctl-opt nomain option(*srcstmt:*nodebugio);

exec sql set option commit=*none;



/include QCPYSRC,TP03MODP



dcl-ds client;

  clnum packed(5:0);

  clnom varchar(30);

  clville varchar(20);

  clplaf packed(9:2);

  clenc packed(9:2);

end-ds;



dcl-proc lireClient;

  dcl-pi *n ind;

    num packed(5:0) const;

  end-pi;

  exec sql select clnum,clnom,clville,clplaf,clenc  into :client from BIB13.client where clnum = :num;

  if sqlcode = 0;

    return *on;

  endif;

  return *off;

end-proc;



dcl-proc nomClient export;

  dcl-pi *n varchar(30);

    num packed(5:0) const;

  end-pi;



  if lireClient(num);

    return clnom;

  endif;

  return 'Client inconnu';

end-proc;



dcl-proc encoursClient export;

  dcl-pi *n packed(9:2);

    num packed(5:0) const;

  end-pi;



  if lireClient(num);

    return clenc;

  endif;

  return -1;



end-proc;



dcl-proc creditDispo export;

  dcl-pi *n packed(9:2);

    num packed(5:0) const;

  end-pi;



  if lireClient(num);

    return clplaf-clenc;

  endif;

  return 0;

end-proc;



dcl-proc peutCommander export;

  dcl-pi *n ind;

    num packed(5:0)const;

    montant packed(9:2) const;

  end-pi;



  if lireClient(num);

  return (montant< creditDispo(num));

  endif;

  return *off;



end-proc;



dcl-proc villeClient export;

  dcl-pi *n varchar(20);

  num packed(5:0) const;

  end-pi;

  if lireClient(num);

  return clville;

  endif;

  return'Ville inconnue';



end-proc;
```
