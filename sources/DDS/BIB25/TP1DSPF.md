---
bibliotheque: BIB25
fichier_source: QILETP
membre: TP1DSPF
type: DDS
longueur_enregistrement: 80
lignes: 31
modifie: 2026-11-25
---

# BIB25/QILETP/TP1DSPF

```text
     A*%%TS  SD  20250417  155232  LEO2        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20250417  155232  LEO2        REL-V7R5M0  5770-WDS
     A                                      CA03(03 'Sortie du programme')
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 36'TP1 : ILE'
     A                                      COLOR(WHT)
     A                                  1 72TIME
     A                                  2 72DATE
     A                                      EDTCDE(Y)
     A                                  6  3'Veuillez saisir un email et/ou un -
     A                                      numéro de sécutité sociale et appuy-
     A                                      er sur'
     A                                      COLOR(BLU)
     A                                  7  3'ENTREZ :'
     A                                      COLOR(BLU)
     A                                 10  3'Email : '
     A                                 12  3'Numéro de sécurité sociale :'
     A                                 23  3'F3=QUITTER'
     A                                      COLOR(BLU)
     A            E_EMAIL       50A  I 10 13
     A            E_NUMSECU     15A  I 12 34
     A            ERRMAIL       60A  O 18  3COLOR(RED)
     A  40                                  DSPATR(ND)
     A            ERRNUMSECU    60A  O 19  3COLOR(RED)
     A  41                                  DSPATR(ND)
     A            ERRSAISI      40   O  8  4COLOR(WHT)
     A  42                                  DSPATR(ND)
```
