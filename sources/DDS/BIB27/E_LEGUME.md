---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: E_LEGUME
type: DDS
longueur_enregistrement: 160
lignes: 56
modifie: 2026-11-25
---

# BIB27/QFREESRC/E_LEGUME

```text
     A*%%TS  SD  20231219  161635  LEO2        REL-V7R4M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A                                      CA03(03)
     A          R SF1                       SFL                                      A*%%TS  SD  20231219  134239  LEO2        REL-V7R4M0  5770-WDS
     A            EID            7S 0H                                               A            ECOULEUR      20A  H
     A            ENOM      R        O  9 12REFFLD(LEGUME/NOM BIB27/LEGUME)        A            ESAISON   R        O  9 37REFFLD(LEGUME/SAISON BIB27/LEGUME)
     A            EPOID     R        O  9 62REFFLD(LEGUME/POID BIB27/LEGUME)       A            OPT            1A  B  9  6
     A          R CTL1                      SFLCTL(SF1)                              A*%%TS  SD  20231219  161635  LEO2        REL-V7R4M0  5770-WDS
     A                                      CA05(05)                                 A                                      CF06(06)
     A                                      CF08(08)                                 A                                      OVERLAY
     A  50                                  SFLDSP                                   A  51                                  SFLDSPCTL
     A  52                                  SFLCLR                                   A  53                                  SFLEND(*MORE)
     A                                      SFLSIZ(0011)                             A                                      SFLPAG(0010)
     A                                  1 31'Gestion des légumes'                    A                                      COLOR(WHT)
     A                                  1  3SYSNAME                                  A                                  2  3USER
     A                                  1 72TIME                                     A                                  2 72DATE
     A                                      EDTCDE(Y)                                A                                  4  4'Indiquer une option et appuyé sur -
     A                                      ENTREE :'                                A                                      COLOR(BLU)
     A                                  5  4'2 = update'                             A                                      COLOR(BLU)
     A                                  5 22'4 = delete'                             A                                      COLOR(BLU)
     A                                  5 41'5 = display'                            A                                      COLOR(BLU)
     A                                  6  4'3 = copy'                               A                                      COLOR(BLU)
     A                                  8  5'opt'                                    A                                      COLOR(WHT)
     A                                  8 12'nom légumes'                            A                                      COLOR(WHT)
     A                                  8 37'saison'                                 A                                      COLOR(WHT)
     A                                  8 62'Poid(gramme)'                           A                                      COLOR(WHT)
     A                                  3 45'Afficher à partir de:'                  A            EINPUT        10A  I  3 68
     A          R BAS                                                                A*%%TS  SD  20231219  131554  LEO2        REL-V7R4M0  5770-WDS
     A                                      OVERLAY                                  A                                 21  3'f3=exit'
     A                                      COLOR(BLU)                               A                                 21 15'f5=actualiser'
     A                                      COLOR(BLU)                               A                                 21 33'f6=créer'
     A                                      COLOR(BLU)                               A                                 21 47'f8=spool'
     A                                      COLOR(BLU)                               A          R FMT1
     A*%%TS  SD  20231219  153336  LEO2        REL-V7R4M0  5770-WDS                  A                                      CF12(12)
     A                                      OVERLAY                                  A                                 21  3'f3=exit'
     A                                      COLOR(BLU)                               A                                  1 31'gestion des légumes'
     A                                      COLOR(WHT)                               A                                  1  5SYSNAME
     A                                  2  5USER                                     A                                  1 72TIME
     A                                  2 72DATE                                     A                                      EDTCDE(Y)
     A                                  6 21'ID:'                                    A  62                                  DSPATR(ND)
     A            E2ID      R        B  6 29REFFLD(LEGUME/ID BIB27/LEGUME)         A  60                                  DSPATR(PR)
     A  62                                  DSPATR(ND)                               A                                  7 20'NOM:'
     A            E2NOM     R        B  7 29REFFLD(LEGUME/NOM BIB27/LEGUME)        A  61                                  DSPATR(PR)
     A                                      CHECK(LC)                                A                                  8 17'SAISON:'
     A            E2SAISON  R        B  8 29REFFLD(LEGUME/SAISON BIB27/LEGUME)     A  61                                  DSPATR(PR)
     A                                      CHECK(LC)                                A                                  9 16'COULEUR:'
     A            E2COULEUR R        B  9 29REFFLD(LEGUME/COULEUR BIB27/LEGUM-     A                                      E)
     A  61                                  DSPATR(PR)                               A                                      CHECK(LC)
     A                                 10 19'POID:'                                  A            E2POID    R        B 10 29REFFLD(LEGUME/POID BIB27/LEGUME)
     A  61                                  DSPATR(PR)                               A                                 21 14'f12=précédent'
     A                                      COLOR(BLU)                               A            TITRE         15   O  3 33COLOR(WHT)
     A          R W1                                                                 A*%%TS  SD  20231219  160038  LEO2        REL-V7R4M0  5770-WDS
     A                                      WINDOW(4 4 10 30)                        A                                      CF12(12)
     A                                  1 14'copy'                                   A                                      COLOR(WHT)
     A                                  4 10'nouveau nom:'                           A            WNOM          20A  I  6  6
     A                                  8 10'enter=valider'                          A                                      COLOR(BLU)
     A                                  9 10'f12= annuler'                           A                                      COLOR(BLU)
```
