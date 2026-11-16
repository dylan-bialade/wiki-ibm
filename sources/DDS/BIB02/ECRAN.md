---
bibliotheque: BIB02
fichier_source: QSRC
membre: ECRAN
type: DDS
longueur_enregistrement: 100
lignes: 332
modifie: 2026-11-16
---

# BIB02/QSRC/ECRAN

```text
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')
     A                                      CA12(12 'Retour')
     A                                      CA08(08 'Imprimer')
     A                                      CA07(07 'Participant')
     A                                      CA09(09 'Formation')
     A                                      ERRSFL
                                            INDARA
     A                                      ALTHELP(CA01)
     A                                      HLPTITLE('Aide au programme')
     A                                      HELP

     A          R SFL1                      SFL
     A            OPT            1A  I  9  2
     A            E1CODFOR       5   O  9  5
     A            E1DTDBT         L  O  9 11
     A            E1DTFIN         L  O  9 22
     A            E1NM           9A  O  9 33
     A            E1PRN          9A  O  9 43
     A            E1SCTE         9A  O  9 53
     A            E1ETAT         1A  O  9 63
     A  88                                  COLOR(RED)
     A            E1TPE          1A  O  9 65
     A  89                                  COLOR(PNK)
     A            E1PRNFMTR     10A  O  9 69
     A            E1ADR         30A  H
     A            E1NUMTEL      12  0H
     A            E1CODSES       5  0H
     A            E1CODPAR       5  0H
     A            E1CODFMTR      5  0H
     A            E1NBJFOR      10S 0H

     A

     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A                                      ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A
     A          H                           HLPPNLGRP('GENERAL' HLP)
     A                                      HLPARA(1 1 2 24)
     A          H                           HLPPNLGRP('ETAT'  HLP)
     A                                      HLPARA(8 60 8 63)
     A          H                           HLPPNLGRP('TYPE' HLP)
     A                                      HLPARA(8 64 8 67)
     A          H                           HLPPNLGRP('FILTRE' HLP)
     A                                      HLPARA(3 25 4 48)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  8  5'Code'
     A                                      DSPATR(HI)
     A                                  8 33'Nom'
     A                                      DSPATR(HI)
     A                                  8 53'Société'
     A                                      DSPATR(HI)
     A                                  1  2'ECRAN'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 24'Gestion des sessions de formation'
     A                                      DSPATR(HI)
     A                                  3  2'Afficher à partir de :'
     A            SDTDBT    R        B  3 25REFFLD(SESSIONF/DTDBT BIB02/SESS-
     A                                      IONSP)
     A                                  3 37'(Date Début)'
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
     A                                  8 11'Date début'
                                             DSPATR(HI)
     A                                  8 22'Date fin'
                                             DSPATR(HI)
     A                                  8 69'Form.'
                                             DSPATR(HI)
     A                                  8 65'Tpe'
                                             DSPATR(HI)
     A                                  8 63'E'
                                             DSPATR(HI)
     A                                  8 43'Prénom'
                                             DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
     A                                 23 12'F6=Creér'
     A                                      COLOR(BLU)
     A                                 23 45'F8=Imprimer'
     A                                       COLOR(BLU)
     A                                 23 22'F7=Gestion Participant'
     A                                       COLOR(BLU)
     A                                 23 58'F9=Créer une formation'
     A                                       COLOR(BLU)
     A          R FMT5
     A                                      WINDOW(*DFT 14 44)
     A                                      WDWTITLE((*TEXT 'Affichage'))
     A                                      WDWBORDER((*COLOR YLW) (*DSPATR RI)-
     A                                       (*CHAR '<.>::<.>'))
     A            E5CODSES  R        H      REFFLD(SESSIONF/CODSES BIB02/-
     A                                      SESSIONSP)
     A            E5CODPAR  R        H      REFFLD(PARTICIPAF/CODPAR BIB02/-
     A                                      PARTICIPA)
     A            E5CODFMTR R        H      REFFLD(FORMATEURF/CODFMTEUR BIB02/-
     A                                      FORMATEUR)
     A            E5CODFOR  R        O  2 19REFFLD(SESSIONF/CODFOR BIB02/-
     A                                      SESSIONSP)
     A                                      DSPATR(HI)
     A            E5DTDBT   R        O  3 19REFFLD(SESSIONF/DTDBT BIB02/-
     A                                      SESSIONSP)
     A                                      DSPATR(HI)
     A            E5DTFIN   R        O  4 19REFFLD(SESSIONF/DTFIN BIB02/-
     A                                      SESSIONSP)
     A                                      DSPATR(HI)
     A            E5NM      R        O  5 19REFFLD(PARTICIPAF/NM BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A            E5PRN     R        O  6 19REFFLD(PARTICIPAF/PRN BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A            E5SCTE    R        O  9 19REFFLD(PARTICIPAF/SCTE BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A            E5ETAT    R        O 10 19REFFLD(SESSIONF/ETAT BIB02/-
     A                                      SESSIONSP)
     A                                      DSPATR(HI)
     A            E5TPE     R        O 11 19REFFLD(SESSIONF/TPE BIB02/-
     A                                      SESSIONSP)
     A                                      DSPATR(HI)
     A            E5PRNFMTR R        O 12 19REFFLD(FORMATEURF/PRNFMTEUR
     A                                      BIB02/FORMATEUR)
     A                                      DSPATR(HI)
     A
     A            E5ADR     R        O  8 15REFFLD(PARTICIPAF/ADR BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A            E5NUMTEL  R        O  7 19REFFLD(PARTICIPAF/NUMTEL BIB02/-
     A                                      PARTICIPA)
     A                                      DSPATR(HI)
     A                                  2  1'Code Formation..:'
     A                                  3  1'Date début......:'
     A                                  4  1'Date fin........:'
     A                                  5  1'Nom.............:'
     A                                  6  1'Prénom..........:'
     A                                  9  1'Société.........:'
     A                                 10  1'Etat (payé).....:'
     A                                 11  1'Type............:'
     A                                 12  1'Formateur.......:'
     A                                  7  1'Numéro tél......:'
     A                                  8  1'Adresse.....:'
     A          R FMT4
     A                                      CF23(23)
     A                                  1 31'Suppression des SessIONSP'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'ENTREPOT'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)

     A            E4CODSES  R        H      REFFLD(SESSIONF/CODSES BIB02/-
     A                                      SESSIONSP)
     A            E4CODPAR  R        H      REFFLD(PARTICIPAF/CODPAR BIB02/-
     A                                      PARTICIPA)
     A            E4CODFMTR R        H      REFFLD(FORMATEURF/CODFMTEUR BIB02/-
     A                                      FORMATEUR)
     A            E4CODFOR  R        O  5 25REFFLD(SESSIONF/CODFOR BIB02/-
     A                                      SESSIONSP)
     A            E4DTDBT   R        O  6 25REFFLD(SESSIONF/DTDBT BIB02/-
     A                                      SESSIONSP)
     A            E4DTFIN   R        O  7 25REFFLD(SESSIONF/DTFIN BIB02/-
     A                                      SESSIONSP)
     A            E4NM      R        O  8 25REFFLD(SESSIONF/NM BIB02/-
     A                                      SESSIONSP)
     A            E4PRN     R        O  9 25REFFLD(SESSIONF/PRN BIB02/-
     A                                      SESSIONSP)
     A            E4SCTE    R        O 10 25REFFLD(SESSIONF/SCTE BIB02/-
     A                                      SESSIONSP)
     A            E4ETAT    R        O 11 25REFFLD(SESSIONF/ETAT BIB02/-
     A                                      SESSIONSP)
     A            E4TPE     R        O 12 25REFFLD(SESSIONF/TPE BIB02/-
     A                                      SESSIONSP)
     A            E4PRNFMTR R        O 13 25REFFLD(FORMATEURF/PRNFMTEUR
     A                                      BIB02/FORMATEUR)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  5  3'Code formateur.....: '
     A                                  6  3'Date début session.:'
     A                                  7  3'Date fin session...:'
     A                                  8  3'Nom................:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  9  3'Prénom.............:'
     A                                 12  3'Type...............:'
     A                                 11  3'Etat...............:'
     A                                 13  3'Formateur..........:'
     A                                 10  3'Société............:'
     A          R FMT2
     A                                      CF23(23)
     A                                  1 31'Modification de la session'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'SESSIONSP'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E2CODSES  R        H      REFFLD(SESSIONF/CODSES BIB02/-
     A                                      SESSIONSP)
     A            E2CODPAR  R        H      REFFLD(PARTICIPAF/CODPAR BIB02/-
     A                                      PARTICIPA)
     A            E2CODFMTR R        H      REFFLD(FORMATEURF/CODFMTEUR BIB02/-
     A                                      FORMATEUR)
     A            E2CODFOR  R        B  5 24REFFLD(SESSIONF/CODFOR BIB02/-
     A                                      SESSIONSP)
     A            E2DTDBT   R        B  6 24REFFLD(SESSIONF/DTDBT BIB02/-
     A                                      SESSIONSP)
     A            E2DTFIN   R        H      REFFLD(SESSIONF/DTFIN BIB02/-
     A                                      SESSIONSP)
     A            E2NM      R        B  7 24REFFLD(PARTICIPAF/NM BIB02/-
     A                                      PARTICIPA)
     A            E2PRN     R        B  8 24REFFLD(PARTICIPAF/PRN BIB02/-
     A                                      PARTICIPA)
     A            E2SCTE    R        B  9 24REFFLD(PARTICIPAF/SCTE BIB02/-
     A                                      PARTICIPA)
     A            E2ETAT    R        B 10 24REFFLD(SESSIONF/ETAT BIB02/-
     A                                      SESSIONSP)
     A            E2TPE     R        B 11 24REFFLD(SESSIONF/TPE BIB02/-
     A                                      SESSIONSP)
     A            E2PRNFMTR R        B 12 24REFFLD(FORMATEURF/PRNFMTEUR
     A                                      BIB02/FORMATEUR)
     A            E2NBJFOR  R        H      REFFLD(FORMATIONF/NBJFOR +
     A                                      BIB02/FORMA)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  7  3'Nom..............:'
     A                                  8  3'Prénom...........:'
     A                                  9  3'Société..........:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                 11  3'Type.............:'
     A                                 10  3'Etat.............:'
     A                                 12  3'Formateur........:'
     A                                  5  3'Code Formation...:'
     A                                  6  3'Date Début.......:'
     A          R FMT6
                                             CF23(23)
     A            E6CODSES  R        O  4 24REFFLD(SESSIONF/CODSES BIB02/-
     A                                      SESSIONSP)
     A  60                                  ERRMSG('Le code session doit +
     A                                      etre unique' 60)
     A
     A            E6CODPAR  R        I  5 24REFFLD(PARTICIPAF/CODPAR BIB02/-
     A                                      PARTICIPA)
     A  61                                  ERRMSG('Le participant n''existe +
     A                                      pas' 61)
     A
     A            E6CODFOR  R        I  6 24REFFLD(SESSIONF/CODFOR BIB02/-
     A                                      SESSIONSP)
     A  62                                  ERRMSG('Le code formation   +
     A                                      n''existe pas' 62)
     A            E6CODFMTR R        I  7 24REFFLD(FORMATEURF/CODFMTEUR BIB02/-
     A                                      FORMATEUR)
     A            E6DTDBT   R        B  8 24REFFLD(SESSIONF/DTDBT BIB02/-
     A                                      SESSIONSP)
     A            E6DTFIN   R        H      REFFLD(SESSIONF/DTFIN BIB02/-
     A                                      SESSIONSP)
     A            E6NM      R        I  9 24REFFLD(SESSIONF/NM BIB02/-
     A                                      SESSIONSP)
     A            E6PRN     R        I 10 24REFFLD(SESSIONF/PRN BIB02/-
     A                                      SESSIONSP)
     A            E6SCTE    R        I 11 24REFFLD(SESSIONF/SCTE BIB02/-
     A                                      SESSIONSP)
     A            E6ETAT    R        I 12 24REFFLD(SESSIONF/ETAT BIB02/-
     A                                      SESSIONSP)
     A            E6TPE     R        I 13 24REFFLD(SESSIONF/TPE BIB02/-
     A                                      SESSIONSP)
     A            E6PRNFMTR R        I 14 24REFFLD(FORMATEURF/PRNFMTEUR
     A                                      BIB02/FORMATEUR)
     A            E6NBJFOR  R        H      REFFLD(FORMATIONF/NBJFOR +
     A                                      BIB02/FORMA)
     A                                  1 31'Création d''une session          '
     A
     A
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
     A                                  6  3'Code Formation...:'
     A                                  9  3'Nom..............:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  8  3'Date Début.......:'
     A                                 10  3'Prénom...........:'
     A                                 11  3'Société..........:'
     A                                 12  3'Etat.............:'
     A                                 13  3'Type.............:'
     A                                 14  3'Formateur........:'
     A                                  5  3'Code Participant.:'
     A                                 12 45'F = Facturé ; N = Non Facturé'
                                             COLOR(BLU)
     A                                 13 45'D = Distanciel, P = Présentiel'
                                             COLOR(BLU)
     A                                  4  3'Code Session.....:'
     A                                  7  3'Code Formateur...:'
     A
```
