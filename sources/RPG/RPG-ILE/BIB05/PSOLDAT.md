---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: PSOLDAT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 293
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/PSOLDAT

```rpg
**FREE

//==============================================================================
// Program: PSOLDAT - Soldier Management System (Modernized)
// Description: CRUD operations for soldier records using modern RPG and SQL
// Author: Modernized by Senior IBM i Developer
// Date: 2025-12-23
//==============================================================================

// Control Options
CTL-OPT DFTACTGRP(*NO) ACTGRP(*NEW) OPTION(*NODEBUGIO:*SRCSTMT);

// File Declarations
DCL-F ESOLDAT WORKSTN INFDS(WSDS);

// SQL Options
EXEC SQL SET OPTION COMMIT=*NONE, CLOSQLCSR=*ENDMOD;

// Standalone Variables
DCL-S exitRequested IND INZ(*OFF);
DCL-S createMode IND INZ(*OFF);
DCL-S cancelRequested IND INZ(*OFF);
DCL-S deleteRequested IND INZ(*OFF);
DCL-S modifyRequested IND INZ(*OFF);

// Display File Fields (matching ESOLDAT field names)
DCL-S IDSLD PACKED(5:0);
DCL-S NMSLD CHAR(30);
DCL-S PRSLD CHAR(30);
DCL-S ARSLD1 CHAR(30);
DCL-S CLASLD CHAR(20);
DCL-S MES CHAR(52);

// Workstation Data Structure
DCL-DS WSDS;
  functionKey CHAR(1) POS(369);
END-DS;

// Message Array
DCL-DS messages QUALIFIED;
  deleted CHAR(52) INZ('Le Soldat à été supprimé');
  modified CHAR(52) INZ('Le Soldat à été modifié');
  notFound CHAR(52) INZ('Numéro de Soldat inexistant');
  created CHAR(52) INZ('Le Soldat à été créé');
END-DS;

// Main Procedure Interface
DCL-PI *N;
END-PI;

// Main Program Logic
mainProcess();
*INLR = *ON;
RETURN;

//==============================================================================
// Main Process - Controls program flow
//==============================================================================
DCL-PROC mainProcess;

  DOW NOT exitRequested;
    displaySearchScreen();

    IF NOT exitRequested AND NOT createMode;
      searchAndDisplay();
    ENDIF;

    IF createMode;
      createNewSoldier();
    ENDIF;
  ENDDO;

END-PROC;

//==============================================================================
// Display Search Screen (FMT1)
//==============================================================================
DCL-PROC displaySearchScreen;

  EXFMT FMT1;
  MES = '';

  // Check function keys
  exitRequested = (functionKey = '3');
  createMode = (functionKey = '6');

END-PROC;

//==============================================================================
// Search and Display Soldier Record
//==============================================================================
DCL-PROC searchAndDisplay;

  DCL-S recordFound IND;

  IF IDSLD > 0;
    recordFound = getSoldierById(IDSLD);

    IF recordFound;
      displayAndModify();
    ELSE;
      MES = messages.notFound;
    ENDIF;
  ENDIF;

END-PROC;

//==============================================================================
// Get Soldier by ID using SQL
//==============================================================================
DCL-PROC getSoldierById;
  DCL-PI *N IND;
    searchId PACKED(5:0) CONST;
  END-PI;

  DCL-S found IND INZ(*OFF);

  MONITOR;
    EXEC SQL
      SELECT IDSLD, NMSLD, PRSLD, ARSLD1, CLASLD
      INTO :IDSLD, :NMSLD, :PRSLD, :ARSLD1, :CLASLD
      FROM SOLDAT
      WHERE IDSLD = :searchId;

    found = (SQLCODE = 0);

  ON-ERROR;
    found = *OFF;
  ENDMON;

  RETURN found;

END-PROC;

//==============================================================================
// Display and Modify Soldier Record (FMT2)
//==============================================================================
DCL-PROC displayAndModify;

  cancelRequested = *OFF;

  DOW NOT cancelRequested AND NOT exitRequested;
    EXFMT FMT2;

    // Check function keys
    exitRequested = (functionKey = '3');
    cancelRequested = (functionKey = 'C');
    deleteRequested = (functionKey = 'M');
    modifyRequested = (functionKey = 'X');

    IF deleteRequested;
      deleteSoldier();
      LEAVE;
    ENDIF;

    IF modifyRequested;
      updateSoldier();
      LEAVE;
    ENDIF;
  ENDDO;

END-PROC;

//==============================================================================
// Delete Soldier using SQL
//==============================================================================
DCL-PROC deleteSoldier;

  MONITOR;
    EXEC SQL
      DELETE FROM SOLDAT
      WHERE IDSLD = :IDSLD;

    IF SQLCODE = 0;
      MES = messages.deleted;
    ENDIF;

  ON-ERROR;
    MES = 'Erreur lors de la suppression';
  ENDMON;

END-PROC;

//==============================================================================
// Update Soldier using SQL
//==============================================================================
DCL-PROC updateSoldier;

  MONITOR;
    EXEC SQL
      UPDATE SOLDAT
      SET NMSLD = :NMSLD,
          PRSLD = :PRSLD,
          ARSLD1 = :ARSLD1,
          CLASLD = :CLASLD
      WHERE IDSLD = :IDSLD;

    IF SQLCODE = 0;
      MES = messages.modified;
    ENDIF;

  ON-ERROR;
    MES = 'Erreur lors de la modification';
  ENDMON;

END-PROC;

//==============================================================================
// Create New Soldier
//==============================================================================
DCL-PROC createNewSoldier;

  DCL-S continueCreate IND INZ(*ON);

  DOW continueCreate;
    // Check for exit or cancel
    IF exitRequested OR cancelRequested;
      LEAVE;
    ENDIF;

    // Generate next soldier ID
    IDSLD = getNextSoldierId();

    // Display create screen
    EXFMT FMT3;

    // Check function keys
    exitRequested = (functionKey = '3');
    cancelRequested = (functionKey = 'C');

    // Validate required fields
    IF IDSLD > 0 AND
       NMSLD <> '' AND
       PRSLD <> '' AND
       ARSLD1 <> '' AND
       CLASLD <> '';

      insertSoldier();
      continueCreate = *OFF;
    ENDIF;
  ENDDO;

  createMode = *OFF;

END-PROC;

//==============================================================================
// Get Next Soldier ID using SQL
//==============================================================================
DCL-PROC getNextSoldierId;
  DCL-PI *N PACKED(5:0);
  END-PI;

  DCL-S nextId PACKED(5:0) INZ(1);
  DCL-S maxId PACKED(5:0);

  MONITOR;
    EXEC SQL
      SELECT MAX(IDSLD)
      INTO :maxId
      FROM SOLDAT;

    IF SQLCODE = 0 AND maxId > 0;
      nextId = maxId + 1;
    ENDIF;

  ON-ERROR;
    nextId = 1;
  ENDMON;

  RETURN nextId;

END-PROC;

//==============================================================================
// Insert New Soldier using SQL
//==============================================================================
DCL-PROC insertSoldier;

  MONITOR;
    EXEC SQL
      INSERT INTO SOLDAT (IDSLD, NMSLD, PRSLD, ARSLD1, CLASLD)
      VALUES (:IDSLD, :NMSLD, :PRSLD, :ARSLD1, :CLASLD);

    IF SQLCODE = 0;
      MES = messages.created;
    ENDIF;

  ON-ERROR;
    MES = 'Erreur lors de la création';
  ENDMON;

END-PROC;
```
