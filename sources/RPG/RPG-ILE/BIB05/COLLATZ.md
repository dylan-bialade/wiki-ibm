---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: COLLATZ
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 80
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/COLLATZ

```rpg
**free
//------------------------------------------------------------------
// Programme : COLLATZ
// Objet     : Calcule la suite de Collatz (conjecture 3n+1) pour
//             un entier positif n et affiche chaque etape.
// Auteur    : Sylvain BIB02
//------------------------------------------------------------------

ctl-opt dftactgrp(*no) actgrp(*caller)
        option(*srcstmt:*nodebugio)
        main(Collatz);

//------------------------------------------------------------------
// Procedure principale (nom = nom du programme)
//------------------------------------------------------------------
dcl-proc Collatz;

  dcl-pi *n;
    pNombre packed(15:0) const;  // Nombre de depart
  end-pi;

  // Variables de travail
  dcl-s wValeur     packed(15:0);  // Valeur courante dans la suite
  dcl-s wEtapes     packed(10:0);  // Compteur d'etapes
  dcl-s wMax        packed(15:0);  // Altitude maximale atteinte
  dcl-s wMessage    char(52);      // Message DSPLY (52 max)

  // Validation du parametre d'entree
  if pNombre <= 0;
    dsply 'Le nombre doit etre strictement positif.';
    return;
  endif;

  // Initialisation
  wValeur = pNombre;
  wEtapes = 0;
  wMax    = pNombre;

  // Affichage du point de depart
  wMessage = 'Depart : ' + %char(wValeur);
  dsply wMessage;

  //----------------------------------------------------------------
  // Boucle principale : 3n+1 ou n/2 jusqu'a atteindre 1
  //----------------------------------------------------------------
  dow wValeur > 1;

    if %rem(wValeur:2) = 0;
      // Cas pair : on divise par 2
      wValeur = wValeur / 2;
    else;
      // Cas impair : on multiplie par 3 et on ajoute 1
      wValeur = (wValeur * 3) + 1;
    endif;

    // Incrementation et mise a jour de l'altitude max
    wEtapes += 1;
    if wValeur > wMax;
      wMax = wValeur;
    endif;

    // Affichage de l'etape courante
    wMessage = 'Etape ' + %char(wEtapes) + ' : ' + %char(wValeur);
    dsply wMessage;

  enddo;

  //----------------------------------------------------------------
  // Resume final
  //----------------------------------------------------------------
  wMessage = 'Termine en ' + %char(wEtapes) + ' etapes';
  dsply wMessage;

  wMessage = 'Altitude max : ' + %char(wMax);
  dsply wMessage;

  *inlr = *on;
  return;

end-proc;
```
