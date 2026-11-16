---
bibliotheque: BIB12
fichier_source: QDDSSRC
membre: ANIPRT
type: DDS
longueur_enregistrement: 100
lignes: 29
modifie: 2026-11-16
---

# BIB12/QDDSSRC/ANIPRT

```text
     A*
     A* --- Page Header Format ---
     A          R HDRREC                    SKIPB(1)
     A                                    45'LISTE DE PERSONNAGES'
     A                                   105'Page:'
     A                                   111PAGNBR
                R SPACE1                    SPACEA(1)
                                           1' '
                R SPACE2                    SPACEA(2)
                                           1' '
     A*
     A* --- Column Headings Format ---
     A          R COLHDR
     A                                     2'NOM'
     A                                    20'PRENOM'
     A                                    38'UNIVERS'
     A                                    61'TEMPS'
                R SEP
     A                                     2'---------------'
     A                                    20'---------------'
     A                                    38'--------------------'
     A                                    61'----------'
     A*
     A* --- Detail Line Format ---
     A          R DETAIL                    SPACEB(1)
     A            P_NOM         15A        2
     A            P_PRENOM      15A       20
     A            P_UNIVERS     20A       38
     A            P_TEMPS       20        61
```
