---
bibliotheque: BIB10
fichier_source: QDSPSRC
membre: SSLIVRE
type: DDS
longueur_enregistrement: 160
lignes: 53
modifie: 2026-11-16
---

# BIB10/QDSPSRC/SSLIVRE

```text
     A*%%TS  SD  20261009  163938  XUAN        REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A                                      CA03(03)
     A          R SFL1                      SFL                                      A*%%TS  SD  20261009  161157  XUAN        REL-V7R5M0  5770-WDS
     A            E1OPT          1A  B 10  5                                         A            E1TIT         30A  O 10  8
     A            E1AUT         30A  O 10 40                                         A            E1DSP          1A  O 10 72
     A            E1ISBN         5S 0H                                               A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261009  151024  XUAN        REL-V7R5M0  5770-WDS                  A                                      CF06(06)
     A  30                                  SFLDSP                                   A  31                                  SFLDSPCTL
     A  32                                  SFLCLR                                   A  33                                  SFLEND(*MORE)
     A                                      SFLSIZ(0010)                             A                                      SFLPAG(0009)
     A                                  1  3'SYS'                                    A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  1  7SYSNAME
     A                                  1 67'DATE'                                   A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  1 72DATE
     A                                      EDTCDE(Y)                                A                                  2  3'USR'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  2  7USER                                     A                                  2 67'TIME'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  2 72TIME                                     A                                  1 36'Exemple ss'
     A                                      DSPATR(UL)                               A                                      COLOR(WHT)
     A                                  6  4'Veuillez choisir une option et app-     A                                      uyez sur ENTREE'
     A                                      COLOR(BLU)                               A                                  7  5'2=Modifier'
     A                                      COLOR(BLU)                               A                                  9  4'Opt'
     A                                      COLOR(WHT)                               A                                  9  8'Titre'
     A                                      COLOR(WHT)                               A                                  9 40'Auteur'
     A                                      COLOR(WHT)                               A                                  9 71'Dispo'
     A                                      COLOR(WHT)                               A                                  7 16'4=Supprimer'
     A                                      COLOR(BLU)                               A                                  7 28'5=afficher'
     A                                      COLOR(BLU)                               A                                  4 45'Afficher a partir:'
     A                                      COLOR(BLU)                               A            E1AFF         10A  I  4 64
     A          R FOOT                                                               A*%%TS  SD  20261009  163938  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF05(05)                                 A                                      OVERLAY
     A                                 23  3'F3=Exit'                                A                                      COLOR(BLU)
     A                                 23 13'F6=Créer'                               A                                      COLOR(BLU)
     A                                 23 24'F5=actualiser'                          A                                      COLOR(BLU)
     A          R FMT2                                                               A*%%TS  SD  20261009  163413  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF12(12)                                 A                                      CF23(23)
     A                                  1  3'SYS'                                    A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  1  8SYSNAME
     A                                  1 66'DATE'                                   A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  1 72DATE
     A                                      EDTCDE(Y)                                A                                  2  3'USR'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  2  8USER                                     A                                  2 66'TIME'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  2 72TIME                                     A                                  1 33'Données du livre'
     A                                      COLOR(BLU)                               A                                  6  7'Numero ISBN:'
     A                                  7 13'Titre:'                                 A                                  8 12'Auteur:'
     A                                  9 13'Dispo:'                                 A            E2ISBN         5S 0O  6 20
     A            E2TIT         30A  B  7 20                                         A  42                                  DSPATR(PR)
     A            E2AUT         30A  B  8 20                                         A  42                                  DSPATR(PR)
     A            E2DSP          1A  B  9 20                                         A  42                                  DSPATR(PR)
     A            E2ACT         70A  O 23  3COLOR(BLU)                               A            E2MOD         50A  O  4 16COLOR(WHT)
```
