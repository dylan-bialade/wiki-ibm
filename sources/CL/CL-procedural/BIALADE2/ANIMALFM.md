---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: ANIMALFM
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 36
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/ANIMALFM

```cl
     A*%%TS  SD  20260924  143606  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260924  143606  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  7SYSNAME
     A                                  2  7USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 26'Affichage d''un pf multimembre'
     A                                  9 20'Voici un annimal'
     A            VAR1          10   O  9 38
     A                                 12 21'TAILLE:'
     A            TAILLE    R        O 12 29REFFLD(FANIMAUX/TAILLE PHAN/ANIMAUX)
     A                                 13 20'COULEUR:'
     A            COULEUR   R        O 13 29REFFLD(FANIMAUX/COULEUR PHAN/ANIMAU-
     A                                      X)
     A                                 11 24'NOM:'
     A            NOM       R        O 11 29REFFLD(FANIMAUX/NOM PHAN/ANIMAUX)
     A                                 23  6'F3=Exit'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
```
