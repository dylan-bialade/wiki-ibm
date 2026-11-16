# SFL001CBLD : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB01 | QCBLLESRC | COBOL | 130 | 100 % | sous-fichier, DDS (R/K/PFILE) | [SFL001CBLD.md](../../sources/COBOL/BIB01/SFL001CBLD.md) |
| BIB20 | QCBLLESRC | COBOL | 130 | 88 % | sous-fichier, DDS (R/K/PFILE) | [SFL001CBLD.md](../../sources/COBOL/BIB20/SFL001CBLD.md) |

## Differences

- Techniques communes : sous-fichier, DDS (R/K/PFILE)

## Codes

### BIB01 (COBOL, 130 lignes)

```text
     A*%%TS  SD  20260430  143350  JBORG       REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A                                      CA06(06)
     A**************************************INDARA
     A          R SFL1                      SFL
     A*%%TS  SD  20260424  094233  JBORG       REL-V7R5M0  5770-WDS
     A            DBLNAM        20A  O  7  9
     A            DBFNAM        20A  O  7 34
     A            DBCIVI         3A  O  7 61
     A            DBTELP        10A  O  7 69
     A************ZONEH         95A  H
     A            OPT            1   I  7  4
     A          R SF1CTL                    SFLCTL(SFL1)
     A*%%TS  SD  20260430  143350  JBORG       REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0016)
     A                                      SFLPAG(0015)
     A                                      OVERLAY
     A N32                                  SFLDSP
     A N31                                  SFLDSPCTL
     A  31                                  SFLCLR
     A                                  6  9'Nom'
     A                                      DSPATR(HI)
     A                                  6 34'Prénom'
     A                                      DSPATR(HI)
     A                                  6 61'Civ.'
     A                                      DSPATR(HI)
     A                                  6 69'Téléphone'
     A                                      DSPATR(HI)
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 25'Sous-fichier avec positionnement'
     A                                      DSPATR(HI)
     A                                  4 31'Afficher à partir de (Nom) :'
     A            PTNAME        20A  B  4 60CHECK(LC)
     A                                      CHANGE(51)
     A                                  2 35'Sous-fichier'
     A                                      DSPATR(HI)
     A                                  6  3'Opt'
     A                                      DSPATR(HI)
     A            FLD001        10A  O  3  5COLOR(BLU)
     A          R FMT6
     A*%%TS  SD  20260422  155806  JBORG       REL-V7R5M0  5770-WDS
     A                                      CA12(12)
     A                                      CF23(23)
     A*                                     RTNCSRLOC(&RCD &FLD)
     A*           RCD           10A  H
     A*           FLD           10A  H
     A                                  1 34'Création fiche'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'SFL001D'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  8  5'Nom :'
     A            DBLNAM        20   B  8 20
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 11'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 24'F23=Confirmer'
     A                                      COLOR(BLU)
     A                                 10  5'Prénom :'
     A            DBFNAM        20   B 10 20
     A                                 12  5'Civilité:'
     A            DBCIVI         3   B 12 20
     A                                 14  5'Téléphone:'
     A            DBTELP        10   B 14 20
     A          R FMT5
     A                                      CA12(12)
     A                                  1 34'VISU fiche'
     A                                      COLOR(YLW)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'SFL001D'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  8  5'Nom :'
     A            DBLNAM        20   O  8 20
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 11'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 24'F23=Confirmer'
     A                                      COLOR(BLU)
     A                                 10  5'Prénom :'
     A            DBFNAM        20   O 10 20
     A                                 12  5'Civilité:'
     A            DBCIVI         3   O 12 20
     A                                 14  5'Téléphone:'
     A            DBTELP        10   O 14 20
     A          R FMT2
     A                                      CA12(12)
     A                                      CF23(23)
     A                                  1 34'MAJ  fiche'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'SFL001D'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  8  5'Nom :'
     A            DBLNAM        20   B  8 20
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 11'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 24'F23=Confirmer'
     A                                      COLOR(BLU)
     A                                 10  5'Prénom :'
     A            DBFNAM        20   B 10 20
     A                                 12  5'Civilité:'
     A            DBCIVI         3   B 12 20
     A                                 14  5'Téléphone:'
     A            DBTELP        10   B 14 20
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
```

