---
bibliotheque: BIB25
fichier_source: QILETP
membre: TPF_ECR
type: DDS
longueur_enregistrement: 80
lignes: 92
modifie: 2026-11-25
---

# BIB25/QILETP/TPF_ECR

```text
     A*%%TS  SD  20250430  142700  LEO2        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R SFL1                      SFL
     A*%%TS  SD  20250430  135741  LEO2        REL-V7R5M0  5770-WDS
     A            OPT            1A  I 10  4
     A            E_TITRE       25A  O 10  8
     A            E_AUTEUR      25A  O 10 35
     A            E_SORTIE  R        O 10 62REFFLD(TP_LIVRES/SORTIE BIB25/TP-
     A                                      _LIVRES)
     A                                      DATFMT(*ISO)
     A            E_DISPO        1A  O 10 76
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20250430  135741  LEO2        REL-V7R5M0  5770-WDS
     A                                      CF06(06)
     A                                      CF05(05)
     A                                      OVERLAY
     A  30                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A                                  1  2TIME
     A                                  2  2DATE
     A                                      EDTCDE(Y)
     A                                  1 32'Gestion des livres'
     A                                      COLOR(WHT)
     A                                  1 70USER
     A                                  2 70SYSNAME
     A                                  6  3'Indiquez vos options, puis appuyer-
     A                                       sur ENTREE.'
     A                                      COLOR(BLU)
     A                                  7  4'2=Modifier'
     A                                      COLOR(BLU)
     A                                  7 31'5=Afficher'
     A                                      COLOR(BLU)
     A                                  7 17'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  9  3'Opt'
     A                                      COLOR(WHT)
     A                                  9  8'Titre'
     A                                      COLOR(WHT)
     A                                  9 35'Auteur'
     A                                      COLOR(WHT)
     A                                  9 62'date'
     A                                      COLOR(WHT)
     A                                  9 74'dispo'
     A                                      COLOR(WHT)
     A                                  4  3'Afficher à partir (titre) : '
     A            SEARCH        25A  I  4 33
     A          R BAS
     A*%%TS  SD  20250430  135741  LEO2        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 16'F5=Actualiser'
     A                                      COLOR(BLU)
     A                                 23 32'F6=Créer'
     A                                      COLOR(BLU)
     A          R WIN1
     A*%%TS  SD  20250430  135741  LEO2        REL-V7R5M0  5770-WDS
     A                                      CA12(12)
     A                                      CF15(15)
     A                                      WINDOW(2 15 13 50)
     A                                      WDWBORDER((*COLOR YLW))
     A                                  2 18'Ajouter un livre'
     A                                      COLOR(WHT)
     A                                  5  3'Titre :'
     A                                  7  3'Auteur :'
     A                                  9  3'Date de sortie :'
     A            W_TITRE       25A  B  5 13CHECK(LC)
     A            W_AUTEUR      25A  B  7 13CHECK(LC)
     A                                 11  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 11 15'F12=Précédent'
     A                                      COLOR(BLU)
     A                                 11 31'F15=Valider'
     A                                      COLOR(BLU)
     A            W_SORTIE      10A  B  9 23
     A            ERR_MSG       30A  O 12  4COLOR(WHT)
     A          R WIN2
     A*%%TS  SD  20250430  142700  LEO2        REL-V7R5M0  5770-WDS
     A                                      CF23(23)
     A                                      WINDOW(6 10 5 60)
     A                                      WDWBORDER((*COLOR YLW))
     A                                  2  2'Vous allez supprimer le livre :'
     A            DLT_L         25A  O  2 35
     A                                  4  3'F12=Précédent'
     A                                      COLOR(BLU)
     A                                  4 19'F23=Confirmer Suppression'
     A                                      COLOR(BLU)
```
