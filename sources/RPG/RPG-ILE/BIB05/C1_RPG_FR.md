---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: C1_RPG_FR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 86
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/C1_RPG_FR

```rpg
**free
// ============================================================================
// Programme : C1_RPG_FR
// Description : Programme de démonstration RPG Free illustrant :
//               - Utilisation de fichier keyed avec préfixe
//               - Appel de procédure interne (modulo)
//               - Appel de modules externes (C et CL)
//               - Affichage de données avec DSPLY
// ============================================================================

// Options de compilation
ctl-opt option(*nodebugio:*srcstmt);  // Désactive debug I/O, active stmt source

// ============================================================================
// DECLARATION DES FICHIERS
// ============================================================================

// Fichier PRODUIT en mode lecture avec accès par clé
// prefix(PRD_) : Tous les champs seront préfixés par PRD_
dcl-f PRODUIT usage(*input) keyed prefix(PRD_);

// ============================================================================
// DECLARATION DES PROTOTYPES DE PROCEDURES
// ============================================================================

// Procédure locale : Calcule le modulo (reste de division)
// Paramètres : num1 (dividende), num2 (diviseur)
// Retourne : Le reste de la division entière
dcl-pr modulo zoned(5:0);
  num1 zoned(5:0);
  num2 zoned(5:0);
end-pr;

// Procédure externe (module C) : Affiche "Hello World"
dcl-pr helloworld EXTPROC('HELLOWORLD');
END-PR;

// Procédure externe (module CL) : Ajoute une bibliothèque
dcl-pr addlib EXTPROC('ADDLIB');
END-PR;

// ============================================================================
// DECLARATION DES VARIABLES
// ============================================================================

dcl-s resultat zoned(5:0);              // Stocke le résultat du modulo
dcl-s nombre1 zoned(5:0) inz(27);       // Premier nombre (dividende)
dcl-s nombre2 zoned(5:0) inz(10);       // Second nombre (diviseur)
dcl-s res char(5);                      // Variable de réponse pour DSPLY

// ============================================================================
// TRAITEMENT PRINCIPAL
// ============================================================================

// Calcul du modulo : 27 % 10 = 7
resultat = modulo(nombre1:nombre2);

// Affichage du résultat du modulo
dsply %char(resultat) ' ' res;

// Lecture du premier enregistrement du fichier PRODUIT
read PRODUIT;

// Affichage du nom du produit (avant appel des modules externes)
dsply PRD_NOMPRO ' ' res;

// ============================================================================
// APPELS DE MODULES EXTERNES
// ============================================================================

// Appel du module C pour afficher "Hello World"
helloworld();

// Appel du module CL pour ajouter une bibliothèque à la liste
addlib();

// Affichage du nom du produit (après appel des modules externes)
// Permet de vérifier si le contexte a changé
dsply PRD_NOMPRO ' ' res;

// ============================================================================
// FIN DU PROGRAMME
// ============================================================================

// Active l'indicateur Last Record pour terminer le programme
*inlr = *on;
```
