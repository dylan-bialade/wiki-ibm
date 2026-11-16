---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: ENTREDSP
type: DDS
longueur_enregistrement: 100
lignes: 91
modifie: 2026-11-16
---

# BIB02/QDDSRC/ENTREDSP

```text
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')
     A                                      CA12(12 'Retour')
     A          R FMT1
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A                                  1 32'Saisie des deux clés'
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
     A            CODPROS   R        I  5 13REFFLD(ENTREPOTF/CODPRO BIB02/ENTR-
     A                                      EPOT)
     A                                      DSPATR(HI)
     A          R FMT2
     A                                      CHANGE(50)
     A                                  1 32'Consultation des produits    '
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  3  3'CodPro : '
     A            FMT2CODP  R        B  3 13REFFLD(ENTREPOTF/CODPRO BIB02/ENTR-
     A                                      EPOT)
     A                                      DSPATR(HI)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                  4  3'NomPro : '
     A                                  5  3'QtPro : '
     A                                  6  3'Date : '
     A            FMT2NOM   R        B  4 13REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A            FMT2QTP   R        B  5 13REFFLD(ENTREPOTF/QTPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A                                 23 22'F12=Retour'
     A                                      COLOR(BLU)
     A            FMT2DATE  R     L  B  6 13REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A                                      DATFMT(*ISO)
     A            FMT2DATE2 R        B  7 13REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A          R FMT6
     A                                      CHANGE(50)
     A                                  1 32'Création des produits    '
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  3  3'CodPro : '
     A            FMT6CODP  R        I  3 13REFFLD(ENTREPOTF/CODPRO BIB02/ENTR-
     A                                      EPOT)
     A                                      DSPATR(HI)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                  4  3'NomPro : '
     A                                  5  3'QtPro : '
     A                                  6  3'Date : '
     A            FMT6NOM   R        I  4 13REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A            FMT6QTP   R        I  5 13REFFLD(ENTREPOTF/QTPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A                                 23 22'F12=Retour'
     A                                      COLOR(BLU)
     A            FMT6DATE  R        I  6 13REFFLD(ENTREPOTF/DTDINV BIB02/ENTR-
     A                                      EPOT)
     A                                      DSPATR(HI)
```
