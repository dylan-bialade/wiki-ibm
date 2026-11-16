---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: ECREABON
type: DDS
longueur_enregistrement: 160
lignes: 31
modifie: 2026-11-16
---

# BIB20/QDDSSRC/ECREABON

```text
     A*%%TS  SD  20251110  143640  GGEOFFREY   REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R CREATION
     A*%%TS  SD  20251106  145053  GGEOFFREY   REL-V7R5M0  5770-WDS                                                         CA03(03)
                                            CA12(12)                                                                        CA04(04)
                                            RTNCSRLOC(&RCD &FLD)                     A            RCD           10A  H
     A            FLD           10A  H                                               A                                  1  3USER
     A                                      COLOR(BLU)                               A                                  2  3'Agrion'
     A                                      COLOR(BLU)                               A                                  1 33'Créer un bonbon'
     A                                      COLOR(WHT)                               A                                  1 73DATE
     A                                      EDTCDE(Y)                                A                                      COLOR(BLU)
     A                                  2 73TIME                                     A                                      COLOR(BLU)
     A                                  5  5'Une fois les champs remplis, appuy-     A                                      ez sur ENTRÉE pour confirmer.'
     A                                      COLOR(WHT)                               A                                  8  9'Numéro du bonbon . :'
     A            NUMBB     R        B  8 30REFFLD(FBONBON/NUMBB BIB20/BONBON)      A                                      CHECK(ME)
     A                                 10  9'Nom du bonbon  . . :'                   A            NOM       R        B 10 30REFFLD(FBONBON/NOM BIB20/BONBON)
     A                                      CHECK(ME)                                A                                 12  9'Marque du bonbon . :'
     A            MARQUE    R        B 12 30REFFLD(FBONBON/MARQUE BIB20/BONBON)     A                                      CHECK(ME)
     A                                 14  9'Couleur du bonbon  :'                   A                                 16  9'Prix du bonbon . . :'
     A            COULEU    R        B 14 30REFFLD(FBONBON/COULEU BIB20/BONBON)     A                                      CHECK(ME)
     A            PRIX      R        B 16 30REFFLD(FBONBON/PRIX BIB20/BONBON)       A                                      EDTCDE(Q)
     A                                      CHECK(ME)                                A            MSGCREA       67   O 20  5
     A N90                                  COLOR(WHT)                               A  90                                  COLOR(RED)
     A                                 23  3'F3=Sortir'                              A                                      COLOR(BLU)
     A                                 23 17'F12=Annuler'                            A                                      COLOR(BLU)
     A          R INVCOULEU                 SFL                                                   OPT            1S 0B  5  5VALUES(1)
                  COULEU    R        B  5  8REFFLD(FBONBON/COULEU BIB20/BONBON)     A*%%TS  SD  20251110  091939  GGEOFFREY   REL-V7R5M0  5770-WDS
     A          R CTLCOULEU                 SFLCTL(INVCOULEU)                        A*%%TS  SD  20251110  143640  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0011)                             A                                      SFLPAG(0010)
     A N30                                  SFLDSP                                   A N31                                  SFLDSPCTL
     A  32                                  SFLCLR                                   A N33                                  SFLEND(*MORE)
     A                                  1 31'Choix d une couleur'                    A                                      COLOR(BLU)
```
