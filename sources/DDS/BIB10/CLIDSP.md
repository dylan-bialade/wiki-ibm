---
bibliotheque: BIB10
fichier_source: QDSPSRC
membre: CLIDSP
type: DDS
longueur_enregistrement: 80
lignes: 153
modifie: 2026-11-16
---

# BIB10/QDSPSRC/CLIDSP

```text
     A*%%TS  SD  20261016  103739  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      CF05(05)
     A          R SFL1                      SFL
     A*%%TS  SD  20261014  091451  XUAN        REL-V7R5M0  5770-WDS
     A            E1OPT          1A  B  9  5
     A            CLIDCL    R        H      REFFLD(CLIENTSF/CLIDCL BIB10/FICCLI)
     A            CLNOCL    R        O  9  8REFFLD(CLIENTSF/CLNOCL BIB10/FICCLI)
     A            CLCPCL    R        O  9 30REFFLD(CLIENTSF/CLCPCL BIB10/FICCLI)
     A            CLVICL    R        O  9 38REFFLD(CLIENTSF/CLVICL BIB10/FICCLI)
     A            DPT       R    2   O  9 78REFFLD(CLIENTSF/CLCPCL BIB10/FICCLI)
     A            TEL           10  0O  9 61EDTWRD('0  .  .  .  .  ')
     A N64                                  DSPATR(ND)
     A            MAIL      R   50   O 10  8REFFLD(CLIENTSF/CLMACL BIB10/FICCLI)
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261014  144537  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF06(06 'Créer')
     A                                      CF10(10 'wrksplf')
     A                                      CF12(12 'annuler')
     A                                      CF21(21 'Imprimer')
     A                                      OVERLAY
     A  80                                  SFLDSP
     A  81                                  SFLDSPCTL
     A  82                                  SFLCLR
     A  83                                  SFLEND(*MORE)
     A                                      SFLDROP(CF11)
     A                                      SFLSIZ(0007)
     A                                      SFLPAG(0006)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  7SYSNAME
     A                                  1 67'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  7USER
     A                                  2 67'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 72TIME
     A                                  1 32'Liste des Clients'
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A                                  6  6'2=Modifier'
     A                                      COLOR(BLU)
     A                                  8  4'Opt'
     A                                      COLOR(WHT)
     A                                  8  8'Nom'
     A                                      COLOR(BLU)
     A                                  6 17'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  6 29'5=afficher'
     A                                      COLOR(BLU)
     A                                  8 31'CP'
     A                                      COLOR(BLU)
     A                                  8 38'Ville'
     A                                      COLOR(BLU)
     A                                  8 61'Téléphone'
     A                                      COLOR(BLU)
     A                                  8 77'Dpt'
     A                                      COLOR(BLU)
     A                                  5  5'Filtre Dpt:'
     A                                      COLOR(BLU)
     A            FDPT           2A  I  5 17
     A                                  6 40'6=imprimer'
     A                                      COLOR(BLU)
     A          R FOOT1
     A*%%TS  SD  20261014  101732  XUAN        REL-V7R5M0  5770-WDS
     A                                 22  3'F5=Réaficher'
     A                                      COLOR(BLU)
     A                                 22 18'F6=Créer'
     A                                      COLOR(BLU)
     A                                 22 29'F10=WRKSPLF'
     A                                      COLOR(BLU)
     A                                 22 44'F11=Email'
     A                                      COLOR(BLU)
     A                                 22 57'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23  3'F21=Imprimer liste'
     A                                      COLOR(BLU)
     A          R DTAI
     A*%%TS  SD  20261014  101732  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF12(12 'annuler')
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                  1  7SYSNAME
     A                                  1 35'Fiche Client'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A                                  1 67'DATE'
     A                                      COLOR(BLU)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                  2  7USER
     A                                  2 67'TIME'
     A                                      COLOR(BLU)
     A                                  2 72TIME
     A            CMOD          20A  O  2 31
     A                                  8  8'ID Client  . :'
     A                                      COLOR(BLU)
     A            CLIDCL    R        O  8 24REFFLD(CLIENTSF/CLIDCL BIB10/FICCLI)
     A                                  9  8'Nom  .  .  . :'
     A                                      COLOR(BLU)
     A            CLNOCL    R        B  9 24REFFLD(CLIENTSF/CLNOCL BIB10/FICCLI)
     A  45                                  DSPATR(PR)
     A                                 10  8'Adresse  .  .:'
     A                                      COLOR(BLU)
     A            CLADCL    R        B 10 24REFFLD(CLIENTSF/CLADCL BIB10/FICCLI)
     A  45                                  DSPATR(PR)
     A                                 11  8'Code postal  :'
     A                                      COLOR(BLU)
     A            CLCPCL    R        B 11 24REFFLD(CLIENTSF/CLCPCL BIB10/FICCLI)
     A  45                                  DSPATR(PR)
     A                                 12  8'Ville  .  .  :'
     A                                      COLOR(BLU)
     A            CLVICL    R        B 12 24REFFLD(CLIENTSF/CLVICL BIB10/FICCLI)
     A  45                                  DSPATR(PR)
     A                                 13  8'Téléphone  . :'
     A                                      COLOR(BLU)
     A            CLTECL    R        B 13 24REFFLD(CLIENTSF/CLTECL BIB10/FICCLI)
     A  45                                  DSPATR(PR)
     A                                 15  8'Email  .  .  :'
     A                                      COLOR(BLU)
     A            CLMACL    R        B 15 24REFFLD(CLIENTSF/CLMACL BIB10/FICCLI)
     A                                      CNTFLD(035)
     A  45                                  DSPATR(PR)
     A                                 14  8'Siret  .  .  :'
     A                                      COLOR(BLU)
     A            CLSICL    R        B 14 24REFFLD(CLIENTSF/CLSICL BIB10/FICCLI)
     A  45                                  DSPATR(PR)
     A          R WFMT1
     A*%%TS  SD  20261013  134220  XUAN        REL-V7R5M0  5770-WDS
     A                                      WINDOW(6 12 10 50)
     A                                  1 21'Suppression'
     A                                  4  4'Vous etes sur le point de supprime-
     A                                      r:'
     A            CLNOCL        20A  O  5  4
     A                                  9  4'Confirmer la suppression:'
     A            CVER           3   B  9 31
     A                                  9 35'(OUI/NON)'
     A          R DUMMY
     A*%%TS  SD  20261013  132108  XUAN        REL-V7R5M0  5770-WDS
     A                                      ASSUME
     A                                  1  3' '
```
