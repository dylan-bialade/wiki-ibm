---
bibliotheque: BIB10
fichier_source: QDSPSRC
membre: LSTSRCD
type: DDS
longueur_enregistrement: 80
lignes: 83
modifie: 2026-11-16
---

# BIB10/QDSPSRC/LSTSRCD

```text
     A*%%TS  SD  20261020  144332  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A                                      CF05(05)
     A                                      CF22(22)
     A          R SFL1                      SFL
     A*%%TS  SD  20261015  113518  XUAN        REL-V7R5M0  5770-WDS
     A            E1OPT          1A  B 11  5
     A            NUMBER    R        H      REFFLD(FBONBON/NUMBER BIB10/BONBON)
     A            DBXFIL    R        O 11  8REFFLD(FMTDBX/DBXFIL BIB10/LSTSRC)
     A            DBXMBR    R        O 11 19REFFLD(FMTDBX/DBXMBR BIB10/LSTSRC)
     A            DBXTYP    R        O 11 30REFFLD(FMTDBX/DBXTYP BIB10/LSTSRC)
     A            DBXTXT    R        O 12 15REFFLD(FMTDBX/DBXTXT BIB10/LSTSRC)
     A                                 12  8'Texte'
     A                                      COLOR(BLU)
     A            DBXNBL    R        O 11 66REFFLD(FMTDBX/DBXNBL BIB10/LSTSRC)
     A          R CTL1                      SFLCTL(SFL1)
     A*%%TS  SD  20261015  153936  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF06(06 'Create')
     A                                      CF21(21 'Print')
     A                                      OVERLAY
     A  80                                  SFLDSP
     A  81                                  SFLDSPCTL
     A  82                                  SFLCLR
     A  83                                  SFLEND(*MORE)
     A                                      SFLDROP(CF11)
     A                                      SFLSIZ(0006)
     A                                      SFLPAG(0005)
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
     A                                  1 29'Liste des membres source'
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A                                  7  4'Veuillez choisir une option et app-
     A                                      uyez sur ENTREE'
     A                                      COLOR(BLU)
     A                                  8  5'2=Modifier'
     A                                      COLOR(BLU)
     A                                 10  4'Opt'
     A                                      COLOR(WHT)
     A                                 10  8'Fichier'
     A                                      COLOR(BLU)
     A                                 10 31'Type'
     A                                      COLOR(BLU)
     A                                  8 16'4=Supprimer'
     A                                      COLOR(BLU)
     A                                  8 28'5=afficher'
     A                                      COLOR(BLU)
     A                                  5 38'Afficher a partir de :'
     A                                      COLOR(BLU)
     A                                 10 66'Taille'
     A                                      COLOR(BLU)
     A            CAFF          10A  I  5 61
     A                                 10 19'Membre'
     A                                      COLOR(BLU)
     A          R FOOT1
     A*%%TS  SD  20261015  113518  XUAN        REL-V7R5M0  5770-WDS
     A                                 23 31'F21=imprimer liste'
     A                                      COLOR(BLU)
     A                                 23  3'F5=Réaficher'
     A                                      COLOR(BLU)
     A                                 23 19'F6=Créer'
     A                                      COLOR(BLU)
     A                                 23 65'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 53'F11=Desc'
     A                                      COLOR(BLU)
```
