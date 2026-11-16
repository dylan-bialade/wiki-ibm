# Wiki IBM i

Projet de documentation généré à partir des exports ACS (IFS / sources).

## Structure
- `depot/sauvegardes/` : déposer ici l'export ACS (.zip / .tar / .tar.gz)
- `architecture/` : documentation d'architecture (applications, bibliothèques, flux)
- `sources/RPG|CL|SQL|Autres` : code analysé, rangé en documents .md
- `scripts/` : décompression, analyse, automatisation
- `docs/` : index général du wiki

## Flux
Export ACS -> depot/sauvegardes -> décompression isolée -> analyse -> .md -> Drive / Git
