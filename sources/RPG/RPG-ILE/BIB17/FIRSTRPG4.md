---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: FIRSTRPG4
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 8
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/FIRSTRPG4

```text
     htimfmt(*hms)
     Duser             S             10A   inz(*USER)
     dsortie           S             52a
     dheure            s               t   inz(*sys)
     c                   eval      sortie='Bonjour '+ %trim(user) + ', il est '+
     c                             %char(heure)
     c     sortie        dsply
     c                   eval      *inlr=*on
```
