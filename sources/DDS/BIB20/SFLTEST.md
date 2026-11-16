---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: SFLTEST
type: DDS
longueur_enregistrement: 80
lignes: 37
modifie: 2026-11-16
---

# BIB20/QDDSSRC/SFLTEST

```text
     A*%%TS  SD  20251112  154333  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R SFL                       SFL
     A*%%TS  SD  20251112  152446  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CHECK(AB)
     A  50                                  SFLNXTCHG
     A            OPT            2Y 0B 14  3EDTCDE(Z)
                                            VALUES(2 4 5)
     A            NUMBB     R        B 14  7REFFLD(FBONBON/NUMBB BIB20/BONBON)
     A            NOM       R        B 14 16REFFLD(FBONBON/NOM BIB20/BONBON)
     A            MARQUE    R        B 14 38REFFLD(FBONBON/MARQUE BIB20/BONBON)
     A            COULEU    R        B 14 60REFFLD(FBONBON/COULEU BIB20/BONBON)
     A            PRIX      R        B 14 72REFFLD(FBONBON/PRIX BIB20/BONBON)
     A          R CTL                       SFLCTL(SFL)
     A*%%TS  SD  20251112  154333  GGEOFFREY   REL-V7R5M0  5770-WDS
                                            CA03(03)
                                            ROLLUP(29)
     A                                      SFLSIZ(0006)
     A                                      SFLPAG(0005)
     A N30                                  SFLDSP
     A N31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A            RRANG          4S 0H      SFLRCDNBR
     A            SSCROLL        5S 0H      SFLSCROLL
     A                                  1 37'TEST SFL'
     A                                  3 10'Actuel :'
     A            NUMBB     R        O  9  7REFFLD(FBONBON/NUMBB BIB20/BONBON)
     A            NOM       R        O  9 16REFFLD(FBONBON/NOM BIB20/BONBON)
     A            MARQUE    R        O  9 38REFFLD(FBONBON/MARQUE BIB20/BONBON)
     A            COULEU    R        O  9 60REFFLD(FBONBON/COULEU BIB20/BONBON)
     A            PRIX      R        O  9 72REFFLD(FBONBON/PRIX BIB20/BONBON)
     A                                  3 33'RANG :'
     A            RANG           5S 0O  3 41
     A                                  5 31'Scroll :'
     A            SCROLL         5  0O  5 41
```
