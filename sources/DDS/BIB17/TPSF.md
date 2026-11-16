---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: TPSF
type: DDS
longueur_enregistrement: 160
lignes: 54
modifie: 2026-11-16
---

# BIB17/QDDSSRC/TPSF

```text
     A*%%TS  SD  20261011  165638  REMI        REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A                                      CF03(03)
     A          R SFL1                      SFL                                      A*%%TS  SD  20261011  134640  REMI        REL-V7R5M0  5770-WDS
     A            TITRE     R        O 11  8REFFLD(LIVREF/TITRE BIB17/LIVR-     A                                      ES)
     A            AUTEUR    R        O 11 39REFFLD(LIVREF/AUTEUR BIB17/LIV-     A                                      RES)
     A            DISPO     R        O 11 72REFFLD(LIVREF/DISPO BIB17/LIVR-     A                                      ES)
     A            E1OPT          2S 0B 11  2                                         A            ISBN           5  0H
     A          R CTL1                      SFLCTL(SFL1)                             A*%%TS  SD  20261009  145853  REMI        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0010)                             A                                      SFLPAG(0009)
     A                                      OVERLAY                                  A  30                                  SFLDSP
     A  31                                  SFLDSPCTL                                A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)                            A                                  1  2SYSNAME
     A                                  2  2USER                                     A                                  1 31'Sous fichiers livres'
     A                                      COLOR(WHT)                               A                                  1 72DATE
     A                                      EDTCDE(Y)                                A                                  2 72TIME
     A                                  5  3'    '                                   A                                      COLOR(WHT)
     A                                  6  4'Indiquez vos options, puis appuyez-     A                                       sur ENTREE'
     A                                      COLOR(BLU)                               A                                 10  2'opt'
     A                                      COLOR(WHT)                               A                                 10  8'Titre'
     A                                      COLOR(WHT)                               A                                 10 39'Auteur'
     A                                      COLOR(WHT)                               A                                 10 72'Dispo'
     A                                      COLOR(WHT)                               A                                  7  5'2=Editer'
     A                                      COLOR(BLU)                               A                                  7 27'5=afficher'
     A                                      COLOR(BLU)                               A                                  7 15'4=Supprimer'
     A                                      COLOR(BLU)                               A          R REC1
     A*%%TS  SD  20261009  112928  REMI        REL-V7R5M0  5770-WDS                  A                                      OVERLAY
     A                                 23  2'F3=Quitter F12=Retour'                  A                                      COLOR(BLU)
     A          R DSPAF                                                              A*%%TS  SD  20261011  165638  REMI        REL-V7R5M0  5770-WDS
     A                                      CF12(12)                                 A                                      CF21(21)
     A                                  1  2SYSNAME                                  A                                  2  2USER
     A                                      DSPATR(UL)                               A                                  1 72DATE
     A                                      EDTCDE(Y)                                A                                  2 72TIME
     A                                  1 33'Gestion de livre'                       A                                      COLOR(PNK)
     A            DAFMOD        20A  O  2 31COLOR(WHT)                               A                                  8  7'ISBN......:'
     A                                 10  7'TITRE.....:'                            A                                 12  7'Auteur....:'
     A                                 14  7'Disponible:'                            A            ISBN      R        B  8 19REFFLD(LIVREF/ISBN BIB17/LIVRE-
     A                                      S)                                       A                                      DSPATR(PR)
     A            TITRE     R        B 10 19REFFLD(LIVREF/TITRE BIB17/LIVR-     A                                      ES)
     A  50                                  DSPATR(PR)                               A            AUTEUR    R        B 12 19REFFLD(LIVREF/AUTEUR BIB17/LIV-
     A                                      RES)                                     A  50                                  DSPATR(PR)
     A            DISPO     R        B 14 19REFFLD(LIVREF/DISPO BIB17/LIVR-     A                                      ES)
     A  50                                  DSPATR(PR)                               A                                 22  5'F3=Quitter F12=Retour F21=Valider'
     A                                      COLOR(BLU)                               A          R SFL2                      SFL
     A*%%TS  SD  20261011  165638  REMI        REL-V7R5M0  5770-WDS                  A            ISBN      R        B  6  2REFFLD(LIVREF/ISBN BIB17/LIVRE-
     A                                      SL)                                      A                                      DSPATR(PR)
     A            TITRE     R        O  6  9REFFLD(LIVREF/TITRE BIB17/LIVR-     A                                      ESL)
     A            AUTEUR    R        O  6 41REFFLD(LIVREF/AUTEUR BIB17/LIV-     A                                      RESL)
     A          R CTL2                      SFLCTL(SFL2)                             A*%%TS  SD  20261011  151738  REMI        REL-V7R5M0  5770-WDS
     A                                      CF12(12)                                 A                                      OVERLAY
     A  40                                  SFLDSP                                   A  41                                  SFLDSPCTL
     A  42                                  SFLCLR                                   A  43                                  SFLEND(*MORE)
     A                                      SFLSIZ(0010)                             A                                      SFLPAG(0009)
     A                                  1 21'Suppression des enregistrements de-     A                                       livre'
     A                                      COLOR(RED)                               A                                  3 12'Entrer pour pour confirmer'
```
