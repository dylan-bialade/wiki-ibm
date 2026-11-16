---
bibliotheque: BIB02
fichier_source: QSRC
membre: ECRANFRMT
type: DDS
longueur_enregistrement: 100
lignes: 166
modifie: 2026-11-16
---

# BIB02/QSRC/ECRANFRMT

```text
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')
     A                                      CA12(12 'Retour')
     A                                      CA08(08 'Imprimer')
     A          R SFL1                      SFL
     A            OPT            1A  I  9  2
     A            E1CODFMT       5  0O  9 12
     A            E1NM           9A  O  9 21
     A            E1PRN          9A  O  9 31
     A            E1NUMTEL      12  0O  9 41
     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A                                      ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  8 12'Code'
     A                                      DSPATR(HI)
     A                                  1  2'ECRAN'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 24'Gestion des formateurs'
     A                                      DSPATR(HI)
     A                                  3  2'Afficher à partir de :'
     A            SCODFMT   R        B  3 25REFFLD(FORMATEURF/CODFMTEUR +
     A                                      BIB02/FORMATEUR)
     A                                  3 32'(Code participant)'
     A                                  8  1'Opt'
     A                                      DSPATR(HI)
     A                                  5  2'Indiquez vos option, puis appuyez-
     A                                       sur ENTREE.'
     A                                      COLOR(BLU)
     A                                  6  3'2=Editer'
     A                                      COLOR(BLU)
     A                                  6 12'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  6 24'5=Afficher'
     A                                      COLOR(BLU)
     A                                  8 21'Nom'
                                             DSPATR(HI)
     A                                  8 31'Prénom'
                                             DSPATR(HI)
     A                                  8 41'N° Tel'
                                             DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
     A                                 23 12'F6=Creér'
     A                                      COLOR(BLU)
     A                                 23 21'F8=Imprimer'
     A                                       COLOR(BLU)
     A          R FMT5
     A                                      WINDOW(*DFT 14 44)
     A                                      WDWTITLE((*TEXT 'Affichage'))
     A                                      WDWBORDER((*COLOR YLW) (*DSPATR RI)-
     A                                       (*CHAR '<.>::<.>'))
     A            E5CODFMT  R        O  4 19REFFLD(FORMATEURF/CODFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E5NM      R        O  5 19REFFLD(FORMATEURF/NOMFMTEUR +
     A                                      BIB02/FORMATEUR)
     A                                      DSPATR(HI)
     A            E5PRN     R        O  6 19REFFLD(FORMATEURF/PRNFMTEUR +
     A                                      BIB02/FORMATEUR)
     A                                      DSPATR(HI)
     A            E5NUMTEL  R        O  7 19REFFLD(FORMATEURF/NUMTELEUR +
     A                                      BIB02/FORMATEUR)
     A                                      DSPATR(HI)
     A                                  4  1'Code formateur..:'
     A                                  5  1'Nom.............:'
     A                                  6  1'Prénom..........:'
     A                                  7  1'Numéro tél......:'
     A          R FMT4
     A                                      CF23(23)
     A                                  1 31'Suppression des formateurs'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'ENTREPOT'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E4CODFMT  R        O  5 25REFFLD(FORMATEURF/CODFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E4NM      R        O  6 25REFFLD(FORMATEURF/NOMFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E4PRN     R        O  7 25REFFLD(FORMATEURF/PRNFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E4NUMTEL  R        O  8 25REFFLD(FORMATEURF/NUMTELEUR +
     A                                      BIB02/FORMATEUR)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  5  3'Code formateur.....: '
     A                                  6  3'Nom formateur......:'
     A                                  7  3'Prénom formateur...:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  8  3'N° Téléphone.......:'
     A          R FMT2
     A                                      CF23(23)
     A                                  1 31'Modification des formateurs'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'SESSIONSP'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E2CODFMT  R        O  6 24REFFLD(FORMATEURF/CODFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E2NM      R        B  7 24REFFLD(FORMATEURF/NOMFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E2PRN     R        B  8 24REFFLD(FORMATEURF/PRNFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E2NUMTEL  R        B  9 24REFFLD(FORMATEURF/NUMTELEUR +
     A                                      BIB02/FORMATEUR)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  7  3'Nom..............:'
     A                                  8  3'Prénom...........:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  9  3'N° Téléphone.....:'
     A                                  6  3'Code Formateur...:'
     A          R FMT6
                                             CF23(23)
     A            E6CODFMT  R        O  8 24REFFLD(FORMATEURF/CODFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E6NM      R        I  9 24REFFLD(FORMATEURF/NOMFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E6PRN     R        I 10 24REFFLD(FORMATEURF/PRNFMTEUR +
     A                                      BIB02/FORMATEUR)
     A            E6NUMTEL  R        I 11 24REFFLD(FORMATEURF/NUMTELEUR +
     A                                      BIB02/FORMATEUR)
     A                                  1 31'Création d''un formateur'
     A                                      COLOR(WHT)
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  9  3'Nom..............:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                 10  3'Prénom...........:'
     A                                 11  3'N° Téléphone.....:'
     A                                  8  3'Code Participant.:'
     A
```
