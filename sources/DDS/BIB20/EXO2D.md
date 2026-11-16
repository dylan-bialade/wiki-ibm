---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: EXO2D
type: DDS
longueur_enregistrement: 80
lignes: 60
modifie: 2026-11-16
---

# BIB20/QDDSSRC/EXO2D

```text
     A*%%TS  SD  20260922  094401  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A          R ECR1
     A*%%TS  SD  20230608  142901  JBORG       REL-V7R4M0  5770-WDS
     A                                      CA12(12 'Retour')
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
     A                                 23  3'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 23'F12=Retour'
     A                                      COLOR(BLU)
     A                                  8  3'Résultat.........:'
     A            T1RACE    R        O  8 23REFFLD(RACEFMT/T1RACE RACES/RACEP)
     A                                      DSPATR(HI)
     A          R ECR2
     A*%%TS  SD  20260922  094401  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CF06(06)
     A                                      CA12(12)
     A                                  1 32'Titre de l écran2'
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A                                  6  7'Numéro de la course ...:'
     A                                 10  7'Nom de la course .......:'
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A            NORACE    R        B  6 33REFFLD(RACEFMT/NORACE RACES/RACEP)
     A            NMRACE    R        B 10 33REFFLD(RACEFMT/NMRACE RACES/RACEP)
     A                                 12  7'Nom du coureur ...:'
     A            COURREUR      25A  O 12 29DSPATR(RI)
     A                                 23  9'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 19'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 36'F6=Création'
     A                                      COLOR(BLU)
     A  27                                  DSPATR(ND)
     A          R ECRMAIN
     A*%%TS  SD  20251007  144449  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                  9  5'Type de la course :'
                                            CHANGE(30)
     A            TYPECOURSE     3A  B  9 27DSPATR(PC)
     A  30                                  DSPATR(RI)
     A  30        ERRORTEXT     55A  O 22  4'TYPE DE COURSE NON TROUVÉ'
```
