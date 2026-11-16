---
bibliotheque: BIB02
fichier_source: QSRC
membre: ECRANPART
type: DDS
longueur_enregistrement: 100
lignes: 206
modifie: 2026-11-16
---

# BIB02/QSRC/ECRANPART

```text
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')
     A                                      CA12(12 'Retour')
     A                                      CA08(08 'Imprimer')
     A                                      CA09(09 'Api')
     A          R SFL1                      SFL
     A            OPT            1A  I  9  2
     A            E1CODPAR       5  0O  9  5
     A            E1NM           9A  O  9 11
     A            E1PRN          9A  O  9 21
     A            E1SCTE         9A  O  9 31
     A            E1ADR         26A  O  9 41
     A            E1NUMTEL      12  0O  9 68
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
     A                                  8  5'Code'
     A                                      DSPATR(HI)
     A                                  8 31'Société'
     A                                      DSPATR(HI)
     A                                  1  2'ECRAN'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 24'Gestion des participants'
     A                                      DSPATR(HI)
     A                                  3  2'Afficher à partir de :'
     A            SCODPAR   R        B  3 25REFFLD(PARTICIPAF/CODPAR +
     A                                      BIB02/PARTICIPA)
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
     A                                  8 11'Nom'
                                             DSPATR(HI)
     A                                  8 21'Prénom'
                                             DSPATR(HI)
     A                                  8 68'N° Tel'
                                             DSPATR(HI)
     A                                  8 41'Adresse Mail'
                                             DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
     A                                 23 12'F6=Creér'
     A                                      COLOR(BLU)
     A                                 23 21'F8=Imprimer'
     A                                       COLOR(BLU)
     A                                 23 33'F9=Créer TXT API'
     A                                      COLOR(BLU)
     A          R FMT5
     A                                      WINDOW(*DFT 14 44)
     A                                      WDWTITLE((*TEXT 'Affichage'))
     A                                      WDWBORDER((*COLOR YLW) (*DSPATR RI)-
     A                                       (*CHAR '<.>::<.>'))
     A            E5CODPAR  R        O  4 19REFFLD(PARTICIPAF/CODPAR BIB02/-
     A                                      PARTICIPA)
     A            E5NM      R        O  5 19REFFLD(PARTICIPAF/NM BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A            E5PRN     R        O  6 19REFFLD(PARTICIPAF/PRN BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A            E5SCTE    R        O  8 19REFFLD(PARTICIPAF/SCTE BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A            E5ADR     R        O  7 15REFFLD(PARTICIPAF/ADR BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A            E5NUMTEL  R        O  9 19REFFLD(PARTICIPAF/NUMTEL BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A                                  4  1'Code participant'
     A                                  5  1'Nom.............:'
     A                                  6  1'Prénom..........:'
     A                                  8  1'Société.........:'
     A                                  9  1'Numéro tél......:'
     A                                  7  1'Adresse.....:'
     A          R FMT4
     A                                      CF23(23)
     A                                  1 31'Suppression des participants'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'ENTREPOT'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E4CODPAR  R        O  5 25REFFLD(PARTICIPAF/CODPAR BIB02/-
     A                                      PARTICIPA)
     A            E4NM      R        O  6 25REFFLD(PARTICIPAF/NM BIB02/PARTICI-
     A                                      PA)
     A            E4PRN     R        O  7 25REFFLD(PARTICIPAF/PRN BIB02/PARTIC-
     A                                      IPA)
     A            E4SCTE    R        O  8 25REFFLD(PARTICIPAF/SCTE BIB02/PARTI-
     A                                      CIPA)
     A            E4ADR     R        O  9 25REFFLD(PARTICIPAF/ADR BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A                                      COLOR(GRN)
     A            E4NUMTEL  R        O 10 25REFFLD(PARTICIPAF/NUMTEL BIB02/-
     A                                      PARTICIPA)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  5  3'Code Participant...: '
     A                                  6  3'Nom Participant....:'
     A                                  7  3'Prénom Participant.:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  8  3'Société............:'
     A                                  9  3'Adresse mail.......:'
     A                                 10  3'N° Téléphone.......:'
     A          R FMT2
     A                                      CF23(23)
     A                                  1 31'Modification du participant'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'SESSIONSP'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E2CODPAR  R        O  6 24REFFLD(PARTICIPAF/CODPAR BIB02/-
     A                                      PARTICIPA)
     A            E2NM      R        B  7 24REFFLD(PARTICIPAF/NM BIB02/-
     A                                      PARTICIPA)
     A            E2PRN     R        B  8 24REFFLD(PARTICIPAF/PRN BIB02/-
     A                                      PARTICIPA)
     A            E2SCTE    R        B  9 24REFFLD(PARTICIPAF/SCTE BIB02/-
     A                                      PARTICIPA)
     A            E2ADR     R        B 10 24REFFLD(PARTICIPAF/ADR BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A                                      COLOR(GRN)
     A            E2NUMTEL  R        B 11 24REFFLD(PARTICIPAF/NUMTEL BIB02/-
     A                                      PARTICIPA)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  7  3'Nom..............:'
     A                                  8  3'Prénom...........:'
     A                                  9  3'Société..........:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                 11  3'N° Téléphone.....:'
     A                                 10  3'Adresse mail.....:'
     A                                  6  3'Code Participant.:'
     A          R FMT6
                                             CF23(23)
     A            E6CODPAR  R        O  8 24REFFLD(PARTICIPAF/CODPAR BIB02/-
     A                                      PARTICIPA)
     A            E6NM      R        I  9 24REFFLD(PARTICIPAF/NM BIB02/PARTICI-
     A                                      PA)
     A            E6PRN     R        I 10 24REFFLD(PARTICIPAF/PRN BIB02/PARTIC-
     A                                      IPA)
     A            E6SCTE    R        I 11 24REFFLD(PARTICIPAF/SCTE BIB02/PARTI-
     A                                      CIPA)
     A            E6ADR     R        I 12 24REFFLD(PARTICIPAF/ADR BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A            E6NUMTEL  R        I 13 24REFFLD(PARTICIPAF/NUMTEL BIB02/-
     A                                      PARTICIPA)
     A                                  1 31'Création d''un participant'
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
     A                                 11  3'Société..........:'
     A                                 12  3'Adresse Mail.....:'
     A                                 13  3'N° Téléphone.....:'
     A                                  8  3'Code Participant.:'
     A
```
