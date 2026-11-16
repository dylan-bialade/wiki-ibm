---
bibliotheque: BIB01
fichier_source: QDDSSRC
membre: SFLBB
type: DDS
longueur_enregistrement: 100
lignes: 44
modifie: 2026-11-16
---

# BIB01/QDDSSRC/SFLBB

```text
     A*%%TS  SD  20251024  110541  CHARLES     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03
     A                                      CF02
     A                                      CF05
     A          R SFL01                     SFL
     A*%%TS  SD  20251024  110541  CHARLES     REL-V7R5M0  5770-WDS
     A            NOM       R        O  9 12REFFLD(FBONBON/NOM *LIBL/BONBON)
     A            MARQUE    R        O  9 34REFFLD(FBONBON/MARQUE *LIBL/BONBON)
     A            NUMBER    R        O  9  4REFFLD(FBONBON/NUMBER *LIBL/BONBON)
     A            COULEUR   R        O  9 56REFFLD(FBONBON/COULEUR *LIBL/BONBON)
     A            PRIX      R        O  9 68REFFLD(FBONBON/PRIX *LIBL/BONBON)
     A            OPT            1A  B  9  2
     A          R CTL01                     SFLCTL(SFL01)
     A*%%TS  SD  20251023  171727  CHARLES     REL-V7R5M0  5770-WDS
     A                                      OVERLAY
     A  42                                  SFLDSP
     A  41                                  SFLDSPCTL
     A  40                                  SFLCLR
     A  43                                  SFLEND(*SCRBAR *SCRBAR)
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0011)
     A                                  1 70DATE
     A                                      EDTCDE(Y)
     A                                  2 70TIME
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  2 31'Sous fichier BONBON'
     A                                      COLOR(WHT)
     A                                  8  6'ID'
     A                                      COLOR(WHT)
     A                                  8 20'Nom'
     A                                      COLOR(WHT)
     A                                  8 41'Marque'
     A                                      COLOR(WHT)
     A                                  8 57'Couleur'
     A                                      COLOR(WHT)
     A                                  8 68'Prix'
     A                                      COLOR(WHT)
     A          R PIED
     A*%%TS  SD  20251023  171727  CHARLES     REL-V7R5M0  5770-WDS
     A                                 23 35'F3 = Quitter'
     A                                      COLOR(BLU)
```
