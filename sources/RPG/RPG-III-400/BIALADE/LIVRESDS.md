---
bibliotheque: BIALADE
fichier_source: QRPGSRC
membre: LIVRESDS
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 80
modifie: 2026-11-16
---

# BIALADE/QRPGSRC/LIVRESDS

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
     A*%%TS  SD  20261007  155506  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R FMT1
     A*%%TS  SD  20261007  145724  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CF06(06)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 32'Gestion des livres'
     A                                      DSPATR(UL)
     A                                 23 37'F3=Exit'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A                                  8 24'numero ISBN:'
     A                                  9 32'opt:'
     A            ISBN           5S 0I  8 37
     A            OPT            1A  I  9 37
     A                                 23 46'F6=Creer'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A                                  9 45'(A=> Affichage)'
     A                                 10 45'(M=> Modifier)'
     A                                 11 45'(D=> Supprimer)'
     A          R FMT2
     A*%%TS  SD  20261007  155506  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CF12(12)
     A                                      CF23(23)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 72TIME
     A                                  1 33'Données du livre'
     A                                      COLOR(BLU)
     A                                  6  7'Numero ISBN:'
     A                                  7 13'Titre:'
     A                                  8 12'Auteur:'
     A                                  9 13'Dispo:'
     A            ISBN           5S 0O  6 20
     A            TITRE         30A  B  7 20
     A            AUTEUR        30A  B  8 20
     A            DISPO          1A  B  9 20
     A                                 22 15'F3=Exit'
     A                                      COLOR(BLU)
     A                                 22 26'F12=Retour'
     A                                      COLOR(BLU)
     A                                 22 40'F23=Suprimer le livre '
     A                                      COLOR(BLU)
     A                                 13 14'Entre pour modifier '
     A                                      COLOR(BLU)
     A            MSG            6A  B 12 15
     A                                 11 13' vous:'
```
