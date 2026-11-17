**FREE
// SQLIMPRIME - liste des personnages par univers : curseur SQL, rupture, totaux, impression.
// NON COMPILE, NON TESTE. Base : motif valide CYCLEQSYS (QSYSPRT + une DS par ligne, saut de page par remplissage)
// et squelette de curseur de la fiche 07. Remplacer BIBXX par ta bibliotheque. Positions reprises de ton programme.
CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER);

DCL-F QSYSPRT PRINTER(132) USAGE(*OUTPUT) OFLIND(*INOF);

DCL-C LIGNE_DEBORD 60;   // OVRFLW par defaut (fiche 08)
DCL-C LIGNES_PAGE  66;   // PAGESIZE par defaut (fiche 08)

DCL-DS ligVide    LEN(132) INZ END-DS;

DCL-DS ligTitre   LEN(132) INZ;
  tTexte  CHAR(21) POS(30) INZ('LISTE DES PERSONNAGES');
END-DS;

DCL-DS ligUnivers LEN(132) INZ;
  uNom    CHAR(20) POS(6);
END-DS;

DCL-DS ligPerso   LEN(132) INZ;
  pNom    CHAR(15) POS(10);
END-DS;

DCL-DS ligTotal   LEN(132) INZ;
  tuLib   CHAR(13) POS(11) INZ('Personnages :');
  tuNb    CHAR(4)  POS(25);
END-DS;

DCL-DS ligGeneral LEN(132) INZ;
  tgLib   CHAR(15) POS(6)  INZ('Total general :');
  tgNb    CHAR(4)  POS(25);
END-DS;

DCL-S hvNom      CHAR(15);          // variables hotes : types a aligner sur tes colonnes
DCL-S hvUniv     CHAR(20);
DCL-S precUniv   CHAR(20) INZ;
DCL-S premier    IND INZ(*ON);
DCL-S rupture    IND INZ(*OFF);
DCL-S nbUniv     PACKED(4:0) INZ(0);   // personnages de l'univers courant
DCL-S nbGeneral  PACKED(4:0) INZ(0);
DCL-S ligneCour  INT(10) INZ(1);       // prochaine ligne physique

EXEC SQL SET OPTION COMMIT = *NONE;

EXEC SQL DECLARE c1 CURSOR FOR
  SELECT p.nom, u.uniname
    FROM BIBXX.perso p
    JOIN BIBXX.univers u ON p.univers = u.univer
   ORDER BY p.univers;

EXEC SQL OPEN c1;
IF SQLCODE < 0;                      // ouverture impossible : rien a imprimer (code non verifie)
  *INLR = *ON;
  RETURN;
ENDIF;

Entete();                            // H 1P : page 1

EXEC SQL FETCH c1 INTO :hvNom, :hvUniv;
DOW SQLCODE = 0;

  rupture = (premier OR hvUniv <> precUniv);

  IF rupture AND NOT premier;        // total de l'univers precedent, sans test de debordement
    TotalUnivers();
  ENDIF;

  IF rupture;
    precUniv = hvUniv;
    nbUniv   = 0;
  ENDIF;
  premier = *OFF;
  nbUniv    += 1;
  nbGeneral += 1;

  Debordement();                     // seulement au moment d'un enregistrement
  IF rupture;
    LigneUnivers();
  ENDIF;
  LignePerso();

  EXEC SQL FETCH c1 INTO :hvNom, :hvUniv;
ENDDO;

IF NOT premier;                      // jamais de total pour un resultat vide
  TotalUnivers();
ENDIF;
TotalGeneral();

EXEC SQL CLOSE c1;
*INLR = *ON;
RETURN;

//--------------------------------------------------------------
DCL-PROC Vides;                      // n lignes blanches
  DCL-PI *N;
    pNb INT(10) CONST;
  END-PI;
  DCL-S i INT(10);
  FOR i = 1 TO pNb;
    WRITE QSYSPRT ligVide;
    ligneCour += 1;
  ENDFOR;
END-PROC;

DCL-PROC Entete;                     // titre en ligne 1, puis 2 lignes blanches
  WRITE QSYSPRT ligTitre;
  ligneCour += 1;
  Vides(2);
END-PROC;

DCL-PROC Debordement;                // ligne 60 depassee : finir la page, nouveau titre
  DCL-S i INT(10);
  IF ligneCour > LIGNE_DEBORD;
    FOR i = ligneCour TO LIGNES_PAGE;
      WRITE QSYSPRT ligVide;
    ENDFOR;
    ligneCour = 1;
    Entete();
  ENDIF;
END-PROC;

DCL-PROC LigneUnivers;
  uNom = hvUniv;
  WRITE QSYSPRT ligUnivers;
  ligneCour += 1;
END-PROC;

DCL-PROC LignePerso;
  pNom = hvNom;
  WRITE QSYSPRT ligPerso;
  ligneCour += 1;
END-PROC;

DCL-PROC TotalUnivers;               // total, puis une ligne blanche
  tuNb = %EDITC(nbUniv : 'Z');
  WRITE QSYSPRT ligTotal;
  ligneCour += 1;
  Vides(1);
END-PROC;

DCL-PROC TotalGeneral;
  tgNb = %EDITC(nbGeneral : 'Z');
  WRITE QSYSPRT ligGeneral;
  ligneCour += 1;
END-PROC;