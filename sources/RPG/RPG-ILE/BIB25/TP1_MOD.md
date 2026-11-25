---
bibliotheque: BIB25
fichier_source: QILESRC
membre: TP1_MOD
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 42
modifie: 2026-11-25
---

# BIB25/QILESRC/TP1_MOD

```rpg
**free
// Pas de point d'entrée principal dans le module
// Ce module sera utilisé uniquement en tant que composant d'autres
// programmes de services.
CTL-OPT NOMAIN;

DCL-F CLIENTS DISK(*EXT) USAGE(*INPUT)
              RENAME(CLIENTS:FCLIENTS)
              USROPN;

DCL-DS DSClients QUALIFIED;
  id int(10);
  nom varchar(50);
  prenom varchar(50);
  age packed(2:0);
  email varchar(100);
END-DS;


// Procédure récupération informations clients
DCL-PROC ReturnInfoClients EXPORT;
  DCL-PI *N LIKEDS(DSClients);
     id int(10) CONST;
  END-PI;

  DCL-DS resultat LIKEDS(DSClients);
  IF NOT %OPEN(CLIENTS);
    OPEN CLIENTS;
  ENDIF;

  CHAIN id FCLIENTS;
  resultat.id = id;
  resultat.nom = nom;
  resultat.prenom = prenom;
  resultat.age = age;
  resultat.email = email;

  CLOSE CLIENTS;

  return resultat;

END-PROC;
```
