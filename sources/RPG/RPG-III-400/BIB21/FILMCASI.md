---
bibliotheque: BIB21
fichier_source: QEXOSRC
membre: FILMCASI
type: RPG/RPG-III-400
longueur_enregistrement: 100
lignes: 42
modifie: 2026-11-16
---

# BIB21/QEXOSRC/FILMCASI

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
-- ==================================================================
-- FILMCASI : alimentation du fichier a plat FILMCAST depuis QF_SQL
--   une ligne par acteur du casting (film + realisateur + acteur)
--   film sans casting -> une ligne avec ACTEUR a blanc
-- Lancement :
--   RUNSQLSTM SRCFILE(BIB21/QEXOSRC) SRCMBR(FILMCASI)
--             COMMIT(*NONE) NAMING(*SYS) DFTRDBCOL(BIB21)
-- ==================================================================
DELETE FROM FILMCAST;

INSERT INTO FILMCAST
  (PAYS, GENRE, TITRE, IDFILM, ANNEE, DUREE, REALIS,
   BUDGET, RECET, NOTE, CLASSI,
   ORDRE, ACTEUR, PERSO, ROLE, CACHET)
SELECT
  F.PAYS,
  COALESCE(F.GENRE, 'Non classe'),
  F.TITRE,
  F.ID_FILM,
  F.ANNEE_SORTIE,
  COALESCE(F.DUREE_MIN, 0),
  COALESCE(TRIM(R.PRENOM) CONCAT ' ' CONCAT TRIM(R.NOM), ' '),
  COALESCE(F.BUDGET_MEUR, 0),
  COALESCE(F.RECETTES_MEUR, 0),
  COALESCE(F.NOTE_PRESSE, 0),
  F.CLASSIFICATION,
  COALESCE(C.ORDRE_GENERIQUE, 0),
  CASE WHEN C.ID_CASTING IS NULL THEN ' '
       ELSE COALESCE(TRIM(A.PRENOM) CONCAT ' ' CONCAT TRIM(A.NOM),
                     'Acteur ' CONCAT VARCHAR(C.ID_ACTEUR)
                               CONCAT ' inconnu')
  END,
  COALESCE(C.PERSONNAGE, ' '),
  COALESCE(C.TYPE_ROLE, ' '),
  COALESCE(C.CACHET_KEUR, 0)
FROM QF_SQL.FILMS F
     LEFT JOIN QF_SQL.REALISATEURS R
            ON R.ID_REALISATEUR = F.ID_REALISATEUR
     LEFT JOIN QF_SQL.CASTING C
            ON C.ID_FILM = F.ID_FILM
     LEFT JOIN QF_SQL.ACTEURS A
            ON A.ID_ACTEUR = C.ID_ACTEUR;
```
