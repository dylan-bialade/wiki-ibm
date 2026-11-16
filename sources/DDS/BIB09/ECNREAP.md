---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: ECNREAP
type: DDS
longueur_enregistrement: 120
lignes: 57
modifie: 2026-11-16
---

# BIB09/QSOURCES/ECNREAP

```text
     A*==========================================================
     A* ÉCRAN : ECNREAP
     A* Consultation des réapprovisionnements produits
     A* Auteur : Sylvain BIB02 - NOTOS / Armonie
     A*==========================================================
     A* CRTDSPF FILE(BIBLIO/ECNREAP) SRCFILE(BIBLIO/QDDSSRC)
     A*==========================================================
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Quitter')
     A*---------------------------------------------------------
     A          R FMT1
     A*
     A* --- Bandeau titre ---
     A                                  1  2'SYSTEM V'
     A                                      DSPATR(HI)
     A                                  1 22'CONSULTATION REAPPRO.'
     A                                      DSPATR(HI)
     A                                  1 65DATE
     A                                      EDTCDE(Y)
     A*
     A* --- Séparateur ---
     A                                  2  2'-------------------------------'
     A                                      COLOR(BLU)
     A*
     A* --- Libellé du produit en cours ---
     A                                  4  2'Produit :'
     A                                      COLOR(BLU)
     A            LIBPRO        30A  O  4 13
     A                                      DSPATR(HI)
     A*
     A* --- Détails du réapprovisionnement ---
     A                                  6  2'Code produit  :'
     A            CODPRO         5Y 0O  6 19
     A                                      EDTCDE(4)
     A*
     A                                  8  2'Date réappro. :'
     A            WDTREP        10A  O  8 19
     A                                      DSPATR(HI)
     A*
     A                                 10  2'Qté commandée :'
     A            QTECMD        10Y 0O 10 19
     A                                      EDTCDE(1)
     A*
     A                                 12  2'Fournisseur   :'
     A            FOURN         20A  O 12 19
     A*
     A* --- Zone de message ---
     A                                 18  2'-------------------------------'
     A                                      COLOR(BLU)
     A            WMSG          50A  O 20  2
     A                                      COLOR(YLW)
     A*
     A* --- Barre de fonctions ---
     A                                 23  2'ENTREE = Produit suivant'
     A                                      COLOR(BLU)
     A                                 23 40'F3 = Quitter'
     A                                      COLOR(BLU)
```
