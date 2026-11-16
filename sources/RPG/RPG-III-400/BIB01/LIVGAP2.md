---
bibliotheque: BIB01
fichier_source: QRPGSRC
membre: LIVGAP2
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 109
modifie: 2026-11-16
---

# BIB01/QRPGSRC/LIVGAP2

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H            D
     *** Déclaration de fichier IP = Input Primary (Cycle) ***********
     FTLIVL2  IP  E           K        DISK
     FQPRINT  O   F     132     OV     PRINTER
     *** Déclaration de tableau chargé à la compilation **************
     E                    TTIT    1   2 80
     E                    TEC    80  80  1
     E                    TEAR    1   3 74
     E                    TEAS    1   3 52
     E                    TOT     1   4 80
     ILIVSF       83
     I                                              LIIDCLL4
     I                                              LIAALIL3
     I                                              LIMMLIL2
     I                                              LIJJLIL1
     IDS1         DS
     I                                        1   20LIJJLI
     I                                        3   40LIMMLI
     I                                        5   60LIAALI
     I                                        1   60DSDATE
     *** Traitement **************************************************
     C                     MOVE LIIDCL    TXT     6
     C                     MOVEATXT       TEC,14
     C                     MOVEALINOCL    TEC,23
      *
     C           LIQTLI    MULT LIPUHT    TTLIHT  82
     C           TTLIHT    ADD  TOTOHT    TOTOHT  92
      *
     C           LITXTV    DIV  100       WTVA    52
     C           WTVA      ADD  1         WTVA
     C           TTLIHT    MULT WTVA      TOLITC  92
     C           TOLITC    ADD  TOTTTC    TOTTTC  92
     *** Fin Traitement **********************************************
     *** Output ******************************************************
     *-------Header ----------------------------*
     OQPRINT  H  1 1   L1
     O       OR        OV
     O                                 +  1 'DATE :'
     O                         UDATE Y +  1
     O                                   76 'PAGE :'
     O                         PAGE      80
     O        H        L1
     O       OR        OV
     O                         TTIT,1
     O        H  2     L1
     O       OR        OV
     O                         TTIT,2
     O        D  2     L1
     O                         TEC
     O                         DSDATE    58 '  /  /  '
     O        D        L1
     O                         TEAR,3
     O                         TEAS,3
     O        D        L1
     O                         TEAR,2
     O                         TEAS,2
     O        D        L1
     O                         TEAR,1
     O                         TEAS,1
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
     O                         TOLITC4B+  1
     O                                 +  1 '|'
     O                         LITXTV4B+  1
     O                                 +  1 '|'
     *------ TOTAL ------------------------------*
     O        T        L1
     O                         TEAR,3
     O                         TEAS,3
     O        T 2      L1
     O                         TOT,1
     O        T 1      L1
     O                         TOT,2
     O                         TOTOHT4B  27
     O        T 1      L1
     O                         TOT,3
     O                         TOTTTC4B  27
     O        T 1      L1
     O                         TOT,4
     *--- TABLEAU --------------------------------------------------*
** TTIT
                            BON DE LIVRAISON
                            ----------------
** TEC
  Client :                                Livraison du :
** TEAR
+-------------------------------------------------------------------------
| Code ar.| Article                       |   Qté   |  PU HT |  TOTAL HT |
+---------+-------------------------------+---------+--------+-----------+
** TEAS
--------------------+
  TOTAL TTC | TVA   |
--------------------+
** TOT
+---------------------------+
| TOTAL HT  :  |            |
| TOTAL TTC :  |            |
+---------------------------+
```
