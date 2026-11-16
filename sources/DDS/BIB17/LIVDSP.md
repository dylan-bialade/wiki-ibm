---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: LIVDSP
type: DDS
longueur_enregistrement: 80
lignes: 60
modifie: 2026-11-16
---

# BIB17/QDDSSRC/LIVDSP

```text
     A*%%TS  SD  20261007  163627  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R LIVF1
     A*%%TS  SD  20261007  144615  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF06(06)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 32'Gestion des livres'
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                 23  4'F3:Quitter'
     A                                      COLOR(BLU)
     A                                 23 24'F6:Créer'
     A                                      COLOR(BLU)
     A                                  8 11'Num ISBN...:'
     A                                  9 11'Opt........:'
     A            D1ISBN         5S 0B  8 25
     A  98                                  ERRMSG('Livre non trouvé')
     A            D1OPT          1A  B  9 25
     A  99                                  ERRMSG('Option non existante')
     A          R LIVF2
     A*%%TS  SD  20261007  163627  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF12(12)
     A                                      CF23(23)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 30'Gestion des livres e2'
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                 23  4'F3:Quiter '
     A                                      COLOR(BLU)
     A                                 23 20'F12:Retour'
     A                                      COLOR(BLU)
     A                                 23 37'F23:Suprimer '
     A                                      COLOR(BLU)
     A                                 10 23' '
     A            ISBN      R        B  7 24REFFLD(LIVREF/ISBN BIB17/LIVRE-
     A                                      S)
     A  30                                  DSPATR(PR)
     A            TITRE     R        B  8 24REFFLD(LIVREF/TITRE BIB17/LIVR-
     A                                      ES)
     A  30                                  DSPATR(PR)
     A            AUTEUR    R        B  9 24REFFLD(LIVREF/AUTEUR BIB17/LIV-
     A                                      RES)
     A  30                                  DSPATR(PR)
     A            DISPO     R        B 11 24REFFLD(LIVREF/DISPO BIB17/LIVR-
     A                                      ES)
     A  30                                  DSPATR(PR)
     A                                 11  5'Disponible.....:'
     A                                  9  5'Auteur.........:'
     A                                  8  5'Titre..........:'
     A                                  7  5'ISBN...........:'
     A  50                             16 13'Confirmer la suppression? si oui f-
     A                                      23'
     A                                      COLOR(RED)
```
