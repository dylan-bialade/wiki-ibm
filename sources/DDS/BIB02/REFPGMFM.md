---
bibliotheque: BIB02
fichier_source: QDSPFSRC
membre: REFPGMFM
type: DDS
longueur_enregistrement: 100
lignes: 88
modifie: 2026-11-16
---

# BIB02/QDSPFSRC/REFPGMFM

```text
     A*%%TS  SD  20100727  091232  SA          REL-V6R1M0  5761-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      INDARA
     A          R F1
     A*%%TS  SD  20031117  135232  SA          REL-V5R2M0  5722-WDS
     A                                      CF01(01)
     A            MES           60A  O 13 10DSPATR(BL)
     A            LIBPGM        10A  B  7 35DSPATR(UL)
     A                                      CHECK(ER)
     A                                 24 19'F1=Validation'
     A                                      COLOR(BLU)
     A                                 24 36'F3=Exit'
     A                                      COLOR(BLU)
     A                                  7 11'Bib  . . . . . . . . .'
     A                                  3 17'Voir les programmes attachés à un -
     A                                      fichier ou programme'
     A                                      COLOR(WHT)
     A                                  1 58DATE
     A                                      EDTCDE(Y)
     A                                  1 67USER
     A                                  8 11'Module . . . . . . . .'
     A            NMPGM         10A  B  8 35DSPATR(UL)
     A                                      CHECK(ER)
     A                                      DSPATR(HI)
     A                                      COLOR(GRN)
     A                                  5  7'Saissisez la bib et le fichier ou -
     A                                      pgm à rechercher, puis appuyez sur -
     A                                      F1.'
     A                                      COLOR(BLU)
     A          R SFL1                      SFL
     A            OPT            1A  I  9  3
     A            E1PGMLIB      10A  O  9  7
     A            E1PGMNM       10A  O  9 21
     A            E1WHRFNM      10A  O  9 32
     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      CF12(12)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A  61                                  SFLMSG('Vide')
     A N90                                  ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  8  7'Bibliotheque'
     A                                      DSPATR(HI)
     A                                  8 21'Programme'
     A                                      DSPATR(HI)
     A                                  1  2'FMDSPF'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 12'Voir les programmes attachés à un -
     A                                      fichier ou programme'
     A                                      DSPATR(HI)
     A                                  6  3'Programme / ou PF :'
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A            INPGM         10A  O  6 24
     A                                  8  3'Opt'
     A                                      DSPATR(HI)
     A                                  3  4'Indiquez vos options, puis appuyez-
     A                                       sur ENTREE.'
     A                                      DSPATR(HI)
     A                                      COLOR(BLU)
     A                                  4  6'2=DSPPGM'
     A                                      DSPATR(HI)
     A                                      COLOR(BLU)
     A                                  6 36'Type :'
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A            INPGMO        10A     6 44
     A                                  8 32'Format DSPF'
     A                                      DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 11'F12=Retour'
     A                                      COLOR(BLU)
     A*%%RS+<record-sequences>
     A*%%RS+ <sequence name="Sans titre">
     A*%%RS+  <device type="display" width="80" height="24" />
     A*%%RS+ </sequence>
     A*%%RS </record-sequences>
```
