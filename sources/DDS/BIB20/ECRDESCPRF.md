---
bibliotheque: BIB20
fichier_source: QEXOSRC
membre: ECRDESCPRF
type: DDS
longueur_enregistrement: 80
lignes: 55
modifie: 2026-11-16
---

# BIB20/QEXOSRC/ECRDESCPRF

```text
     A*%%TS  SD  20251009  134914  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R ECRDESCPRF
     A*%%TS  SD  20251009  134914  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A                                      CA12(12)
     A                                      CF21(21)
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  2  3'Descriptif profil'
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  6  8'Profil :'
     A            PROFIL        10A  O  6 18COLOR(WHT)
     A                                 10  8'Description travail'
     A                                 14  8'Bibliothèque en cours'
     A                                 16  8'Péremption mot de passe'
     A            JOBD          10A  B 10 38
     A N60                                  DSPATR(PC)
     A  95                                  DSPATR(RI)
     A  60                                  DSPATR(PR)
     A N60                                  COLOR(GRN)
     A  60                                  COLOR(WHT)
     A            CURLIB        10A  B 14 38
     A N60                                  DSPATR(PC)
     A  96                                  DSPATR(RI)
     A  60                                  DSPATR(PR)
     A N60                                  COLOR(GRN)
     A  60                                  COLOR(WHT)
     A            PWEXP         10A  B 16 38
     A N60                                  DSPATR(PC)
     A  97                                  DSPATR(RI)
     A  60                                  DSPATR(PR)
     A N60                                  COLOR(GRN)
     A  60                                  COLOR(WHT)
     A                                 23  3'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 19'F12=Retour'
     A                                      COLOR(BLU)
     A N60                             23 36'F21=Modifier'
     A                                      COLOR(BLU)
     A            MESSAGE       41A  O 21  3COLOR(WHT)
     A                                 12 10'Bibliothèque . . . . . . .'
     A                                 10 28' . . . .'
     A                                 14 30' . . .'
     A                                 16 32' . .'
     A            BIB           10A  B 12 38
     A N60                                  DSPATR(PC)
     A  95                                  DSPATR(RI)
     A  60                                  DSPATR(PR)
     A N60                                  COLOR(GRN)
     A  60                                  COLOR(WHT)
```
