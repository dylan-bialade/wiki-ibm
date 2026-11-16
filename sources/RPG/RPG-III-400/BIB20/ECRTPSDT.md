---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: ECRTPSDT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 155
modifie: 2026-11-16
---

# BIB20/QRPGSRC/ECRTPSDT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20251022  150037  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A          R SAISIE
     A*%%TS  SD  20251022  150037  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CA06(06)
     A                                  1 31'Gestion des soldats'
     A                                      DSPATR(RI)
     A                                      COLOR(BLU)
     A                                  1  3'TPRPGSDT'
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                  2 73'AGRION'
     A                                  4 30'Chercher votre soldat'
     A                                      COLOR(BLU)
     A                                  8  3'Saisissez l id du soldat, puis app-
     A                                      uyez sur ENTREE'
     A                                      COLOR(PNK)
     A                                 11  8'Numéro du soldat :'
     A            ESID      R        B 11 28REFFLD(SOLDATF/IDSDT BIB20/SOLDAT)
     A                                      EDTCDE(Q)
     A  91                                  DSPATR(RI)
     A  91                                  DSPATR(PC)
     A  90        MSGERS        65   O 20  3
     A  89                                  COLOR(WHT)
     A N89                                  COLOR(RED)
     A                                 23  3'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 20'F6=Création'
     A                                      COLOR(BLU)
     A          R CREATION
     A*%%TS  SD  20251021  160836  GGEOFFREY   REL-V7R5M0  5770-WDS
                                            CA12(12)
                                            CF23(23)
     A                                  1 31'Gestion des soldats'
     A                                      DSPATR(RI)
     A                                      COLOR(BLU)
     A                                  1  3'TPRPGSDT'
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                  2 73'AGRION'
     A  90        MSGERC        65A  O 20  3
     A  89                                  COLOR(WHT)
     A N89                                  COLOR(RED)
     A                                 23  3'F3=Sortir'
     A                                      COLOR(BLU)
     A                                  4 31'Création d un soldat'
     A                                      COLOR(BLU)
     A                                  8  3'Ajouter les données d un soldat, p-
     A                                      uis appuyez sur F23'
     A                                      COLOR(PNK)
     A                                 10  9'Nom  . . . . :'
     A                                 12  9'Prénom . . . :'
     A                                 14  9'Arme . . . . :'
     A                                 16  9'Arme 2 . . . :'
     A                                 18  9'Classe . . . :'
     A                                 23 19'F12=Retour'
     A                                      COLOR(BLU)
     A                                 23 34'F23=Validation'
     A                                      COLOR(BLU)
     A            ECNMSD    R        B 10 24REFFLD(SOLDATF/NMSDT BIB20/SOLDAT)
     A  92                                  DSPATR(RI)
     A  92                                  DSPATR(PC)
     A            ECPRSD    R        B 12 24REFFLD(SOLDATF/PRSDT BIB20/SOLDAT)
     A  93                                  DSPATR(RI)
     A  93                                  DSPATR(PC)
     A            ECARS1    R        B 14 24REFFLD(SOLDATF/ARSDT1 BIB20/SOLDAT)
     A  94                                  DSPATR(RI)
     A  94                                  DSPATR(PC)
     A            ECARS2    R        B 16 24REFFLD(SOLDATF/ARSDT2 BIB20/SOLDAT)
     A  95                                  DSPATR(RI)
     A  95                                  DSPATR(PC)
     A            ECCLAS    R        B 18 24REFFLD(SOLDATF/CLASID BIB20/SOLDAT)
     A  96                                  DSPATR(RI)
     A  96                                  DSPATR(PC)
     A          R MODIF
     A*%%TS  SD  20251022  150037  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CA12(12)
     A                                      CF23(23)
     A                                  1 31'Gestion des soldats'
     A                                      DSPATR(RI)
     A                                      COLOR(BLU)
     A                                  1  3'TPRPGSDT'
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                  2 73'AGRION'
     A  90        MSGERM        65   O 20  3
     A  89                                  COLOR(WHT)
     A N89                                  COLOR(RED)
     A                                 23  3'F3=Sortir'
     A                                      COLOR(BLU)
     A                                  8  3'Modifiez les données d''un soldat,-
     A                                       puis appuyez sur F23'
     A                                      COLOR(PNK)
     A                                 10  9'Nom  . . . . :'
     A                                 12  9'Prénom . . . :'
     A                                 14  9'Arme . . . . :'
     A                                 16  9'Arme 2 . . . :'
     A                                 18  9'Classe . . . :'
     A                                 23 19'F12=Retour'
     A                                      COLOR(BLU)
     A                                 23 34'F23=Validation'
     A                                      COLOR(BLU)
     A            EMNMSD    R        B 10 24REFFLD(SOLDATF/NMSDT BIB20/SOLDAT)
     A  92                                  DSPATR(RI)
     A  92                                  DSPATR(PC)
     A            EMPRSD    R        B 12 24REFFLD(SOLDATF/PRSDT BIB20/SOLDAT)
     A  93                                  DSPATR(RI)
     A  93                                  DSPATR(PC)
     A            EMARS1    R        B 14 24REFFLD(SOLDATF/ARSDT1 BIB20/SOLDAT)
     A  94                                  DSPATR(RI)
     A  94                                  DSPATR(PC)
     A            EMARS2    R        B 16 24REFFLD(SOLDATF/ARSDT2 BIB20/SOLDAT)
     A  95                                  DSPATR(RI)
     A  95                                  DSPATR(PC)
     A            EMCLAS    R        B 18 24REFFLD(SOLDATF/CLASID BIB20/SOLDAT)
     A  96                                  DSPATR(RI)
     A  96                                  DSPATR(PC)
     A                                  4 29'Modification d un soldat'
     A                                      COLOR(BLU)
     A          R AFFICHE
     A*%%TS  SD  20251021  160836  GGEOFFREY   REL-V7R5M0  5770-WDS
                                            CF02(02)
                                            CF07(07)
                                            CA12(12)
     A                                  1 31'Gestion des soldats'
     A                                      DSPATR(RI)
     A                                      COLOR(BLU)
     A                                  1  3'TPRPGSDT'
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                  2 73'AGRION'
     A                                 23 19'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 10  9'Nom  . . . . :'
     A                                 12  9'Prénom . . . :'
     A                                 14  9'Arme . . . . :'
     A                                 16  9'Arme 2 . . . :'
     A                                 18  9'Classe . . . :'
     A                                 23 48'F12=Retour'
     A                                      COLOR(BLU)
     A            EANMSD    R        O 10 24REFFLD(SOLDATF/NMSDT BIB20/SOLDAT)
     A            EAPRSD    R        O 12 24REFFLD(SOLDATF/PRSDT BIB20/SOLDAT)
     A            EAARS1    R        O 14 24REFFLD(SOLDATF/ARSDT1 BIB20/SOLDAT)
     A            EAARS2    R        O 16 24REFFLD(SOLDATF/ARSDT2 BIB20/SOLDAT)
     A            EACLAS    R        O 18 24REFFLD(SOLDATF/CLASID BIB20/SOLDAT)
     A                                  4 30'Affichage d un soldat'
     A                                      COLOR(BLU)
     A                                  8  9'N° soldat  . :'
     A            EAIDSD    R        O  8 24REFFLD(SOLDATF/IDSDT BIB20/SOLDAT)
     A                                 23 32'F7=Supprimer'
     A                                      COLOR(BLU)
     A                                 23  3'F2=Modifier'
     A                                      COLOR(BLU)
```
