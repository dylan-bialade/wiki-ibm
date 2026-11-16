---
bibliotheque: BIB17
fichier_source: QSQLSRC
membre: FILM
type: SQL
longueur_enregistrement: 100
lignes: 75
modifie: 2026-11-16
---

# BIB17/QSQLSRC/FILM

```sql
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
