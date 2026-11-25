---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: GAP1
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 41
modifie: 2026-11-25
---

# BIB25/QRPGSRC/GAP1

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H* Déclaration du fichier en CYCLE
     H* Déclaration de QPRINT qui génèrera un SPOOL
     FLFGAP1  IP  E           K        DISK
     FQPRINT  O   F     132     OF     PRINTER
     F*
     I* Déclaration des zones de ruptures
     I* Déclaration de l'indicateur de lecture
     IFORMAT      30
     I                                              POSTE L1
     I                                              EQUIPEL2
     I*
     C* Remise à zéro des variables lors de l'activation rupture
     C   L2                MOVE *ZERO     CNT     30
     C   L2                MOVE *ZERO     AMOY    52
     C   L2                MOVE *ZERO     ATOT    50
     C   L1                MOVE *ZERO     CNT1    30
     C*
     C* Calcul : Count effectué
     C                     ADD  1         CNT
     C                     ADD  1         CNT1
     C*
     O* Remplissage du SPOOL
     OQPRINT  H        1P
     O                                      'LISTE JOUEURS NBA'
     O        D        30
     O                                      'NOM :'
     O                         NOM
     O                                      'PRENOM :'
     O                         PRENOM
     O                                      'AGE :'
     O                         AGE   4
     O        T        L1
     O                                      'TOTAL POSTE '
     O                         POSTE
     O                                      ' :'
     O                         CNT1
     O        T        L2
     O                                      'TOTAL JOUEURS '
     O                         EQUIPE
     O                                      ' : '
     O                         CNT   4
```
