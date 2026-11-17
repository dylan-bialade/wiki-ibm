**FREE
// CYCLEPRTCTL - meme etat que CYCLEQSYS, avec PRTCTL(*COMPAT) a la disposition documentee par IBM.
// NON COMPILE, NON TESTE. Disposition : espace avant CHAR(1), espace apres CHAR(1),
// saut avant CHAR(2), saut apres CHAR(2), compteur ZONED(3:0). Blanc = aucun (jamais '0' ni '00').
CTL-OPT DFTACTGRP(*NO);

DCL-F PERSO DISK(*EXT) USAGE(*INPUT);
DCL-F QSYSPRT PRINTER(132) USAGE(*OUTPUT) OFLIND(*INOF) PRTCTL(prtCtl:*COMPAT);

DCL-DS prtCtl;
  spaceB  CHAR(1);
  spaceA  CHAR(1);
  skipB   CHAR(2);
  skipA   CHAR(2);
  lineCnt ZONED(3:0);
END-DS;

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

DCL-S NB       PACKED(4:0) INZ(0);
DCL-S NBU      PACKED(4:0) INZ(0);
DCL-S numPage  PACKED(4:0) INZ(0);
DCL-S univPrec LIKE(UNIVERS);
DCL-S premier  IND INZ(*ON);
DCL-S rupture  IND INZ(*OFF);

Entete();

READ PERSOF;
DOW NOT %EOF(PERSO);

  rupture = (premier OR UNIVERS <> univPrec);

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

  IF *INOF;                          // dépassement : au moment d'un enregistrement
    Entete();                        // saut avant 01 : nouvelle page
    *INOF = *OFF;
  ENDIF;
  IF rupture;
    LigneUnivers();
  ENDIF;
  LigneDetail();

  READ PERSOF;
ENDDO;

TotalUnivers();
TotalGeneral();

*INLR = *ON;
RETURN;

//--------------------------------------------------------------
DCL-PROC Regle;                      // une seule affectation par ligne ; blanc = aucun
  DCL-PI *N;
    pAvant CHAR(1) CONST;
    pApres CHAR(1) CONST;
    pSkipB CHAR(2) CONST;
  END-PI;
  spaceB = pAvant;
  spaceA = pApres;
  skipB  = pSkipB;
  skipA  = *BLANKS;
END-PROC;

DCL-PROC Entete;                     // H : saut avant 1, espace apres 1
  numPage += 1;
  eNum = %EDITC(numPage : 'Z');
  Regle(' ' : '1' : '01');
  WRITE QSYSPRT dsEntete;
END-PROC;

DCL-PROC LigneUnivers;               // D : espace avant 1, apres 1
  uNum = %EDITC(UNIVERS : 'Z');
  Regle('1' : '1' : *BLANKS);
  WRITE QSYSPRT dsUnivers;
END-PROC;

DCL-PROC LigneDetail;                // D : espace apres 1
  dNom    = NOM;
  dPrenom = PRENOM;
  Regle(' ' : '1' : *BLANKS);
  WRITE QSYSPRT dsDetail;
END-PROC;

DCL-PROC TotalUnivers;               // T : espace avant 2, apres 0
  tuNum = %EDITC(NBU : 'Z');
  Regle('2' : '0' : *BLANKS);
  WRITE QSYSPRT dsTotUni;
END-PROC;

DCL-PROC TotalGeneral;               // T : espace avant 2, apres 0
  tgNum = %EDITC(NB : 'Z');
  Regle('2' : '0' : *BLANKS);
  WRITE QSYSPRT dsTotGen;
END-PROC;