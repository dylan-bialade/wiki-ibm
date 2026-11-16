---
bibliotheque: BIB19
fichier_source: QRPGLESRC
membre: IDBGAGT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 43
modifie: 2026-11-16
---

# BIB19/QRPGLESRC/IDBGAGT

```rpg
**free
// ---------------------------------------------------------------------------
// IDBGAGT - point d'entree de l'agent pour les programmes CL de BIB19
//   mode INIT   : debut de session (evenement READY), sert Python
//   mode ENDPGM : le programme debogue a rendu la main (evenement ENDPGM)
//   mode ENDCMD : fin de la ligne de commande (INVPGM(*CMD))
//   mode END    : ENDIDBG (evenement END)
//   mode KILL   : fin forcee sans Python
// En retour : action decidee par Python (CALL, CMDLINE, RETURN, END...) et la
// commande a executer pour CALL.
// Licence MIT
// ---------------------------------------------------------------------------
ctl-opt main(main) option(*srcstmt: *nodebugio);

/copy IDBGSRVPR

dcl-proc main;
  dcl-pi *n;
    mode char(10);
    key char(16);
    data char(8192);
    action char(10);
    cmd char(3000);
  end-pi;
  idbgInit(key);
  if mode = 'KILL';
    idbgKill();
    action = 'END';
    return;
  endif;
  select;
    when mode = 'INIT';
      idbgEvent('READY': data: 8192);
    when mode = 'ENDPGM';
      idbgEvent('ENDPGM': data: 8192);
    when mode = 'ENDCMD';
      idbgEvent('ENDCMD': data: 8192);
    when mode = 'END';
      idbgEvent('END': data: 8192);
  endsl;
  action = idbgSession();
  cmd = idbgLastCmd();
end-proc;
```
