---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: LECTURE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 83
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/LECTURE

```rpg
**FREE
// ============================================================================
// Programme : LECTURE
// Description : Programme débutant pour lire et afficher les noms des clients
//               depuis la table CLIENT en utilisant SQL
// Auteur : Formation RPG
// ============================================================================

// ============================================================================
// OPTIONS DE COMPILATION
// ============================================================================
// dftactgrp(*no)     : N'utilise pas le groupe d'activation par défaut
// actgrp(*caller)    : Utilise le groupe d'activation de l'appelant
// option(*srcstmt)   : Active les numéros de ligne pour le débogage
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt);

// ============================================================================
// DÉCLARATION DES VARIABLES
// ============================================================================
// NomClient : Variable qui va contenir le nom de chaque client
// varchar(50) : Type chaîne de caractères de longueur variable (max 50)
dcl-s NomClient varchar(50);

// ============================================================================
// PRÉPARATION DE LA REQUÊTE SQL
// ============================================================================
// Un curseur SQL fonctionne comme un pointeur sur les résultats d'une requête
// Il permet de parcourir les lignes une par une
// curClient : Nom que nous donnons à notre curseur
// select NOMCLI : On sélectionne uniquement la colonne nom du client
// from CLIENT : Dans la table CLIENT
exec sql declare curClient cursor for
  select NOMCLI
  from CLIENT;

// ============================================================================
// OUVERTURE DU CURSEUR
// ============================================================================
// L'ouverture du curseur exécute la requête SELECT
// Les résultats sont maintenant disponibles mais pas encore lus
exec sql open curClient;

// ============================================================================
// BOUCLE DE LECTURE DES DONNÉES
// ============================================================================
// dow = "Do While" = "Faire tant que"
// sqlcode = Code de retour SQL (0 = pas d'erreur, 100 = fin de fichier)
// sqlcode = 0 signifie : tant qu'il n'y a pas d'erreur
dow sqlcode = 0;

  // FETCH = Récupérer la ligne suivante du curseur
  // next = ligne suivante
  // into :NomClient = stocker le résultat dans la variable NomClient
  // Le ":" devant NomClient indique que c'est une variable du programme
  exec sql fetch next from curClient into :NomClient;

  // On vérifie que le FETCH a réussi avant d'afficher
  // Si sqlcode = 0 : la lecture est OK
  // Si sqlcode = 100 : on a atteint la fin du fichier (plus de lignes)
  if sqlcode = 0;

    // DSPLY = Afficher à l'écran
    // Affiche le nom du client récupéré
    dsply NomClient;

  endif;

// On retourne au début de la boucle pour lire la ligne suivante
enddo;

// ============================================================================
// FERMETURE DU CURSEUR
// ============================================================================
// Toujours fermer le curseur pour libérer les ressources
// C'est une bonne pratique de programmation
exec sql close curClient;

// ============================================================================
// FIN DU PROGRAMME
// ============================================================================
// *inlr (indicateur Last Record) = *on
// Termine le programme et libère toutes les ressources (fichiers, mémoire...)
*inlr = *on;
```
