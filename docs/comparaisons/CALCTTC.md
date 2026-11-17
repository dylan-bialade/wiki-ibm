# CALCTTC : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGSRC | RPG/RPG-III-400 | 12 | 100 % |  | [CALCTTC.md](../../sources/RPG/RPG-III-400/BIB05/CALCTTC.md) |
| BIB20 | QRPGSRC | RPG/RPG-III-400 | 4 | 14 % |  | [CALCTTC.md](../../sources/RPG/RPG-III-400/BIB20/CALCTTC.md) |
| BIB09 | QSOURCES | RPG/RPG-ILE | 44 | 0 % | full free, prototypes (dcl-pr) | [CALCTTC.md](../../sources/RPG/RPG-ILE/BIB09/CALCTTC.md) |

## Differences

- **BIB09** en propre : full free, prototypes (dcl-pr)
- Langages / types differents : RPG/RPG-III-400, RPG/RPG-ILE

## Codes

### BIB05 (RPG/RPG-III-400, 12 lignes)

```text
     C           *ENTRY    PLIST
     C                     PARM           PRIXHT  82
     C                     PARM           TVA     82
     C                     SETON                     LR
     C                     Z-ADD0         PRIXTT  82
     C                     Z-ADD0         LAVAL   82
     C           PRIXHT    MULT TVA       LAVAL
     C           LAVAL     DIV  100       LAVAL
     C           LAVAL     ADD  PRIXHT    PRIXTT
     C           PRIXTT    DSPLY
     C           PRIXHT    DSPLY
     C           TVA       DSPLY
```

### BIB20 (RPG/RPG-III-400, 4 lignes)

```text
     C           *ENTRY    PLIST
     C                     PARM           PRIX    52
     C           PRIX      MULT 1.20      PRIX
     C                     SETON                         LR
```

### BIB09 (RPG/RPG-ILE, 44 lignes)

```text
**free
ctl-opt dftactgrp(*no) actgrp(*caller);

// --------------------------------------------------
// Programme CALCTTC : Calcule un montant TTC
// Parametres :
//   - montantHT   (entree)  : montant hors taxe
//   - tauxTVA     (entree)  : taux de TVA (ex: 0.20)
//   - montantTTC  (sortie)  : montant TTC calcule
//   - codeRetour  (sortie)  : 0 = OK, -1 = erreur
// --------------------------------------------------

// Interface : declare les parametres recus par CE programme
dcl-pi *n;
  montantHT   packed(11:2) const;  // const = parametre non modifie
  tauxTVA     packed(5:4)  const;
  montantTTC  packed(11:2);        // pas de const = parametre modifie (sortie)
  codeRetour  int(10);
end-pi;

// Variables de travail
dcl-s wMontantTVA packed(11:2) inz(*zero);

// --- Logique principale ---

// Validation des parametres d'entree
if montantHT < 0 or tauxTVA < 0;
  montantTTC = 0;
  codeRetour = -1;
  *inlr = *on;
  return;
endif;

// Calcul du montant TVA
wMontantTVA = montantHT * tauxTVA;

// Calcul du montant TTC
montantTTC = montantHT + wMontantTVA;

// Retour OK
codeRetour = 0;

*inlr = *on;
return;
```
