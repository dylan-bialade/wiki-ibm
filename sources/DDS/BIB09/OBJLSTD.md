---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: OBJLSTD
type: DDS
longueur_enregistrement: 120
lignes: 115
modifie: 2026-11-16
---

# BIB09/QSOURCES/OBJLSTD

```text
     A*================================================================
     A* OBJLSTD  - Ecran liste des objets d'une bibliotheque
     A*================================================================
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A*----------------------------------------------------------------
     A* FMT1 : Ecran de saisie de la bibliotheque
     A*----------------------------------------------------------------
     A          R FMT1
     A                                      CA03(03)
     A                                  1 25'Objets d''une bibliotheque'
     A                                      COLOR(WHT)
     A                                      DSPATR(HI)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  8 15'Bibliotheque . . :'
     A                                      COLOR(TRQ)
     A            WBIB          10A  B  8 35
     A                                      DSPATR(HI)
     A                                      DSPATR(PC)
     A                                 10 15'Saisissez une bibliotheque -
     A                                      puis appuyez sur ENTREE.'
     A                                      COLOR(BLU)
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A  61                             20 15'Bibliotheque introuvable !'
     A                                      COLOR(RED)
     A                                      DSPATR(BL)
     A*----------------------------------------------------------------
     A* SFLOBJ : Ligne du sous-fichier (1 ligne = 1 objet)
     A*----------------------------------------------------------------
     A          R SFLOBJ                    SFL
     A  67                                  SFLNXTCHG
     A            SOPT           2A  I  8  2
     A            SOBJNM        10A  O  8  5
     A            SOBJTP        10A  O  8 16
     A            SOBJBI        10A  O  8 27
     A            SOBJAT        10A  O  8 38
     A  70                                  COLOR(RED)
     A  71                                  COLOR(PNK)
     A            SOBJTX        30A  O  8 49
     A*----------------------------------------------------------------
     A* CTLOBJ : Controle du sous-fichier
     A*----------------------------------------------------------------
     A          R CTLOBJ                    SFLCTL(SFLOBJ)
     A                                      CA03(03)
     A                                      CA12(12)
     A                                      CA21(21)
     A N90                                  ROLLUP(39)
     A                                      OVERLAY
     A                                      SFLCSRRRN(&SFLRRN)
     A  32                                  SFLDSP
     A N31                                  SFLDSPCTL
     A  31                                  SFLCLR
     A  90                                  SFLEND(*MORE)
     A                                      SFLSIZ(0015)
     A                                      SFLPAG(0014)
     A            SFLRRN         5S 0H
     A            SRRN           4S 0H      SFLRCDNBR
     A                                  1 22'Liste des objets de'
     A                                      COLOR(WHT)
     A                                      DSPATR(HI)
     A            HBIB          10A  O  1 42
     A                                      COLOR(YLW)
     A                                      DSPATR(HI)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  3  2'Options :'
     A                                      COLOR(BLU)
     A                                  4  2'2=Droits  3=Copier  -
     A                                      4=Suppr  5=AffDrt'
     A                                      COLOR(BLU)
     A                                  5  2'7=Rename  8=Desc  -
     A                                      13=ChgDesc'
     A                                      COLOR(BLU)
     A                                  7  2'Op'
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A                                  7  5'Objet     '
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A                                  7 16'Type      '
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A                                  7 27'Biblio    '
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A                                  7 38'Attribut  '
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A                                  7 49'Texte'
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A            HNBOBJ         7A  O  1 62
     A                                      COLOR(TRQ)
     A*----------------------------------------------------------------
     A* FMTBAS : Bas d'ecran du sous-fichier
     A*----------------------------------------------------------------
     A          R FMTBAS
     A                                      CA03(03)
     A                                      CA12(12)
     A                                      CA21(21)
     A                                 23  2'F3=Exit   F12=Biblio   -
     A                                      F21=Ligne de commande'
     A                                      COLOR(BLU)
```
