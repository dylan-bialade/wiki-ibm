---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: CHATDSP
type: DDS
longueur_enregistrement: 80
lignes: 49
modifie: 2026-11-16
---

# BIB20/QDDSSRC/CHATDSP

```text
     A*%%TS  SD  20260313  090350  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*================================================================
     A* CHATDSP - Ecran 5250 pour Chat BIB09 (Anthropic API)
     A* Type   : DSPF (Display File)
     A* Auteur : Generation assistee
     A* But    : Sous-fichier unique servant de zone de saisie
     A*          ET d'affichage (lignes INPUT/OUTPUT)
     A*================================================================
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A*----------------------------------------------------------------
     A* Format SFL1 : Enregistrement du sous-fichier
     A*----------------------------------------------------------------
     A          R SFL1                      SFL
     A*%%TS  SD  20260303  100035  GGEOFFREY   REL-V7R5M0  5770-WDS
     A            SFLLCK         1A  H
     A            SFLLIN        78A  B  5  2
     A  50                                  DSPATR(PR)
     A N51                                  COLOR(WHT)
     A  51                                  COLOR(BLU)
     A N52                                  DSPATR(UL)
     A                                      CHECK(LC)
     A*----------------------------------------------------------------
     A* Format CTL1 : Controle du sous-fichier
     A*----------------------------------------------------------------
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20260313  090350  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      CF03(03 'F3=Quitter')
     A                                      CF05(05 'F5=Effacer')
     A                                      OVERLAY
     A  31                                  SFLCLR
     A  32                                  SFLDSP
     A N31                                  SFLDSPCTL
     A  90                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  1 37'5250 Chat'
     A                                      COLOR(WHT)
     A                                  1 72TIME
     A                                      COLOR(BLU)
     A                                  1  2DATE
     A                                      COLOR(BLU)
     A                                      EDTCDE(Y)
     A          R PIED
     A                                 23  2'F3=Quitter   F5=Effacer  -
     A                                      Entree=Envoyer'
     A                                      COLOR(BLU)
```
