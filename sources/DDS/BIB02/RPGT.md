---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: RPGT
type: DDS
longueur_enregistrement: 100
lignes: 20
modifie: 2026-11-16
---

# BIB02/QDDSRC/RPGT

```text
     D********  Declaration CTDATA  ********
     D TBLJOUR         S              8A   DIM(7) CTDATA PERRCD(1)
     D JOUR            S              8A

     C********  Action  ********************
     C                   EVAL      JOUR = TBLJOUR(5)
     C     JOUR          DSPLY
     C                   EVAL      JOUR = TBLJOUR(6)
     C     JOUR          DSPLY
     C                   SETON                                            LR

     **=====================================
** CTDATA TBLJOUR
Lundi
Mardi
Mercredi
Jeudi
Vendredi
Samedi
Dimanche
```
