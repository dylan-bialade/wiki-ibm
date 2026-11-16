---
bibliotheque: BIB10
fichier_source: QDSPSRC
membre: BONBOND
type: DDS
longueur_enregistrement: 80
lignes: 77
modifie: 2026-11-16
---

# BIB10/QDSPSRC/BONBOND

```text
     A*%%TS  SD  20261015  093714  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      CF05(05)
     A          R SFL1                      SFL
     A*%%TS  SD  20261015  092245  XUAN        REL-V7R5M0  5770-WDS
     A            E1OPT          1A  B 11  5
     A            NUMBER    R        H      REFFLD(FBONBON/NUMBER BIB10/BONBON)
     A            NOM       R        O 11  8REFFLD(FBONBON/NOM BIB10/BONBON)
     A            MARQUE    R        O 11 31REFFLD(FBONBON/MARQUE BIB10/BONBON)
     A            COULEUR   R        O 11 54REFFLD(FBONBON/COULEUR BIB10/BONBON)
     A            PRIX      R        O 11 67REFFLD(FBONBON/PRIX BIB10/BONBON)
     A                                      EDTWRD(' 0 ,  &€')
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261015  093714  XUAN        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0010)
     A                                      SFLPAG(0009)
     A                                      CF06(06 'Create')
     A                                      CF21(21 'Print')
     A                                      OVERLAY
     A  80                                  SFLDSP
     A  81                                  SFLDSPCTL
     A  82                                  SFLCLR
     A  83                                  SFLEND(*MORE)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  7SYSNAME
     A                                  1 67'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  7USER
     A                                  2 67'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 72TIME
     A                                  1 32'Liste des Bonbons'
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A                                  7  4'Veuillez choisir une option et app-
     A                                      uyez sur ENTREE'
     A                                      COLOR(BLU)
     A                                  8  5'2=Modifier'
     A                                      COLOR(BLU)
     A                                 10  4'Opt'
     A                                      COLOR(WHT)
     A                                 10  8'Nom'
     A                                      COLOR(BLU)
     A                                 10 31'Marque'
     A                                      COLOR(BLU)
     A                                  8 16'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  8 28'5=afficher'
     A                                      COLOR(BLU)
     A                                  5 38'Afficher a partir de :'
     A                                      COLOR(BLU)
     A            E1AFF         20A  I  5 61CHECK(LC)
     A                                 10 54'Couleur'
     A                                      COLOR(BLU)
     A                                 10 67'Prix'
     A                                      COLOR(BLU)
     A          R FOOT1
     A*%%TS  SD  20261015  092245  XUAN        REL-V7R5M0  5770-WDS
     A                                 23 31'F21=imprimer liste'
     A                                      COLOR(BLU)
     A                                 23  3'F5=Réaficher'
     A                                      COLOR(BLU)
     A                                 23 19'F6=Créer'
     A                                      COLOR(BLU)
     A                                 23 59'F3=Quitter'
     A                                      COLOR(BLU)
```
