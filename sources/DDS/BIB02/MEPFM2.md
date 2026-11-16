---
bibliotheque: BIB02
fichier_source: QSRC
membre: MEPFM2
type: DDS
longueur_enregistrement: 100
lignes: 148
modifie: 2026-11-16
---

# BIB02/QSRC/MEPFM2

```text
     A*%%TS  SD  20100727  091232  BG          REL-V6R1M0  5761-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R F1
     A*%%TS  SD  20031117  135232  BG          REL-V5R2M0  5722-WDS
     A                                      CF03(03)
     A            NAMEMEP       10   B  8 46DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A                                 24 19'Entrée-Suite'
     A                                      COLOR(BLU)
     A                                 24 36'F3=Exit'
     A                                      COLOR(BLU)
     A            MES           60A  O 13 10DSPATR(BL)
     A                                  8 11'Nom du savf de MEP . . . . . . .'
     A                                  3 26'Mise en production 1/2'
     A                                      COLOR(WHT)
     A                                  1 58DATE
     A                                      EDTCDE(Y)
     A                                  1 67USER
     A                                  5 10'Saissisez les deux noms, puis appu-
     A                                      yez sur ENTREE.'
     A                                      COLOR(BLU)
     A            NAMESAV       10   B  9 46DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A                                  7 10'Objet :'
     A                                  9 11'Nom du savf de SAV . . . . . . .'
     A          R F2
     A*%%TS  SD  20031117  135232  BG          REL-V5R2M0  5722-WDS
     A                                      CF03(03)
     A                                      CF04(04)
     A                                 24 16'Entrée-Suite'
     A                                      COLOR(BLU)
     A                                 24 32'F3=Exit'
     A                                      COLOR(BLU)
     A            MES           60A  O 19 15DSPATR(BL)
     A                                  3 26'Mise en production 2/2'
     A                                      COLOR(WHT)
     A                                  1 58DATE
     A                                      EDTCDE(Y)
     A                                  1 67USER
     A                                  6 11'Nom de la bib sources (MAX, ENV) .-
     A                                       . .'
     A            LIBE1         10   B  6 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE2         10   B  9 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE3         10   B 11 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE4         10   B  9 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE5         10   B 13 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE6         10   B 14 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE7         10   B 12 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE8         10   B 15 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A                                  8 11'Nom objet sources  . . . . . . . .-
     A                                       . .'
     A            BADE9         10   B  8 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A                                  7 11'Objet type (*all, *file, *pgm) . .-
     A                                       . .'
     A            OBJT           5   B  7 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE10        10   B 17 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE11        10   B 16 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE12        10   B  8 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE13        10   B 10 51DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE14        10   B 11 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE15        10   B 12 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE16        10   B 13 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE17        10   B 14 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE18        10   B 15 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE19        10   B 16 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE20        10   B 17 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A            BADE21        10   B 10 63DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(WHT)
     A                                 24 45'F4=DSPSAVF'
     A                                      COLOR(BLU)
     A                                  4  9'Indiquez vos choix, puis appuez su-
     A                                      r ENTREE.'
     A                                      COLOR(BLU)
     A*%%RS+<record-sequences>
     A*%%RS+ <sequence name="Sans titre">
     A*%%RS+  <device type="display" width="80" height="24" />
     A*%%RS+ </sequence>
     A*%%RS </record-sequences>
```
