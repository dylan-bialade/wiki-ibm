---
bibliotheque: BIB10
fichier_source: QDSPSRC
membre: SOLDATD
type: DDS
longueur_enregistrement: 80
lignes: 85
modifie: 2026-11-16
---

# BIB10/QDSPSRC/SOLDATD

```text
     A*%%TS  SD  20261016  103726  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A          R FMT1                      CHGINPDFT(LC UL)
     A*%%TS  SD  20261008  153924  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF06(06)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 32'Gestion des Soldat'
     A                                      DSPATR(UL)
     A                                 23  6'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 15'F6=Creer'
     A                                      COLOR(BLU)
     A  91                             20  4'Msg erreur:'
     A                                      COLOR(RED)
     A                                  6  8'Saisissez l''id du soldat, puis ap-
     A                                      puyez sur ENTREE'
     A                                      COLOR(BLU)
     A                                  8 12'numéro du soldat:'
     A                                  3 30'Cherchez votre soldat'
     A            IDSLD     R        I  8 30REFFLD(SOLDATR/IDSLD BIB10/SOLDAT)
     A  91        EERR          35A  O 20 16COLOR(RED)
     A          R FMT2
     A*%%TS  SD  20261008  154759  XUAN        REL-V7R5M0  5770-WDS
     A                                      CHGINPDFT(UL LC)
     A                                      CF12(12 'retour')
     A                                      CF07(07 'supp')
     A                                      CF02(02 'modifier')
     A                                      CF23(23)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 72TIME
     A                                  1 32'Gestion des soldat'
     A                                      COLOR(BLU)
     A            E2MOD         25A  O  3 28
     A N30                              7  8'N°Soldat :'
     A                                  9  8'Nom      :'
     A                                 11  8'Prénom   :'
     A                                 13  8'Arme     :'
     A                                 15  8'Classe   :'
     A            NMSLD     R        B  9 19REFFLD(SOLDATR/NMSLD BIB10/SOLDAT)
     A  40                                  DSPATR(PR)
     A            PRSLD     R        B 11 19REFFLD(SOLDATR/PRSLD BIB10/SOLDAT)
     A  40                                  DSPATR(PR)
     A N30        IDSLD     R        O  7 19REFFLD(SOLDATR/IDSLD BIB10/SOLDAT)
     A            ARSLD1    R        B 13 19REFFLD(SOLDATR/ARSLD1 BIB10/SOLDAT)
     A  40                                  DSPATR(PR)
     A            CLASLD    R        B 15 19REFFLD(SOLDATR/CLASLD BIB10/SOLDAT)
     A  40                                  DSPATR(PR)
     A            E2ACT         70A  O 22  3COLOR(BLU)
     A  91                             18  7'Msg erreur:'
     A                                      COLOR(RED)
     A  91        EERR          35A  O 18 19COLOR(RED)
     A            E2HINT        50A  O  6  8COLOR(BLU)
```
