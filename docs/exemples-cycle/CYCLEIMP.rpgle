**FREE
// CYCLEIMP - etat a rupture sur UNIVERS, ecrit comme dans tes autres programmes :
// fichier imprimante externe CYCLEPRT (formats ENTETE, UNIVERS, DETAIL, TOTUNI, TOTGEN)
// et OFLIND(*IN60), comme BONPRT / PRINT de la bibliotheque.
CTL-OPT DFTACTGRP(*NO);

DCL-F PERSO DISK(*EXT) USAGE(*INPUT);
DCL-F CYCLEPRT PRINTER OFLIND(*IN60);

DCL-S NB       PACKED(4:0) INZ(0);   // total general
DCL-S NBU      PACKED(4:0) INZ(0);   // total de l'univers
DCL-S univPrec LIKE(UNIVERS);
DCL-S premier  IND INZ(*ON);
DCL-S rupture  IND INZ(*OFF);

WRITE ENTETE;                        // H 1P : page 1

READ PERSOF;
DOW NOT %EOF(PERSO);

  rupture = (premier OR UNIVERS <> univPrec);

  // Total L1 : avant le nouvel enregistrement, sans test de debordement (comme le cycle)
  IF rupture AND NOT premier;
    TNBU = NBU;
    WRITE TOTUNI;
  ENDIF;

  premier  = *OFF;
  univPrec = UNIVERS;
  IF rupture;
    NBU = 0;
  ENDIF;
  NBU += 1;
  NB  += 1;

  // H ... OR OF : page pleine -> nouvelle page avec en-tete, au moment de l'enregistrement
  IF *IN60;
    WRITE ENTETE;                    // SKIPB(1) : saut de page, PAGNBR s'incremente
    *IN60 = *OFF;
  ENDIF;

  IF rupture;
    TUNIV = UNIVERS;
    WRITE UNIVERS;
  ENDIF;

  TNOM    = NOM;
  TPRENOM = PRENOM;
  WRITE DETAIL;

  READ PERSOF;
ENDDO;

// LR : totaux, sans test de debordement
TNBU = NBU;
WRITE TOTUNI;
TNB = NB;
WRITE TOTGEN;

*INLR = *ON;
RETURN;