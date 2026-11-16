---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: SQUELLETTE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 25
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/SQUELLETTE

```rpg
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
    * SI TU VOIS SA TU A COPIER BIALADE
      *carte h
      *carte f
      *fNomFichier
      *carte d
     dAlpha1           S             20a
     dtot              s             50
     dprint            s             50a
     duser             s             20a
     dheure            s               t   inz(*sys)
     dh                s              8a
      *carte c
     C                   eval      LR=1
     c                   eval      h=%char(heure)
     c                   eval      user='dylan2 il est '
     c                   eval      alpha1='bonjour, '
     c                   eval      print=alpha1+%trim(user)+h
     c     print         dsply

      *carte o

      *carte p
```
