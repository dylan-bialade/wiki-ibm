---
bibliotheque: BIB25
fichier_source: QILE_DG
membre: CEEDATERPG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 26
modifie: 2026-11-25
---

# BIB25/QILE_DG/CEEDATERPG

```text
     Dlildate          S             10i 0
     DDatetxt          S             40
     Dfmt1             S              8    inz('DD/MM/YY')
     Dfmt2             S             40    inz('Wwwwwwwwwz DD Mmmmmmmmm YYYY')
     Djour             S              8
     dfc               S             12
     dlil              S             12


     C     *entry        plist
     C                   parm                    jour
     C                   parm                    datetxt

     c                   callb(D)  'CEEDAYS'
     c                   parm                    jour
     c                   parm                    fmt1
     c                   parm                    lildate
     c                   parm                    *omit
     c
     c                   callb(D)  'CEEDATE'
     c                   parm                    lildate
     c                   parm                    fmt2
     c                   parm                    datetxt
     c                   parm                    *omit
     c                   return
     c                   EVAL       *INLR= *ON
```
