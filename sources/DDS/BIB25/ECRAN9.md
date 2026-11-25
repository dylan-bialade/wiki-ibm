---
bibliotheque: BIB25
fichier_source: QTEST
membre: ECRAN9
type: DDS
longueur_enregistrement: 80
lignes: 55
modifie: 2026-11-25
---

# BIB25/QTEST/ECRAN9

```text
     A*%%TS  SD  20250515  231103  LEO2        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20250515  231103  LEO2        REL-V7R5M0  5770-WDS
     A                                      CA03(03 'quittée')
     A                                      CA12(12 'annulée')
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  2TIME
     A                                  1 27'Calcule de prets immobilier'
     A                                      COLOR(WHT)
     A                                  1 73SYSNAME
     A                                  2 71USER
     A                                 10  8'Veuillez saisir et appuyer sur ENT-
     A                                      REE:'
     A                                      COLOR(BLU)
     A                                 12 11'Montant:'
     A                                      COLOR(WHT)
     A                                 13 11'Durée:'
     A                                      COLOR(WHT)
     A                                 14 11'Taux d''interet:'
     A                                      COLOR(WHT)
     A            MONTANT       15Y 2I 12 28
     A            DUREE          2S 0I 13 28
     A            TAUX           4Y 2I 14 28
     A                                 23  3'F3=QUITTER'
     A                                      COLOR(BLU)
     A                                 23 16'F12=Remise à zéro'
     A                                      COLOR(BLU)
     A                                  2 32'Annuité constante'
     A                                      COLOR(WHT)
     A            MESSAGE       45   O 19  4COLOR(BLU)
     A  30                                  DSPATR(ND)
     A          R FMT2
     A*%%TS  SD  20250515  230000  LEO2        REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A                                      CA12(12)
     A                                  1  2DATE
     A                                      EDTCDE(Y)
     A                                  2  1TIME
     A                                  1 28'Ton prêt est calculer'
     A                                      COLOR(WHT)
     A                                  1 63SYSNAME
     A                                  2 62USER
     A                                  7  7'Tableau des Amortissements:'
     A                                      COLOR(BLU)
     A                                  9  8'Coût total du prêt :'
     A            PRET          12Y 2O  9 30EDTWRD('          .  ')
     A                                 10  8'Coût des intéréts  :'
     A            COUTINT       12Y 2O 10 30EDTWRD('          .  ')
     A                                 23  4'F3=QUITTER'
     A                                      COLOR(BLU)
     A                                 23 18'F12=Précédent'
     A                                      COLOR(BLU)
```
