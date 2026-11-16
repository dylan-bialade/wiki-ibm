---
bibliotheque: BIB20
fichier_source: QDDSLESRC
membre: TPILEECR
type: DDS
longueur_enregistrement: 100
lignes: 148
modifie: 2026-11-16
---

# BIB20/QDDSLESRC/TPILEECR

```text
                                            CA03(03)
     A          R MAIN
     A                                  2  2SYSNAME
     A                                      COLOR(BLU)
     A  90        MSG          100   M
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  1 32'Outils gestion ILE'
     A                                      COLOR(WHT)
     A                                  5  2'Veuillez saisir un programme ILE a-
     A                                      insi que sa bibliothèque.'
     A                                  6 27'Appuyez sur ENTRÉE pour continuer.'
     A                                  9  2'Objet  . . . .'
     A                                 11  2'Bibliothèque .'
     A            OBJ           10   B  9 18CHECK(ME)
     A            BIB           10   B 11 18CHECK(ME)
     A                                 23  2'F3=Quitter'
     A                                      COLOR(BLU)
     A          R SFL1                      SFL
     A            OPT            2N 0B 16  5
     A            PGM           10   O 16 12
     A            PGMLIB        10   O 16 27
     A            SIGN          32   O 16 42
     A          R CTL1                      SFLCTL(SFL1)
                                            CA12(12)
     A N31                                  SFLDSPCTL
     A  30                                  SFLDSP
     A                                      SFLPAG(6)
     A                                      SFLSIZ(6)
     A  33                                  SFLEND(*MORE)
     A  32                                  SFLCLR
     A            RANG           4S 0H      SFLRCDNBR
     A  90        MSG          100   M
     A                                  1 32'Outils gestion ILE'
     A                                      COLOR(WHT)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  2  2SYSNAME
     A                                      COLOR(BLU)
     A                                  4  3'Programme :'
     A                                      COLOR(WHT)
     A                                  4 30'Bibliothèque :'
     A                                      COLOR(WHT)
     A            OBJ           10   O  4 16COLOR(BLU)
     A            BIB           10   O  4 46COLOR(BLU)
     A                                  6  3'Libellé :'
     A                                  7  3'Propriétaire :'
     A                                  8  3'Date de création :'
     A                                  9  3'Date de modification :'
     A                                 10  3'Date dernière utilisation :'
     A                                 11  3'Jour utilisé :'
     A            PROPRIO       10   O  7 36
     A            DATEMODIF     10   O  9 36
     A            DATEUTIL      10   O 10 36
     A            DATECREA      10   O  8 36
     A            JOUR          10  0O 11 36EDTCDE(J)
     A            LIBELLE       67      6 14
     A  30                             13  5'Liste des programmes de services l-
     A                                      iés :'
     A                                      COLOR(BLU)
     A  30                             15 12'PGM'
     A                                      COLOR(WHT)
     A  30                             15 27'PGM LIB'
     A                                      COLOR(WHT)
     A  30                             15 42'SIGNATURE'
     A                                      COLOR(WHT)
     A  30                             14  8'Option :  14=Recompiler'
     A                                      COLOR(BLU)
     A  30                             15  5'OPT'
     A                                      COLOR(WHT)
     A          R BASSFL1
     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 17'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 34'F13=Voir modules'
     A                                      COLOR(BLU)
     A          R SFL2                      SFL
     A            OPT2           2N 0B 10  3
     A            PGM2          10   O 10  8
        50                                  COLOR(RED)
     A            PGMLIB2       10   O 10 21
        50                                  COLOR(RED)
     A            ATTR          10     10 35
        50                                  COLOR(RED)
     A            SRCFILE       10     10 49
        50                                  COLOR(RED)
     A            BIBSRCFILE    10     10 63
        50                                  COLOR(RED)
                  TIMESTAMP     19   H
     A          R CTL2                      SFLCTL(SFL2)
                                            CA12(12)
     A N31                                  SFLDSPCTL
     A  30                                  SFLDSP
     A                                      SFLPAG(10)
     A                                      SFLSIZ(10)
     A  33                                  SFLEND(*MORE)
     A  32                                  SFLCLR
     A            RANG           4S 0H      SFLRCDNBR
     A  90        MSG          100   M
     A                                  1 35'Liste module'
     A                                      COLOR(WHT)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  2  2SYSNAME
     A                                      COLOR(BLU)
     A                                  4  3'Programme :'
     A                                      COLOR(WHT)
     A                                  4 30'Bibliothèque :'
     A                                      COLOR(WHT)
     A            OBJ           10   O  4 16COLOR(BLU)
     A            BIB           10   O  4 46COLOR(BLU)
     A                                  6  3'Veuillez saisir une option et appu-
     A                                      yez sur ENTRÉE.'
     A                                      COLOR(BLU)
     A                                  7  8'Option :  5=Voir source   14=Recom-
                                            piler module avec service    15=Rec-
                                            ompiler module'
     A                                      COLOR(BLU)
     A                                  9  3'OPT'
     A                                      COLOR(WHT)
     A                                  9  8'Nom'
     A                                      COLOR(WHT)
     A                                  9 21'BIB'
     A                                      COLOR(WHT)
     A                                  9 35'Attribut'
     A                                      COLOR(WHT)
     A                                  9 47'Fichier SRC'
     A                                      COLOR(WHT)
     A                                  9 63'BIB Fichier SRC'
     A                                      COLOR(WHT)
     A          R BASSFL2
     A                                 21  2'Rouge = Module point entrée'
     A                                      COLOR(RED)
     A                                 23  2'F3=Quitter    F12=Précédent'
     A                                      COLOR(BLU)
```
