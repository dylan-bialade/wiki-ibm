---
bibliotheque: BIB02
fichier_source: QSRC
membre: ECRANFORMA
type: DDS
longueur_enregistrement: 100
lignes: 163
modifie: 2026-11-16
---

# BIB02/QSRC/ECRANFORMA

```text
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Fin de travail')
     A                                      CA06(06 'Créer')
     A                                      CA12(12 'Retour')
     A                                      CA08(08 'Imprimer')
     A          R SFL1                      SFL
     A            OPT            1A  I  9  2
     A            E1NUMFOR       5  0O  9  5
     A            E1CODFOR       5A  O  9 11
     A            E1LIBFOR      10A  O  9 18
     A            E1DETFOR      35A  O  9 31
     A            E1NBJFOR      10S 0O  9 68
     A          R SF1CTL                    SFLCTL(SFL1)
     A                                      SFLSIZ(0013)
     A                                      SFLPAG(0012)
     A                                      OVERLAY
     A N31                                  SFLDSPCTL
     A N32                                  SFLDSP
     A  31                                  SFLCLR
     A                                      ROLLUP(39)
     A  90                                  SFLEND(*MORE)
     A            RANG           4S 0H      SFLRCDNBR
     A                                  8  5'N° F'
     A                                      DSPATR(HI)
     A                                  8 31'Détail'
     A                                      DSPATR(HI)
     A                                  1  2'ECRAN'
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 24'Gestion des formations'
     A                                      DSPATR(HI)
     A                                  3  2'Afficher à partir de :'
     A            SNUMFOR   R        B  3 25REFFLD(FORMATIONF/NUMFOR
     A                                      BIB02/FORMA)
     A                                  3 32'(Code formation)'
     A                                  8  1'Opt'
     A                                      DSPATR(HI)
     A                                  5  2'Indiquez vos option, puis appuyez-
     A                                       sur ENTREE.'
     A                                      COLOR(BLU)
     A                                  6  3'2=Editer'
     A                                      COLOR(BLU)
     A                                  6 12'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  6 24'5=Afficher'
     A                                      COLOR(BLU)
     A                                  8 11'Code'
                                             DSPATR(HI)
     A                                  8 18'Libellé'
                                             DSPATR(HI)
     A                                  8 68'Nb jour'
                                             DSPATR(HI)
     A          R FKEY1
     A                                 23  2'F3=Sortie'
     A                                      COLOR(BLU)
     A                                 23 12'F6=Creér'
     A                                      COLOR(BLU)
     A                                 23 21'F8=Imprimer'
     A                                       COLOR(BLU)
     A          R FMT4
     A                                      CF23(23)
     A                                  1 31'Suppression des formations'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'Formation'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E4NUMFOR  R        O  5 25REFFLD(FORMATIONF/NUMFOR +
     A                                      BIB02/FORMA)
     A            E4CODFOR  R        O  6 25REFFLD(FORMATIONF/CODFOR +
     A                                      BIB02/FORMA)
     A            E4LIBFOR  R        O  7 25REFFLD(FORMATIONF/LIBFOR +
     A                                      BIB02/FORMA)
     A            E4DETFOR  R        O  8 25REFFLD(FORMATIONF/DETFOR +
     A                                      BIB02/FORMA)
     A            E4NBJFOR  R        O 10 25REFFLD(FORMATIONF/NBJFOR +
     A                                      BIB02/FORMA)
     A                                      DSPATR(HI)
     A                                      COLOR(GRN)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  5  3'N° Formation.......: '
     A                                  6  3'Code Formation.....:'
     A                                  7  3'Libellé............:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  8  3'Détail.............:'
     A                                 10  3'Nb Jours...........:'
     A          R FMT2
     A                                      CF23(23)
     A                                  1 31'Modification de la formation'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2  2'FORMA'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E2NUMFOR  R        O  5 25REFFLD(FORMATIONF/NUMFOR +
     A                                      BIB02/FORMA)
     A            E2CODFOR  R        O  6 25REFFLD(FORMATIONF/CODFOR +
     A                                      BIB02/FORMA)
     A            E2LIBFOR  R        O  7 25REFFLD(FORMATIONF/LIBFOR +
     A                                      BIB02/FORMA)
     A            E2DETFOR  R        O  8 25REFFLD(FORMATIONF/DETFOR +
     A                                      BIB02/FORMA)
     A            E2NBJFOR  R        O 11 25REFFLD(FORMATIONF/NBJFOR +
     A                                      BIB02/FORMA)
     A                                      COLOR(GRN)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  6  3'Code Formation...:'
     A                                  7  3'Libellé..........:'
     A                                  8  3'Détail...........:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                 11  3'Nb Jours.........:'
     A                                  5  3'N° Formation.....:'
     A          R FMT6
                                             CF23(23)
     A            E6NUMFOR  R        O  5 25REFFLD(FORMATIONF/NUMFOR +
     A                                      BIB02/FORMA)
     A            E6CODFOR  R        I  6 25REFFLD(FORMATIONF/CODFOR +
     A                                      BIB02/FORMA)
     A            E6LIBFOR  R        I  7 25REFFLD(FORMATIONF/LIBFOR +
     A                                      BIB02/FORMA)
     A            E6DETFOR  R        I  8 25REFFLD(FORMATIONF/DETFOR +
     A                                      BIB02/FORMA)
     A            E6NBJFOR  R        I 10 25REFFLD(FORMATIONF/NBJFOR +
     A                                      BIB02/FORMA)
     A                                      DSPATR(HI)
     A                                      COLOR(GRN)
     A                                  1 31'Création d''une formation'
     A                                      COLOR(WHT)
     A                                  1  3USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A                                 23  2'F3=SORTIR'
     A                                      COLOR(BLU)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                  6  3'Code Formation...:'
     A                                  2 33'F23=Confirmation'
     A                                      COLOR(RED)
     A                                  7  3'Libellé..........:'
     A                                  8  3'Détail...........:'
     A                                 10  3'Nb Jours.........:'
     A                                  5  3'N° Formation.....:'
     A
```
