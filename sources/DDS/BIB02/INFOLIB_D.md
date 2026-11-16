---
bibliotheque: BIB02
fichier_source: QSRC
membre: INFOLIB_D
type: DDS
longueur_enregistrement: 100
lignes: 60
modifie: 2026-11-16
---

# BIB02/QSRC/INFOLIB_D

```text
   A                                        DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA05(05 'Actualiser')
     A                                      CA06(06 'Créer')
     A                                      CA08(08 'Imprimer')
     A                                      CA12(12 'Retour')
     A                                      CF23(23 'Confirmer')
     A                                      INDARA
     A          R SFL1                      SFL
     A            OPT            1A  I  9  2

     A            E1LIBL        30   O  9  8
     A            E1SIZE        12S 0O  9 41
        88                                  COLOR(TRQ)
     A            E1DATE         6A  O  9 55



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
     A                                  8  8'Nom Librairie'
     A                                      DSPATR(HI)
     A                                  8 41'Taille '
     A                                      DSPATR(HI)
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 29'Librairies d''Agrion'
     A                                      DSPATR(HI)
     A                                  3  2'Afficher à partir de :'
     A            Z_LIB         10   B  3 25CHECK(LC)
     A                                  8  2'Opt'
     A                                      DSPATR(HI)
     A                                  5  2'Indiquez vos options, puis appuyez-
     A                                       sur ENTREE.'
     A                                      COLOR(BLU)
     A                                  6  4'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  8 55'Date Création'
                                             DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A          R SFL2
     A                                  2  6'Cette librairie contient des fichi-
     A                                      ers dépendants d''une autre librair-
     A                                      ie.'
                                        6 24'F23=Confirmation de la suppression'
     A                                      COLOR(RED)
     A                                  4  9'Voulez-vous supprimer les relation-
     A                                      s entre les librairies existantes?'
```
