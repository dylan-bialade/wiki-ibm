---
bibliotheque: BIB25
fichier_source: QILESRC
membre: TP_PRET
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 178
modifie: 2026-11-25
---

# BIB25/QILESRC/TP_PRET

```rpg
**free
// ------------------------------------------------------------|
// Programme : TP_PRET (BIB25)                              |
// Description  : Programme qui calcul des prêts immobillier   |
// Contexte : TP formation ILE (Alternants)                    |
// 27/12/2024 - Léo BIB27                                    |
// ------------------------------------------------------------|
// indicateurs :                      |
// *IN03 = Quitter                    |
// *IN12 = Annuler                    |
// *in50 = SFLDSP                     |
// *IN51 = SFLDSPCTl                  |
// *IN52 = SFLCLEAR                   |
// *IN53 = SFLLEND                    |
// -----------------------------------|
//Options
CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER) STGMDL(*INHERIT) BNDDIR('PRET_BND');

// Déclaration écran
DCL-F PRETBD WORKSTN sfile(sfl1:rang);

// Déclarations variables
DCL-S rang packed(4:0);
DCL-S i packed(4:0); // variable compteur boucle
DCL-S mensualite packed(9:2);
DCL-S m_assurance packed(9:2); // Assurance/mois à rembourser
DCL-S f_hypotheque packed(9:2); // Frais d'hypothèque
DCL-S f_caution packed(9:2); // Frais de caution

// Déclaration DS
DCL-DS Amortissement QUALIFIED;
  r_interet packed(9:2); // Interet remboursé
  r_capital packed(9:2); // capital remboursé
  restant_du packed(9:2);
END-DS;

// Module(s) :  PRET_MOD (BIB25) : Annuité constante
// Déclarations procédure modules
DCL-PR Mensualites packed(9:2);
  capital packed(9:2);
  taux packed(4:2);
  duree packed(2:0);
END-PR;

DCL-PR Assurance packed(9:2);
  capital packed(9:2);
  taux_a packed(4:2);
END-PR;

DCL-PR hypotheque packed(9:2);
  capital packed(9:2);
  taux_h packed(4:2);
END-PR;

DCL-PR caution packed(9:2);
  capital packed(9:2);
  caution packed(4:2);
END-PR;

DCL-PR CalculAmortissement LIKEDS(Amortissement);
  capital packed(9:2);
  taux packed(4:2);
  mensualite packed(9:2);
END-PR;

DCL-PR DerniereMensualite LIKEDS(Amortissement);
  capital packed(9:2);
  taux packed(4:2);
  mensualite packed(9:2);
END-PR;

// Boucle d'affichage
DOW 1 = 1;
  WRITE FNKEYS;
  // SND-MSG *STATUS 'TEST' %target(*ext);
  EXFMT FMT1;
  IF *IN03 = *ON;
    LEAVE;
  ENDIF;
  IF *IN12 = *ON;
    ITER;
  ENDIF;
  // Choix du type de prêt
  // + affichage des informations en fonction
  SELECT;
  when type = 1;
    typec = 'Vous avez choisi les annuités constantes :';
  when type = 2;
    typec = 'Vous avez choisi l''amortissement constant :';
  ENDSL;
  EXSR DISPLAY;
  CLEAR typec;
  CLEAR INFO;
  IF *IN03 = *ON;
    LEAVE;
  ENDIF;
  IF *IN12 = *ON;
    ITER;
  ENDIF;
  EXSR CALCUL;
  // Affichage du sous fichier (Tableau Amortissement)
  WRITE FNKEYS;
  SND-MSG *STATUS %char(rang) + 'mensualité chargé' %target(*ext);
  EXFMT CTL1;
  IF *IN03 = *ON;
    LEAVE;
  ENDIF;
  IF *IN12 = *ON;
    ITER;
  ENDIF;
ENDDO;


*INLR = *ON;

// Sous routines
begsr DISPLAY;
  WRITE INFO;
  EXFMT FMT1;
ENDSR;

BEGSR CALCUL;
  READ INFO;
  // Calcul des mensualités du prêt
  mensualite = Mensualites(emontant:etaux:eduree);
  m_assurance = Assurance(emontant:eassurance);
  //mensualite = mensualite + m_assurance;
  // Calcul des frais d'hypthèque et de caution
  f_hypotheque = hypotheque(emontant:ehypo);
  f_caution = caution(emontant:ecaution);

  // Calcul du tableau d'amortissement
  EXSR TableauAmortissement;
ENDSR;

// Sour routines Remplissage du sous fichier (tableau amortissement)
BEGSR TableauAmortissement;
  // Remise à 1 du compteur pour l'écriture du sous fichier
  i = 1;
  // Initialisation du sous fichier
  EXSR INIT_TABLEAU_AMORTISSEMENT;
  // Ecriture du sous fichier
  for i to ((eduree *12) -1);
    Amortissement = CalculAmortissement(emontant:etaux:mensualite);
    rang += 1;
    E1_MOIS = rang;
    E1_CAPRD = emontant;
    emontant = Amortissement.restant_du;
    E1_INTERET = Amortissement.r_interet;
    E1_RCAP = Amortissement.r_capital;
    E1_MENS = mensualite;
    WRITE SFL1;
  ENDFOR;
  // Dernière mensualité
  rang += 1;
  Amortissement = DerniereMensualite(emontant:etaux:mensualite);
  E1_MOIS = eduree * 12;
  E1_CAPRD = emontant;
  E1_INTERET = Amortissement.r_interet;
  E1_RCAP = Amortissement.r_capital;
  E1_MENS = mensualite;
  WRITE SFL1;
  *IN53 = *ON;
  IF rang > 0;
    *IN51 = *ON;
    *IN50 = *ON;
  ELSE;
    *IN51 = *ON;
  ENDIF;
ENDSR;

// Initialisation du sous fichier (tableau amortissement)
BEGSR INIT_TABLEAU_AMORTISSEMENT;
  rang = 0;
  *IN52 = *ON;
  WRITE CTL1;
  *IN52 = *OFF;
ENDSR;
```
