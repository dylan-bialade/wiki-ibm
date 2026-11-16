---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: ANIMSFLDSP
type: DDS
longueur_enregistrement: 80
lignes: 39
modifie: 2026-11-16
---

# BIB17/QDDSSRC/ANIMSFLDSP

```text
     A*%%TS  SD  20261026  161523  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R SFL1                      SFL
     A*%%TS  SD  20261026  155617  REMI        REL-V7R5M0  5770-WDS
     A            NOM       R        O  7  3REFFLD(PERSOF/NOM BIB17/PERSO)
     A            PRENOM    R        O  7 20REFFLD(PERSOF/PRENOM BIB17/PER-
     A                                      SO)
     A            UNINAME   R        O  7 37REFFLD(UNIVERSF/UNINAME BIB17/-
     A                                      UNIVERS)
     A            TMPAPPAR      20A  O  7 60
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261026  161523  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03
     A                                      CF12
     A                                      OVERLAY
     A  32                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0011)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 26'Affichage des personnages'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  5  3'Nom'
     A                                      COLOR(WHT)
     A          R FOOT
     A*%%TS  SD  20261026  160851  REMI        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Quitter   F12=Retour'
     A                                      COLOR(BLU)
     A                                 20 15'Nombre de personnages dans la list-
     A                                      e :'
     A                                      COLOR(YLW)
     A            RANG           4S 0O 20 54COLOR(YLW)
```
