---
bibliotheque: BIB25
fichier_source: QRPG3
membre: TP3DSPF
type: DDS
longueur_enregistrement: 80
lignes: 39
modifie: 2026-11-25
---

# BIB25/QRPG3/TP3DSPF

```text
     A*%%TS  SD  20251021  103036  LEO2        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20251010  134943  LEO2        REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  2TIME
     A                                  1 33'Ecran de saisie'
     A                                      COLOR(WHT)
     A                                  1 71'TP2C'
     A                                      COLOR(BLU)
     A                                  2 71USER
     A                                 23  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                  7  5'Nombre n°1 :'
     A                                  9  5'Nombre n°2 :'
     A                                 11  5'Opération  :'
     A            FLD003         1A  I 11 20VALUES('*' '-' '/' '+')
     A            FLD001         4S 0B  7 20
     A            FLD002         4S 0B  9 20
     A            MSG           50   O 19  4
     A  30                                  DSPATR(ND)
     A          R FMT2
     A*%%TS  SD  20251021  103036  LEO2        REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  2TIME
     A                                  1 33'Ecran de resultat'
     A                                      COLOR(WHT)
     A                                  1 71'TP2C'
     A                                      COLOR(BLU)
     A                                  2 71USER
     A                                 23  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 11 16'Résulat :'
     A            FLD004         6Y 0B 11 28EDTCDE(Q)
```
