---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: SAISAGN
type: DDS
longueur_enregistrement: 100
lignes: 110
modifie: 2026-11-16
---

# BIB02/QDDSRC/SAISAGN

```text
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')

     A          R FMT1
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A                                  1 32'Saisie des deux clés'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  5  3'Code client :'
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                 23 23'F6=Créer'
     A                                      COLOR(BLU)
     A            CODCLIS   R        I  5 18REFFLD(AGENCEF/CODCLI BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
     A            CODAGNS   R        I  6 18REFFLD(AGENCEF/CODAGN BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
     A                                  6  3'Code agence :'
     A          R FMT2
     A                                      CA12(12 'Retour')
     A                                      CHANGE(50)
     A                                  1 32'Consultation de l''agence   '
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  3  3'Code client : '
     A            CODCLI    R        B  3 18REFFLD(AGENCEF/CODCLI BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                  4  3'Code agence : '
     A                                  5  3'Nom........ : '
     A                                  6  3'Rue........ : '
     A                                  7  3'CP......... : '
     A                                  9  3'Region..... : '
     A                                  8  3'Ville...... : '
     A            CODAGN    R        B  4 18REFFLD(AGENCEF/CODAGN BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
     A            FMT2NOM   R        B  5 18REFFLD(AGENCEF/NOM BIB02/AGENCETP4)
     A                                      DSPATR(HI)
     A            FMT2RUE   R        B  6 18REFFLD(AGENCEF/RUE BIB02/AGENCETP4)
     A                                      DSPATR(HI)
     A            FMT2CP    R        B  7 18REFFLD(AGENCEF/NOM BIB02/AGENCETP4)
     A                                      DSPATR(HI)
     A            FMT2VILLE R   50   B  8 18REFFLD(AGENCEF/VILLE BIB02/AGENCET-
     A                                      P4)
     A                                      DSPATR(HI)
     A            FMT2REGIONR        B  9 18REFFLD(AGENCEF/REGION BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
     A                                 23 22'F12=Retour'
     A                                      COLOR(BLU)
     A          R FMT6
     A                                      CA12(12 'Retour')
     A                                  1 32'Création de l''agence   '
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  5  3'Code client : '
     A            CODECLI   R        B  5 21REFFLD(AGENCEF/CODCLI BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                 23 23'F12=Retour'
     A                                      COLOR(BLU)
     A                                  6  3'Code agence.: '
     A                                  7  3'Nom.........: '
     A                                  8  3'Rue.........: '
     A                                  9  3'CP..........: '
     A                                 11  3'Region......: '
     A                                 10  3'Ville.......: '
     A            CODEAGN   R        B  6 21REFFLD(AGENCEF/CODAGN BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
     A            FMT2NOM   R        B  7 21REFFLD(AGENCEF/NOM BIB02/AGENCETP4)
     A                                      DSPATR(HI)
     A            FMT2RUE   R        B  8 21REFFLD(AGENCEF/RUE BIB02/AGENCETP4)
     A                                      DSPATR(HI)
     A            FMT2CP    R        B  9 21REFFLD(AGENCEF/NOM BIB02/AGENCETP4)
     A                                      DSPATR(HI)
     A            FMT2VILLE R        B 10 21REFFLD(AGENCEF/VILLE BIB02/AGENCET-
     A                                      P4)
     A                                      DSPATR(HI)
     A            FMT2REGIONR        B 11 21REFFLD(AGENCEF/REGION BIB02/AGENCE-
     A                                      TP4)
     A                                      DSPATR(HI)
```
