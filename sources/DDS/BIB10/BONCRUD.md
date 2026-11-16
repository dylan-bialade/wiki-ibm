---
bibliotheque: BIB10
fichier_source: QDSPSRC
membre: BONCRUD
type: DDS
longueur_enregistrement: 160
lignes: 35
modifie: 2026-11-16
---

# BIB10/QDSPSRC/BONCRUD

```text
     A*%%TS  SD  20261013  134220  XUAN        REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R FMT1
     A*%%TS  SD  20261013  115114  XUAN        REL-V7R5M0  5770-WDS                  A                                      CF03(03)
     A                                      CF12(12)                                 A                                  1  3'SYS'
     A                                      COLOR(BLU)                               A                                  1  7SYSNAME
     A                                  1 67'DATE'                                   A                                      COLOR(BLU)
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2  3'USR'                                    A                                      COLOR(BLU)
     A                                  2  7USER                                     A                                  2 67'TIME'
     A                                      COLOR(BLU)                               A                                  2 72TIME
     A                                 24  4'F3=Exit'                                A                                      COLOR(BLU)
     A                                 24 13'F12=Annuler'                            A                                      COLOR(BLU)
     A                                 24 26'F23=Valider'                            A                                      COLOR(BLU)
     A                                  9 13'NOM:'                                   A            CNOM      R        B  9 20REFFLD(FBONBON/NOM BIB10/BONBONF)
     A  50                                  DSPATR(PR)                               A                                      CHECK(LC)
     A  81                                  ERRMSG('Nom Obligatoire !!' 81)         A                                 11 10'MARQUE:'
     A            CMRQ      R        B 11 20REFFLD(FBONBON/MARQUE BIB10/BONBONF)      A  50                                  DSPATR(PR)
     A  82                                  ERRMSG('Marque obligatoire' 82)         A                                      CHECK(LC)
     A                                 13  9'COULEUR:'                               A            CCOUL     R        B 13 20REFFLD(FBONBON/COULEUR BIB10/BONBONF)
     A  50                                  DSPATR(PR)                               A                                      CHECK(LC)
     A                                 15 12'PRIX:'                                  A            CPRX      R        B 15 20REFFLD(FBONBON/PRIX BIB10/BONBONF)
     A                                      EDTCDE(N)                                A  50                                  DSPATR(PR)
     A  83                                  ERRMSG('Prix Obligatoire !!' 83)        A                                  7 10'NUMBER:'
     A            CNUM      R        O  7 20REFFLD(FBONBON/NUMBER BIB10/BONBONF)      A                                  1 35'Fiche bonbon'
     A                                      COLOR(BLU)                               A            CMOD          20A  O  2 31COLOR(WHT)
     A                                 23  3'F3=exit'                                A                                      COLOR(BLU)
     A                                 23 27'Entree=Valider  F12=Annuler'            A                                      COLOR(BLU)
     A                                 23 65'F20=impression'                         A                                      COLOR(BLU)
     A          R WFMT1                                                              A*%%TS  SD  20261013  134220  XUAN        REL-V7R5M0  5770-WDS
     A                                      WINDOW(6 12 10 50)                       A                                  1 21'Suppression'
     A                                  4  4'Vous etes sur le point de supprime-     A                                      r:'
     A            CNOM          20A  O  5  4                                         A                                  9  4'Confirmer la suppression:'
     A            CVER           3   B  9 31                                         A                                  9 35'(OUI/NON)'
     A          R DUMMY                                                              A*%%TS  SD  20261013  132108  XUAN        REL-V7R5M0  5770-WDS
     A                                      ASSUME                                   A                                  1  3' '
```
