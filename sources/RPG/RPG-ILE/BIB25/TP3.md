---
bibliotheque: BIB25
fichier_source: QRPGLESRC
membre: TP3
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 17
modifie: 2026-11-25
---

# BIB25/QRPGLESRC/TP3

```text
     *********** déclaratives **********
     ** datastructure sous zone 'zone'=> tableau de 10 *10 *********
     Di                s              2  0 inz(1)
     Ddtarea           ds                  dtaara(dt100)
     Dzone                           10    dim(10)
     ************ traitement ***********
     c                   seton                                            lr
     c                   in        dtarea
     C                   for       I to 10
     c                   if        %scan('FIN': zone(i)) > 0
     c     zone(i)       dsply
     c                   leave
     c                   else
     c     zone(i)       dsply
     c                   endif
     C                   endfor
     C                   eval      *inlr=*on
```
