---
bibliotheque: BIB21
fichier_source: QEXOSRC
membre: FILMCAST
type: DDS
longueur_enregistrement: 100
lignes: 30
modifie: 2026-11-16
---

# BIB21/QEXOSRC/FILMCAST

```text
     A*****************************************************************
     A* FILMCAST : films a plat (film + realisateur + casting)        *
     A* Une ligne par acteur du casting ; un film sans casting donne  *
     A* une ligne avec ACTEUR a blanc. Alimente par FILMCASI (SQL).   *
     A* Creation (tri francais : accents ranges avec les lettres) :   *
     A*   CRTPF FILE(BIB21/FILMCAST) SRCFILE(BIB21/QEXOSRC)       *
     A*         SRTSEQ(*LANGIDSHR) LANGID(FRA) SIZE(*NOMAX)           *
     A*****************************************************************
     A          R FILMCASR                  TEXT('Films a plat pour cycle RPG')
     A            PAYS          20A         TEXT('Pays de production')
     A            GENRE         20A         TEXT('Genre du film')
     A            TITRE         40A         TEXT('Titre')
     A            IDFILM         5S 0       TEXT('Identifiant du film')
     A            ANNEE          4S 0       TEXT('Annee de sortie')
     A            DUREE          3S 0       TEXT('Duree en minutes')
     A            REALIS        40A         TEXT('Realisateur prenom nom')
     A            BUDGET         7S 2       TEXT('Budget en millions EUR')
     A            RECET          9S 2       TEXT('Recettes en millions EUR')
     A            NOTE           2S 1       TEXT('Note presse sur 5')
     A            CLASSI        12A         TEXT('Classification')
     A            ORDRE          2S 0       TEXT('Ordre au generique')
     A            ACTEUR        40A         TEXT('Acteur prenom nom')
     A            PERSO         40A         TEXT('Personnage')
     A            ROLE          12A         TEXT('Type de role')
     A            CACHET         9S 2       TEXT('Cachet en milliers EUR')
     A          K PAYS
     A          K GENRE
     A          K TITRE
     A          K IDFILM
     A          K ORDRE
```
