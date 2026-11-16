---
bibliotheque: BIB10
fichier_source: QDSPSRC
membre: GESTLV
type: DDS
longueur_enregistrement: 80
lignes: 83
modifie: 2026-11-16
---

# BIB10/QDSPSRC/GESTLV

```text
     A*%%TS  SD  20261007  145938  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R FMT1
     A*%%TS  SD  20261007  133502  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF06(06)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 32'Gestion des livres'
     A                                      DSPATR(UL)
     A                                 23 37'F3=Exit'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A                                  8 24'numero ISBN:'
     A                                  9 32'opt:'
     A            E1SBN          5S 0I  8 37
     A            E1OPT          1A  I  9 37VALUES('A' 'M' 'D')
     A                                 23 46'F6=Creer'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A                                  9 45'(A=> Affichage)'
     A                                 10 45'(M=> Modifier)'
     A                                 11 45'(D=> Supprimer)'
     A                                 20  4'Message:'
     A                                      COLOR(BLU)
     A            E1MES         65A  O 20 13
     A          R FMT2
     A*%%TS  SD  20261007  145938  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF12(12)
     A                                      CF23(23)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 72TIME
     A                                  1 33'Données du livre'
     A                                      COLOR(BLU)
     A                                  6  7'Numero ISBN:'
     A                                  7 13'Titre:'
     A                                  8 12'Auteur:'
     A                                  9 13'Dispo:'
     A            E2SBN          5S 0O  6 20
     A            E2TI          30A  B  7 20
     A  42                                  DSPATR(PR)
     A            E2AUT         30A  B  8 20
     A  42                                  DSPATR(PR)
     A            E2DSP          1A  B  9 20
     A  42                                  DSPATR(PR)
     A                                 22 15'F3=Exit'
     A                                      COLOR(BLU)
     A                                 22 26'F12=Retour'
     A                                      COLOR(BLU)
     A                                 22 40'F23=Supprimer le livre'
     A                                      COLOR(BLU)
     A            E2ACT         50A  O 13 16COLOR(BLU)
```
