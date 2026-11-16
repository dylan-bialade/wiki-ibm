---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: PGM3D
type: DDS
longueur_enregistrement: 100
lignes: 52
modifie: 2026-11-16
---

# BIB02/QDDSRC/PGM3D

```text
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06 (06 'Créer')
     A          R FMT1
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A                                  1 32'Saisie des deux clés'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  5  3'Code clients :'
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                 23 23'F6=Créer'
     A                                      COLOR(BLU)
     A            CODECLI   R        O  5 18REFFLD(AGENCEF/CODCLI BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
     A            CODEAGN   R        I  6 18REFFLD(AGENCEF/CODAGN BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
     A                                  6  3'Code agences :'
     A          R FMT2
     A                                  1 32'Consultation des courses'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  5  3'Numéro courses...:'
     A                                  7  3'Nom de la course :'
     A            NORACE    R        O  5 23REFFLD(NORACE RACES/RACEP)
     A                                      DSPATR(HI)
     A            NMRACE    R        O  7 23REFFLD(NMRACE RACES/RACEP)
     A                                      DSPATR(HI)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                 23 23'F12=Retour'
     A                                      COLOR(BLU)
     A                                  8  3'Résultat.........:'
     A            T1RACE    R        O  8 23REFFLD(RACEFMT/T1RACE RACES/RACEP)
     A                                      DSPATR(HI)
     A          R FMT6
```
