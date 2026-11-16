---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: ARM400M
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 262
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/ARM400M

```rpg
**free
// ============================================================================
// Programme : ARM400 - Gestion Fichier Acier (Version Modernisée)
// Description : Refactorisation complète du programme ARM400.RPG
//               Conversion RPG III  RPG Totally Free + SQL Embedded
// Auteur : Modernisation automatique
// Date : 2026-02-04
// ============================================================================
ctl-opt dftactgrp(*no) actgrp(*new);
ctl-opt option(*srcstmt : *nodebugio : *noshowcpy);
ctl-opt datfmt(*iso) timfmt(*iso);

// ----------------------------------------------------------------------------
// Déclaration du fichier écran (Display File)
// ----------------------------------------------------------------------------
dcl-f EAS400 workstn sfile(SFL1:ligne) infds(wsInfoDs);

// ----------------------------------------------------------------------------
// Structure d'information du fichier écran
// ----------------------------------------------------------------------------
dcl-ds wsInfoDs;
  wsFunctionKey char(1) pos(369);
end-ds;

// ----------------------------------------------------------------------------
// Constantes pour les touches de fonction
// ----------------------------------------------------------------------------
dcl-c FK_EXIT    x'33';    // F3  - Sortie
dcl-c FK_CREATE  x'35';    // F6  - Création
dcl-c FK_SPOOL   x'37';    // F8  - WRKSPLF
dcl-c FK_CMDLN   x'B5';    // F22 - Ligne de commande

// ----------------------------------------------------------------------------
// Variables de travail
// ----------------------------------------------------------------------------
dcl-s ligne       packed(4:0) inz(0);
dcl-s sqlState    char(5);
dcl-s exitProgram ind inz(*off);
dcl-s recordFound ind;

// ----------------------------------------------------------------------------
// Structure pour les données de PFACIER
// ----------------------------------------------------------------------------
dcl-ds dsAcier qualified;
  AAAA char(10);
  // Ajouter les autres champs selon la structure réelle de PFACIER
end-ds;

// ----------------------------------------------------------------------------
// Prototype pour l'appel au programme de maintenance
// ----------------------------------------------------------------------------
dcl-pr callBonbRpg3 extpgm('BONBRPG3');
  pCode char(10);
  pOk   packed(10:0);
end-pr;

// ----------------------------------------------------------------------------
// Prototype pour QCMDEXC
// ----------------------------------------------------------------------------
dcl-pr execCmd extpgm('QCMDEXC');
  command char(80) const;
  length  packed(15:5) const;
end-pr;

// ----------------------------------------------------------------------------
// Prototype pour QUSCMDLN (Ligne de commande)
// ----------------------------------------------------------------------------
dcl-pr openCmdLine extpgm('QUSCMDLN');
end-pr;

// ============================================================================
// PROGRAMME PRINCIPAL
// ============================================================================
doW not exitProgram;

  chargerSubfile();
  write BAS1;
  exfmt CTL1;

  select;
    when wsFunctionKey = FK_EXIT;
      exitProgram = *on;

    when wsFunctionKey = FK_CREATE;
      creerEnregistrement();

    when wsFunctionKey = FK_SPOOL;
      afficherSpool();

    when wsFunctionKey = FK_CMDLN;
      ouvrirLigneCommande();

    other;
      traiterOptionsSubfile();

  endsl;

enddo;

*inlr = *on;
return;

// ============================================================================
// PROCÉDURE : chargerSubfile
// Description : Charge le subfile avec les données de PFACIER via SQL
// ============================================================================
dcl-proc chargerSubfile;

  // Réinitialiser les indicateurs du subfile
  *in30 = *on;   // SFLCLR
  *in31 = *off;  // SFLDSP
  *in32 = *off;  // SFLDSPCTL
  *in33 = *off;  // SFLEND

  write CTL1;    // Effacer le subfile

  *in30 = *off;  // Fin du clear
  ligne = 0;

  // Déclaration du curseur SQL pour lire PFACIER
  exec sql
    DECLARE curAcier CURSOR FOR
      SELECT AAAA
      FROM PFACIER
      WHERE AAAA >= :FAAAA
      ORDER BY AAAA
      FOR READ ONLY;

  exec sql OPEN curAcier;

  // Lecture et chargement du subfile
  doW sqlState = '00000' or sqlState = '';
    exec sql
      FETCH FROM curAcier
      INTO :dsAcier.AAAA;

    sqlState = sqlstt;

    if sqlState = '00000';
      ligne += 1;
      AAAA = dsAcier.AAAA;
      OPT = *blanks;
      write SFL1;
    else;
      leave;
    endif;
  enddo;

  exec sql CLOSE curAcier;

  // Paramétrer l'affichage du subfile
  *in32 = *on;  // SFLDSPCTL - Toujours afficher le contrôle
  *in33 = *on;  // SFLEND    - Fin du subfile

  if ligne > 0;
    *in31 = *on;  // SFLDSP - Afficher le subfile s'il y a des enregistrements
  endif;

end-proc;

// ============================================================================
// PROCÉDURE : traiterOptionsSubfile
// Description : Traite les options saisies par l'utilisateur dans le subfile
// ============================================================================
dcl-proc traiterOptionsSubfile;

  dcl-s optionCode char(1);

  readc SFL1;

  doW not %eof(EAS400);

    optionCode = OPT;

    select;
      when optionCode = '2';
        modifierEnregistrement(AAAA);

      when optionCode = '4';
        supprimerEnregistrement(AAAA);
    endsl;

    // Réinitialiser l'option après traitement
    OPT = *blanks;
    update SFL1;

    readc SFL1;
  enddo;

end-proc;

// ============================================================================
// PROCÉDURE : creerEnregistrement
// Description : Appelle le programme de création d'un nouvel enregistrement
// ============================================================================
dcl-proc creerEnregistrement;

  dcl-s pCode char(10) inz('0');
  dcl-s pOk   packed(10:0) inz(0);

  callBonbRpg3(pCode : pOk);

end-proc;

// ============================================================================
// PROCÉDURE : modifierEnregistrement
// Description : Appelle le programme de modification pour l'enregistrement sélectionné
// ============================================================================
dcl-proc modifierEnregistrement;

  dcl-pi *n;
    pCodeAcier char(10) const;
  end-pi;

  dcl-s pOk packed(10:0) inz(0);

  callBonbRpg3(pCodeAcier : pOk);

end-proc;

// ============================================================================
// PROCÉDURE : supprimerEnregistrement
// Description : Supprime l'enregistrement sélectionné via SQL
// ============================================================================
dcl-proc supprimerEnregistrement;

  dcl-pi *n;
    pCodeAcier char(10) const;
  end-pi;

  exec sql
    DELETE FROM PFACIER
    WHERE AAAA = :pCodeAcier;

  // Vérification du résultat
  if sqlstt <> '00000';
    // Gérer l'erreur de suppression (log, message, etc.)
  endif;

end-proc;

// ============================================================================
// PROCÉDURE : afficherSpool
// Description : Affiche les fichiers spool de l'utilisateur (WRKSPLF)
// ============================================================================
dcl-proc afficherSpool;

  dcl-s cmdString char(80) inz('WRKSPLF');

  execCmd(cmdString : 80);

end-proc;

// ============================================================================
// PROCÉDURE : ouvrirLigneCommande
// Description : Ouvre la ligne de commande système
// ============================================================================
dcl-proc ouvrirLigneCommande;

  openCmdLine();

end-proc;
```
