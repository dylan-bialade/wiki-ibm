---
bibliotheque: BIB05
fichier_source: QCLPSRC
membre: ANIMAU1
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 17
modifie: 2026-11-16
---

# BIB05/QCLPSRC/ANIMAU1

```cl
     A*%%TS  SD  20260924  154856  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260924  154856  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  6 19'un annimal'
     A            PARAM         10A  B  6 31
     A                                 21 20'f3=exit'
     A                                 14 12'NOM:'
     A            VAR2      R        B 14 18REFFLD(FANIMAUX/NOM BIB05/ANIMAUX)
     A                                 15  3'TAILLE:'
     A            VAR3      R        B 15 12REFFLD(FANIMAUX/TAILLE BIB05/ANIM-
     A                                      AUX)
     A                                 18  1'COULEUR:'
     A            VAR4      R        B 18 11REFFLD(FANIMAUX/COULEUR BIB05/ANI-
     A                                      MAUX)
```
