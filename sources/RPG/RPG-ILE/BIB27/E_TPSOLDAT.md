---
bibliotheque: BIB27
fichier_source: QSQLRPGLE
membre: E_TPSOLDAT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 141
modifie: 2026-11-25
---

# BIB27/QSQLRPGLE/E_TPSOLDAT

```text
     A*%%TS  SD  20231208  162707  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      CF12(12)
     A          R FMT1
     A*%%TS  SD  20231208  162707  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF06(06)
     A                                  2  5'tpsoldat'
     A                                  2 31'gestion des soldats'
     A                                      COLOR(PNK)
     A                                  2 69DATE
     A                                      EDTCDE(Y)
     A                                  3 69SYSNAME
     A                                  4 31'chercher votre soldat'
     A                                  6  5'saisissez l''id du soldat, puis ap-
     A                                      puyer sur ENTREE :'
     A                                      COLOR(BLU)
     A                                  9 10'Numéro du soldat : '
     A            E1_ID          6S 0I  9 32
     A                                 22  3'f3=EXIT'
     A                                      COLOR(BLU)
     A                                 22 15'f6=CREATION'
     A                                      COLOR(BLU)
     A                                 19  4'Msg erreur:'
     A                                      COLOR(RED)
     A            E1_ERREUR     50A  O 19 17COLOR(RED)
     A          R FMT2
     A*%%TS  SD  20231208  155812  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF02(02)
     A                                      CF07(07)
     A                                  2  5'tpsoldat'
     A                                  2 31'gestion des soldats'
     A                                      COLOR(PNK)
     A                                  2 69DATE
     A                                      EDTCDE(Y)
     A                                  3 69SYSNAME
     A                                  4 31'Affichage d un soldat'
     A                                 22 34'f3=EXIT'
     A                                      COLOR(BLU)
     A                                 22  5'f2=MODIFIER'
     A                                      COLOR(BLU)
     A                                 22 19'f7=SUPPRIMER'
     A                                      COLOR(BLU)
     A                                 22 45'f12=RETOUR'
     A                                      COLOR(BLU)
     A                                  7  6'N° Soldat :'
     A                                  9  6'Nom       :'
     A                                 11  6'Prénom    :'
     A                                 13  6'Arme      :'
     A                                 15  6'Arme2     :'
     A                                 17  6'Classe    :'
     A            E2_PRENOM R        O 11 19REFFLD(SOLDAT/PRENOM_SLD BIB27/SO-
     A                                      LDAT)
     A            E2_ARME   R        O 13 19REFFLD(SOLDAT/ARME_SLD BIB27/SOLD-
     A                                      AT)
     A            E2_ARME2  R        O 15 19REFFLD(SOLDAT/ARME2_SLD BIB27/SOL-
     A                                      DAT)
     A            E2_CLASSE R        O 17 19REFFLD(SOLDAT/CLASSE_SLD BIB27/SO-
     A                                      LDAT)
     A            E2_NOM    R        O  9 19REFFLD(SOLDAT/NOM_SLD BIB27/SOLDA-
     A                                      T)
     A            E2_ID     R        O  7 19REFFLD(SOLDAT/ID_SLD BIB27/SOLDAT)
     A          R FMT3
     A*%%TS  SD  20231208  162159  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF23(23)
     A                                  2  5'tpsoldat'
     A                                  2 31'gestion des soldats'
     A                                      COLOR(PNK)
     A                                  2 69DATE
     A                                      EDTCDE(Y)
     A                                  3 69SYSNAME
     A                                  4 31'Modification d un soldat'
     A                                 22  6'f3=EXIT'
     A                                      COLOR(BLU)
     A                                 22 15'f12=RETOUR'
     A                                      COLOR(BLU)
     A                                  7  6'N° Soldat :'
     A                                  9  6'Nom       :'
     A                                 11  6'Prénom    :'
     A                                 13  6'Arme      :'
     A                                 15  6'Arme2     :'
     A                                 17  6'Classe    :'
     A            E2_PRENOM R        B 11 19REFFLD(SOLDAT/PRENOM_SLD BIB27/SO-
     A                                      LDAT)
     A            E2_ARME   R        B 13 19REFFLD(SOLDAT/ARME_SLD BIB27/SOLD-
     A                                      AT)
     A            E2_ARME2  R        B 15 19REFFLD(SOLDAT/ARME2_SLD BIB27/SOL-
     A                                      DAT)
     A            E2_CLASSE R        B 17 19REFFLD(SOLDAT/CLASSE_SLD BIB27/SO-
     A                                      LDAT)
     A                                      CHECK(LC)
     A            E2_NOM    R        B  9 19REFFLD(SOLDAT/NOM_SLD BIB27/SOLDA-
     A                                      T)
     A            E2_ID     R        O  7 19REFFLD(SOLDAT/ID_SLD BIB27/SOLDAT)
     A                                 20  6'Msg erreur:'
     A                                      COLOR(RED)
     A            E3_ERREUR     50A  O 20 19COLOR(RED)
     A                                  6  6'Modifier les données d un soldat, -
     A                                      puis appuyer sur f23'
     A                                      COLOR(BLU)
     A                                 22 28'f23=VALIDER'
     A                                      COLOR(BLU)
     A          R FMT4
     A*%%TS  SD  20231208  162554  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF23(23)
     A                                  2  5'tpsoldat'
     A                                  2 31'gestion des soldats'
     A                                      COLOR(PNK)
     A                                  2 69DATE
     A                                      EDTCDE(Y)
     A                                  3 69SYSNAME
     A                                  4 31'Modification d un soldat'
     A                                 22  6'f3=EXIT'
     A                                      COLOR(BLU)
     A                                 22 15'f12=RETOUR'
     A                                      COLOR(BLU)
     A                                  9  6'Nom       :'
     A                                 11  6'Prénom    :'
     A                                 13  6'Arme      :'
     A                                 15  6'Arme2     :'
     A                                 17  6'Classe    :'
     A            E4_PRENOM R        I 11 19REFFLD(SOLDAT/PRENOM_SLD BIB27/SO-
     A                                      LDAT)
     A            E4_ARME   R        I 13 19REFFLD(SOLDAT/ARME_SLD BIB27/SOLD-
     A                                      AT)
     A            E4_ARME2  R        I 15 19REFFLD(SOLDAT/ARME2_SLD BIB27/SOL-
     A                                      DAT)
     A            E4_CLASSE R        I 17 19REFFLD(SOLDAT/CLASSE_SLD BIB27/SO-
     A                                      LDAT)
     A                                      CHECK(LC)
     A            E4_NOM    R        I  9 19REFFLD(SOLDAT/NOM_SLD BIB27/SOLDA-
     A                                      T)
     A                                 20  6'Msg erreur:'
     A                                      COLOR(RED)
     A            E4_ERREUR     50A  O 20 19COLOR(RED)
     A                                  6  6'Ajouter les données d un soldat, p-
     A                                      uis appuyer sur f23'
     A                                      COLOR(BLU)
     A                                 22 28'f23=VALIDER'
     A                                      COLOR(BLU)
```
