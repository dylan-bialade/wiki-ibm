---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: GAP
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 32
modifie: 2026-11-25
---

# BIB25/QRPGSRC/GAP

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H*
     FLFGAP   IP  E           K        DISK
     FQPRINT  O   F     132     OF     PRINTER
     F*
     IFORMAT      30
     I                                              EQUIPEL1
     C*
     C   L1                MOVE *ZERO     CNT     30
     C   L1                MOVE *ZERO     AMOY    52
     C   L1                MOVE *ZERO     ATOT    50
     C*                                                 *
     C*
     C                     ADD  1         CNT
     C                     ADD  AGE       ATOT
     C           ATOT      DIV  CNT       AMOY
     O*
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
     O                                      'TOTAL JOUEURS '
     O                         EQUIPE
     O                                      ' : '
     O                         CNT   4
     O                                      '  MOY AGE :'
     O                         AMOY  4
```
