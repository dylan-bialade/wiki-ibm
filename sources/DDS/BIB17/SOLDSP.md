---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: SOLDSP
type: DDS
longueur_enregistrement: 80
lignes: 101
modifie: 2026-11-16
---

# BIB17/QDDSSRC/SOLDSP

```text
     A*%%TS  SD  20261008  153721  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R SOLF1
     A*%%TS  SD  20261008  134650  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF06(06)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72SYSNAME
     A                                  1 31'Gestion des soldats'
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A            NMPGM         10A  O  1  3
     A                                  3 30'Chercher votre soldat'
     A                                      COLOR(WHT)
     A                                  7  3'Saisissez l''id du soldat, puis ap-
     A                                      puyez sur ENTREE'
     A                                      COLOR(BLU)
     A                                 10  7'Numéro de soldat :'
     A  70                             20  3'Msg erreur'
     A                                      COLOR(RED)
     A  70        D1ERMS        50A  O 20 15COLOR(RED)
     A                                 23  4'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 19'F6=Création'
     A                                      COLOR(BLU)
     A            D1IDS          5  0I 10 27
     A          R SOLF2
     A*%%TS  SD  20261008  112909  REMI        REL-V7R5M0  5770-WDS
     A                                      CF02(02)
     A                                      CF07(07)
     A                                      CF03(03)
     A                                      CF12(12)
     A                                  1 31'Gestion des soldats'
     A                                      DSPATR(RI)
     A                                      COLOR(PNK)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72SYSNAME
     A            NMPGM         10   O  1  3
     A                                  4 30'Affichage d''un soldat'
     A                                      COLOR(WHT)
     A                                 23  4'F2=Modifier'
     A                                      COLOR(BLU)
     A                                 23 19'F7=Supprimer'
     A                                      COLOR(BLU)
     A                                 23 35'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 46'F12=Retour'
     A                                      COLOR(BLU)
     A                                  7  6'N° Soldat :'
     A            IDSLD     R        O  7 20REFFLD(SOLDATR/IDSLD BIB17/SOL-
     A                                      DAT)
     A                                  9  6'Nom       :'
     A            NMSLD     R        O  9 20REFFLD(SOLDATR/NMSLD BIB17/SOL-
     A                                      DAT)
     A                                 11  6'Prénom    :'
     A            PRSLD     R        O 11 20REFFLD(SOLDATR/PRSLD BIB17/SOL-
     A                                      DAT)
     A                                 13  6'Arme      :'
     A            ARSLD1    R        O 13 20REFFLD(SOLDATR/ARSLD1 BIB17/SO-
     A                                      LDAT)
     A                                 15  6'Classe    :'
     A            CLASLD    R        O 15 20REFFLD(SOLDATR/CLASLD BIB17/SO-
     A                                      LDAT)
     A          R SOLF3
     A*%%TS  SD  20261008  153721  REMI        REL-V7R5M0  5770-WDS
     A                                      CF23(23)
     A                                      CF03(03)
     A                                      CF12(12)
     A                                  1 31'Gestion des soldats'
     A                                      DSPATR(RI)
     A                                      COLOR(PNK)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72SYSNAME
     A            NMPGM         10A  O  1  3
     A                                 23  3'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 12'F12=Retour'
     A                                      COLOR(BLU)
     A                                  9  6'Nom       :'
     A            NMSLD     R        B  9 20REFFLD(SOLDATR/NMSLD BIB17/SOL-
     A                                      DAT)
     A                                 11  6'Prénom    :'
     A            PRSLD     R        B 11 20REFFLD(SOLDATR/PRSLD BIB17/SOL-
     A                                      DAT)
     A                                 13  6'Arme      :'
     A            ARSLD1    R        B 13 20REFFLD(SOLDATR/ARSLD1 BIB17/SO-
     A                                      LDAT)
     A                                 15  6'Classe    :'
     A            CLASLD    R        B 15 20REFFLD(SOLDATR/CLASLD BIB17/SO-
     A                                      LDAT)
     A                                 23 24'F23=Validation'
     A                                      COLOR(BLU)
     A  80                             20  4'Msg erreur'
     A                                      COLOR(RED)
     A  80        D3ERMS        50A  O 20 16COLOR(RED)
     A            D3MOD         30A  O  3 26COLOR(WHT)
     A            D3INS         60A  O  6  5COLOR(BLU)
```
