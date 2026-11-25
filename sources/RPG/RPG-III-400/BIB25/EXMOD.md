---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: EXMOD
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 48
modifie: 2026-11-25
---

# BIB25/QRPGSRC/EXMOD

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**FREE

// Ce programme n'est pas une procédure principale
// Possibilité qu'un module soit en MAIN (procédure principale)
CTL-OPT NOMAIN;

// Variable statique, elle garde sa valeur entre les appels de modules
DCL-S compteur int(10) INZ(0);

// Procédure exportée
DCL-PROC addition  EXPORT;
  DCL-PI *n packed(7:2);
    nbr1 packed(6:0);
    nbr2 packed(6:0);
  END-PI;

  dcl-s P_nbr1 packed(6:0);
  dcl-s P_nbr2 packed(6:0);

  // Transformation en nombres positifs
  P_nbr1 = NbrPositif(nbr1);
  P_nbr2 = NbrPositif(nbr2);
  compteur = compteur + 1;
  // Retourn l'addition
  return P_nbr1 + P_nbr2;

END-PROC;

// Procédure interne au module
DCL-PROC NbrPositif;
  DCL-PI *n packed(6:0);
    nbr packed(6:0);
  END-PI;

  // Si nombre négatif, passage en positif
  IF nbr < 0;
    return nbr * (-1);
  else;
    return nbr;
  ENDIF;
END-PROC;

// Retourne le compteur
DCL-PROC returnC export;
  DCL-PI *n int(10);
  END-PI;
  return compteur;
END-PROC;
```
