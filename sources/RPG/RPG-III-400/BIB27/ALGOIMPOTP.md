---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: ALGOIMPOTP
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 374
modifie: 2026-11-25
---

# BIB27/QRPGSRC/ALGOIMPOTP

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
CTL-OPT COPYRIGHT('(C) ORGFORM 2024.')
OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*NONE)
ACTGRP(*CALLER)  DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
STGMDL(*INHERIT) THREAD(*SERIALIZE);

//*****************************************************************
// Programme : ALGOIMPOTP
// Projet    : TPALGO - Calculateur d'impôt
// Date      : 09/07/2024
// Copyright : ORGFORM - par Léo BIB27
//*****************************************************************


//*****************************************************************//
// Indicateur                                                      //
//*****************************************************************//
// 03 : CA03
// 12 : CA12
// 50 : ERRMSG('Erreur saisie')
// 51 : ERRMSG('Choisir Oui ou Non')


//*****************************************************************//
// Déclaration des fichiers                                        //
//*****************************************************************//
DCL-F ALGOIMPOTD WORKSTN ;
Dcl-F CAR_IMP keyed USAGE(*input);
DCL-F BIKE_IMP keyed USAGE(*input);
DCL-F CYCLO_IMP keyed USAGE(*input);


//*****************************************************************//
// Déclaration des Variables                                       //
//*****************************************************************//

DCL-S PART PACKED(3:1);
DCL-S reduc_max packed(8:2);
DCL-S index packed(2:0);
DCL-S i packed(2:0);
DCL-S impot packed(8:2);
DCL-S impot_p packed(8:2);
DCL-S winet packed(9:0);
DCL-S decote packed(6:2);
DCL-S impot_h packed(8:2);
DCL-S we_inet packed(9:0);
DCL-S deduc_frais packed(7:2);
DCL-S deduc_donate packed(7:2);

DCL-S TAUX packed(3: 2) dim(5) ASCEND;
DCL-S REVENU packed(6: 0) dim(5) ASCEND;
DCL-S TAUX_hseule packed(3:2) dim(3) ASCEND;
DCL-S TAUX_hpacse packed(3:2) dim(3) ASCEND;
DCL-S REVENU_h packed(7:0) dim(3) ASCEND;

// Liste de clé pour le fichier car_fr
dcl-s k_km LIKE(KMC1);
dcl-s k_cv packed(1:0);


//*****************************************************************//
// Traitement pricipale                                            //
//*****************************************************************//

// Chargement Taux d'imposition
// Tranche 1
TAUX(1)= 0 ;
// Tranche 2
TAUX(2) = 0,11;
// Tranche 3
TAUX(3) = 0,30;
// Tranche 4
TAUX(4)= 0,41;
// Tranche 5
TAUX(5)= 0,45;
// Chargement du revenue
REVENU(1) = 0;
REVENU(2) = 11294;
REVENU(3) = 28797;
REVENU(4) = 82341;
REVENU(5) = 177106;


// Chargement Haut revenus et taux haut revenus
TAUX_hseule(1) = 0.03;
TAUX_hseule(2) = 0.04;
TAUX_hseule(3) = 0.04;

TAUX_hpacse(1) = 0;
TAUX_hpacse(2) = 0.03;
TAUX_hpacse(3) = 0.04;

REVENU_h(1) = 250000;
REVENU_h(2) = 500000;
REVENU_h(3) = 1000000;





dou *in03;
  clear FMT1;
  WRITE FTOUCHE;
  exfmt fmt1; // Affiche le premier écran

  // Véhicule = Voitures
  IF f2 = 1 and FRC1 = *zero;
    WRITE VFMT1;
    exfmt FMT1;
    IF *IN12 = *on;
      iter;
    ENDIF;
  ENDIF;

  // Véhicule = Deux-roues
  IF f2 = 2 and FRC1 = *zero;
    WRITE DFMT1;
    exfmt FMT1;
    IF *IN12 = *on;
      iter;
    ENDIF;
  ENDIF;

  // Véhicule = Cyclomoteur
  IF F2 = 3 AND FRC1 = *zero;
    WRITE CFMT1;
    EXFMT FMT1;
    IF *in12 = *on;
      iter;
    ENDIF;
  ENDIF;



  select;
  when *in03 = *on;  // F3=Exit
    iter;
  when inet < *zero or inet = *zero; // Saisir une valeur
    *in50 = *on;
  when f1 <> 01 and f1 <> 02 ;   // Selectionner un choix  Oui/Non
    *in51 = *on;
  other;
    dou *in03;
      // Calcul de l'impot
      EXSR CALCUL;
      oimpot1 = %trim(%char(inet));
      oimpot = %trim(%char(impot));
      oreste = %trim(%char(inet-impot));
      deduc_f = %trim(%char(deduc_frais));
      donate = %trim(%char(deduc_donate));
      H_revenu = %trim(%char(impot_h));
      exfmt fmt2;        // Affiche le second écran
      select;
      when *in03=*on;    // F3=Exit
        iter;
      when *in12=*on;    // F12=Retour
        leave;
      endsl;
    enddo;
  endsl;

enddo;

*inlr = *on;

//*****************************************************************//
// SOUS ROUTINES                                                   //
//*****************************************************************//

