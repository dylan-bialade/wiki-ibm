---
bibliotheque: BIB02
fichier_source: QSQLSRC
membre: INSERTDATA
type: SQL
longueur_enregistrement: 100
lignes: 25
modifie: 2026-11-16
---

# BIB02/QSQLSRC/INSERTDATA

```sql
-- Insertion de données dans les tables
INSERT INTO BIB02.Club (Club_ID, Nom, Ville, Annee_fondation) VALUES
(1, 'Real Madrid', 'Madrid', 1902),
(2, 'FC Barcelone', 'Barcelone', 1899),
(3, 'Manchester City', 'Manchester', 1880),
(4, 'Paris SG', 'Paris', 1970),
(5, 'Bayern Munich', 'Munich', 1900);

INSERT INTO BIB02.Joueurs (Joueur_ID, Nom_joueur, Position, Numero, Club_ID)
VALUES
(1, 'Karim Benzema', 'Attaquant', 9, 1),
(2, 'Luka Modric', 'Milieu', 10, 1),
(3, 'Thibaut Courtois', 'Gardien', 1, 1),
(4, 'Robert Lewandowski', 'Attaquant', 9, 2),
(5, 'Pedri', 'Milieu', 8, 2),
(6, 'Marc-André ter Stegen', 'Gardien', 1, 2),
(7, 'Erling Haaland', 'Attaquant', 9, 3),
(8, 'Kevin De Bruyne', 'Milieu', 17, 3),
(9, 'Ederson', 'Gardien', 31, 3),
(10, 'Kylian Mbappé', 'Attaquant', 7, 4),
(11, 'Marco Verratti', 'Milieu', 6, 4),
(12, 'Gianluigi Donnarumma', 'Gardien', 99, 4),
(13, 'Thomas Müller', 'Attaquant', 25, 5),
(14, 'Joshua Kimmich', 'Milieu', 6, 5),
(15, 'Manuel Neuer', 'Gardien', 1, 5);
```
