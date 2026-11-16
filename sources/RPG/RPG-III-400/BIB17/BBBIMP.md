---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: BBBIMP
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 59
modifie: 2026-11-16
---

# BIB17/QRPGSRC/BBBIMP

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FBBNLF2  IF  E           K        DISK
     FQPRINT  O   F     132     OA    LPRINTER
      *
     E                    TBB     1   4 80
      *
     LQPRINT   16FL 14OL
      *
     IFBONBON
     I              COULEUR                         COLOR
     I           SDS
     I                                      270 2750DATE
      *
     *  IMPRESSION DE ENTETE
     C                     MOVE DATE      DATEI   60
     C                     EXCPTENT
      *
     C           *LOVAL    SETLLFBONBON
     C                     READ FBONBON                  99
     C           *IN99     DOWEQ'0'
     C   OA                EXCPTENT
     C                     EXCPTDET
     C                     READ FBONBON                  99
     C                     ENDDO
     C                     EXCPTFIN
     C                     SETON                     LR
      *
      *
     *   ENTETE DE L'IMPRESSION
     OQPRINT  E  1 1           ENT
     O                                   45 'LISTE DES BONBONS'
     O                                   65 'Edité le :'
     O                         DATEI Y   75
      *
     *   ENTETE DE L'IMPRESSION SOUS LIGNE
     OQPRINT  E  1             ENT
     O                                   45 '==================='
      *
     OQPRINT  E  3             ENT
     O                         TBB,1
     OQPRINT  E  1             ENT
     O                         TBB,2
     OQPRINT  E  1             ENT
     O                         TBB,3
     * LIGNES DE CORPS
     OQPRINT  E  1             DET
     O                         TBB,4     80
     O                         NUMBER     8
     O                         NOM       31
     O                         MARQUE    54
     O                         COLOR     67
     O                         PRIX      77 '  0 ,  &€'
     * FIN D'IMPRESSION
     O        E  1             FIN
     O                         TBB,1
**
+----------------------------------------------------------------------------+
| Numero | Nom                  | Marque               | Couleur   |  Prix   |
|--------|----------------------|----------------------|-----------|---------|
| XXXXXX | xxxxxxxxx1xxxxxxxxx2 | xxxxxxxxx1xxxxxxxxx2 | xxxxxxxxx1|xxx,xx € |
```
