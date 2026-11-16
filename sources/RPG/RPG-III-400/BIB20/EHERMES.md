---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: EHERMES
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 72
modifie: 2026-11-16
---

# BIB20/QRPGSRC/EHERMES

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     A*%%TS  SD  20251031  110936  GGEOFFREY   REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R HERMESF                   SFL
     A*%%TS  SD  20251024  103503  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CHECK(AB)
     A            SELECT         1A  I  7  2VALUES('2' '4' '5')
     A            IDARTICLE      5S 0O  7  5
     A            NOMARTICLE    20A  O  7 11
     A            TAILLE         2S 0O  7 32
     A            COULEUR       10A  O  7 35
     A            PRIX           7S 2O  7 46
     A            QTESTK         5S 0O  7 54
     A          R HERMESCTL                 SFLCTL(HERMESF)
     A*%%TS  SD  20251024  103503  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A  30                                  SFLDSP
     A  31                                  SFLDSPCTL
     A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A            RANG           4S 0H      SFLRCDNBR
     A            SCROLL         5S 0H      SFLSCROLL
     A                                  1 32'Gestion des stocks'
     A                                      COLOR(WHT)
     A          R MODIF
     A*%%TS  SD  20251031  095147  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A                                      CA12(12)
     A                                      WINDOW(5 9 13 45)
     A                                      WDWBORDER((*COLOR BLU) (*DSPATR RI)-
     A                                       (*CHAR '        '))
     A
     A  58                                  RMVWDW
     A                                  8  9'Taille . . .:'
     A                                 10  9'Couleur  . .:'
     A                                  6  9'Nom article :'
     A            NOMARTICLER        B  6 23REFFLD(HERMESPF/NOMARTICLE BIB20/H-
     A                                      ERMES)
     A            TAILLE    R        B  8 23REFFLD(HERMESPF/TAILLE BIB20/HERME-
     A                                      S)
     A            COULEUR   R        B 10 23REFFLD(HERMESPF/COULEUR BIB20/HERM-
     A                                      ES)
     A                                 12  9'Prix . . . .:'
     A            PRIX      R        B 12 23REFFLD(HERMESPF/PRIX BIB20/HERMES)
     A                                  4  9'Numéro art. :'
     A            IDARTICLE R        B  4 23REFFLD(HERMESPF/IDARTICLE BIB20/HE-
     A                                      RMES)
     A          R AFFICHE
     A*%%TS  SD  20251031  110936  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CA03(03)
     A                                      CA12(12)
     A                                      WINDOW(5 9 13 45)
     A                                      WDWBORDER((*COLOR PNK) (*DSPATR RI)-
     A                                       (*CHAR '        '))
     A
     A  58                                  RMVWDW
     A                                  8  9'TAILLE . . .:'
     A                                 10  9'COULEUR  . .:'
     A                                  6  9'NOM ARTICLE :'
     A            NOMARTICLER        O  6 23REFFLD(HERMESPF/NOMARTICLE BIB20/H-
     A                                      ERMES)
     A            TAILLE    R        O  8 23REFFLD(HERMESPF/TAILLE BIB20/HERME-
     A                                      S)
     A            COULEUR   R        O 10 23REFFLD(HERMESPF/COULEUR BIB20/HERM-
     A                                      ES)
     A                                 12  9'PRIX . . . .:'
     A            PRIX      R        O 12 23REFFLD(HERMESPF/PRIX BIB20/HERMES)
     A                                  4  9'NUMÉRO ART. :'
     A            IDARTICLE R        O  4 23REFFLD(HERMESPF/IDARTICLE BIB20/HE-
     A                                      RMES)
```
