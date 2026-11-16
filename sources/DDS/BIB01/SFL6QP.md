---
bibliotheque: BIB01
fichier_source: QDDSSRC
membre: SFL6QP
type: DDS
longueur_enregistrement: 100
lignes: 44
modifie: 2026-11-16
---

# BIB01/QDDSSRC/SFL6QP

```text
     A*%%TS  SD  20260323  184042  FADRIEN     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R SFL01                     SFL
     A*%%TS  SD  20260323  184042  FADRIEN     REL-V7R5M0  5770-WDS
     A            OPT            1A  B  9  3
     A            NOM_25        25A  O  9  5
     A            POINTS    R        B  9 31REFFLD(SCORE/POINTS BIB01/SCORE)
     A          R CTL01                     SFLCTL(SFL01)
     A*%%TS  SD  20260323  184042  FADRIEN     REL-V7R5M0  5770-WDS
     A                                      OVERLAY
     A  61                                  SFLDSP
     A  60                                  SFLDSPCTL
     A N60                                  SFLCLR
     A  60                                  SFLEND(*MORE)
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0011)
     A                                  8  3'O Nom                       Points'
     A                                      COLOR(WHT)
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A            PGMPRC        10A  O  1  3
     A                                  2  3USER
     A                                  1 32'Saisie des scores'
     A                                      COLOR(WHT)
     A                                  4  5'Partie :'
     A                                      COLOR(BLU)
     A                                  4 36'Manche :'
     A                                      COLOR(BLU)
     A            ID_PARTIE R        B  4 14REFFLD(SCORE/ID_PARTIE BIB01/SCORE)
     A                                      EDTCDE(1)
     A            N_MANCHE  R        B  4 45REFFLD(SCORE/N_MANCHE BIB01/SCORE)
     A                                      EDTCDE(1)
     A          R PIED01
     A*%%TS  SD  20260323  184042  FADRIEN     REL-V7R5M0  5770-WDS
     A                                 22 68'F12=Retour'
     A                                      COLOR(BLU)
     A                                 22  4'F1=Valider'
     A                                      COLOR(BLU)
     A                                 22 46'F9=Manche suivante'
     A                                      COLOR(BLU)
     A                                 22 19'F8=Manche précédente'
     A                                      COLOR(BLU)
```
