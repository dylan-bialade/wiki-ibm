---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: IMPOTDSP
type: DDS
longueur_enregistrement: 80
lignes: 47
modifie: 2026-11-16
---

# BIB17/QDDSSRC/IMPOTDSP

```text
     A*%%TS  SD  20261020  140536  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20261020  140536  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 24'Calculateur d''impot sur le revenu'
     A                                      COLOR(WHT)
     A                                  5  6'Indiquez vos choix, puis appuyez s-
     A                                      ur ENTREE'
     A                                      COLOR(BLU)
     A                                  7  6'Votre revenus net imposable sur un-
     A                                      e année . . .'
     A                                 23  4'F3=Quitter'
     A                                      COLOR(BLU)
     A                                  9 34'Pacsé / Marié'
     A            CHOIX          2Y 0B  9 57SNGCHCFLD((*NUMCOL 2))
     A                                      CHOICE(1 '>OUI')
     A                                      CHOICE(2 '>NON')
     A                                 11 32'Nombre d''enfant . . .'
     A            NBENF          2  0B 11 57
     A            REVNET         8  2B  7 57
     A                                      EDTWRD('      ,  ')
     A          R FMT2
     A*%%TS  SD  20261020  140536  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF12(12)
     A                                  1  2SYSNAME
     A                                  1 70USER
     A                                  1 33'Votre estimation'
     A                                      COLOR(WHT)
     A                                  5  6'Pour un salaire net imposable de .-
     A                                       . .'
     A                                  7  6'L''impot sur le revenu s''élèvera -
     A                                      à . . .'
     A                                  9  6'Il vous restera . . . . . . . . . -
     A                                      . . .'
     A            REVNET         8Y 2O  5 49COLOR(WHT)
     A                                      EDTWRD('      ,  ')
     A            IMPOT          8Y 2O  7 49COLOR(WHT)
     A                                      EDTWRD('      ,  ')
     A            RESTE          8Y 2O  9 49COLOR(WHT)
     A                                      EDTWRD('      ,  ')
     A                                 23  5'F3=Exit     F12=Retour'
     A                                      COLOR(BLU)
```
