---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: C2_SQLRPG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 41
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/C2_SQLRPG

```rpg
**free
CTL-OPT COPYRIGHT('(C) ORGFORM 2025.')
OPTION(*SRCSTMT) DFTACTGRP(*NO)
ACTGRP(*CALLER) DATFMT(*ISO);

//*****************************************************************
// Programme : C1_SQLRPG
// Formation SQL dans RPGLE
// Copyright - ORGFORM
//*****************************************************************

dcl-s nom char(20);      // Variable pour stocker le nom du client
dcl-s prenom char(20);   // Variable pour stocker le prénom du client

//**********************************************************************
// Traitement principal
//**********************************************************************

EXEC SQL
SET OPTION COMMIT = *NONE, DATFMT = *ISO;



// Requête SQL embarquée : on récupère les colonnes nomcli et precli de la table CLIENT
// pour le client ayant le numéro 2, et on les met dans les variables RPG nom et prenom
// Le préfixe ":" signifie qu'on utilise une variable RPG
EXEC SQL
  SELECT nomcli, precli
    INTO :nom, :prenom
    FROM client
   WHERE numcli = 2;


if sqlcode = 0;
  // Vérifie que la requête s'est bien déroulée (SQLCODE = 0 signifie succès)

  dsply nom;       // Affiche le nom du client
  dsply prenom;    // Affiche le prénom du client
endif;

*INLR = *ON;        // Marque la fin du programme et libère les ressources
```
