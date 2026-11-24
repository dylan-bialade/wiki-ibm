---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: C1_RPG_SFQ
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 313
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/C1_RPG_SFQ

```rpg
**FREE
CTL-OPT copyright('(C) ORGFORM 2025.') dftactgrp(*no) actgrp(*caller)
option(*nodebugio:*srcstmt) datfmt(*iso) timfmt(*iso) ;

// **********************************************************************//
// Déclaration des fichiers                                              //
// **********************************************************************//
DCL-F SFDSPF WORKSTN SFILE(SFL1:RANG);

// **********************************************************************//
// Déclaration des variables                                             //
// **********************************************************************//
dcl-s RANG zoned(4:0) inz(*zero);
dcl-s datejour  date(*iso) inz(*job);

//**********************************************************************//
// Déclaration des constantes                                           //
//**********************************************************************//
dcl-c AFFICHER  const('5');
dcl-c SUPPRIMER const('4');
dcl-c MODIFIER  const('2');
dcl-c SFLMAX 9999;


// Compilateur SQL
EXEC SQL
  SET option commit = *none , alwcpydta = *optimize, closqlcsr = *endmod,
  Datfmt = *iso, Timfmt = *iso;

// **********************************************************************//
// Traitement pricipal                                                   //
// **********************************************************************//
// Début de mon programme
init_sous_fichier();  // Réinitialise le sous-fichier (compteur à zéro, vidage des données).
fab_sous_fichier();   // Remplit le sous-fichier avec les données issues de la base SQL.
scodpro = *zero;

// Boucle principale : Gestion des interactions utilisateur
Dou *IN03;  // Sortie de la boucle si l'utilisateur appuie sur la touche F3 (IN03 activé).

  write fkey1;        // Affiche les touches de fonction disponibles sur l'écran.
  Exfmt Sf1ctl;       // Affiche le format de contrôle associé au sous-fichier.

  // Gestion des différentes actions en fonction des touches appuyées
  select;

  when scodpro <> *zero;
    exec sql close c1;
    init_sous_fichier();     // Réinitialisation complète du sous-fichier.
    fab_sous_fichier();      // Rechargement des données dans le sous-fichier.
    clear Scodpro;

  // Cas où l'utilisateur appuie sur F5 - Réafficher
  when *in05;
    exec sql close c1;       // Fermeture du curseur SQL actif pour libérer les ressources.
    init_sous_fichier();     // Réinitialisation complète du sous-fichier.
    fab_sous_fichier();      // Rechargement des données dans le sous-fichier.

  // Cas où l'utilisateur appuie sur F6 - Création
  when *in06;
    creation();              // Exécute la fonction `creation`.
    exec sql close c1;       // Ferme le curseur SQL actif après la création.
    init_sous_fichier();     // Réinitialisation du sous-fichier pour refléter les nouvelles données
    fab_sous_fichier();      // Remplit le sous-fichier avec les données mises à jour.

  // Cas par défaut : lecture et traitement d'un enregistrement spécifique
  other;
    exec sql
      SELECT codpro INTO :e1codpro FROM produit;
    // Sélectionne un enregistrement particulier en fonction des critères (par exemple, codpro).

    if sqlcode <> 100;       // Si l'enregistrement existe (pas de fin de fichier SQL).
      trt_readc();           // Appelle une procédure pour traiter l'enregistrement sélectionné.
    endif;

    exec sql close c1;       // Ferme le curseur SQL actif après le traitement.
    init_sous_fichier();     // Réinitialisation du sous-fichier pour refléter les changements.
    fab_sous_fichier();      // Recharge le sous-fichier avec les nouvelles données.

  endsl;  // Fin du bloc `select`.

Enddo;    // Fin de la boucle principale (retourne à l'attente des actions utilisateur).

// Fermeture finale des ressources SQL et fin du programme
exec sql close c1;   // Assure la fermeture propre du curseur SQL avant de terminer.
*Inlr = *On;         // Marque le programme comme terminé et libère les ressources.


// **********************************************************************//
// PROCÉDURE                                                             //
// **********************************************************************//

// Initisalisation sous fichier
dcl-proc init_sous_fichier;
  RANG = *Zero;   // Initialisat° du compteur d'enregistrement.
  *In31 = *On;    // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
  Write Sf1ctl;   // Vidage du sous-fichier
  *In31 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
  *In32 = *Off;   // Désactivation de l'indic lié au mot-clé SFLDSP pour indiquer que le sous-fichie
  *In90 = *Off;   // Réinitialisat° de l'indic lié au mot-clé SFLEND pour ne pas afficher la mention

  // Déclaration d'un curseur SQL (C1) pour lire les données de la table PRODUIT
  // Les données sont triées par le champ codpro (Code produit).
  EXEC SQL
      Declare C1 CURSOR FOR
      (select codpro, nompro, qtpro, dtdinv  -- Sélection des champs : code produit, nom produit, qu
       from produit                          -- Table: PRODUIT.
       order by codpro)                      -- Tri des résultats par code produit.
      FOR READ ONLY OPTIMIZE FOR 12 ROWS;    -- Le curseur est en lecture seule pour lire 12 lignes

  EXEC SQL
      open C1;  // Ouverture du curseur SQL pour préparer la lecture des données.
end-proc;


// fabrication de sous fichier
dcl-proc fab_sous_fichier;
  // B- Tant que non fin de fichier
  Dow (Not (sqlcode = 100)) And (RANG <= SFLMAX);
    // TQ Non Fin de Fichier et limite de 9999 lignes
    EXEC SQL Fetch C1 into :e1codpro, :e1nmpro, :e1qtpro, :e1dtdinv;
    IF sqlcode = 100;
      *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
      leave;
    ENDIF;
    if e1codpro >= scodpro;
      RANG += 1;  // Incrémentation du compteur de ligne
      Write Sfl1;       // Ecriture du format de sous-fichier
    endif;

    IF sqlcode = 100 or rang = sflmax; // Fin de fichier ou limite atteint ?
      *in32 = *on;   // "Fin" en bas à droite de l'écran et on sort.
      LEAVE;
    ENDIF;
  Enddo;

  // C -Cas particulier (aucun enregistrement)
  If RANG = *Zero;  // Si aucun enregistement à charger
    *In32 = *On;    // Indicateur de non affichage du SFL (Associé au mot clé SFLDSP)
  else;
    rang = 1;
  Endif;
end-proc;


//******************************************************************
// Procédure `TRT_READC` : Traitement des entrées utilisateur dans le sous-fichier
// Cette procédure traite les lignes sélectionnées dans le sous-fichier grâce à la commande READC.
//******************************************************************
dcl-proc TRT_READC;

  Readc SFL1; // Lecture conditionnelle de la première ligne modifiée ou sélectionnée du sous-fichie
  dow not %eof; // Boucle tant que la fin du sous-fichier (EOF) n'est pas atteinte.

    select;
    // Cas où l'utilisateur a sélectionné l'option '5' "AFFICHER"
    when opt = AFFICHER;
      affiche(); // Appelle la procédure `affiche` pour afficher les détails de l'enregistrement.

    // Cas où l'utilisateur a sélectionné l'option '4'  "SUPPRIMER"
    when opt = SUPPRIMER;
      suppression(); // Appelle la procédure `suppression` pour supprimer l'enregistrement sélection

    // Cas où l'utilisateur a sélectionné l'option '2' "MODIFIER"
    when opt = MODIFIER;
      modification(); // Appelle la procédure `modification` pour modifier l'enregistrement sélectio
    endsl; // Fin de la structure `select`.

    Readc SFL1; // Lecture de la prochaine ligne modifiée ou sélectionnée du sous-fichier.
  ENDDO; // Fin de la boucle lorsque toutes les lignes sélectionnées ont été traitées.

end-proc;


//******************************************************************
// Procédure `creation` : Gestion de la création d'un nouvel enregistrement
// Cette procédure permet à l'utilisateur d'ajouter un nouvel enregistrement dans la table PRODUIT.
//******************************************************************
dcl-proc creation;

  dou *in03; // Boucle principale pour gérer la saisie utilisateur, sortie si F3 est appuyé.

    e6dtdinv = datejour; // Initialise la date d'inventaire avec la date du jour.

    exfmt FMT6; // Affiche le format d'écran FMT6 pour permettre la saisie des informations par l'ut

    // Gestion des actions utilisateur en fonction des touches de fonction appuyées
    select;

    // Cas où l'utilisateur appuie sur F3 (annulation de la création)
    when *in03;
      iter; // Recommence la boucle sans rien faire (revient à l'affichage de FMT6).

    // Cas où l'utilisateur appuie sur F12 (annuler et quitter)
    when *in12;
      leave; // Sort de la boucle et termine la procédure sans créer d'enregistrement.

    // Cas où l'utilisateur appuie sur F23 (valider et insérer les données)
    when *in23;
      // Exécution de l'instruction SQL pour insérer un nouvel enregistrement dans la table PRODUIT.
      exec sql
        INSERT INTO produit (codpro, nompro, qtpro, dtdinv)
        VALUES (:e6codpro, :e6nmpro, :e6qtpro, :datejour);

      leave; // Sort de la boucle après avoir inséré les données.
    endsl; // Fin de la structure `select`.

  enddo; // Fin de la boucle principale après validation ou annulation.

  clear opt; // Réinitialise la variable `opt`.

end-proc;


//******************************************************************
// Procédure `affiche` : Affichage des détails d'un enregistrement
// Cette procédure récupère et affiche les informations d'un produit spécifique.
//******************************************************************
dcl-proc affiche;

  // Exécution d'une requête SQL pour récupérer les informations du produit
  exec sql
    SELECT codpro, nompro, qtpro, dtdinv  -- Colonnes à récupérer : code produit, nom produit, quant
    INTO :e5codpro, :e5nmpro, :e5qtpro, :e5dtdinv -- Variables dans lesquelles les données seront st
    FROM produit                              -- Table : PRODUIT
    WHERE codpro = :e1codpro;                 -- Critère de recherche : code produit spécifié (e1cod

  exfmt FMT5; // Affiche les informations récupérées dans le format d'écran FMT5.

  clear opt; // Réinitialise la variable `opt`.

end-proc;


//******************************************************************
// Procédure `modification` : Modification des détails d'un enregistrement
// Cette procédure permet à l'utilisateur de modifier les informations d'un produit existant.
//******************************************************************
dcl-proc modification;

  // Exécution d'une requête SQL pour récupérer les informations du produit à modifier
  exec sql
    select codpro, nompro, qtpro, dtdinv          -- Colonnes à récup : code produit, nom produit, q
    INTO :e2codpro, :e2nmpro, :e2qtpro, :e2dtdinv -- Variables (ici l'ecran) dans lesquelles les don
    FROM produit                                  -- Table : PRODUIT
    WHERE codpro = :e1codpro;                     -- Critère de recherche : code produit spécifié (e

  // Boucle principale pour gérer la modification
  dou *in03; // Sortie de la boucle si F3 est appuyé (annulation de la modification).

    exfmt FMT2; // Affiche le format d'écran FMT2 pour permettre la modification des données.

    // Gestion des actions utilisateur en fonction des touches appuyées
    select;

    // Cas où l'utilisateur appuie sur F3 (annulation sans sauvegarde)
    when *in03;
      iter; // Ignore les changements et quitte le programme.

    // Cas où l'utilisateur appuie sur F12 (annuler)
    when *in12;
      leave; // Sort de la boucle sans sauvegarder les modifications.

    // Cas où l'utilisateur appuie sur F23 (valider et sauvegarder les modifications)
    when *in23;
      // Exécution d'une requête SQL pour mettre à jour les informations du produit
      exec sql
        UPDATE produit
        SET codpro = :e2codpro,                 -- Mise à jour du code produit
            nompro = :e2nmpro,                  -- Mise à jour du nom du produit
            qtpro = :e2qtpro,                   -- Mise à jour de la quantité
            dtdinv = :E2DTDinV                  -- Mise à jour de la date d'inventaire
        WHERE codpro = :e2codpro;               -- Critère de mise à jour : code produit.

      leave; // Quitte la boucle après la mise à jour réussie.
    endsl; // Fin de la structure `select`.

  enddo; // Fin de la boucle principale.

  clear opt; // Réinitialise la variable `opt`.

  update SFL1; // Met à jour la ligne correspondante dans le sous-fichier pour refléter les changeme

end-proc;


//******************************************************************
// Procédure `suppression` : Suppression d'un enregistrement
// Cette procédure permet à l'utilisateur de supprimer un produit de la table PRODUIT.
//******************************************************************
dcl-proc suppression;

  // Exécution d'une requête SQL pour récupérer les informations du produit à supprimer
  exec sql
    SELECT codpro, nompro, qtpro, dtdinv          // Colonnes à récup: code produit, nom produit, qu
    INTO :e4codpro, :e4nmpro, :e4qtpro, :e4dtdinv // Variables où les données sont stockées
    FROM produit                                  // Table : PRODUIT
    WHERE codpro = :e1codpro;                     // Critère de recherche : code produit spécifié (e

  exfmt FMT4; // Affiche le format d'écran FMT4.

  clear opt; // Réinitialise la variable `opt`.

  // Vérification si l'utilisateur valide la suppression en appuyant sur F23
  if *in23;
    // Exécution d'une requête SQL pour supprimer le produit de la table PRODUIT
    exec sql
      delete from produit where codpro = :e4codpro; // Suppression du produit correspondant au code
  endif;

  update SFL1; // Met à jour le sous-fichier pour refléter la suppression.

end-proc;
```
