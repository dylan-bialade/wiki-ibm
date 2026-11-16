---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: BFFM
type: DDS
longueur_enregistrement: 80
lignes: 50
modifie: 2026-11-16
---

# BIB20/QDDSSRC/BFFM

```text
     A*...+... 1 ...+... 2 ...+... 3 ...+... 4 ...+... 5 ...+... 6 ...+... 7
     A*****************************************************
     A*  BFFM      : DEFILEMENT "BONNE ANNEE"
     A*  PROGRAMME : BONANRPG (RPG III)
     A*****************************************************
     A                                      DSPSIZ(24 80 *DS3)
     A          R ECRAN1                    FRCDTA
     A                                  1  2'BONANRPG'
     A                                      COLOR(BLU)
     A                                  1 30'DEFILEMENT DE DONNEES'
     A                                      DSPATR(HI)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A*--- BLOC 1 : TABLE T1 ("BONNE")
     A            L11           79A  O  4  2
     A                                      COLOR(WHT)
     A            L12           79A  O  5  2
     A                                      COLOR(WHT)
     A            L13           79A  O  6  2
     A                                      COLOR(WHT)
     A            L14           79A  O  7  2
     A                                      COLOR(WHT)
     A            L15           79A  O  8  2
     A                                      COLOR(WHT)
     A            L16           79A  O  9  2
     A                                      COLOR(WHT)
     A            L17           79A  O 10  2
     A                                      COLOR(WHT)
     A*--- BLOC 2 : TABLE T2 ("ANNEE") - ROUGE QUAND J > 60 (IND 02)
     A            L21           79A  O 13  2
     A  02                                  COLOR(RED)
     A N02                                  COLOR(YLW)
     A            L22           79A  O 14  2
     A  02                                  COLOR(RED)
     A N02                                  COLOR(YLW)
     A            L23           79A  O 15  2
     A  02                                  COLOR(RED)
     A N02                                  COLOR(YLW)
     A            L24           79A  O 16  2
     A  02                                  COLOR(RED)
     A N02                                  COLOR(YLW)
     A            L25           79A  O 17  2
     A  02                                  COLOR(RED)
     A N02                                  COLOR(YLW)
     A            L26           79A  O 18  2
     A  02                                  COLOR(RED)
     A N02                                  COLOR(YLW)
     A            L27           79A  O 19  2
     A  02                                  COLOR(RED)
     A N02                                  COLOR(YLW)
```
