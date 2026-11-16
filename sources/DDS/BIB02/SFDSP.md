---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: SFDSP
type: DDS
longueur_enregistrement: 100
lignes: 148
modifie: 2026-11-16
---

# BIB02/QDDSRC/SFDSP

```text
     A*%%TS  SD  20210414  152704  ANGELIQUE   REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')
     A                                      CA12(12 'Retour')
     A                                      INDARA
     A                                      ALTHELP(CA01)
     A                                      HLPTITLE('Aide produits')
     A                                      HELP

     A          R SFL1                      SFL
     A            OPT            1A  I  7  2
     A            CODPRO         5   O  7  6
     A            NMPRO         30   O  7 15
     A            QTPRO          3S 0O  7 50
     A            DTDINV          L  O  7 64
     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0015)
     A                                      SFLPAG(0014)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A                                      ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A          H                           HLPPNLGRP('GENERAL' SFRHLP)
     A                                      HLPARA(01 001 02 024)
     A          H                           HLPPNLGRP('NMPRO'  SFRHLP)
     A                                      HLPARA(05 032 05 034)
     A          H                           HLPPNLGRP('QTPRO' SFRHLP)
     A                                      HLPARA(05 021 05 024)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  6  6'codpro'
     A                                      DSPATR(HI)
     A                                  6 15'nom pro'
     A                                      DSPATR(HI)
     A                                  6 50'qtpro'
     A                                      DSPATR(HI)
     A                                  6 64'dtdinv'
     A                                      DSPATR(HI)
     A                                  1  2'SFL001D'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 24'Sous-fichier avec positionnement'
     A                                      DSPATR(HI)
     A                                  4  2'Afficher à partir de :'
     A            CODPRO         5   B  4 25CHECK(LC)
     A                                  4 31'(Codeproduit)'
     A            QTPROS         3D 0B  4 45
     A                                  4 49'(Qte)'
     A                                  6  2'Opt'
     A                                      DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
     A                                 23 13'F6=Creér'
     A                                      COLOR(BLU)
     A          R FMT5
     A                                      WINDOW(*DFT 14 44)
     A                                      WDWTITLE((*TEXT 'Affiche Produit'))
     A                                      WDWBORDER((*COLOR YLW) (*DSPATR RI)-
     A                                       (*CHAR '<.>::<.>'))
     A            E5CODPRO  R        O  4 18REFFLD(ENTREPOTF/CODPRO BIB02/ENTR-
     A                                      EPOT)
     A                                      DSPATR(HI)
     A            E5NMPRO   R   30   O  5 15REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A            E5QTPRO   R        O  7 17REFFLD(ENTREPOTF/QTPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A            E5DTDINV  R        O  8 14REFFLD(ENTREPOTF/DTDINV BIB02/ENTR-
     A                                      EPOT)
     A                                      DSPATR(HI)
     A                                  4  1'Code produit :'
     A                                  5  1'Nom produit :'
     A                                  7  1'Qte produit : '
     A                                  8  1'Date inv : '
     A          R FMT4
     A                                      CF23(23)
     A                                  1 31'Suppression des Produits'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'ENTREPOT'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E4CODPRO  R        O  7 20REFFLD(ENTREPOTF/CODPRO BIB02/ENTR-
     A                                      EPOT)
     A            E4NMPRO   R        O  8 20REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A            E4QTPRO   R        O  9 20REFFLD(ENTREPOTF/QTPRO BIB02/ENTRE-
     A                                      POT)
     A            E4DTDINV  R        O 10 20REFFLD(ENTREPOTF/DTDINV BIB02/ENTR-
     A                                      EPOT)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  7  3'Code produit'
     A                                  7 17':'
     A                                  8  3'Nom produit'
     A                                  8 17':'
     A                                  9  3'Qte produit'
     A                                  9 17':'
     A                                 10  3'Date Inv'
     A                                 10 17':'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(WHT)
     A          R FMT2
     A                                      CF23(23)
     A                                  1 31'Modification des Produits'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'ENTREPOT'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E2CODPRO  R        B  7 20REFFLD(ENTREPOTF/CODPRO BIB02/ENTR-
     A                                      EPOT)
     A            E2NMPRO   R        B  8 20REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A            E2QTPRO   R        B  9 20REFFLD(ENTREPOTF/QTPRO BIB02/ENTRE-
     A                                      POT)
     A            E2DTDINV  R        B 10 20REFFLD(ENTREPOTF/DTDINV BIB02/ENTR-
     A                                      EPOT)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  7  3'Code produit'
     A                                  7 17':'
     A                                  8  3'Nom produit'
     A                                  8 17':'
     A                                  9  3'Qte produit'
     A                                  9 17':'
     A                                 10  3'Date Inv'
     A                                 10 17':'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(WHT)
```
