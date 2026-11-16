---
bibliotheque: BIB01
fichier_source: QDDSSRC
membre: ECODPOS
type: DDS
longueur_enregistrement: 100
lignes: 32
modifie: 2026-11-16
---

# BIB01/QDDSSRC/ECODPOS

```text
     A*%%TS  SD  20260324  080536  FADRIEN     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A                                      CF03
     A          R WSFL                      SFL
     A*%%TS  SD  20260319  112740  FADRIEN     REL-V7R5M0  5770-WDS
     A            NOMCOM    R        O  6 13REFFLD(FCODPO/NOMCOM *LIBL/CODPOSPF)
     A            CODPOS    R        O  6  6REFFLD(FCODPO/CODPOS *LIBL/CODPOSPF)
     A            WOPT           1A  B  6  3
     A          R WCTL                      SFLCTL(WSFL)
     A*%%TS  SD  20260324  080536  FADRIEN     REL-V7R5M0  5770-WDS
     A  61                                  SFLDSP
     A N60                                  SFLDSPCTL
     A  60                                  SFLCLR
     A N60                                  SFLEND
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      WINDOW(3 20 18 54)
     A                                  5  3'X  CP     VILLE'
     A                                      COLOR(WHT)
     A                                  2  3'Filtre  :'
     A                                      COLOR(WHT)
     A            WFLT          40A  B  2 13
     A                                  4  3'X=Sélectionner'
     A                                      COLOR(BLU)
     A                                  4 36'F3=Quitter'
     A                                      COLOR(BLU)
     A          R CHAMPION
     A*%%TS  SD  20260319  141609  FADRIEN     REL-V7R5M0  5770-WDS
     A                                      ASSUME
     A                                  2  3' '
```
