---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: FICLIAFF
type: DDS
longueur_enregistrement: 80
lignes: 48
modifie: 2026-11-16
---

# BIB17/QDDSSRC/FICLIAFF

```text
     A*%%TS  SD  20261014  101951  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R REC1
     A*%%TS  SD  20261014  101951  REMI        REL-V7R5M0  5770-WDS
     A                                      CF12(12)
     A                                      CF03(03)
     A                                  1  2USER
     A            NMPGM         10A  O  2  2
     A                                  1 32'Gestion de client'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A            MODE          13A  O  3 34
     A            CLIDCL    R        B  6  8REFFLD(CLIENTSF/CLIDCL BIB17/F-
     A                                      ICCLI)
     A                                      DSPATR(ND)
     A                                  7  9'Nom........:'
     A            CLNOCL    R        B  7 22REFFLD(CLIENTSF/CLNOCL BIB17/F-
     A                                      ICCLI)
     A  60                                  DSPATR(PR)
     A                                  8  9'Adresse....:'
     A            CLADCL    R        B  8 22REFFLD(CLIENTSF/CLADCL BIB17/F-
     A                                      ICCLI)
     A  60                                  DSPATR(PR)
     A                                  9  9'Code postal:'
     A            CLCPCL    R        B  9 22REFFLD(CLIENTSF/CLCPCL BIB17/F-
     A                                      ICCLI)
     A  60                                  DSPATR(PR)
     A                                 10  9'Ville......:'
     A            CLVICL    R        B 10 22REFFLD(CLIENTSF/CLVICL BIB17/F-
     A                                      ICCLI)
     A  60                                  DSPATR(PR)
     A                                 11  9'Téléphone..:'
     A            CLTECL    R        B 11 22REFFLD(CLIENTSF/CLTECL BIB17/F-
     A                                      ICCLI)
     A  60                                  DSPATR(PR)
     A                                 12  9'Email......:'
     A            CLMACL    R        B 12 22REFFLD(CLIENTSF/CLMACL BIB17/F-
     A                                      ICCLI)
     A  60                                  DSPATR(PR)
     A                                 14  9'Siret......:'
     A            CLSICL    R        B 14 22REFFLD(CLIENTSF/CLSICL BIB17/F-
     A                                      ICCLI)
     A  60                                  DSPATR(PR)
     A                                 23  8'F3=Quitter  F12=Retour'
     A                                      COLOR(BLU)
```
