---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: FILM
type: DDS
longueur_enregistrement: 120
lignes: 12
modifie: 2026-11-16
---

# BIB09/QSOURCES/FILM

```text
     A*================================================================
     A* Fichier : FILM
     A* Type    : PF (Fichier Physique)
     A* Desc    : Table des films
     A*================================================================
     A                                      UNIQUE
     A          R FILMFMT                   TEXT('Format fichier films')
     A            IDFILM         5P 0       COLHDG('ID' 'Film')
     A                                      TEXT('Identifiant du film')
     A            TITREFILM     50A         COLHDG('Titre' 'du film')
     A                                      TEXT('Titre du film')
     A          K IDFILM
```
