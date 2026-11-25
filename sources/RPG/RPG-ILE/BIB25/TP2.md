---
bibliotheque: BIB25
fichier_source: QRPGLESRC
membre: TP2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 14
modifie: 2026-11-25
---

# BIB25/QRPGLESRC/TP2

```text
     ************   déclaratives ************
     ** déclaration data structure => changer une zone de la data **
     Ddtarea           ds                  dtaara(tp2)
     Dzone1                           1
     dzone2                           1
     dzone3                           1
     ************   traitement   ************
     ** changement du caractère 3 dans la data **
     C                   eval      *inlr=*on
     c                   seton                                            lr
     C     *lock         in        dtarea
     C                   eval      zone3 = '3'
     C     *lock         out       dtarea
     c                   unlock    dtarea
```
