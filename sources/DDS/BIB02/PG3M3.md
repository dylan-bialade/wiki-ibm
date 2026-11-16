---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: PG3M3
type: DDS
longueur_enregistrement: 100
lignes: 31
modifie: 2026-11-16
---

# BIB02/QDDSRC/PG3M3

```text
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A          R FMT5
     A                                  9  3'SAISIR LE TYPE DE COURSE :'
     A            TPRACE         4   I  9 34
 90  A                                      ERRMSG('TRUFFET' 90)
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
