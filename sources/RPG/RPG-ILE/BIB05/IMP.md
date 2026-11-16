---
bibliotheque: BIB05
fichier_source: QRPGLESRC
membre: IMP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 81
modifie: 2026-11-16
---

# BIB05/QRPGLESRC/IMP

```text
     A*%%TS  SD  20261021  095619  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20261020  155857  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A                                  1  2SYSNAME
     A                                  1 70USER
     A                                  2 19'calculateur d'
     A                                      COLOR(WHT)
     A                                  2 33'impot'
     A                                      COLOR(WHT)
     A                                  2 39'sur'
     A                                      COLOR(WHT)
     A                                  2 43'le'
     A                                      COLOR(WHT)
     A                                  2 46'revenu'
     A                                      COLOR(WHT)
     A                                  5  5'indiquez vos choix, puis appuyez s-
     A                                      ur ENTREE.'
     A                                      COLOR(BLU)
     A                                  7  6'Votre revenus net imposable sur un-
     A                                      e année . . .'
     A            REVIMP        10S 0B  7 57
     A                                  9  6'Marie(e) ou pacse(e) . . .'
     A            CHOICE         2Y 0B  9 58SNGCHCFLD((*NUMCOL 2))
     A                                      CHOICE(1 'NON')
     A                                      CHOICE(2 'OUI')
     A                                 11  6'Nombre d''enfants a charge . . .'
     A            NBENFANT       2S 0I 11 57
     A                                 23  5'F3=EXIT'
     A                                      COLOR(BLU)
     A          R FMT2
     A*%%TS  SD  20261021  095619  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A                                      CA12(12)
     A                                  1  2SYSNAME
     A                                  1 70USER
     A                                  2 31'votre estimation :'
     A                                      COLOR(WHT)
     A                                  4  5'Pour un salaire net imposable de .-
     A                                       . .'
     A            SALNETIMP     10Y 0O  4 47COLOR(WHT)
     A                                      EDTWRD('       .   ')
     A                                  4 61'€'
     A                                  5  5'L'
     A                                  5  7'impôt'
     A                                  5 13'sur'
     A                                  5 17'le'
     A                                  5 20'revenu'
     A                                  5 27's'
     A                                  5 29'élévera'
     A                                  5 37'à'
     A                                  5 39'.'
     A                                  5 41'.'
     A                                  5 43'.'
     A            IMPREVO       11Y 2O  5 47COLOR(WHT)
     A                                      EDTWRD('         ,  ')
     A                                  5 61'€'
     A                                  6  5'Il'
     A                                  6  8'vous'
     A                                  6 13'restera'
     A                                  6 21'.'
     A                                  6 23'.'
     A                                  6 25'.'
     A                                  6 27'.'
     A                                  6 29'.'
     A                                  6 31'.'
     A                                  6 33'.'
     A                                  6 35'.'
     A                                  6 37'.'
     A                                  6 39'.'
     A                                  6 41'.'
     A                                  6 43'.'
     A            REST           9Y 0O  6 47COLOR(WHT)
     A                                      EDTWRD('      .   ')
     A                                  6 61'€'
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 11'F12=Retour'
     A                                      COLOR(BLU)
```
