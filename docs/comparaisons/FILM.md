# FILM : 2 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB09 | QSOURCES | DDS | 12 | 100 % | DDS (R/K/PFILE) | [FILM.md](../../sources/DDS/BIB09/FILM.md) |
| BIB05 | QRPGLESRC2 | RPG/RPG-ILE | 12 | 100 % | DDS (R/K/PFILE) | [FILM.md](../../sources/RPG/RPG-ILE/BIB05/FILM.md) |
| BIB17 | QSQLSRC | SQL | 75 | 0 % | jointure | [FILM.md](../../sources/SQL/BIB17/FILM.md) |

## Differences

- **BIB09** en propre : DDS (R/K/PFILE)
- **BIB05** en propre : DDS (R/K/PFILE)
- **BIB17** en propre : jointure
- Langages / types differents : DDS, RPG/RPG-ILE, SQL

## Codes

### BIB09 (DDS, 12 lignes)

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

### BIB05 (RPG/RPG-ILE, 12 lignes)

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

### BIB17 (SQL, 75 lignes)

```text
SELECT f.titre,
       r.nom
    FROM qf_sql.films f
         JOIN qf_sql.realisateurs r
             ON f.id_realisateur = r.id_realisateur;

SELECT *
    FROM qf_sql.seances;

SELECT *
    FROM qf_sql.films f
         JOIN qf_sql.realisateurs r
             ON f.id_realisateur = r.id_realisateur
         JOIN qf_sql.seances s
             ON f.ID_FILM = s.ID_FILM
    WHERE s.date_seance = '2026-09-29'
          AND LOWER(r.nom) = 'schmidt'
          AND LOWER(r.prenom) = 'lucas';


SELECT a.nom,
       c.personnage
    FROM qf_sql.acteurs a
         JOIN qf_sql.casting c
             ON c.id_acteur = a.id_acteur
         JOIN qf_sql.films f
             ON f.id_film = c.id_film
         JOIN qf_sql.realisateurs r
             ON r.ID_REALISATEUR = f.ID_REALISATEUR
    WHERE LOWER(r.nom) = 'tanaka'
          AND LOWER(r.prenom) = 'lena';


SELECT *
    FROM qf_sql.realisateurs r
         LEFT EXCEPTION JOIN qf_sql.films f
             ON r.ID_REALISATEUR = f.ID_REALISATEUR;

SELECT DISTINCT *
    FROM qf_sql.realisateurs r
    WHERE r.nom IN (SELECT nom
                  FROM qf_sql.acteurs)
          AND r.prenom IN (SELECT prenom
                  FROM qf_sql.acteurs)
          AND r.date_naissance IN (SELECT date_naissance
                  FROM qf_sql.acteurs)
          AND r.nationalite IN (SELECT nationalite
                  FROM qf_sql.acteurs);

SELECT DISTINCT *
    FROM qf_sql.acteurs r
    WHERE r.nom IN (SELECT nom
                  FROM qf_sql.realisateurs)
          AND r.prenom IN (SELECT prenom
                  FROM qf_sql.realisateurs)
          AND r.date_naissance IN (SELECT date_naissance
                  FROM qf_sql.realisateurs)
          AND r.nationalite IN (SELECT nationalite
                  FROM qf_sql.realisateurs);

SELECT DISTINCT r.*
    FROM qf_sql.realisateurs r
         JOIN qf_sql.acteurs a
             ON r.nom = a.nom
                 AND r.prenom = a.prenom
                 AND r.date_naissance = a.date_naissance;



SELECT COUNT(ID_casting) Nombre_acteurs,
       f.titre
    FROM qf_sql.casting c
         RIGHT JOIN qf_sql.films f
             ON f.id_film = c.id_film
    GROUP BY f.id_film, f.titre;
```
