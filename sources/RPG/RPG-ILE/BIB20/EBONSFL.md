---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: EBONSFL
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 90
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/EBONSFL

```text
     A*%%TS  SD  20251104  090704  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R EBONSFLF                  SFL
     A*%%TS  SD  20251103  114435  GGEOFFREY   REL-V7R5M0  5770-WDS
     A            NUMBB     R        O  8  2REFFLD(FBONBON/NUMBB BIB20/BONBON)
     A  50                                  COLOR(RED)
     A N50                                  COLOR(GRN)
     A            NOM       R        O  8 12REFFLD(FBONBON/NOM BIB20/BONBON)
     A            MARQUE    R        O  8 36REFFLD(FBONBON/MARQUE BIB20/BONBON)
     A            COULEU    R        O  8 60REFFLD(FBONBON/COULEU BIB20/BONBON)
     A          R EBONCTL                   SFLCTL(EBONSFLF)
     A*%%TS  SD  20251103  115159  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
                                            OVERLAY
     A                                      CA06(06)
     A                                      CA03(03)
     A                                      ROLLUP(29)
     A                                      ROLLDOWN(30)
     A  30                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  7  4'N°'
     A                                      COLOR(WHT)
     A                                  7 18'Nom'
     A                                      COLOR(WHT)
     A                                  7 43'Marque'
     A                                      COLOR(WHT)
     A                                  7 62'Couleur'
     A                                      COLOR(WHT)
     A                                  1 38'Bonbon'
     A                                      COLOR(WHT)
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  2  3'Agrion'
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  5 34'Rechercher à partir de:'
     A                                      COLOR(WHT)
     A            SEARCH        20A  B  5 58COLOR(WHT)
     A                                      CHECK(LC)
     A          R CREATION
     A*%%TS  SD  20251103  163331  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      WINDOW(4 22 16 35)
     A                                      CA12(12)
     A                                      CA03(03)
     A                                      WDWBORDER((*COLOR PNK) (*DSPATR RI)-
     A                                       (*CHAR '        '))
     A                                  1 10'Ajouter un bonbon'
     A                                      COLOR(WHT)
     A                                  3  2'N° bonbon :'
     A            NUMBB     R        B  3 14REFFLD(FBONBON/NUMBB BIB20/BONBON)
     A                                      CHECK(ME)
     A                                  5  2'Nom . . . :'
     A            NOM       R        B  5 14REFFLD(FBONBON/NOM BIB20/BONBON)
     A                                      CHECK(ME)
     A                                      CHECK(LC)
     A            MARQUE    R        B  7 14REFFLD(FBONBON/MARQUE BIB20/BONBON)
     A                                      CHECK(ME)
     A                                      CHECK(LC)
     A            COULEU    R        B  9 14REFFLD(FBONBON/COULEU BIB20/BONBON)
     A                                      CHECK(ME)
     A                                      CHECK(LC)
     A            PRIX      R        B 11 14REFFLD(FBONBON/PRIX BIB20/BONBON)
     A                                      CHECK(ME)
     A                                      EDTCDE(Q)
     A                                  7  2'Marque  . :'
     A                                  9  2'Couleur . :'
     A                                 11  2'Prix  . . :'
     A                                 15  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 15 18'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 11 22'€'
     A            MSGCREA       33A  O 13  2
     A N90                                  COLOR(WHT)
     A  90                                  COLOR(RED)
     A          R EXIT
     A*%%TS  SD  20251104  090704  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 21'F6=Créer'
     A                                      COLOR(BLU)
```
