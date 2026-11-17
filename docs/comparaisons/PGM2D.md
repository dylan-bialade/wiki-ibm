# PGM2D : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QDDSRC | DDS | 27 | 37 % | DDS (R/K/PFILE) | [PGM2D.md](../../sources/DDS/BIB02/PGM2D.md) |
| BIB20 | QDDSSRC | DDS | 57 | 100 % | DDS (R/K/PFILE) | [PGM2D.md](../../sources/DDS/BIB20/PGM2D.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)

## Codes

### BIB02 (DDS, 27 lignes)

```text
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A          R FMT6
     A                                      CA12(12 'Retour')
     A                                  1 32'Consultation des courses'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  5  3'Numéro courses...:'
     A                                  7  3'Nom de la course :'
     A            NORACE    R        O  5 23REFFLD(NORACE BIB02/RACEP)
     A                                      DSPATR(HI)
     A            NMRACE    R        O  7 23REFFLD(NMRACE BIB02/RACEP)
     A                                      DSPATR(HI)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Fin de travail'
     A                                      COLOR(BLU)
     A                                 23 23'F12=Retour'
     A                                      COLOR(BLU)
     A                                  8  3'Résultat.........:'
     A            T1RACE    R        O  8 23REFFLD(RACEFMT/T1RACE RACES/RACEP)
     A                                      DSPATR(HI)
```

### BIB20 (DDS, 57 lignes)

```text
     A*%%TS  SD  20251007  131718  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A          R ECR1
     A*%%TS  SD  20230608  142901  JBORG       REL-V7R4M0  5770-WDS
     A                                      CA12(12 'Retour')
     A                                  1 32'Consultation des courses'
     A                                      DSPATR(HI)
     A                                      COLOR(PNK)
     A                                      DSPATR(RI)
     A                                  5  3'Numéro courses...:'
     A                                  7  3'Nom de la course :'
     A            NORACE    R        O  5 23REFFLD(NORACE RACES/RACEP)
     A                                      DSPATR(HI)
     A            NMRACE    R        O  7 23REFFLD(NMRACE RACES/RACEP)
     A                                      DSPATR(HI)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 70COLOR(BLU)
     A                                      DATE
     A                                      EDTCDE(Y)
     A                                 23  3'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 23'F12=Retour'
     A                                      COLOR(BLU)
     A                                  8  3'Résultat.........:'
     A            T1RACE    R        O  8 23REFFLD(RACEFMT/T1RACE RACES/RACEP)
     A                                      DSPATR(HI)
     A          R ECR2
     A*%%TS  SD  20241105  100506  JBORG       REL-V7R4M0  5770-WDS
     A                                      CF06(06)
     A                                      CA12(12)
     A                                  1 32'Titre de l écran2'
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A                                  6  7'Numéro de la course ...:'
     A                                 10  7'Nom de la course .......:'
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A            NORACE    R        B  6 33REFFLD(RACEFMT/NORACE RACES/RACEP)
     A            NMRACE    R        B 10 33REFFLD(RACEFMT/NMRACE RACES/RACEP)
     A                                 12  7'Nom du coureur ...:'
     A            COURREUR      25A  O 12 29DSPATR(RI)
     A                                 23  9'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 19'F12=Annuler'
     A                                      COLOR(BLU)
     A                                 23 36'F6=Création'
     A                                      COLOR(BLU)
     A  27                                  DSPATR(ND)
     A          R ECRMAIN
     A*%%TS  SD  20251007  131718  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                  9  5'Type de la course :'
     A            TYPECOURSE     3   B  9 27
```
