---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: FILM
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 12
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/FILM

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
