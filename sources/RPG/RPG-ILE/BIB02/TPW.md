---
bibliotheque: BIB02
fichier_source: QRPGLESRC2
membre: TPW
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 47
modifie: 2026-11-16
---

# BIB02/QRPGLESRC2/TPW

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

// Déclaration des variables pour stocker les données dun produit
dcl-s title     char(50) ;        // Titre du produit


exec sql set option commit = *none;

// Déclaration dun curseur SQL nommé c1
// Ce curseur récupère les données JSON de lAPI https://fakestoreapi.com/products
// et les transforme en tableau SQL grâce à JSON_TABLE
exec sql
    declare c1 cursor for
    select  title
    from JSON_TABLE(
        QSYS2.HTTP_GET('https://fakestoreapi.com/products',
        '{"header":"Content-Type,application/json;charset=utf-8;"}'), // Appel API
        '$[*]' COLUMNS (

            title CHAR(50) PATH '$.title'          // Extrait le titre

        )
    );

// Ouverture du curseur pour commencer la lecture des données
exec sql open c1;

// Boucle : tant que SQLCODE = 0, on continue à lire ligne par ligne
dow sqlcode = 0;

    // Lecture dune ligne et insertion dans les variables :id, :title, :price, :category
    exec sql fetch c1 into  :title;

    // Si je trouve des données
    if sqlcode = 0;

        // Affichage du titre du produit
        dsply title;
    endif;
enddo;

// Fermeture du curseur une fois toutes les lignes lues
exec sql close c1;

// Fin du programme
*inlr = *on;
```
