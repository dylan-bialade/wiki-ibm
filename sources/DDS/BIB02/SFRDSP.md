---
bibliotheque: BIB02
fichier_source: QVSRC
membre: SFRDSP
type: DDS
longueur_enregistrement: 100
lignes: 193
modifie: 2026-11-16
---

# BIB02/QVSRC/SFRDSP

```text
     A*%%TS  SD  20210414  152704  SYLVAIN     REL-V7R5M0  5770-WDS
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
     A            OPT            1A  I  9  2
     A            E1CODPRO       5   O  9  6
     A            E1NMPRO       30   O  9 15
     A            E1QTPRO        3S 0O  9 47
     A            E1DTDINV        L  O  9 55
     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A                                      ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A  50                                  SFLMSG('Modif réussi')
     A  51                                  SFLMSG('Ajout réussi')
     A  52                                  SFLMSG('Supression réussi')
     A          H                           HLPPNLGRP('GENERAL' SFRHLP)
     A                                      HLPARA(01 001 02 024)
     A          H                           HLPPNLGRP('NMPRO'  SFRHLP)
     A                                      HLPARA(8 49 8 51)
     A          H                           HLPPNLGRP('QTPRO' SFRHLP)
     A                                      HLPARA(8 15 8 18)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  8  6'Codpro'
     A                                      DSPATR(HI)
     A                                  8 15'Nom produit'
     A                                      DSPATR(HI)
     A                                  8 47'Qtpro'
     A                                      DSPATR(HI)
     A                                  8 55'Dtdinv'
     A                                      DSPATR(HI)
     A                                  1  2'SFRDSP'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 24'Sous-fichier avec positionnement'
     A                                      DSPATR(HI)
     A                                  3  2'Afficher à partir de :'
     A            SCODPRO        5   B  3 25CHECK(LC)
     A                                  3 31'(Codeproduit)'
     A                                  5  2'Indiquez vos option, puis appuyez -
     A                                      sur ENTREE.'
     A                                      COLOR(BLU)
     A                                  6  3'2=Editer'
     A                                      COLOR(BLU)
     A                                  6 14'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  6 28'5=Afficher'
     A                                      COLOR(BLU)
     A                                  8  1'Opt'
     A                                      DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 11'F6=Créer'
     A                                      COLOR(BLU)
     A          R FMT5
     A                                      WINDOW(*DFT 14 44)
     A                                      WDWTITLE((*TEXT 'Affiche Produit'))
     A                                      WDWBORDER((*COLOR YLW) (*DSPATR RI)-
     A                                       (*CHAR '<.>::<.>'))
     A            E5CODPRO  R        O  4 16REFFLD(ENTREPOTF/CODPRO BIB02/ENTR-
     A                                      EPOT)
     A                                      DSPATR(HI)
     A            E5NMPRO   R   30   O  5 15REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A            E5QTPRO   R        O  6 16REFFLD(ENTREPOTF/QTPRO BIB02/ENTRE-
     A                                      POT)
     A                                      DSPATR(HI)
     A            E5DTDINV  R        O  8 16REFFLD(ENTREPOTF/DTDINV BIB02/ENTR-
     A                                      EPOT)
     A                                      DSPATR(HI)
     A                                  4  1'Code prod   :'
     A                                  5  1'Nom produit :'
     A                                  6  1'Qte produit : '
     A                                  8  1'Date inv    : '
     A          R FMT4
     A                                      CF23(23)
     A                                  1 28'Suppression des Produits'
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
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 14'F12=Annuler'
     A                                      COLOR(BLU)
     A                                  7  3'Code produit'
     A                                  7 17':'
     A                                  8  3'Nom produit'
     A                                  8 17':'
     A                                  9  3'Qte produit'
     A                                  9 17':'
     A                                 10  3'Date Inv'
     A                                 10 17':'
     A                                  2 31'F23=Confirmation'
     A                                      COLOR(RED)
     A          R FMT2

     A                                      CF23(23)
     A                                  1 28'Modification des Produits'
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
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 14'F12=Annuler'
     A                                      COLOR(BLU)
     A                                  7  3'Code produit'
     A                                  7 17':'
     A                                  8  3'Nom produit'
     A                                  8 17':'
     A                                  9  3'Qte produit'
     A                                  9 17':'
     A                                 10  3'Date Inv'
     A                                 10 17':'
     A                                  2 31'F23=Confirmation'
     A                                      COLOR(RED)
     A          R FMT6
     A                                      CF23(23)
     A                                  1 28'Création des Produits'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'ENTREPOT'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E6CODPRO  R        I  7 20REFFLD(ENTREPOTF/CODPRO BIB02/ENTR-
     A                                      EPOT)
     A            E6NMPRO   R        I  8 20REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A            E6QTPRO   R        I  9 20REFFLD(ENTREPOTF/QTPRO BIB02/ENTRE-
     A                                      POT)
     A            E6DTDINV  R        B 10 20REFFLD(ENTREPOTF/DTDINV BIB02/ENTR-
     A                                      EPOT)
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 14'F12=Annuler'
     A                                      COLOR(BLU)
     A                                  7  3'Code produit'
     A                                  7 17':'
     A                                  8  3'Nom produit'
     A                                  8 17':'
     A                                  9  3'Qte produit'
     A                                  9 17':'
     A                                 10  3'Date Inv'
     A                                 10 17':'
     A                                  2 30'F23=Confirmation'
     A                                      COLOR(RED)
```