// Calul de l'impot sur le revenu
BEGSR CALCUL;

  clear part;
  clear index;
  clear impot;
  clear winet;
  clear decote;

  winet = inet;



  // Calcul du nombre de parts (0.5 parts par enfants)
  // Pas Marié / pacsé
  IF f1 <> 01;
    part = 1 + (nbe * 0.5);
  // Marié / pacsé
  ELSE;
    part = 2 + (nbe * 0.5);
  ENDIF;
  winet = winet / part;
  index = %LOOKUPLE(winet : REVENU);
  i = 1;
  impot = 0;
  // Calcul de l'impot sans décote et sans plafonnement
  FOR i TO index;
    IF i <> index;
      impot += (REVENU(i+1) - REVENU(i)) * TAUX(i);
      winet = winet - (REVENU(i+1) - REVENU(i));
    ENDIF;
    IF i = index;
      impot +=  winet * TAUX(i);
      impot = impot * part;
      // Décote sur l'impot sur le revenu
      // personne seule
      IF f1 <> 01 and impot < 1929;
        decote = 873 - ( impot * 0.4525);
        impot = impot - decote;
      ENDIF;
      // couple marié/pacsé
      IF f1 <> 02 and impot < 3191;
        decote  =  1444 - ( impot * 0.4525);
        impot = impot - decote;
      ENDIF;
    ENDIF;
  ENDFOR;
  // Calcul de l'impot avec plafonnement
  i = 1;
  impot_p = 0;
  winet = inet;
  // Pas Marié / pacsé
  IF f1 <> 01;
    part = 1;
  // Marié / pacsé
  ELSE;
    part = 2;
  ENDIF;
  winet = winet / part;
  index = %LOOKUPLE(winet : REVENU);
  FOR i TO index;
    IF i <> index;
      impot_p += (REVENU(i+1) - REVENU(i)) * TAUX(i);
      winet = winet - (REVENU(i+1) - REVENU(i));
    ENDIF;
    IF i = index;
      impot_p +=  winet * TAUX(i);
      impot_p = impot_p * part;
      reduc_max = nbe * 1759;
      impot_p = impot_p - reduc_max;
    ENDIF;
  ENDFOR;

  // Comparaison des 2 calculs (avec et sans plafonnement)
  IF impot_p < impot;
    impot = impot_p;
  ENDIF;

  EXSR CONTRIBUTION;

  impot = impot + impot_h;

  EXSR TRANSPORT;

  impot = impot - deduc_frais;

  // Donnation association

  deduc_donate = (don_y * 0.66);
  if deduc_donate > (0.2 * inet);
    deduc_donate = 0.2 * inet;
  ENDIF;

  impot = impot - deduc_donate;


  If impot < 0;
    impot = 0;
  ENDIF;

ENDSR;

// Calcul de la contribution des hauts revenus
BEGSR CONTRIBUTION;
  clear index;
  clear winet;

  winet = inet;
  impot_h = 0;
  i = 1;
  // Contribution haut revenus personne seule
   IF f1 <> 01 and inet > 250000;
       index = %LOOKUPLE(winet : REVENU_h);
       for i to index;
         if i <> index;
              impot_h += (revenu_h(i+1) - revenu_h(i)) * TAUX_hseule(i);
         ENDIF;
         if i = index ;
             impot_h +=  (winet - revenu_h(i)) *  TAUX_hseule(i);
         ENDIF;
       ENDFOR;
   ENDIF;

   // Contribution haut revenus marié/pacsé
   IF f1 = 01 and inet > 500000;
       index = %LOOKUPLE(winet : REVENU_h);
       for i to index;
         if i <> index;
              impot_h += (revenu_h(i+1) - revenu_h(i)) * TAUX_hpacse(i);
         ENDIF;
         if i = index ;
             impot_h +=  (winet - revenu_h(i)) *  TAUX_hpacse(i);
         ENDIF;
       ENDFOR;
   ENDIF;
ENDSR;

BEGSR TRANSPORT;
  // Frais réèls déjà calculé
   IF FRC1 <> 0;
       deduc_frais = FRC1;
   ENDIF;

  // Calcul des frais réèls
   IF FRC1 = *zero;
      deduc_frais = 0;
      SELECT;
        // Voitures
        WHEN f2 = 1;
          select;
            when kmc1 <= 5000;
              k_km = 0;
            when kmc1 <= 20000 and kmc1 > 5000;
              k_km = 5000;
            other;
              k_km = 20000;
          ENDSL;
          read VFMT1;
          k_cv = MV;
          CHAIN (k_km : k_cv) CAR_IMP;
          deduc_frais = (kmc1 * coeff) + ajout;
          // véhicule électrique (majoré de 20%)
          if mv = 1;
             deduc_frais = deduc_frais * 1.2;
          ENDIF;
        // Deux-roues
        WHEN F2 = 2;
          select;
            when kmc1 <= 3000;
              k_km = 0;
            when kmc1 <= 6000 and kmc1 > 3000;
              k_km = 3000;
            other;
              k_km = 6000;
          ENDSL;
          READ DFMT1;
          k_cv = MD;
          CHAIN (k_km : k_cv) BIKE_IMP;
          deduc_frais = (kmc1 * coeff) + ajout;
          // véhicule électrique (majoré de 20%)
          if ed = 1;
             deduc_frais = deduc_frais * 1.2;
          ENDIF;
        // cyclomoteurs
        WHEN F2 = 3;
          select;
            when kmc1 <= 3000;
              k_km = 0;
            when kmc1 > 3000 and kmc1 <= 6000;
              k_km = 3000;
            other;
              k_km = 6000;
          ENDSL;
          READ CFMT1;
          CHAIN (k_km) CYCLO_IMP;
          deduc_frais = (kmc1 * coeff) + ajout;
          // véhicule électrique (majoré de 20%)
          if cd = 1;
            deduc_frais = deduc_frais * 1.2;
          ENDIF;
      ENDSL;
   ENDIF;


ENDSR;
```
