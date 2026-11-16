---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: ENTREP1
type: DDS
longueur_enregistrement: 100
lignes: 44
modifie: 2026-11-16
---

# BIB02/QDDSRC/ENTREP1

```text
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')

     A          R SFL1                      SFL
     A            CODPRO         5   O  7  2
     A            NMPRO         30   O  7 11
     A            QTPRO          3S 0O  7 50
     A            DTDINV          L  O  7 64
     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0016)
     A                                      SFLPAG(0015)
     A                                      OVERLAY
     A N32                                  SFLDSP
     A N31                                  SFLDSPCTL
     A  31                                  SFLCLR
     A                                      ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  6  2'codpro'
     A                                      DSPATR(HI)
     A                                  6 11'nom pro'
     A                                      DSPATR(HI)
     A                                  6 50'qtpro'
     A                                      DSPATR(HI)
     A                                  6 64'dtdinv'
     A                                      DSPATR(HI)
     A                                  1  2'SFL001D'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 24'Sous-fichier avec positionnement'
     A                                      DSPATR(HI)
     A                                  4  2'Afficher à partir de :'
     A            CODPRO         5   B  4 28CHECK(LC)
     A                                  4 34'(Codeproduit)'
     A            QTPRO          5   B  4 50CHECK(LC)
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
     A                                 23 13'F6=Creér'
     A                                      COLOR(BLU)
```
