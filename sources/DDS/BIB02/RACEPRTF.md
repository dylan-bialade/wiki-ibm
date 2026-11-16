---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: RACEPRTF
type: DDS
longueur_enregistrement: 100
lignes: 36
modifie: 2026-11-16
---

# BIB02/QDDSRC/RACEPRTF

```text
     A          R ENTETE
     A                                      SPACEB(001)
     A                                     1'**ENTETE**'
     A
     A
     A*****************************************************************
     A          R DETAIL
     A                                      SPACEB(001)
     A            TDTRACE         L  O     3
     A            TLIBELLE      10   O    +2
     A            TNMRACE       30   O    +7
     A            TDSRACE        3S 0O    +7
     A            TT1RACE         T  O    +9
     A            TP3RACE        4S  O    +9
     A*****************************************************************
     A          R TITRE
     A                                      SPACEB(001)
     A                                     3'Date'
     A                                    15'Cat'
     A                                    32'Nom Course'
     A                                    69'Distance'
     A                                    81'Temps'
     A                                    98'Position'
     A
     A*****************************************************************
     A          R SA
     A                                      SPACEB(001)
     A                                     2'TOTAL'
     A            TDTRACESM      2S  O     8
     A            TDTRACESA      4S  O    12
     A            TDTRACEDS      4S  O    21
     A            TDTRACEMT       T  O    32
     A            TDTRACEMP      4S  O    51
     A*****************************************************************
     A          R EJECT                     SKIPA(1)
     A                                   117'À SUIVRE ... ->'
```
