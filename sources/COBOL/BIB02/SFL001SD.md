---
bibliotheque: BIB02
fichier_source: QCBLLESRC
membre: SFL001SD
type: COBOL
longueur_enregistrement: 100
lignes: 41
modifie: 2026-11-16
---

# BIB02/QCBLLESRC/SFL001SD

```text
     A*%%TS  SD  20231215  141702  JBORG       REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      PRINT
     A                                      CA03(03)
     A          R SFL1                      SFL
     A            DBLNAM        20A  O  7  2
     A            DBFNAM        20A  O  7 25
     A            DBCIVI         3A  O  7 50
     A            DBTELP        10A  O  7 64
     A          R SF1CTL                    SFLCTL(SFL1)
     A*%%TS  SD  20231215  141702  JBORG       REL-V7R4M0  5770-WDS
     A                                      SFLSIZ(0016)
     A                                      SFLPAG(0015)
     A                                      OVERLAY
     A N32                                  SFLDSP
     A N31                                  SFLDSPCTL
     A  31                                  SFLCLR
     A            POSIT          4S 0H      SFLRCDNBR
     A                                  6  2'Nom'
     A                                      DSPATR(HI)
     A                                  6 25'Prénom'
     A                                      DSPATR(HI)
     A                                  6 50'Civ.'
     A                                      DSPATR(HI)
     A                                  6 64'Téléphone'
     A                                      DSPATR(HI)
     A                                  1  2'SFL001D'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 25'Sous-fichier avec positionnement'
     A                                      DSPATR(HI)
     A                                  4  2'Afficher à partir de :'
     A            PTNAME        20A  B  4 28CHECK(LC)
     A                                  4 50'(Nom)'
     A                                  2 35'Sous-fichier COBOL'
     A                                      DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
```
