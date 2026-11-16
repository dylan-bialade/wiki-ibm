---
bibliotheque: BIB10
fichier_source: QDSPSRC
membre: IMPOTDSP
type: DDS
longueur_enregistrement: 80
lignes: 43
modifie: 2026-11-16
---

# BIB10/QDSPSRC/IMPOTDSP

```text
     A*%%TS  SD  20261020  153758  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20261020  153758  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  1 70USER
     A                                  2 23'Calculateur d''impots sur le reven-
     A                                      ue'
     A                                      COLOR(WHT)
     A                                  5  7'Indiquez vos choix puis appuyez su-
     A                                      r ENTREE'
     A                                      COLOR(BLU)
     A                                  7  7'Votre revenue net imposable sur un-
     A                                      e année ......:'
     A                                  9 39'Pacsé / Marié ..:'
     A                                 11 36'Nombre d''enfant ...:'
     A            NBENF          3S 0B 11 58
     A            MARIE          2Y 0B  9 58SNGCHCFLD((*NUMCOL 2))
     A                                      CHOICE(1 'NON')
     A                                      CHOICE(2 'OUI')
     A                                 23  5'F3=Exit'
     A                                      COLOR(BLU)
     A            NETIMPOT      10Y 2B  7 58EDTWRD('  &   & 0 ,  &€')
     A          R FMT2
     A*%%TS  SD  20261020  144650  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  1 70USER
     A                                  2 33'Votre estimation'
     A                                      COLOR(WHT)
     A                                 23  5'F3=Exit'
     A                                      COLOR(BLU)
     A                                  6  5'Pour un salaire imposable de .....-
     A                                      .......:'
     A                                  7  5'L''impôt sur le revenu s''élèvera -
     A                                      à .......:'
     A                                  8  5'Il vous restera ..................-
     A                                      .......:'
     A            NETIMPOT      10Y 2O  6 49EDTWRD('  &   &  0,  &€')
     A            IMPOTD        10Y 2O  7 49EDTWRD('  &   &  0,  &€')
     A            REST          10Y 2O  8 49EDTWRD('  &   &  0,  &€')
```
