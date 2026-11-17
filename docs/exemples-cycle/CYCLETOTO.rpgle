**FREE
// CYCLETOTO - version full free du programme RPG III a cycle (CORRIGEE d'apres le spool obtenu)
// Pas de PRTCTL : espacements = lignes blanches ecrites, saut de page = remplissage jusqu'a la fin de page.
// Modele : apres une ligne ecrite en L avec "espace apres" A, le curseur est en L+A ;
// une ligne avec "espace avant" B s'imprime en curseur+B (comme les O-specs, mesure sur le spool de reference).
CTL-OPT DFTACTGRP(*NO);

DCL-F PERSO DISK(*EXT) USAGE(*INPUT);
DCL-F QSYSPRT PRINTER(132) USAGE(*OUTPUT) OFLIND(*INOF);

DCL-C LIGNE_DEBORD 60;   // OVRFLW par defaut (fiche 08)
DCL-C LIGNES_PAGE  66;   // PAGESIZE par defaut (fiche 08)

DCL-DS ligne;
  buf CHAR(132);
END-DS;

DCL-S NB        PACKED(3:0) INZ(0);
DCL-S NBU       PACKED(3:0) INZ(0);
DCL-S numPage   PACKED(4:0) INZ(0);
DCL-S ligneCour INT(10)     INZ(1);   // prochaine ligne physique a ecrire
DCL-S curseur   INT(10)     INZ(1);   // ligne ou s'imprimerait une ligne sans espace avant
DCL-S univPrec  LIKE(UNIVERS);
DCL-S premier   IND         INZ(*ON);
DCL-S rupture   IND         INZ(*OFF);

Entete();                      // H 1P : page 1

READ PERSOF;
DOW NOT %EOF(PERSO);

  rupture = (premier OR UNIVERS <> univPrec);

  // Total L1 : avant le nouvel enregistrement, SANS test de debordement
  IF rupture AND NOT premier;
    TotalUnivers();
  ENDIF;

  premier  = *OFF;
  univPrec = UNIVERS;

  IF rupture;
    NBU = 0;
  ENDIF;
  NBU += 1;
  NB  += 1;

  Debordement();               // H ... OR OF : seulement au moment de l'enregistrement
  IF rupture;
    LigneUnivers();
  ENDIF;
  LigneDetail();

  READ PERSOF;
ENDDO;

// LR : totaux sans test de debordement
TotalUnivers();
TotalGeneral();

*INLR = *ON;
RETURN;

//--------------------------------------------------------------
DCL-PROC Placer;               // texte termine en colonne pFin
  DCL-PI *N;
    pFin   INT(10) CONST;
    pTexte VARCHAR(132) CONST;
  END-PI;
  %SUBST(buf : pFin - %LEN(pTexte) + 1 : %LEN(pTexte)) = pTexte;
END-PROC;

DCL-PROC Ecrire;               // pAvant = espace avant, pApres = espace apres
  DCL-PI *N;
    pAvant INT(10) CONST;
    pApres INT(10) CONST;
  END-PI;
  DCL-S cible INT(10);
  DCL-S sauve CHAR(132);
  cible = curseur + pAvant;
  sauve = buf;                 // le texte a imprimer est garde pendant les lignes blanches
  buf = *BLANKS;
  DOW ligneCour < cible;       // lignes blanches jusqu'a la ligne cible
    WRITE QSYSPRT ligne;
    ligneCour += 1;
  ENDDO;
  buf = sauve;
  WRITE QSYSPRT ligne;
  buf = *BLANKS;
  ligneCour += 1;
  curseur = cible + pApres;
END-PROC;

DCL-PROC Entete;               // H : ligne 1, espace apres 1
  numPage += 1;
  Placer(40 : 'NOUVELLE ANIME');
  Placer(70 : 'Page');
  Placer(75 : %EDITC(numPage : 'Z'));
  Ecrire(0 : 1);
END-PROC;

DCL-PROC Debordement;          // ligne 60 depassee : finir la page puis nouvel entete
  DCL-S i INT(10);
  IF ligneCour > LIGNE_DEBORD;
    buf = *BLANKS;
    FOR i = ligneCour TO LIGNES_PAGE;
      WRITE QSYSPRT ligne;
    ENDFOR;
    ligneCour = 1;
    curseur   = 1;
    Entete();
  ENDIF;
END-PROC;

DCL-PROC LigneUnivers;         // D : espace avant 1, apres 1
  Placer(8  : 'UNIVERS');
  Placer(12 : %EDITC(UNIVERS : 'Z'));
  Ecrire(1 : 1);
END-PROC;

DCL-PROC LigneDetail;          // D : espace apres 1
  Placer(16 : NOM);
  Placer(34 : PRENOM);
  Ecrire(0 : 1);
END-PROC;

DCL-PROC TotalUnivers;         // T : espace avant 2
  Placer(17 : 'TOTAL UNIVERS');
  Placer(21 : %EDITC(NBU : 'Z'));
  Ecrire(2 : 0);
END-PROC;

DCL-PROC TotalGeneral;         // T : espace avant 2
  Placer(17 : 'TOTAL GENERAL');
  Placer(21 : %EDITC(NB : 'Z'));
  Ecrire(2 : 0);
END-PROC;