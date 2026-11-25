---
bibliotheque: BIB25
fichier_source: QWEBSRVTP
membre: WSARTE
type: DDS
longueur_enregistrement: 100
lignes: 116
modifie: 2026-11-25
---

# BIB25/QWEBSRVTP/WSARTE

```text
     A*================================================================
     A* Ecran     : WSARTE
     A* Objet     : TP Web services (corrige) - gestion des articles
     A* Cote      : consommateur (personne B)
     A* Compil.   : CRTDSPF FILE(BIB25/WSARTE)
     A*             SRCFILE(BIB25/QWEBSRVTP) SRCMBR(WSARTE)
     A* Indicateurs : 03 F3  05 F5  06 F6  12 F12
     A*   31 SFLDSP 32 SFLDSPCTL 33 SFLCLR 34 SFLEND
     A*   41 creation (code saisissable)  42 affichage (tout protege)
     A*================================================================
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A* --- Sous-fichier : une ligne par article -----------------------
     A          R SFL01                     SFL
     A            SOPT           1A  B  7  3VALUES(' ' '2' '4' '5')
     A            SCODE          6A  O  7  6
     A            SLIB          30A  O  7 13
     A            SFAM           3A  O  7 44
     A            SPRIXHT        7Y 2O  7 48EDTCDE(3)
     A            STTC           9Y 2O  7 57EDTCDE(3)
     A            SSTOCK         5Y 0O  7 69EDTCDE(3)
     A* --- Controle du sous-fichier ------------------------------------
     A          R CTL01                     SFLCTL(SFL01)
     A                                      SFLSIZ(0999)
     A                                      SFLPAG(0014)
     A                                      CA03(03 'Sortie')
     A                                      CA05(05 'Actualiser')
     A                                      CA06(06 'Creer')
     A                                      CA12(12 'Annuler')
     A                                      OVERLAY
     A  31                                  SFLDSP
     A  32                                  SFLDSPCTL
     A  33                                  SFLCLR
     A  34                                  SFLEND(*MORE)
     A            RCDNBR         4S 0H      SFLRCDNBR(CURSOR)
     A                                  1  2'WSARTGES'
     A                                  1 27'Gestion des articles'
     A                                      DSPATR(HI)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  3  2'Positionner sur le code . :'
     A            POSCOD         6A  B  3 31
     A                                  4  2'Indiquez vos options, puis -
     A                                      appuyez sur Entrée.'
     A                                      COLOR(BLU)
     A                                  5  4'2=Modifier'
     A                                      COLOR(BLU)
     A                                  5 17'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  5 31'5=Afficher'
     A                                      COLOR(BLU)
     A                                  6  2'Opt'
     A                                      DSPATR(HI)
     A                                  6  6'Code'
     A                                      DSPATR(HI)
     A                                  6 13'Libellé'
     A                                      DSPATR(HI)
     A                                  6 44'Fam'
     A                                      DSPATR(HI)
     A                                  6 49'Prix HT'
     A                                      DSPATR(HI)
     A                                  6 58'Prix TTC'
     A                                      DSPATR(HI)
     A                                  6 69'Stock'
     A                                      DSPATR(HI)
     A* --- Bas d'ecran : touches et ligne de message ------------------
     A          R BAS
     A                                 22  2'F3=Sortie'
     A                                      COLOR(BLU)
     A                                 22 15'F5=Actualiser'
     A                                      COLOR(BLU)
     A                                 22 32'F6=Créer'
     A                                      COLOR(BLU)
     A                                 22 44'F12=Annuler'
     A                                      COLOR(BLU)
     A            MSG           78A  O 23  2COLOR(WHT)
     A* --- Detail : creation, modification, affichage ------------------
     A          R DET01                     CA12(12 'Annuler')
     A                                  1  2'WSARTGES'
     A            DTITRE        30A  O  1 27DSPATR(HI)
     A                                  4  2'Code . . . . . . . :'
     A            DCODE          6A  B  4 24
     A N41                                  DSPATR(PR)
     A                                  6  2'Libellé  . . . . . :'
     A            DLIB          30A  B  6 24
     A  42                                  DSPATR(PR)
     A                                  8  2'Famille  . . . . . :'
     A            DFAM           3A  B  8 24
     A  42                                  DSPATR(PR)
     A                                  8 30'INF, BUR, MOB, ENT'
     A                                      COLOR(BLU)
     A                                 10  2'Prix HT  . . . . . :'
     A            DPRIXHT        7Y 2B 10 24EDTCDE(3)
     A  42                                  DSPATR(PR)
     A                                 12  2'Taux de TVA  . . . :'
     A            DTVA           4Y 2B 12 24EDTCDE(3)
     A  42                                  DSPATR(PR)
     A                                 12 30'5,50  10,00  20,00'
     A                                      COLOR(BLU)
     A                                 14  2'Stock  . . . . . . :'
     A            DSTOCK         5Y 0B 14 24EDTCDE(3)
     A  42                                  DSPATR(PR)
     A                                 16  2'Prix TTC . . . . . :'
     A            DTTC           9Y 2O 16 24EDTCDE(3)
     A                                 22  2'Entrée=Valider   F12=Annuler'
     A                                      COLOR(BLU)
     A            MSG           78A  O 23  2COLOR(WHT)
     A* --- Fenetre de confirmation de suppression ----------------------
     A          R CONF01                    WINDOW(8 15 7 46)
     A                                      CA12(12 'Annuler')
     A                                  1  2'Suppression d''un article'
     A                                      DSPATR(HI)
     A            WCODE          6A  O  3  2
     A            WLIB          30A  O  3 10
     A                                  5  2'Confirmer la suppression (O/N) :'
     A            WREP           1A  B  5 36VALUES('O' 'N')
```
