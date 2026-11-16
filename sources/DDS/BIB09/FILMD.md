---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: FILMD
type: DDS
longueur_enregistrement: 120
lignes: 77
modifie: 2026-11-16
---

# BIB09/QSOURCES/FILMD

```text
     A*================================================================
     A* Fichier : FILMD
     A* Type    : DSPF (Fichier Ecran)
     A* Desc    : Ecran de gestion des films avec sous-fichier
     A* Bib     : BIB09
     A*================================================================
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A*----------------------------------------------------------------
     A* Format ASSUME (evite problemes affichage initial)
     A*----------------------------------------------------------------
     A          R FANTOME
     A                                      ASSUME
     A                                  1  3' '
     A*----------------------------------------------------------------
     A* SFL1 : Lignes du sous-fichier
     A*----------------------------------------------------------------
     A          R SFL1                      SFL
     A            OPT            1A  B  8  2VALUES(' ' '1' '2' '4' '5')
     A            EIDFILM        5Y 0O  8  5
     A            ETITREFILM    50A  O  8 12
     A*----------------------------------------------------------------
     A* CTL1 : Controle du sous-fichier
     A*----------------------------------------------------------------
     A          R CTL1                      SFLCTL(SFL1)
     A                                      CA03(03 'Sortie')
     A                                      CA05(05 'Actualiser')
     A                                      CA06(06 'Creation')
     A                                      CA12(12 'Annuler')
     A N90                                  ROLLUP(39)
     A                                      OVERLAY
     A N32                                  SFLDSP
     A N31                                  SFLDSPCTL
     A  31                                  SFLCLR
     A  90                                  SFLEND(*MORE)
     A                                      SFLSIZ(0015)
     A                                      SFLPAG(0014)
     A* En-tete ecran
     A*
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 30'GESTION DES FILMS'
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A                                  1 70DATE
     A                                      EDTCDE(Y)
     A                                  3  2'Recherche :'
     A                                      COLOR(WHT)
     A            WRECHERCHE    30A  B  3 14
     A*
     A* En-tete colonnes
     A*
     A                                  6  2'Opt'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                  6  5'ID'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                  6 12'Titre du film'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A*
     A* Legende options
     A*
     A*----------------------------------------------------------------
     A* BAS1 : Bas d ecran (touches de fonction)
     A*----------------------------------------------------------------
     A          R BAS1
     A                                 22  2'F3=Sortie   F5=Actualiser   F6=Cr-
     A                                      eation   F12=Annuler'
     A                                      COLOR(BLU)
     A*----------------------------------------------------------------
     A* MSGLIGNE : Ligne de message
     A*----------------------------------------------------------------
     A          R MSGLIGNE
     A                                      OVERLAY
     A            WMSG          78A  O 24  2COLOR(RED)
```
