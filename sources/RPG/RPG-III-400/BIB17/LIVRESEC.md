---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: LIVRESEC
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 75
modifie: 2026-11-16
---

# BIB17/QRPGSRC/LIVRESEC

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A* LIVRESD2 - Ecran de gestion des livres (copie de LIVRESD)
     A* Indicateurs : 61 = zones protegees (A et D)
     A*               62 = ISBN saisissable (creation)
     A*               63 = mode suppression (affiche F23)
     A*               64 = message d erreur (rouge)
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A* FMT1 : saisie du numero ISBN et de l option
     A          R FMT1
     A                                      CF06(06)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 32'Gestion des livres'
     A                                      COLOR(WHT)
     A                                  1 66TIME
     A                                  2 66DATE
     A                                      EDTCDE(Y)
     A                                  6  3'Numéro ISBN du livre :'
     A                                      COLOR(WHT)
     A            E1ISB          5Y 0I  6 28
     A                                  8  3'Option               :'
     A                                      COLOR(WHT)
     A            E1OPT          1A  I  8 28
     A                                  8 38'(A = Afficher)'
     A                                  9 38'(M = Modifier)'
     A                                 10 38'(D = Supprimer)'
     A                                 20  4'Message : '
     A                                      COLOR(WHT)
     A            E1MSG         50A  O 20 15
     A  64                                  COLOR(RED)
     A N64                                  COLOR(GRN)
     A                                 23  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 16'F6=Créer'
     A                                      COLOR(BLU)
     A* FMT2 : detail du livre (affichage, modif, suppression, creation)
     A          R FMT2
     A                                      CF12(12)
     A                                      CF23(23)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 32'Gestion des livres'
     A                                      COLOR(WHT)
     A                                  1 66TIME
     A                                  2 66DATE
     A                                      EDTCDE(Y)
     A            E2MOD         20A  O  4 32
     A                                      COLOR(WHT)
     A                                  7  8'Numéro ISBN :'
     A            E2ISB          5Y 0B  7 24
     A N62                                  DSPATR(PR)
     A                                  9  8'Titre       :'
     A            E2TIT         30A  B  9 24
     A                                      CHECK(LC)
     A  61                                  DSPATR(PR)
     A                                 11  8'Auteur      :'
     A            E2AUT         30A  B 11 24
     A                                      CHECK(LC)
     A  61                                  DSPATR(PR)
     A                                 13  8'Dispo       :'
     A            E2DISP         1A  B 13 24
     A  61                                  DSPATR(PR)
     A                                 13 28'(O = Oui, N = Non)'
     A                                 20  4'Message : '
     A                                      COLOR(WHT)
     A            E1MSG         50A  O 20 15
     A  64                                  COLOR(RED)
     A N64                                  COLOR(GRN)
     A                                 23  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 16'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 30'F23=Supprimer'
     A                                      COLOR(BLU)
     A N63                                  DSPATR(ND)
```
