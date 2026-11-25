---
bibliotheque: BIB27
fichier_source: QDDSSRC
membre: ALGOIMPOTD
type: DDS
longueur_enregistrement: 80
lignes: 141
modifie: 2026-11-25
---

# BIB27/QDDSSRC/ALGOIMPOTD

```text
     A*%%TS  SD  20240708  154750  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A*%%ORGFORM ECRAN CALCULATEUR d'IMPOT
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A          R FMT1
     A*%%TS  SD  20240708  094023  LEO2        REL-V7R4M0  5770-WDS
     A                                      CA12(12)
     A                                      OVERLAY
     A                                  6  5'Votre revenus net imposable sur un-
     A                                      e année . . .'
     A                                      COLOR(WHT)
     A            INET           9S 0B  6 56DSPATR(UL)
     A  50                                  ERRMSG('Erreur saisie')
     A            F1             2Y 0B  8 56SNGCHCFLD(*AUTOSLT (*NUMCOL 2))
     A  51                                  ERRMSG('Choisir Oui ou Non')
     A                                      CHOICE(1 'Oui')
     A                                      CHOICE(2 'Non')
     A            F2             2Y 0B 18 17SNGCHCFLD(*AUTOSLT (*NUMCOL 3))
     A                                      CHOICE(1 'Voitures')
     A                                      CHOICE(2 'Deux-roues')
     A                                      CHOICE(3 'Cyclomoteurs')
     A                                  2 22'Calculateur d''impôt sur le revenu-
     A                                      e'
     A                                      COLOR(WHT)
     A                                  1  2SYSNAME
     A                                  4  4'Indiquez vos choix, puis appuyez s-
     A                                      ur ENTREE.'
     A                                      COLOR(BLU)
     A                                  1 70USER
     A                                  8 33'Pacsé / Marié'
     A                                 10 30'Nombre d''enfant  . . .'
     A            NBE            2S 0B 10 56DSPATR(UL)
     A                                 13  5'Vos frais de transport professione-
     A                                      ls  . . . . .'
     A                                      COLOR(WHT)
     A                                 15 21'Frais réels déjà calculé  . . .'
     A            FRC1           5S 0I 15 56
     A                                 17 14'Calcul'
     A                                 17 21'avec'
     A                                 17 26'le'
     A                                 17 29'barème'
     A                                 17 36'kilométrique'
     A                                 16 49'.'
     A                                 16 51'.'
     A            KMC1           6S 0I 17 56
     A                                 17 65'(km parcourus)'
     A                                 18  5'Véhicule :'
     A                                 11  5'Donnation sur une année (associati-
     A                                      on) . . . . .'
     A                                      COLOR(WHT)
     A            DON_Y          6Y 2B 11 56EDTWRD('    .  ')
     A                                 15 65'(en €)'
     A                                 11 65'(en €)'
     A          R FMT2
     A*%%TS  SD  20240708  154750  LEO2        REL-V7R4M0  5770-WDS
     A                                      CA12(12 'Retour')
     A                                  5  4'L''impôt sur le revenu s''élèvera -
     A                                      à . . .'
     A            OIMPOT         9A  O  5 46DSPATR(HI)
     A                                 23  3'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 13'F12=Retour'
     A                                      COLOR(BLU)
     A                                  2 31'Votre estimation :'
     A                                      COLOR(WHT)
     A                                  1  2SYSNAME
     A                                  1 70USER
     A                                  6  4'Il vous restera . . . . . . . . . -
     A                                      . . .'
     A            ORESTE         9A  O  6 46DSPATR(HI)
     A                                  5 56'€'
     A                                  6 56'€'
     A            OIMPOT1        9A  O  4 46DSPATR(HI)
     A                                  4  4'Pour un salaire net imposable de  -
     A                                      . . .'
     A                                  4 56'€'
     A                                  8  4'Détails :'
     A                                      COLOR(WHT)
     A                                  9  4'Déduction des frais réèls . . . . -
     A                                      . . .'
     A                                  9 56'€'
     A            DEDUC_F        9A  O  9 46COLOR(WHT)
     A                                 10  4'Contribution'
     A                                 10 17'hauts'
     A                                 10 23'revenus'
     A                                 10 32'.'
     A                                 10 34'.'
     A                                 10 36'.'
     A                                 10 38'.'
     A                                 10 40'.'
     A                                 10 42'.'
     A            H_REVENU       9A  O 10 46COLOR(WHT)
     A                                 10 56'€'
     A                                 11  4'Déduction donnation . . . . . . . -
     A                                      . . .'
     A            DONATE         9A  O 11 46COLOR(WHT)
     A                                 11 56'€'
     A          R VFMT1
     A*%%TS  SD  20240628  145655  LEO2        REL-V7R4M0  5770-WDS
     A            MV             2Y 0B 19 29SNGCHCFLD(*AUTOSLT (*NUMCOL 3))
     A                                      CHOICE(3 '3CV et -')
     A                                      CHOICE(4 '4CV')
     A                                      CHOICE(5 '5CV')
     A                                      CHOICE(6 '6CV')
     A                                      CHOICE(7 '7CV et +')
     A            EV             2Y 0B 21 29SNGCHCFLD(*AUTOSLT (*NUMCOL 2))
     A                                      CHOICE(1 'Oui')
     A                                 23  2'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 15'F12=Précédent'
     A                                      COLOR(BLU)
     A                                 19  5'Motorisation :'
     A                                 21  5'Véhicule Électrique :'
     A          R DFMT1
     A            MD             2Y 0B 19 29SNGCHCFLD(*AUTOSLT (*NUMCOL 3))
     A                                      CHOICE(2 '1/2 CV')
     A                                      CHOICE(4 '3.4/5 CV')
     A                                      CHOICE(5 '5CV et +')
     A            ED             2Y 0B 21 29SNGCHCFLD(*AUTOSLT (*NUMCOL 2))
     A                                      CHOICE(1 'Oui')
     A                                 23  2'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 15'F12=Précédent'
     A                                      COLOR(BLU)
     A                                 19  5'Motorisation :'
     A                                 21  5'Véhicule Électrique :'
     A          R CFMT1
     A            CD             2Y 0B 21 29SNGCHCFLD(*AUTOSLT (*NUMCOL 2))
     A                                      CHOICE(1 'Oui')
     A                                 23  2'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 15'F12=Précédent'
     A                                      COLOR(BLU)
     A                                 21  5'Véhicule Électrique :'
     A          R FTOUCHE
     A*%%TS  SD  20240628  145221  LEO2        REL-V7R4M0  5770-WDS
     A                                 23  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 16'F12=Précédent'
     A                                      COLOR(BLU)
```
