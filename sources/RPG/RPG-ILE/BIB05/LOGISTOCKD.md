---
bibliotheque: BIB05
fichier_source: QRPGLESRC3
membre: LOGISTOCKD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 164
modifie: 2026-11-16
---

# BIB05/QRPGLESRC3/LOGISTOCKD

```text
     A*-----------------------------------------------------------------
     A* LOGISTOCKD : ECRAN DU TP LOGISTOCK (sous-fichier + options)
     A*-----------------------------------------------------------------
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A* ---------- SOUS-FICHIER : UNE LIGNE (11 lignes par page) ----------
     A          R SFL1                      SFL
     A            OPT            1A  B  9  2
     A            CODPRO         5A  O  9  7
     A            NOMPRO        30A  O  9 15
     A            QTPRO          3S 0O  9 51
     A            DTDINV          L  O  9 58DATFMT(*ISO)
     A* ---------- SOUS-FICHIER : CONTROLE (en-tete + positionnement) -------
     A          R CTL1                      SFLCTL(SFL1)
     A                                      SFLSIZ(9999)
     A                                      SFLPAG(11)
     A                                      OVERLAY
     A                                      ROLLUP(25)
     A                                      CF06(06)
     A* 31=SFLDSP  32=SFLDSPCTL  33=SFLCLR  34=SFLEND (voir programme RPG)
     A  31                                  SFLDSP
     A  32                                  SFLDSPCTL
     A  33                                  SFLCLR
     A  34                                  SFLEND(*MORE)
     A* SFLPOS : numero de la ligne a afficher en haut de page
     A            SFLPOS         4S 0H      SFLRCDNBR(CURSOR)
     A* POSCOD : filtre, afficher a partir de ce code produit
     A            POSCOD         5A  B  3 25
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 25'Sous-fichier avec positionnement'
     A                                      DSPATR(HI)
     A                                  3  2'Afficher a partir de :'
     A                                  3 32'(Codeproduit)'
     A                                  5  2'Indiquez vos options,'
     A                                      COLOR(BLU)
     A                                  5 24'puis appuyez sur ENTREE.'
     A                                      COLOR(BLU)
     A                                  6  2'2=Editer'
     A                                      COLOR(BLU)
     A                                  6 14'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  6 28'5=Afficher'
     A                                      COLOR(BLU)
     A                                  8  2'Opt'
     A                                      COLOR(WHT)
     A                                  8  7'Codpro'
     A                                      COLOR(WHT)
     A                                  8 15'Nom produit'
     A                                      COLOR(WHT)
     A                                  8 51'Qtpro'
     A                                      COLOR(WHT)
     A                                  8 58'Dtdinv'
     A                                      COLOR(WHT)
     A* ---------- PIED DE PAGE + MESSAGE (ecrit avant CTL1) ----------
     A          R FOOTER
     A            MSG           60A  O 21  2COLOR(RED)
     A                                 22  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 22 14'F6=Creer'
     A                                      COLOR(BLU)
     A* ---------- OPTION 5 : FENETRE POP-UP ----------
     A          R FMTAFF                    WINDOW(6 25 11 50)
     A                                      WDWBORDER((*COLOR YLW) +
     A                                      (*CHAR '<.>::<.>'))
     A                                      WDWTITLE((*TEXT 'Affiche Produit') +
     A                                      (*COLOR YLW))
     A                                  2  2'Code prod    :'
     A            CODPRO         5A  O  2 17
     A                                  3  2'Nom produit  :'
     A            NOMPRO        30A  O  3 17
     A                                  4  2'Qte produit  :'
     A            QTPRO          3S 0O  4 17
     A                                  6  2'Date inv     :'
     A            DTDINV          L  O  6 17DATFMT(*ISO)
     A                                 10  2'ENTREE=Fermer'
     A                                      COLOR(BLU)
     A* ---------- OPTION 2 : MODIFICATION (F23 pour confirmer) ----------
     A          R FMTMOD
     A                                      CF23(23)
     A                                      CF12(12)
     A            MSG           60A  O 21  2COLOR(RED)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 28'Modification des Produits'
     A                                      DSPATR(HI)
     A                                  2 30'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  5  3'Code produit :'
     A            CODPRO         5A  O  5 20DSPATR(UL)
     A                                  6  3'Nom produit  :'
     A            NOMPRO        30A  B  6 20
     A                                  7  3'Qte produit  :'
     A            QTPRO          3S 0B  7 20
     A                                  8  3'Date Inv     :'
     A            DTDINV          L  B  8 20DATFMT(*ISO)
     A                                 22  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 22 14'F12=Annuler'
     A                                      COLOR(BLU)
     A* ---------- OPTION 4 : SUPPRESSION (F23 pour confirmer) ----------
     A          R FMTSUP
     A                                      CF23(23)
     A                                      CF12(12)
     A            MSG           60A  O 21  2COLOR(RED)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 27'Suppression des Produits'
     A                                      DSPATR(HI)
     A                                  2 30'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  5  3'Code produit :'
     A            CODPRO         5A  O  5 20
     A                                  6  3'Nom produit  :'
     A            NOMPRO        30A  O  6 20
     A                                  7  3'Qte produit  :'
     A            QTPRO          3S 0O  7 20
     A                                  8  3'Date Inv     :'
     A            DTDINV          L  O  8 20DATFMT(*ISO)
     A                                 10  3'Confirmez la suppression avec F23'
     A                                      COLOR(RED)
     A                                 22  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 22 14'F12=Annuler'
     A                                      COLOR(BLU)
     A* ---------- F6 : CREATION ----------
     A          R FMTCRE
     A                                      CF12(12)
     A            MSG           60A  O 21  2COLOR(RED)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 28'Creation des Produits'
     A                                      DSPATR(HI)
     A                                  2 32'ENTREE=Valider'
     A                                      COLOR(BLU)
     A                                  5  3'Code produit :'
     A            CODPRO         5A  B  5 20
     A                                  6  3'Nom produit  :'
     A            NOMPRO        30A  B  6 20
     A                                  7  3'Qte produit  :'
     A            QTPRO          3S 0B  7 20
     A                                  8  3'Date Inv     :'
     A            DTDINV          L  B  8 20DATFMT(*ISO)
     A                                 22  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 22 14'F12=Annuler'
     A                                      COLOR(BLU)
     A*%%RS+<record-sequences>
     A*%%RS+ <sequence name="Sans titre">
     A*%%RS+  <device type="display" width="80" height="24" />
     A*%%RS+ </sequence>
     A*%%RS </record-sequences>
```
