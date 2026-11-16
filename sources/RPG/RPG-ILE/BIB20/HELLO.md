---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: HELLO
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 28
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/HELLO

```rpg
**free


dcl-f clientex usage(*input) keyed;


dcl-pr client likeds(client_info);
                                          id zoned(4:0) const;

end-pr;


dcl-ds client_info likerec(clientf : *input);


  client_info = client(1);


  dsply client_info.nom;
                                          dsply client_info.prenom;

  dsply %subst(client_info.adresse:1:30);


  close clientex;


*inlr = *on;
```
