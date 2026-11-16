---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: ENTREPDSP
type: DDS
longueur_enregistrement: 160
lignes: 58
modifie: 2026-11-16
---

# BIB17/QDDSSRC/ENTREPDSP

```text
     A*%%TS  SD  20261023  161820  REMI        REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R SFL1                      SFL
     A*%%TS  SD  20261023  130559  REMI        REL-V7R5M0  5770-WDS                  A            OPT            1  0B  9  2
     A            CODPRO    R        O  9  7REFFLD(ENTREPOTF/CODPRO BIB17/-     A                                      ENTREPOT)
     A            NOMPROD   R        O  9 16REFFLD(ENTREPOTF/NOMPROD BIB17-     A                                      /ENTREPOT)
     A            QUANTSTOCKR        O  9 52REFFLD(ENTREPOTF/QUANTSTOCK BIB16-     A                                      EMB/ENTREPOT)
     A            DINVDATE  R        O  9 61REFFLD(ENTREPOTF/DINVDATE STREICHEM-     A                                      B/ENTREPOT)
     A          R CTL1                      SFLCTL(SFL1)                             A*%%TS  SD  20261023  143517  REMI        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0012)                             A                                      SFLPAG(0011)
     A                                      CF03                                     A                                      CF06
     A                                      OVERLAY                                  A  32                                  SFLDSP
     A  31                                  SFLDSPCTL                                A  30                                  SFLCLR
     A  33                                  SFLEND(*MORE)                            A            NMPGM         10A  O  1  3
     A                                  1 25'Sous-fichier avec positionnement'       A                                      COLOR(WHT)
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2 72TIME                                     A                                  3  3'Afficher à partir de :'
     A            FLTCOD    R        B  3 26REFFLD(ENTREPOTF/CODPRO BIB17/-     A                                      ENTREPOT)
     A                                      CHANGE(70)                               A                                  3 33'(Code produit)'
     A                                  5  3'Indiquez vos options, puis appuyez-     A                                       sur ENTREE'
     A                                      COLOR(BLU)                               A                                  6  5'2=Editer   4=Supprimer   5=Affiche-
     A                                      r'                                       A                                      COLOR(BLU)
     A                                  8  2'Opt'                                    A                                      COLOR(WHT)
     A                                  8  7'Codpro'                                 A                                      COLOR(WHT)
     A                                  8 16'Nom produit'                            A                                      COLOR(WHT)
     A                                  8 52'Qtpro'                                  A                                      COLOR(WHT)
     A                                  8 61'Dtinv'                                  A                                      COLOR(WHT)
     A          R FOOT                                                               A*%%TS  SD  20261023  130559  REMI        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Exit  F6=Créer'                      A                                      COLOR(BLU)
     A          R FMTMOD                                                             A*%%TS  SD  20261023  161820  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03                                     A                                      CF12
     A                                      CF23                                     A                                  1  3USER
     A                                      COLOR(BLU)                               A            NMPGM         10A  O  2  3COLOR(BLU)
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2 72TIME                                     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)                               A                                  7  8'Code produit   :'
     A                                  8  8'Nom produit    :'                       A                                  9  8'Qte produit    :'
     A                                 10  8'Date inv       :'                       A            CODPRO    R        B  7 26REFFLD(ENTREPOTF/CODPRO BIB17/-
     A                                      ENTREPOT)                                A            NOMPROD   R        B  8 26REFFLD(ENTREPOTF/NOMPROD BIB17-
     A                                      /ENTREPOT)                               A            QUANTSTOCKR        B  9 26REFFLD(ENTREPOTF/QUANTSTOCK BIB16-
     A                                      EMB/ENTREPOT)                            A            DINVDATE  R        B 10 26REFFLD(ENTREPOTF/DINVDATE STREICHEM-
     A                                      B/ENTREPOT)                              A                                      DATFMT(*ISO)
     A                                      TEXT('DTE_DERNIER_INVENT')               A                                 23  6'F3=Exit   F12=Annuler'
     A                                      COLOR(BLU)                               A            MODEED        12   O  1 29COLOR(WHT)
     A                                  1 43'du produit'                             A                                      COLOR(WHT)
     A          R BIDON                                                              A*%%TS  SD  20261023  130559  REMI        REL-V7R5M0  5770-WDS
     A                                      ASSUME                                   A                                  1  3' '
     A          R WDWAFF                                                             A*%%TS  SD  20261023  130559  REMI        REL-V7R5M0  5770-WDS
     A                                      TEXT('*')                                A                                      WINDOW(4 12 14 60)
     A                                      WDWTITLE((*TEXT 'AFFICHE PRODUIT') +                                            *CENTER *TOP)
     A                                      WDWBORDER((*COLOR YLW) (*DSPATR HI -     A                                      RI) (*CHAR '<.>::<.>'))
     A                                  4  4'Code prod   :'                          A                                  5  4'Nom produit :'
     A                                  6  4'Qte produit :'                          A                                  8  4'Date inv    :'
     A            CODPRO    R        B  4 20REFFLD(ENTREPOTF/CODPRO BIB17/-     A                                      ENTREPOT)
     A                                      COLOR(WHT)                               A            NOMPROD   R        B  5 20REFFLD(ENTREPOTF/NOMPROD BIB17-
     A                                      /ENTREPOT)                               A                                      COLOR(WHT)
     A            QUANTSTOCKR        B  6 20REFFLD(ENTREPOTF/QUANTSTOCK BIB16-     A                                      EMB/ENTREPOT)
     A                                      COLOR(WHT)                               A            DINVDATE  R        B  8 20REFFLD(ENTREPOTF/DINVDATE STREICHEM-
     A                                      B/ENTREPOT)                              A                                      COLOR(WHT)
```
