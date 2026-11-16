---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: HELLOMODUL
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 23
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/HELLOMODUL

```rpg
**free

ctl-opt nomain;
dcl-f clientex usage(*input) keyed;

dcl-proc client export;
  dcl-pi *n likeds(client_info);
    id zoned(4:0) const;
  END-PI;

  dcl-ds client_info likerec(clientf : *input);

  if not %open(clientex);
    open clientex;
  endif;

  chain id clientex client_info;

  close clientex;

  return client_info;

END-PROC;
```
