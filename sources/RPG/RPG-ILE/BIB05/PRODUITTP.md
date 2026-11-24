---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: PRODUITTP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 80
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/PRODUITTP

```rpg
**free
// ======================================================================
// Programme : LSTPRODUITS
// Objet     : Lire les noms de produits en SQL et les afficher (DSPLY)
// Auteur    : Sylvain BIB02                              Version : 1.0
// Société   : ORGFORM                                       Date   : 2025-11-05
// IBM i     : V7R5
// Base      : Table PRODUIT avec colonne NOMPRO
// Remarque  : Exemple simple dutilisation dun CURSOR SQL en RPG Free SQL
//             On ouvre un curseur, on FETCH en boucle jusquà fin ,
//             on affiche chaque nom puis on ferme le curseur.
//

ctl-opt copyright('(C) ORGFORM 2025.')
        dftactgrp(*no)               // Programme ILE (pas dans *DFTACTGRP)
        actgrp(*caller)              // Sexécute dans le groupe dactivation de lappelant
        datfmt(*iso) timfmt(*iso)    // Formats date/heure ISO
        option(*srcstmt:*nodebugio); // Numéros de lignes dans erreurs / I/O plus rapide

//**********************************************************************//
// Déclaration des variables (hôte)                                      //
//**********************************************************************//
dcl-s NomProduit char(30);             // Réceptacle du champ NOMPRO lu par le curseur

//**********************************************************************//
// Options SQL de session                                                //
//**********************************************************************//
exec sql
  set option commit = *none,           // Pas de gestion de transaction pour lexemple
             datfmt = *iso,
             timfmt = *iso,
             closqlcsr = *endmod;      // Fermer curseurs automatiquement à fin de module

//**********************************************************************//
// 1) Déclaration du curseur                                             //
//    - Un curseur est comme un "pointeur" de lecture sur un jeu de     //
//      résultats (ici : SELECT NOMPRO FROM PRODUIT WHERE CODPRO > 13 ).                  //
//**********************************************************************//
exec sql
  declare c1 cursor for
    select nompro
      from produit where codpro > 13;

//**********************************************************************//
// 2) Ouverture du curseur                                               //
//**********************************************************************//
exec sql open c1;

// Premier FETCH pour amorcer la boucle.
// Remarque : SQLCOD est une variable hôte fournie par le précompilateur.
//  - 0   = lecture OK
//  - 100 = fin des données (aucune ligne supplémentaire)
//  - >0  = erreur SQL
//  - <0  = Warning SQL
exec sql fetch c1 into :NomProduit;

//**********************************************************************//
// 3) Boucle de lecture                                                  //
//    Tant que SQLCOD = 0, on a bien lu une ligne.                       //
//**********************************************************************//
dow sqlcod = 0;

  // Ici on traite lenregistrement lu : on affiche le nom du produit.
  dsply NomProduit;

  // FETCH suivant
  exec sql fetch c1 into :NomProduit;

enddo;

//**********************************************************************//
// 4) Fermeture du curseur                                               //
//**********************************************************************//
exec sql close c1;

//**********************************************************************//
// Fin de programme                                                      //
//**********************************************************************//
*inlr = *on;
return;
```
