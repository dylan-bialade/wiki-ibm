---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: DSPOINTER
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 137
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/DSPOINTER

```rpg
**FREE
//**************************************************************
// Nom      : DSPOINTER.RPGLE
// Auteur   : Sylvain BIB02
// Objet    : Exemple de manipulation de structures avec pointeurs
//            et allocation dynamique via %alloc sur IBM i
// Description :
//    - Ce programme démontre comment gérer des structures
//      contenant des pointeurs sans perdre les données.
//    - La technique consiste à stocker non pas des structures,
//      mais des pointeurs vers des structures allouées dynamiquement.
//**************************************************************

ctl-opt dftactgrp(*no) actgrp(*caller)
        option(*nodebugio:*srcstmt)
        timfmt(*iso) datfmt(*iso);

//--------------------------------------------------------------
// Déclaration du modèle de structure (template)
//--------------------------------------------------------------
// Structure contenant une chaîne de caractères et un pointeur.
// Ce modèle sert à allouer dynamiquement des zones mémoire
// qui seront manipulées via des pointeurs.
dcl-ds TOTO_TEMPL template;
  val_char char(20);     // Valeur textuelle
  val_ptr  pointer;      // Pointeur vers une autre zone mémoire
end-ds;

//--------------------------------------------------------------
// Structure basée : permet d'accéder à la mémoire pointée par p_toto
//--------------------------------------------------------------
dcl-ds TOTO based(p_toto) likeds(TOTO_TEMPL);

//--------------------------------------------------------------
// Tableau de pointeurs : chaque case pointera vers une
// structure TOTO_TEMPL allouée dynamiquement.
//--------------------------------------------------------------
dcl-s TOTO_LIST pointer dim(100);

//--------------------------------------------------------------
// Variables de travail
//--------------------------------------------------------------
dcl-s i int(10);
dcl-s p_toto pointer;            // Pointeur temporaire pour chaque TOTO
dcl-s val_ptr_str char(100) based(p_val_ptr); // Lecture dune zone mémoire pointée
dcl-s p_val_ptr pointer;

//--------------------------------------------------------------
// BOUCLE D'INITIALISATION
// On crée 100 structures dynamiques distinctes,
// on les remplit, puis on stocke leur adresse dans le tableau.
//--------------------------------------------------------------
for i = 1 to 100;

  // Allocation dynamique d'une structure TOTO
  p_toto = %alloc(%size(TOTO_TEMPL)); // on réserve de la mémoire

  // On initialise la structure pointée (sécurité mémoire)
  TOTO = *allx'00'; // Remplit toute la structure de zéros

  // Remplissage de la zone allouée
  TOTO.val_char = 'valeur_' + %char(i);
  TOTO.val_ptr  = get_pointer(i); // Stocke un pointeur vers une autre zone mémoire

  // On stocke le pointeur dans le tableau
  TOTO_LIST(i) = p_toto;

endfor;

//--------------------------------------------------------------
// BOUCLE DE LECTURE
// On affiche les 5 premières entrées pour vérifier que
// les valeurs sont bien conservées et isolées.
//--------------------------------------------------------------
for i = 1 to 5;

  p_toto = TOTO_LIST(i); // On récupère le pointeur

  if p_toto <> *null;

    // Grâce à la structure basée, TOTO accède maintenant à la mémoire pointée
    // par p_toto. On peut lire directement val_char et val_ptr.
    dsply ('val_char : ' + TOTO.val_char);

    // On vérifie que le pointeur est valide avant de lutiliser
    if TOTO.val_ptr <> *null;

      p_val_ptr = TOTO.val_ptr; // On lit ladresse
      dsply ('val_ptr : ' + %subst(val_ptr_str:1:42)); // Affichage partiel pour respecter la limite

    else;

      dsply ('val_ptr : *NULL');

    endif;

  else;

    dsply ('p_toto : *NULL');

  endif;

endfor;

//--------------------------------------------------------------
// Fin du programme
//--------------------------------------------------------------
*inlr = *on;
return;

//--------------------------------------------------------------
// PROCÉDURE GET_POINTER
// Retourne un pointeur vers une zone mémoire contenant
// un message dynamique basé sur un index donné.
//--------------------------------------------------------------
dcl-proc get_pointer;

  dcl-pi *n pointer;
    idx int(10); // Index utilisé pour générer un texte
  end-pi;

  dcl-s buffer char(100);       // Contenu à stocker
  dcl-s p pointer;              // Pointeur vers mémoire allouée
  dcl-s p_buf char(100) based(p); // Zone basée sur le pointeur

  buffer = 'Texte dyn. pour index ' + %char(idx);

  // Pour éviter tout débordement mémoire,
  // on alloue toujours la taille maximale du buffer
  p = %alloc(%size(buffer));

  // On écrit dans la mémoire pointée
  p_buf = buffer;

  return p;

end-proc;
```
