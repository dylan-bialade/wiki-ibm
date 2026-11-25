---
bibliotheque: BIB27
fichier_source: QTPSRC
membre: E_TPFINAL
type: DDS
longueur_enregistrement: 100
lignes: 98
modifie: 2026-11-25
---

# BIB27/QTPSRC/E_TPFINAL

```text
     A*%%TS  SD  20231222  115739  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A                                      CA12(12)
     A          R SF1                       SFL
     A*%%TS  SD  20231222  102239  LEO2        REL-V7R4M0  5770-WDS
     A            OPT            1A  B 10  4
     A            E_LIBELLE     20A  O 10 13
     A            E_PRIXHT       6Y 2O 10 37EDTCDE(A *)
     A            E_PRIXTTC      6Y 2O 10 57EDTCDE(A *)
     A            E_TVA          3S 0H
     A          R CTL1                      SFLCTL(SF1)
     A*%%TS  SD  20231222  103744  LEO2        REL-V7R4M0  5770-WDS
     A                                      SFLSIZ(0009)
     A                                      SFLPAG(0008)
     A                                      CF05(05)
     A                                      CF06(06)
     A                                      CF08(08)
     A                                      OVERLAY
     A  50                                  SFLDSP
     A  51                                  SFLDSPCTL
     A  52                                  SFLCLR
     A  53                                  SFLEND(*MORE)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 31'Gestion des Articles'
     A                                      COLOR(WHT)
     A                                  1 73TIME
     A                                  2 73DATE
     A                                      EDTCDE(Y)
     A                                  4 45'Afficher à partir de :'
     A            E_SRH         10A  I  4 70CHECK(LC)
     A                                  6  2'Indiquez vos options, puis appuyer-
     A                                       sur ENTREE.'
     A                                      COLOR(BLU)
     A                                  7  4'2=Editer'
     A                                      COLOR(BLU)
     A                                  7 16'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  7 31'5=Afficher'
     A                                      COLOR(BLU)
     A                                  9  3'Opt'
     A                                      COLOR(WHT)
     A                                  9 13'Libelle'
     A                                      COLOR(WHT)
     A                                  9 37'Prix Hors Taxe'
     A                                      COLOR(WHT)
     A                                  9 57'Prix TTC'
     A                                      COLOR(WHT)
     A          R BAS
     A*%%TS  SD  20231222  101715  LEO2        REL-V7R4M0  5770-WDS
     A                                 22  3'f3=Exit'
     A                                      COLOR(BLU)
     A                                 22 15'f5=Actualiser'
     A                                      COLOR(BLU)
     A                                 22 33'f6=Ajouter'
     A                                      COLOR(BLU)
     A                                 22 48'f8=Impression'
     A                                      COLOR(BLU)
     A          R FMT1
     A*%%TS  SD  20231222  115739  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF02(02)
     A                                      CF23(23)
     A                                      CF06(06)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 31'Gestion des Articles'
     A                                      COLOR(WHT)
     A                                  1 72TIME
     A                                  2 72DATE
     A                                      EDTCDE(Y)
     A            TITRE         20A  O  3 31
     A                                  7 16'Libelle Article :'
     A            E1_LIBELLE    20A  B  7 36
     A  60                                  DSPATR(PR)
     A                                      CHECK(LC)
     A                                  8 18'Rayon Article :'
     A            E1_RAYON      20A  B  8 36
     A  60                                  DSPATR(PR)
     A                                      CHECK(LC)
     A                                  9  5'Prix Hors Taxe Article (€) :'
     A            E1_PRIXHT      6Y 2B  9 36EDTCDE(A *)
     A  60                                  DSPATR(PR)
     A                                 10 11'Prix TTC Article (€) :'
     A            E1_PRIXTTC     6Y 2B 10 36EDTCDE(A *)
     A                                      DSPATR(PR)
     A                                 11 16'TVA Article (%) :'
     A            E1_TVA         3S 0B 11 36
     A  60                                  DSPATR(PR)
     A                                 21  2'f3=Exit'
     A                                      COLOR(BLU)
     A                                 21 14'f12=précédent'
     A                                      COLOR(BLU)
     A            FONCTION      15A  O 22  2COLOR(BLU)
     A                                 19  3'Message...:'
     A                                      COLOR(RED)
     A            MSG           50A  O 19 16
```
