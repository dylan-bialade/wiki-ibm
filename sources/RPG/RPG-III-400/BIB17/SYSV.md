---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: SYSV
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 24
modifie: 2026-11-16
---

# BIB17/QRPGSRC/SYSV

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
select * from rst001.produit;

select * from rst001.reappro;

SELECT curdate() - 12 MONTHS from sysibm.sysdummy1;

SELECT
       CASE
           WHEN r.fourn IS NULL THEN 'Aucun réapprovisionnement'
           ELSE r.fourn
       END AS Fournisseur,
       COUNT(DISTINCT p.codpro) AS NbProduitsDistincts,
       SUM(r.qtecmd) AS TotalQuantites,
       SUM(r.qtecmd * p.priuni) AS ValeurTotale
    FROM rst001.produit p
         LEFT JOIN rst001.reappro r
             ON p.codpro = r.codpro
                 AND r.datrep >= CURRENT DATE - 12 MONTHS
    GROUP BY
        CASE
            WHEN r.fourn IS NULL THEN 'Aucun réapprovisionnement'
            ELSE r.fourn
        END
    ORDER BY ValeurTotale DESC;
```
