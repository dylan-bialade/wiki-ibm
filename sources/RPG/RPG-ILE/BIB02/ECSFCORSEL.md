---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: ECSFCORSEL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 55
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/ECSFCORSEL

```text
     A*%%TS  SD  20210414  152704  SYLVAIN     REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Exit')
     A                                      CA05(05 'Réafficher')

     A          R SFL1                      SFL
     A            OPT            1A  I  9  2
     A            ID_ETU        10Y 0O  9  7EDTCDE(Z)
     A            NOM           30A  O  9 18

     A            PRENOM        30A  O  9 49

     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A  61                                  SFLMSG('Vide')
     A N90                                  ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  8  7'ID Etu'
     A                                      DSPATR(HI)
     A                                  8 16'Nom'
     A                                      DSPATR(HI)
     A                                  8 49'Prenom'
     A                                      DSPATR(HI)
     A                                  1  2'ETUDIANT'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 25'Liste des étudiants'
     A                                      DSPATR(HI)
     A                                  3  2'Afficher à partir de :'
     A            SCODPRO        5   B  3 25CHECK(LC)
     A                                  3 31'(ID Etudiant)'
     A                                  8  2'Opt'
     A                                      DSPATR(HI)
     A                                  5  2'Indiquez vos options, puis appuyez-
     A                                       sur ENTREE.'
     A                                      COLOR(BLU)
     A                                  6  3'2=Editer'
     A                                      COLOR(BLU)
     A                                  6 14'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  6 28'5=Afficher'
     A                                      COLOR(BLU)
     A          R FKEY1
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 13'F5=Réafficher'
     A                                      COLOR(BLU)
```
