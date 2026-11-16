---
bibliotheque: BIB02
fichier_source: QTMABUG
membre: AGENCE001D
type: DDS
longueur_enregistrement: 100
lignes: 89
modifie: 2026-11-16
---

# BIB02/QTMABUG/AGENCE001D

```text
     A*%%TS  SD  20220422  110221  JBORG       REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      REF(BIB02/AGENCETMA)
     A          R FMT6
     A*%%TS  SD  20220422  110221  JBORG       REL-V7R4M0  5770-WDS
     A                                      CA03(03)
     A                                      CA12(12)
     A                                  1 31'CREATION  des AGENCES'
     A                                      COLOR(WHT)
     A            E6CODCLI  R        I  7 20REFFLD(AGENCEF/CODCLI)
     A            E6CODAGN  R        I  8 20REFFLD(AGENCEF/CODAGN)
     A            E6TNOM    R        I  9 20REFFLD(AGENCEF/NOM)
     A            E6RUE     R        I 10 20REFFLD(AGENCEF/RUE)
     A            E6CP      R        I 11 20REFFLD(AGENCEF/CP)
     A            E6VILLE   R        I 12 20REFFLD(AGENCEF/VILLE)
     A            E6REGION  R        I 13 20REFFLD(AGENCEF/REGION)
     A                                  7  2'CODCLI...:'
     A                                  8  2'CODAGN.....:'
     A                                  9  2'NOM.....:'
     A                                 10  2'RUE.....:'
     A                                 11  2'CP......:'
     A                                 12  2'VILLE.....:'
     A                                 13  1'REGION.....:'
     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 14'F12=Annuler'
     A                                      COLOR(BLU)
     A          R FMT1
     A*%%TS  SD  20191219  143215  JBORG       REL-V7R3M0  5770-WDS
     A                                      CA03(03)
     A                                      CA06(06)
     A                                      CA08(08)
     A                                  1 31'Choix des AGENCES'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
                                            EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2  2'AGENCED'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E1CODCLI  R        B  7 41REFFLD(AGENCEF/CODCLI)
     A                                      EDTCDE(Z)
     A            E1CODAGN  R        B  8 41REFFLD(AGENCEF/CODAGN)
     A  55                                  ERRMSG('Non trouvé')
     A                                  7 13'Code Client :'
     A                                  8 13'Code Agence :'
     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                 23 13'F6=Création'
     A                                      COLOR(BLU)
     A                                 23 26'F8=Imprimer'
     A                                      COLOR(BLU)
     A          R FMT5
     A*%%TS  SD  20191219  143215  JBORG       REL-V7R3M0  5770-WDS
     A                                      CA03(03)
     A                                      CA12(12)
     A                                  1 31'Affichage des AGENCES'
     A                                      COLOR(WHT)
     A                                  1  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
                                            EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2  2'AGENCED'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A                                      COLOR(BLU)
     A            E5CODCLI  R        O  7 20REFFLD(AGENCEF/CODCLI)
     A            E5CODAGN  R        O  8 20REFFLD(AGENCEF/CODAGN)
     A            E5TNOM    R        O  9 20REFFLD(AGENCEF/NOM)
     A            E5RUE     R        O 10 20REFFLD(AGENCEF/RUE)
     A            E5CP      R        O 11 20REFFLD(AGENCEF/CP)
     A            E5VILLE   R        O 12 20REFFLD(AGENCEF/VILLE)
     A            E5REGION  R        O 13 20REFFLD(AGENCEF/REGION)
     A                                 23 30'F12=RETOUR'
     A                                      COLOR(BLU)
     A                                 23  2'F3=Sortir'
     A                                      COLOR(BLU)
     A                                  7  2'CODCLI...:'
     A                                  8  2'CODAGN.....:'
     A                                  9  2'NOM.....:'
     A                                 10  2'RUE.....:'
     A                                 11  2'CP......:'
     A                                 12  2'VILLE.....:'
     A                                 13  1'REGION.....:'
```
