---
bibliotheque: BIB02
fichier_source: QDSPFSRC
membre: FMDSPF
type: DDS
longueur_enregistrement: 100
lignes: 99
modifie: 2026-11-16
---

# BIB02/QDSPFSRC/FMDSPF

```text
     A*%%TS  SD  20100727  091232  BG          REL-V6R1M0  5761-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      INDARA
     A          R F1
     A*%%TS  SD  20031117  135232  BG          REL-V5R2M0  5722-WDS
     A                                      CF01(01)
     A            MES           60A  O 13 10DSPATR(BL)
     A            LIBMD         10A  B  7 35DSPATR(UL)
     A                                      CHECK(ER)
     A                                 24 19'F1=Validation'
     A                                      COLOR(BLU)
     A                                 24 36'F3=Exit'
     A                                      COLOR(BLU)
     A                                  7 11'Bib  . . . . . . . . .'
     A                                  3 26'Module dans PGM'
     A                                      COLOR(WHT)
     A                                  1 58DATE
     A                                      EDTCDE(Y)
     A                                  1 67USER
     A                                  8 11'Module . . . . . . . .'
     A            NMMD          10A  B  8 35DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(GRN)
     A                                  5 10'Saissisez la bib et le module @ re-
     A                                      chercher, puis appuyez sur F1.'
     A                                      COLOR(BLU)
     A          R SFL1                      SFL
     A            OPT            1A  I  9  3
     A            E1PGMLIB      10A  O  9  7
     A            E1PGMNM       10A  O  9 21
     A            E1PGMDT       19A  O  9 32
     A            E1MAJ          3A  O  9 65
     A  88                                  COLOR(RED)
     A            E1PGMATR      10A  O  9 53
     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      CF05(05)
     A                                      CF12(12)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A  61                                  SFLMSG('Vide')
     A N90                                  ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  8  7'Biblioth}que'
     A                                      DSPATR(HI)
     A                                  8 21'Programme'
     A                                      DSPATR(HI)
     A                                  1  2'FMDSPF'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 29'Module dans PGM'
     A                                      DSPATR(HI)
     A                                  6  3'Module :'
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A            INFMD         10A  O  6 12
     A                                  8 32'Date de cr{ation '
     A                                      DSPATR(HI)
     A                                  8  3'Opt'
     A                                      DSPATR(HI)
     A                                  6 25'Date de l''objet module :'
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A            DATEMD        19A     6 51
     A                                  8 65'MAJ'
     A                                      DSPATR(HI)
     A                                  3  4'Indiquez vos options, puis appuyez-
     A                                       sur ENTREE.'
     A                                      DSPATR(HI)
     A                                      COLOR(BLU)
     A                                  4  5'1=UPDPGM'
     A                                      DSPATR(HI)
     A                                      COLOR(BLU)
     A                                  8 53'Attribut'
     A                                      DSPATR(HI)
     A                                  4 16'2=DSPPGM'
     A                                      DSPATR(HI)
     A                                      COLOR(BLU)
     A          R FKEY1
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 26'F12=Retour'
     A                                      COLOR(BLU)
     A                                 23 11'F5=Rafraîchir'
     A                                      COLOR(BLU)
     A
     A*%%RS+<record-sequences>
     A*%%RS+ <sequence name="Sans titre">
     A*%%RS+  <device type="display" width="80" height="24" />
     A*%%RS+ </sequence>
     A*%%RS </record-sequences>
```
