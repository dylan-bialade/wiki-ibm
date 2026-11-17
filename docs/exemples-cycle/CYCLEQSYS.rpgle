**FREE
// VALIDE : compile et teste par l'utilisateur, spool identique a la reference RPG III (8 pages).
// CYCLEQSYS - meme etat, sans fichier DDS : QSYSPRT + une DS de 132 car. par type de ligne.
// Espacements = lignes blanches ecrites (modele du curseur, mesure sur le spool de reference).
CTL-OPT DFTACTGRP(*NO);

DCL-F PERSO DISK(*EXT) USAGE(*INPUT);
DCL-F QSYSPRT PRINTER(132) USAGE(*OUTPUT) OFLIND(*INOF);

DCL-C LIGNE_DEBORD 60;   // OVRFLW par defaut (fiche 08)
DCL-C LIGNES_PAGE  66;   // PAGESIZE par defaut (fiche 08)

// ---- une DS par type de ligne (les colonnes sont celles du spool de reference)
DCL-DS dsVide    LEN(132) INZ END-DS;

DCL-DS dsEntete  LEN(132) INZ;
  eTitre CHAR(14) POS(27) INZ('NOUVELLE ANIME');
  ePage  CHAR(4)  POS(67) INZ('Page');
  eNum   CHAR(4)  POS(72);
END-DS;

DCL-DS dsUnivers LEN(132) INZ;
  uLib   CHAR(7)  POS(2)  INZ('UNIVERS');
  uNum   CHAR(4)  POS(9);
END-DS;

DCL-DS dsDetail  LEN(132) INZ;
  dNom    CHAR(15) POS(2);
  dPrenom CHAR(15) POS(20);
END-DS;

DCL-DS dsTotUni  LEN(132) INZ;
  tuLib  CHAR(13) POS(5)  INZ('TOTAL UNIVERS');
  tuNum  CHAR(4)  POS(18);
END-DS;

DCL-DS dsTotGen  LEN(132) INZ;
  tgLib  CHAR(13) POS(5)  INZ('TOTAL GENERAL');
  tgNum  CHAR(4)  POS(18);
END-DS;

DCL-S NB        PACKED(4:0) INZ(0);
DCL-S NBU       PACKED(4:0) INZ(0);
DCL-S numPage   PACKED(4:0) INZ(0);
DCL-S ligneCour INT(10)     INZ(1);   // prochaine ligne physique
DCL-S curseur   INT(10)     INZ(1);   // ligne d'une ligne sans espace avant
DCL-S cible     INT(10)     INZ(1);
DCL-S univPrec  LIKE(UNIVERS);
DCL-S premier   IND         INZ(*ON);
DCL-S rupture   IND         INZ(*OFF);

Entete();                            // H 1P : page 1

READ PERSOF;
DOW NOT %EOF(PERSO);

  rupture = (premier OR UNIVERS <> univPrec);

  IF rupture AND NOT premier;        // total L1, sans test de debordement
    TotalUnivers();
  ENDIF;

  premier  = *OFF;
  univPrec = UNIVERS;
  IF rupture;
    NBU = 0;
  ENDIF;
  NBU += 1;
  NB  += 1;

  Debordement();                     // seulement au moment d'un enregistrement
  IF rupture;
    LigneUnivers();
  ENDIF;
  LigneDetail();

  READ PERSOF;
ENDDO;

TotalUnivers();                      // LR : sans test de debordement
TotalGeneral();

*INLR = *ON;
RETURN;

//--------------------------------------------------------------
DCL-PROC Avant;                      // amene le papier a curseur + espace avant
  DCL-PI *N;
    pAvant INT(10) CONST;
  END-PI;
  cible = curseur + pAvant;
  DOW ligneCour < cible;
    WRITE QSYSPRT dsVide;
    ligneCour += 1;
  ENDDO;
END-PROC;

DCL-PROC Apres;                      // la ligne est ecrite : met a jour le curseur
  DCL-PI *N;
    pApres INT(10) CONST;
  END-PI;
  ligneCour += 1;
  curseur = cible + pApres;
END-PROC;

DCL-PROC Entete;                     // H : ligne 1, espace apres 1
  numPage += 1;
  eNum = %EDITC(numPage : 'Z');
  Avant(0);
  WRITE QSYSPRT dsEntete;
  Apres(1);
END-PROC;

DCL-PROC Debordement;                // ligne 60 depassee : finir la page, nouvel entete
  DCL-S i INT(10);
  IF ligneCour > LIGNE_DEBORD;
    FOR i = ligneCour TO LIGNES_PAGE;
      WRITE QSYSPRT dsVide;
    ENDFOR;
    ligneCour = 1;
    curseur   = 1;
    Entete();
  ENDIF;
END-PROC;

DCL-PROC LigneUnivers;               // D : espace avant 1, apres 1
  uNum = %EDITC(UNIVERS : 'Z');
  Avant(1);
  WRITE QSYSPRT dsUnivers;
  Apres(1);
END-PROC;

DCL-PROC LigneDetail;                // D : espace apres 1
  dNom    = NOM;
  dPrenom = PRENOM;
  Avant(0);
  WRITE QSYSPRT dsDetail;
  Apres(1);
END-PROC;

DCL-PROC TotalUnivers;               // T : espace avant 2
  tuNum = %EDITC(NBU : 'Z');
  Avant(2);
  WRITE QSYSPRT dsTotUni;
  Apres(0);
END-PROC;

DCL-PROC TotalGeneral;               // T : espace avant 2
  tgNum = %EDITC(NB : 'Z');
  Avant(2);
  WRITE QSYSPRT dsTotGen;
  Apres(0);
END-PROC;