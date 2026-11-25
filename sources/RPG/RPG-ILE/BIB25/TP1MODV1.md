---
bibliotheque: BIB25
fichier_source: QILETP
membre: TP1MODV1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 67
modifie: 2026-11-25
---

# BIB25/QILETP/TP1MODV1

```rpg
**FREE
//-------------------------------------------------------------------//
// Module : TP1MOD                                                   //
// Bibliothèque de compilation : BIB25                            //
// 16/04/2025 - LEO2 (Léo BIB27)                                   //
// ------------------------------------------------------------------//
CTL-OPT NOMAIN;

// Procédure de vérification de l'email
DCL-PROC CheckEmail EXPORT;
  Dcl-pi *n ind;
    email char(120);
  End-pi;
  Dcl-s count int(10); //Valeur de retour 1 = mail valide & 0 = mail invalide
  dcl-c REGEX_SQL
   '^[a-zA-Z0-9]{1}[0-9a-zA-Z-_.!?#%&]*@([0-9a-zA-Z-_.])+\.[a-zA-Z]{2,13}';


  //Vérification du mail
  Exec sql
      Set :count = regexp_count(trim(:email), :REGEX_SQL);

  IF count = 0;
    return *off;
  else;
    return *on;
  ENDIF;

END-PROC;

// Procédure de vérification du numéro de Secu
DCL-PROC CheckNumSecu EXPORT;
  Dcl-pi *n ind;
    numsecu char(15);
  End-pi;

  DCL-S cle packed(2:0);
  DCL-S numsecu_13 packed(13:0);

  // Contrôle sur la longueur du numéro
  IF %len(%trim(numsecu)) < 15;
    return *off;
  ENDIF;

  // Gestion des départements de la CORSE pour calcul de clé
  // 2A --> '19'
  // 2B --> '18'
  SELECT;
  WHEN %SUBST(numsecu : 6 : 2) = '2A';
    numsecu = %SUBST(numsecu : 1 : 5) + '19' + %SUBST(numsecu : 8 : 7);
  WHEN %SUBST(numsecu : 6 : 2) = '2B';
    numsecu = %SUBST(numsecu : 1 : 5) + '18' + %SUBST(numsecu : 8 : 7);
  ENDSL;

  // Clé = correspond au deux derniers chiffre du numéro de secu
  // Calcul de la clé (en fonction des 13 premiers chiffres de numéro de sécu)
  numsecu_13 = %DEC(%SUBST(numsecu: 1 : 13): 13 : 0);
  cle = 97 - %REM(numsecu_13 : 97);

  // Retour du booleen
  IF cle = %DEC(%SUBST(numsecu : 14 : 2): 2 : 0);
    return *on;
  else;
    return *off;
  ENDIF;

END-PROC;
```
