---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: OBJLSTM
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 45
modifie: 2026-11-16
---

# BIB09/QSOURCES/OBJLSTM

```rpg
**free
// ================================================================
// Module  : OBJLSTM
// Objectif : Procédure pour déterminer la couleur d'affichage
//            selon l'attribut de l'objet
//            *PF   Rouge (indicateur 70)
//            *LF   Rose  (indicateur 71)
//            Autre  pas de couleur spéciale
// ================================================================
ctl-opt nomain option(*srcstmt);

// -----------------------------------------------------------
// Procédure exportée : getCouleurObjet
// Paramètre : attribut de l'objet (char 10)
// Retour    : structure avec indicateurs couleur
// -----------------------------------------------------------
dcl-ds dsCouleur qualified template;
  indRouge ind;
  indRose  ind;
end-ds;

dcl-proc getCouleurObjet export;
  dcl-pi *n likeds(dsCouleur);
    pAttribut char(10) const;
  end-pi;

  dcl-ds resultat likeds(dsCouleur);

  // Initialisation : pas de couleur
  resultat.indRouge = *off;
  resultat.indRose  = *off;

  // Déterminer la couleur selon l'attribut
  select;
    when %trim(pAttribut) = 'PF';
      // Fichier physique  Rouge
      resultat.indRouge = *on;
    when %trim(pAttribut) = 'LF';
      // Fichier logique  Rose
      resultat.indRose = *on;
  endsl;

  return resultat;

end-proc;
```
