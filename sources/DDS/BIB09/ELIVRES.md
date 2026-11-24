---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: ELIVRES
type: DDS
longueur_enregistrement: 120
lignes: 77
modifie: 2026-11-16
---

# BIB09/QSOURCES/ELIVRES

```text
     A*%%TS  SD  20250211  EXERCICE ORGFORM - GESTION LIVRES
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03 'Quitter')
     A                                      REF(LIVRES)
     A*
     A* =============================================
     A* FORMAT 1 : SAISIE ISBN
     A* =============================================
     A          R FMT1
     A                                      CF06(06 'Ajouter')
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  2  3SYSNAME
     A                                      COLOR(BLU)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  1 28'GESTION DES LIVRES'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A                                  5  5'+-------------------------------+'
     A                                      COLOR(BLU)
     A                                  6  5'|'
     A                                      COLOR(BLU)
     A                                  6 39'|'
     A                                      COLOR(BLU)
     A                                  7  5'+-------------------------------+'
     A                                      COLOR(BLU)
     A                                  6  8'Saisir ISBN :'
     A                                      COLOR(WHT)
     A            ISBN      R        I  6 23
     A            MSG1          50A  O 10  5COLOR(RED)
     A                                 23  2'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 15'F6=Ajouter'
     A                                      COLOR(BLU)
     A*
     A* =============================================
     A* FORMAT 2 : DETAIL / MODIFICATION / SUPPRESSION
     A* =============================================
     A          R FMT2
     A                                      CF12(12 'Retour')
     A                                      CF13(13 'Supprimer')
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  2  3SYSNAME
     A                                      COLOR(BLU)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  1 28'DETAIL DU LIVRE'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A                                  5  5'ISBN ........:'
     A                                      COLOR(WHT)
     A            ISBN      R        O  5 20
     A                                  7  5'Titre ......:'
     A                                      COLOR(WHT)
     A            TITRE     R        B  7 20CHECK(LC)
     A                                  9  5'Auteur .....:'
     A                                      COLOR(WHT)
     A            AUTEUR    R        B  9 20CHECK(LC)
     A            MSG2          50A  O 13  5COLOR(RED)
     A                                  6  5'Modifier les champs puis'
     A                                      COLOR(BLU)
     A                                  6 31'Entree pour valider'
     A                                      COLOR(BLU)
     A                                 23  2'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 15'F12=Retour'
     A                                      COLOR(BLU)
     A                                 23 28'F13=Supprimer'
     A                                      COLOR(BLU)
```
