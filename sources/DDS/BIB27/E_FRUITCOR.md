---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: E_FRUITCOR
type: DDS
longueur_enregistrement: 160
lignes: 19
modifie: 2026-11-25
---

# BIB27/QFREESRC/E_FRUITCOR

```text
     A                                      CA03(03)                                 A                                      CA05(05)
     A                                      CA06(06)                                 A                                      CA12(12)
     A          R SFL1                      SFL                                      A            OPT            1   I  7  2
     A            EIDFRUIT       2   H                                               A            ENOMFRUIT     20   O  7  5
     A            ENOMLATIN     20   O  7 29                                         A          R CTL1                      SFLCTL(SFL1)
     A N31                                  SFLDSPCTL                                A N32                                  SFLDSP
     A  31                                  SFLCLR                                   A  90                                  SFLEND(*MORE)
     A                                      SFLPAG(10)                               A                                      SFLSIZ(11)
     A                                      OVERLAY                                  A                                  1 30'Liste des fruits'
     A                                      COLOR(WHT)                               A                                  4  2'2=Editer    4=Supprimer    5=Affic-
     A                                      her'                                     A                                      COLOR(BLU)
     A                                  3  2'Indiquez vos options, puis appuyez-     A                                       sur ENTREE.'
     A                                      COLOR(BLU)                               A          R BAS
     A                                 22  5'F3 =Exit   F5=Réafficher    F6=Cré-     A                                      er'
     A                                      COLOR(BLU)                               A          R MODIF
     A            E2ID           4   B  4 35                                         A  80                                  DSPATR(PR)
     A            E2NOM         20   B  5 35                                         A            E2NOMLATIN    20   B  6 35
     A                                  4 15'Identifiant :'                          A                                  5 15'Nom         :'
     A                                  6 15'Nom Latin   :'                          A            TITRE         25   O  1 29
```
