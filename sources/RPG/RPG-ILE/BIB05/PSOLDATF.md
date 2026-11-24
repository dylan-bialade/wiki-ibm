---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: PSOLDATF
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 245
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/PSOLDATF

```rpg
**FREE

CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER) OPTION(*SRCSTMT : *NODEBUGIO);

//=============================================================================
// PROGRAMME : PSOLDATF
// AUTEUR    : Sylvain BIB02 - ORGFORM (Modernisé en RPG Full Free SQL)
// DATE      : 15/12/2025
// VERSION   : 2.0
// DESCRIPTION :
//   Programme de gestion des soldats (C  RUD) en RPG Full Free avec SQL intégré.
//   Permet la création, la modification et la suppression d'enregistrements
//   dans le fichier SOLDAT.
//
// FONCTIONS :
//   - F3  : Quitter le programme
//   - F6  : Créer un nouveau soldat
//   - F12 : Retour écran précédent
//   - F13 : Supprimer le soldat
//   - F23 : Modifier les informations d'un soldat
//
// BASE DE DONNÉES :
//   Table : SOLDAT (Clé = IDSLD)
//   Formats écran : FMT1 (Main), FMT2 (Modif/Supp), FMT3 (Création)
//
// NOTES TECHNIQUES :
//   - Utilisation de SQL pour les opérations de base de données
//   - Auto-incrémentation via MAX(IDSLD) + 1
//   - Messages stockés dans un tableau
//
// HISTORIQUE :
//   - V2.0 (15/12/2025) : Migration en RPG Full Free SQL
//   - V1.0 (22/10/2025) : Création initiale du programme
//=============================================================================

// Déclaration des fichiers
DCL-F ESOLDAT WORKSTN INFDS(InfoDS);
DCL-F SOLDAT USAGE(*UPDATE:*DELETE:*OUTPUT) KEYED;

// Data Structure pour les informations écran
DCL-DS InfoDS;
  FKey CHAR(1) POS(369);
END-DS;

// Déclaration de la structure SOLDAT pour SQL
DCL-DS SoldatDS EXTNAME('SOLDAT') QUALIFIED;
END-DS;

// Variables de travail
DCL-S MES CHAR(52);
DCL-S NouvelId PACKED(5:0);
DCL-S Trouve IND;

// Variables de champs de la table SOLDAT
DCL-S IDSLD PACKED(5:0);
DCL-S NMSLD CHAR(30);
DCL-S PRSLD CHAR(30);
DCL-S ARSLD1 CHAR(30);
DCL-S CLASLD CHAR(20);

// Tableau des messages
DCL-DS Messages DIM(4) QUALIFIED;
  Texte CHAR(52);
END-DS;

// Initialisation du tableau de messages
Messages(1).Texte = 'Le Soldat a été supprimé';
Messages(2).Texte = 'Le Soldat a été modifié';
Messages(3).Texte = 'Numéro de Soldat inexistant';
Messages(4).Texte = 'Le Soldat a été créé';

// Boucle principale - Tant que F3 n'est pas appuyé
DOW NOT *INKC;

  // Affichage du format d'écran FMT1
  EXFMT FMT1;
  MES = *BLANKS;

  // Si pas F3 et pas F6
  IF NOT *INKC AND NOT *INKF;

    // Rechercher le soldat en fonction de son ID avec SQL
    Trouve = RechercherSoldat(IDSLD);

    // Si le soldat est trouvé
    IF Trouve;

      // Boucle de modification/suppression - Tant que pas F3 et pas F12
      DOW NOT *INKC AND NOT *INKL;

        // Afficher le format d'écran FMT2
        EXFMT FMT2;

        // F13 - Suppression
        IF *INKM;
          SupprimerSoldat(IDSLD);
          MES = Messages(1).Texte;
          LEAVE;
        ENDIF;

        // F23 - Modification
        IF *INKX;
          ModifierSoldat();
          MES = Messages(2).Texte;
          LEAVE;
        ENDIF;

      ENDDO;

    ELSE;
      MES = Messages(3).Texte;
    ENDIF;

  ENDIF;

  // F6 - Création
  IF *INKF;

    DOW *ON;

      // Sortie si F3 ou F12
      IF *INKC OR *INKL;
        LEAVE;
      ENDIF;

      // Auto-incrémentation avec SQL - Récupération du MAX(IDSLD)
      EXEC SQL
        SELECT COALESCE(MAX(IDSLD), 0) + 1
        INTO :NouvelId
        FROM SOLDAT;

      IDSLD = NouvelId;

      // Affiche le format FMT3 - Écran de Création
      EXFMT FMT3;

      // Validation : Tous les champs doivent être remplis
      IF IDSLD <> 0
         AND NMSLD <> *BLANKS
         AND PRSLD <> *BLANKS
         AND ARSLD1 <> *BLANKS
         AND CLASLD <> *BLANKS;

        // Création du nouveau soldat
        CreerSoldat();
        MES = Messages(4).Texte;
        LEAVE;

      ENDIF;

    ENDDO;

  ENDIF;

ENDDO;

*INLR = *ON;
RETURN;

//=============================================================================
// PROCÉDURE : RechercherSoldat
// DESCRIPTION : Recherche un soldat par son ID et charge ses données
// PARAMÈTRES : IdRecherche (PACKED 7,0) - ID du soldat à rechercher
// RETOUR : IND - *ON si trouvé, *OFF sinon
//=============================================================================
DCL-PROC RechercherSoldat;
  DCL-PI *N IND;
    IdRecherche PACKED(5:0);
  END-PI;

  DCL-S SqlCode INT(10);

  // Recherche SQL du soldat
  EXEC SQL
    SELECT IDSLD, NMSLD, PRSLD, ARSLD1, CLASLD
    INTO :IDSLD, :NMSLD, :PRSLD, :ARSLD1, :CLASLD
    FROM SOLDAT
    WHERE IDSLD = :IdRecherche;

  SqlCode = SQLCODE;

  // Retourne *ON si trouvé (SQLCODE = 0), *OFF sinon
  RETURN (SqlCode = 0);

END-PROC;

//=============================================================================
// PROCÉDURE : SupprimerSoldat
// DESCRIPTION : Supprime un soldat de la base de données
// PARAMÈTRES : IdSupprimer (PACKED 7,0) - ID du soldat à supprimer
//=============================================================================
DCL-PROC SupprimerSoldat;
  DCL-PI *N;
    IdSupprimer PACKED(5:0);
  END-PI;

  // Suppression SQL du soldat
  EXEC SQL
    DELETE FROM SOLDAT
    WHERE IDSLD = :IdSupprimer;

  // Commit de la transaction
  EXEC SQL COMMIT;

END-PROC;

//=============================================================================
// PROCÉDURE : ModifierSoldat
// DESCRIPTION : Met à jour les informations d'un soldat
//=============================================================================
DCL-PROC ModifierSoldat;
  DCL-PI *N;
  END-PI;

  // Mise à jour SQL du soldat avec les valeurs de l'écran
  EXEC SQL
    UPDATE SOLDAT
    SET NMSLD = :NMSLD,
        PRSLD = :PRSLD,
        ARSLD1 = :ARSLD1,
        CLASLD = :CLASLD
    WHERE IDSLD = :IDSLD;

  // Commit de la transaction
  EXEC SQL COMMIT;

END-PROC;

//=============================================================================
// PROCÉDURE : CreerSoldat
// DESCRIPTION : Crée un nouveau soldat dans la base de données
//=============================================================================
DCL-PROC CreerSoldat;
  DCL-PI *N;
  END-PI;

  // Insertion SQL du nouveau soldat avec les valeurs de l'écran
  EXEC SQL
    INSERT INTO SOLDAT (IDSLD, NMSLD, PRSLD, ARSLD1, CLASLD)
    VALUES (:IDSLD, :NMSLD, :PRSLD, :ARSLD1, :CLASLD);

  // Commit de la transaction
  EXEC SQL COMMIT;

END-PROC;
```
