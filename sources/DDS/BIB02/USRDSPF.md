---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: USRDSPF
type: DDS
longueur_enregistrement: 100
lignes: 67
modifie: 2026-11-16
---

# BIB02/QDDSRC/USRDSPF

```text
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A          R ECR0
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A                                  1 32'Saisie un profil utilisateur'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  5  3'Saissisez un profil utilisateur'
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                 23 23'F12=Retour'
     A                                      COLOR(BLU)
     A            USER      R   10   I  5 37REFFLD(RACEFMT/TPRACE RACES/RACEP)
     A                                      DSPATR(HI)
     A          R ECR1
     A                                      CA12(12 'Retour')
     A                                  1 32'Information du profil'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  6  3'Jobd : '
     A                                  8  3'msgq : '
     A                                  9  3'outq : '
     A                                 10  3'curlib : '
     A                                 11  3'Menu initial : '
     A                                 12  3'DLVRY : '
     A                                 13  3'PRTDEV : '
     A            JOBD      R        B  6 11REFFLD(NORACE RACES/RACEP)
     A            MSGQ      R        B  6 11REFFLD(NORACE RACES/RACEP)
     A            OUTQ      R        B  6 11REFFLD(NORACE RACES/RACEP)
     A            CURLIB    R        B  6 11REFFLD(NORACE RACES/RACEP)
     A            MNINIT    R        B  6 11REFFLD(NORACE RACES/RACEP)
     A            DLVRY     R        B  6 11REFFLD(NORACE RACES/RACEP)
     A            PRTDEV    R        B  6 11REFFLD(NORACE RACES/RACEP)
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
     A                                  7  3'Résultat : '
     A            JOBD      R          10 12REFFLD(NORACE RACES/RACEP)
     A                                      DSPATR(HI)
     A            MSGQ      R           8 10REFFLD(NORACE RACES/RACEP)
     A                                      DSPATR(HI)
     A            OUTQ      R           9 10REFFLD(NORACE RACES/RACEP)
     A                                      DSPATR(HI)
     A            CURLIB    R          11 18REFFLD(NORACE RACES/RACEP)
     A                                      DSPATR(HI)
     A            MNINIT    R          12 11REFFLD(NORACE RACES/RACEP)
     A                                      DSPATR(HI)
     A            DLVRY     R          13 12REFFLD(NORACE RACES/RACEP)
     A                                      DSPATR(HI)
     A            PRTDEV    R           7 12REFFLD(NORACE RACES/RACEP)
     A                                      DSPATR(HI)
```
