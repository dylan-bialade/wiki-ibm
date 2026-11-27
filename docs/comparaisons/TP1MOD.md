# TP1MOD : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB03 | QRPGLESRC | RPG/RPG-ILE | 59 | 100 % | full free, procedures (dcl-proc), prototypes (dcl-pr) | [TP1MOD.md](../../sources/RPG/RPG-ILE/BIB03/TP1MOD.md) |
| BIB25 | QILETP | RPG/RPG-ILE | 82 | 8 % | full free, SQL embarque, procedures (dcl-proc), prototypes (dcl-pr) | [TP1MOD.md](../../sources/RPG/RPG-ILE/BIB25/TP1MOD.md) |

## Differences

- Techniques communes : full free, procedures (dcl-proc), prototypes (dcl-pr)
- **BIB25** en propre : SQL embarque

## Codes

### BIB03 (RPG/RPG-ILE, 59 lignes)

```text
**free
ctl-opt nomain;

/copy QCPYSRC,TP1MODP

// Donnee exportee : nombre de calculs effectues
dcl-s nbCalculs int(10) export inz(0);

// Procedure interne (non exportee) : arrondi au centime
dcl-proc arrondir;
  dcl-pi *n packed(9 : 2);
    valeur packed(31 : 9) const;
  end-pi;

  return %dech(valeur : 9 : 2);
end-proc;

dcl-proc tauxTva export;
  dcl-pi *n packed(5 : 3);
    cdTva char(1) const;
  end-pi;

select;
    when cdTva = 'N';
      return 20;
    when cdTva = 'I';
      return 10;
    when cdTva = 'R';
      return 5.5;
    other;
      return 0;
  endsl;
end-proc;

dcl-proc calcTtc export;
  dcl-pi *n packed(9 : 2);
    pxHt  packed(9 : 2) const;
    cdTva char(1) const;
  end-pi;

  dcl-s brut packed(31 : 9);

  nbCalculs += 1;
  brut = pxHt * (1 + tauxTva(cdTva) / 100);
  return arrondir(brut);
end-proc;

dcl-proc calcHt export;
  dcl-pi *n packed(9 : 2);
    pxTtc packed(9 : 2) const;
    cdTva char(1) const;
  end-pi;

  dcl-s brut packed(31 : 9);

  nbCalculs += 1;
  brut = pxTtc / (1 + tauxTva(cdTva) / 100);
  return arrondir(brut);
end-proc;
```

### BIB25 (RPG/RPG-ILE, 82 lignes)

```text
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
    email char(40);
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

// Procédure contrôle d'une zone numérique
DCL-PROC checkNumeric EXPORT;
  DCL-PI *n ind;
    numeric char(20);
  END-PI;

  DCL-S result packed(2:0);

  result = %CHECK('0123456789' : %TRIM(numeric));

  if result = 0;
    return *on;
  else;
    return *off;
  ENDIF;
END-PROC;
```
