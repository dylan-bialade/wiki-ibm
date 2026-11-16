---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: INVENDSP
type: DDS
longueur_enregistrement: 100
lignes: 27
modifie: 2026-11-16
---

# BIB02/QDDSRC/INVENDSP

```text
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')
     A                                      CA12(12 'Retour')
     A          R FMT1
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A                                  1 32'Saisie des quantités  '
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  5  3'CodPro :'
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                 23 23'F6=Créer'
     A                                      COLOR(BLU)
     A            CODPROS   R        I  5 13REFFLD(INVENTF/CODPRO BIB02/INVENT)
     A                                      DSPATR(HI)
     A                                  6  3'Qtinv :'
     A            FMTQTINV  R        B  6 13REFFLD(INVENTF/QTINV BIB02/INVENT)
     A                                      DSPATR(HI)
```