### BIB20 (COBOL, 130 lignes)

```text
     A*%%TS  SD  20260430  143350  JBORG       REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03)
     A                                      CA06(06)
     A**************************************INDARA
     A          R SFL1                      SFL
     A*%%TS  SD  20260424  094233  JBORG       REL-V7R5M0  5770-WDS
     A            DBLNAM        20A  O  7  9
     A            DBFNAM        20A  O  7 34
     A            DBCIVI         3A  O  7 61
     A            DBTELP        10A  O  7 69
     A            ZONEH         95A  H
     A            OPT            1   I  7  4
     A          R SF1CTL                    SFLCTL(SFL1)
     A*%%TS  SD  20260430  143350  JBORG       REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0016)
     A                                      SFLPAG(0015)
     A                                      OVERLAY
     A                                      ROLLUP(29)
     A N32                                  SFLDSP
     A N31                                  SFLDSPCTL
     A  31                                  SFLCLR
     A                                  6  9'Nom'
     A                                      DSPATR(HI)
     A                                  6 34'Prénom'
     A                                      DSPATR(HI)
     A                                  6 61'Civ.'
     A                                      DSPATR(HI)
     A                                  6 69'Téléphone'
     A                                      DSPATR(HI)
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 25'Sous-fichier avec positionnement'
     A                                      DSPATR(HI)
     A                                  4 31'Afficher à partir de (Nom) :'
     A            PTNAME        20A  B  4 60CHECK(LC)
     A                                      CHANGE(51)
     A                                  2 35'Sous-fichier'
     A                                      DSPATR(HI)
     A                                  6  3'Opt'
     A                                      DSPATR(HI)
     A            FLD001        10A  O  3  5COLOR(BLU)
     A          R FMT6
     A*%%TS  SD  20260422  155806  JBORG       REL-V7R5M0  5770-WDS
     A                                      CA12(12)
     A                                      CF23(23)
     A                                      RTNCSRLOC(&RCD &FLD)
     A            RCD           10A  H
     A            FLD           10A  H
     A                                  1 34'Création fiche'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'SFL001D'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  8  5'Nom :'
     A            DBLNAM        20   B  8 20
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 11'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 24'F23=Confirmer'
     A                                      COLOR(BLU)
     A                                 10  5'Prénom :'
     A            DBFNAM        20   B 10 20
     A                                 12  5'Civilité:'
     A            DBCIVI         3   B 12 20
     A                                 14  5'Téléphone:'
     A            DBTELP        10   B 14 20
     A          R FMT5
     A                                      CA12(12)
     A                                  1 34'VISU fiche'
     A                                      COLOR(YLW)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'SFL001D'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  8  5'Nom :'
     A            DBLNAM        20   O  8 20
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 11'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 24'F23=Confirmer'
     A                                      COLOR(BLU)
     A                                 10  5'Prénom :'
     A            DBFNAM        20   O 10 20
     A                                 12  5'Civilité:'
     A            DBCIVI         3   O 12 20
     A                                 14  5'Téléphone:'
     A            DBTELP        10   O 14 20
     A          R FMT2
     A                                      CA12(12)
     A                                  1 34'MAJ  fiche'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'SFL001D'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                  8  5'Nom :'
     A            DBLNAM        20   B  8 20
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 11'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 24'F23=Confirmer'
     A                                      COLOR(BLU)
     A                                 10  5'Prénom :'
     A            DBFNAM        20   B 10 20
     A                                 12  5'Civilité:'
     A            DBCIVI         3   B 12 20
     A                                 14  5'Téléphone:'
     A            DBTELP        10   B 14 20
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
```
