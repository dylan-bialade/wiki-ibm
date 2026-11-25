---
bibliotheque: BIB25
fichier_source: QILESRC
membre: PRET_MOD
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 190
modifie: 2026-11-25
---

# BIB25/QILESRC/PRET_MOD

```rpg
**free
//-----------------------------------------------------------------|
// Programme : PRET_MOD.SQLRPGLE (Module)                          |
// Bibliothèque : BIB25                                         |
// Fichier source : QILESRC/BIB25                               |
// Projet : Calcul de prêt immobilier (annuités constante)         |
// 27/12/2024 - Léo BIB27                                        |
//-----------------------------------------------------------------|

// Pas de point d'entrée principal dans le module
// Ce module sera utilisé uniquement en tant que composant d'autres
// programmes de services.
CTL-OPT NOMAIN;

// Déclarations
DCL-DS Amortissement QUALIFIED;
  r_interet packed(9:2); // Interet remboursé
  r_capital packed(9:2); // capital remboursé
  restant_du packed(9:2);
END-DS;

//-----------------------------------------------------------------|
// Procédure 1 :  Calcul des mensualités hors assurance            |
//                (capital + intérêts)                             |
//-----------------------------------------------------------------|
DCL-PROC Mensualites EXPORT;
  // données en entrée
  DCL-PI *N packed(9:2);
    capital packed(9:2);
    taux packed(4:2);
    duree packed(2:0);
  END-PI;

  // Déclaration variables
  DCL-S mensualite packed(9:2);
  DCL-S Wtaux packed(7:6);
  DCL-S Wcalcul packed(7:6);
  DCL-S m_duree packed(3:0); // durée en mois

  // Calcul du taux (exemple : 3.2% devient 0.032 )
  Wtaux = taux / 100;
  // Transformation du taux en taux mensuel
  Wtaux = Wtaux / 12;

  // Transformation de la duree (annee en mois)
  m_duree = duree * 12;


  // Calcul de la puissance
  EXEC SQL
    SET :Wcalcul = power( 1 + :Wtaux , -:m_duree);

  // Calcul des annuitées
  mensualite = (capital * Wtaux) / (1 - Wcalcul);

  return mensualite;

END-PROC;

//-----------------------------------------------------------------|
// Procédure 2 : Calcul du coût de l'assurance sur les mensualitées|
//-----------------------------------------------------------------|
DCL-PROC Assurance EXPORT;
  // données en entrée
  DCL-PI *N packed(9:2);
    capital packed(9:2);
    taux_a packed(4:2);
  END-PI;

  // Déclaration variables
  DCL-S Wtaux packed(5:4);
  DCL-S assurance packed(9:2);

  // Calcul du taux ( exemple : 0.3 % devient 0.003 )
  Wtaux = taux_a / 100;

  // Calcul de la mensualité d'assurance
  assurance = capital * ( Wtaux / 12 );

  return assurance;

END-PROC;

//-----------------------------------------------------------------|
// Procédure 3 : Calcul des fr  ais d'hypothèque                     |
//-----------------------------------------------------------------|
DCL-PROC hypotheque EXPORT;
  // données en entrée
  DCL-PI *N packed(9:2);
    capital packed(9:2);
    taux_h packed(4:2);
  END-PI;

  // Déclaration variables
  DCL-S Wtaux packed(5:4);
  DCL-S hypotheque packed(9:2);

  // Calcul du taux
  Wtaux = taux_h / 100;

  //Calcul frais d'hypothèque
  hypotheque = capital * Wtaux;

  return hypotheque;

END-PROC;

//-----------------------------------------------------------------|
// Procédure 4 : Calcul des frais de caution                       |
//-----------------------------------------------------------------|
DCL-PROC caution EXPORT;
  // données en entrée
  DCL-PI *N packed(9:2);
    capital packed(9:2);
    taux_c packed(4:2);
  END-PI;

  // Déclaration variables
  DCL-S Wtaux packed(5:4);
  DCL-S caution packed(9:2);

  // Calcul du taux
  Wtaux = taux_c / 100;

  //Calcul frais d'hypothèque
  caution = capital * Wtaux;

  return caution;

END-PROC;

//-----------------------------------------------------------------|
// Procédure 5 : Calcul du tableau d'amortissement                 |
//-----------------------------------------------------------------|
DCL-PROC CalculAmortissement EXPORT;
  // Données en entrée
  DCL-PI *N LIKEDS(Amortissement);
    capital packed(9:2);
    taux packed(4:2);
    mensualite packed(9:2);
  END-PI;

  // Déclaration
  DCL-DS RAmortissement LIKEDS(Amortissement);
  DCL-S Wtaux packed(7:6);
  DCL-S Wcapital packed(9:2);

  // Calcul du taux mensuel
  Wtaux = (taux / 100) / 12;

  // Remplissage de la DS
  // Calcul des intérets remboursé sur le n mois
  Ramortissement.r_interet  = capital * Wtaux;
  // Calcul du capital remboursé sur le n mois
  Ramortissement.r_capital = mensualite - Ramortissement.r_interet;
  // Mise à jour du capital restant du
  Wcapital = capital - Ramortissement.r_capital;
  RAmortissement.restant_du = Wcapital;
  return RAmortissement;

END-PROC;

//-----------------------------------------------------------------|
// Procédure 6 : Ajustement dernière mensualité                    |
//-----------------------------------------------------------------|
DCL-PROC DerniereMensualite EXPORT;
   // Données en entrée
  DCL-PI *N LIKEDS(Amortissement);
    capital packed(9:2);
    taux packed(4:2);
    mensualite packed(9:2);
  END-PI;

  DCL-DS RAmortissement LIKEDS(Amortissement);
  DCL-S Wtaux packed(7:6);

  // Calcul du taux mensuel
  Wtaux = (taux / 100) / 12;

  // Intérets
  Ramortissement.r_interet = Wtaux * capital;

  // Capital remboursé
  Ramortissement.r_capital = capital;

  // Dernière mensualité
  mensualite = Ramortissement.r_capital +  Ramortissement.r_interet;

  return Ramortissement;
END-PROC;
```
