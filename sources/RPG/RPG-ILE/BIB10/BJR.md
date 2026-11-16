---
bibliotheque: BIB10
fichier_source: QRPGLESRC
membre: BJR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB10/QRPGLESRC/BJR

```text
     htimfmt(*hms)
     dUser             s             10    inz(*user)
     dtime             s               t   inz(*sys)
     dmsg              s             30
     ds1               s              6  2 inz(0)
     ds2               s              6  2 inz(0)

     c                   eval      *inlr = *on
     c                   eval      s1 = 1000 / 2.0
     c                   eval      s2 = 1000 / 2
     c
     c     s1            dsply
     c     s2            dsply
```
