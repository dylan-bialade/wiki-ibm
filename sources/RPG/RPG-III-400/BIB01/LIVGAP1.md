---
bibliotheque: BIB01
fichier_source: QRPGSRC
membre: LIVGAP1
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 78
modifie: 2026-11-16
---

# BIB01/QRPGSRC/LIVGAP1

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H            D
     *** Déclaration de fichier IP = Input Primary (Cycle) ***********
     FTLIVL1  IP  E           K        DISK
     FQPRINT  O   F     132     OV     PRINTER
     *** Déclaration de tableau chargé à la compilation **************
     E                    TTIT    1   2 80
     E                    TEC    80  80  1
     E                    TEAR    1   3 80
     ILIVSF       83
     I                                              LIIDCLL1
     *** Traitement **************************************************
     C                     MOVE LIIDCL    TXT     6
     C                     MOVEATXT       TEC,12
     C                     MOVEALINOCL    TEC,19
     C           LIQTLI    MULT LIPUHT    TTLIHT  82
     C           LIQTLI    ADD  TOTONB    TOTONB  60
     C           TTLIHT    ADD  TOTOHT    TOTOHT  92
     *** Fin Traitement **********************************************
     *** Output ******************************************************
     *-------Header ----------------------------*
     OQPRINT  H  1 1   1P
     O       OR        OV
     O                                 +  1 'DATE :'
     O                         UDATE Y +  1
     O                                   76 'PAGE :'
     O                         PAGE      80
     O        H        1P
     O       OR        OV
     O                         TTIT,1    80
     O        H  2     1P
     O       OR        OV
     O                         TTIT,2    80
     O        D        L1
     O                         TEAR,3    80
     O        D        L1
     O                         TEC       80
     O        D        L1
     O                         TEAR,3    80
     O        D        L1
     O                         TEAR,2    80
     O        D        L1
     O                         TEAR,1    80
     *------ Detail -----------------------------*
     O        D        83
     O                                      '|'
     O                         LICOAR B+  1 '   .   '
     O                                 +  1 '|'
     O                         LINOAR B+  1
     O                                      '|'
     O                         LIQTLI B+  1 '      0'
     O                                 +  1 '|'
     O                         LIPUHT4B
     O                                 +  1 '|'
     O                         TTLIHT4B+  1
     O                                 +  1 '|'
     *------ TOTAL ------------------------------*
     O        T        L1
     O                         TEAR,1    80
     O        T        L1
     O                                      '|'
     O                                   43 'TOTAL : |'
     O                         TOTONB4B  51
     O                                 +  1 '|'
     O                                   62 '|'
     O                         TOTOHT4B  72
     O                                 +  1 '|'
     O        T  2     L1
     O                         TEAR,3
     *--- TABLEAU --------------------------------------------------*
** TTIT
                     LISTE DES LIVRAISONS PAR CLIENT
                     -------------------------------
** TEC
| Client :                                                               |
** TEAR
|---------|-------------------------------|---------|--------|-----------|
| Code ar.| Article                       |   Qté   |  PU HT |  TOTAL HT |
|------------------------------------------------------------------------|
```
