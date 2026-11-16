---
bibliotheque: BIB02
fichier_source: QVSRC
membre: SFRRPG
type: RPG/RPG-III-400
longueur_enregistrement: 100
lignes: 21
modifie: 2026-11-16
---

# BIB02/QVSRC/SFRRPG

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     C                     SETOF                         99
     C*
     C  N01N02             EXSR TR00
     C*
     C   01                EXSR TR01
     C*
     C   02                EXSR TR02
     C           FIN       TAG
     C* Appel sous-prog erreur
     C   99                EXSR ERREUR
     C*****************************************************
     C*             SOUS PROGRAMMES                       *
     C*****************************************************
     C* Sous PG Traitement écran de départ à blanc
     C           TR00      BEGSR
     C*          ----      -----
     C                     SETOF                     U1
     C                     Z-ADD0         ECOTIS                               0
     C                     Z-ADD0         EDATE                                0
     C                     EXCPTEC1
     C                     ENDSR
```
