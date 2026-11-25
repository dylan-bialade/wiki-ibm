---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: TP2
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 14
modifie: 2026-11-25
---

# BIB27/QRPGSRC/TP2

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

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
