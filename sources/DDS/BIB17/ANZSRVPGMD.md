---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: ANZSRVPGMD
type: DDS
longueur_enregistrement: 80
lignes: 133
modifie: 2026-11-16
---

# BIB17/QDDSSRC/ANZSRVPGMD

```text
     A*%%TS  SD  20261105  160533  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A                                      CF03(03)
     A                                      CF12(12)
     A          R FMT1
     A*%%TS  SD  20261105  130901  REMI        REL-V7R5M0  5770-WDS
     A                                  1 24'Analyse d''un programme de service'
     A                                      COLOR(WHT)
     A                                 23  4'F3=Quitter  F12=Annuler  Entree=Va-
     A                                      lider'
     A                                      COLOR(BLU)
     A                                  4  7'Programme de service . :'
     A                                  5  9'Bibliothèque . . . . :'
     A            ODOBNM    R        B  4 32REFFLD(QLIDOBJD/ODOBNM QSYS/QADSPOB-
     A                                      J)
     A                                      CHECK(ME)
     A            ODLBNM    R        B  5 32REFFLD(QLIDOBJD/ODLBNM QSYS/QADSPOB-
     A                                      J)
     A                                  4 44'Nom'
     A                                  5 44'Nom, *LIBL'
     A  40        ERMSG         70   O  9  3COLOR(RED)
     A          R WDW1
     A*%%TS  SD  20261105  130901  REMI        REL-V7R5M0  5770-WDS
     A                                      WINDOW(7 10 12 60)
     A                                      WDWTITLE((*TEXT 'Programme de servi-
     A                                      ce') (*COLOR BLU) *TOP *CENTER)
     A                                      WDWBORDER((*COLOR BLU))
     A                                  1  3'Programme de service :'
     A                                  2  3'Bibliothèque . . . . :'
     A            ODOBNM    R        O  1 26REFFLD(QLIDOBJD/ODOBNM QSYS/QADSPOB-
     A                                      J)
     A                                      COLOR(WHT)
     A            ODLBNM    R        O  2 26REFFLD(QLIDOBJD/ODLBNM QSYS/QADSPOB-
     A                                      J)
     A                                      COLOR(WHT)
     A                                  4  3'1. Programmes lies à ce programme -
     A                                      de service'
     A                                  5  3'2. Modules du programme de service'
     A                                  6  3'3. Procedures exportées'
     A                                  8  3'Choix :'
     A            WDWCHOICE      1   B  8 12
     A                                 11  4'F3=Quitter  F12=Retour'
     A                                      COLOR(BLU)
     A          R SFLPGM                    SFL
     A*%%TS  SD  20261105  160533  REMI        REL-V7R5M0  5770-WDS
     A            PGMNMLST      10   O  7  7
     A            LIBNMLST      10   O  7 22
     A            SIGNLST       32   O  7 46
     A          R CTLPGM                    SFLCTL(SFLPGM)
     A*%%TS  SD  20261105  160533  REMI        REL-V7R5M0  5770-WDS
     A  52                                  SFLDSP
     A  50                                  SFLCLR
     A  51                                  SFLDSPCTL
     A  53                                  SFLEND(*MORE)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A                                  1 21'Programmes lies au programme de se-
     A                                      rvice'
     A                                      COLOR(WHT)
     A                                  3  3'Programme de service :'
     A                                  4  3'Nombre de programmes :'
     A            OBJNAM        10   O  3 27
     A            LIBNAM        10   O  3 57
     A                                  3 41'Bibliothèque :'
     A            PGMNMB         4  0O  4 27
     A                                  6  7'Programme'
     A                                      COLOR(WHT)
     A                                  6 22'Biblio'
     A                                      COLOR(WHT)
     A                                  6 46'Signature'
     A                                      COLOR(WHT)
     A          R FOOT
     A*%%TS  SD  20261105  160533  REMI        REL-V7R5M0  5770-WDS
     A                                 23  3'F3=Quitter   F12=Retour'
     A                                      COLOR(BLU)
     A          R SFLMOD                    SFL
     A*%%TS  SD  20261105  160533  REMI        REL-V7R5M0  5770-WDS
     A            PGMNMLST      10A  O  7  4
     A            LIBNMLST      10A  O  7 15
     A            FLD001         1   B  7  2
     A            ATTRLST       10   O  7 26
     A            SRCDET        33   O  7 37
     A            CREATEDAT     10   O  7 71
     A          R CTLMOD                    SFLCTL(SFLMOD)
     A*%%TS  SD  20261105  160533  REMI        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A  62                                  SFLDSP
     A  60                                  SFLCLR
     A  61                                  SFLDSPCTL
     A  63                                  SFLEND(*MORE)
     A                                  1 25'Modules du programme de services'
     A                                      COLOR(WHT)
     A                                  3  3'Programme de service :'
     A                                  4  3'Nombre de modules    :'
     A            OBJNAM        10A  O  3 27
     A            LIBNAM        10A  O  3 57
     A                                  3 41'Bibliothèque :'
     A            MODNMB         4S 0O  4 27
     A                                  6  4'Module'
     A                                      COLOR(WHT)
     A                                  6 15'Biblio'
     A                                      COLOR(WHT)
     A                                  6 26'Attribut'
     A                                      COLOR(WHT)
     A                                  6 37'Source bib/fichier(membre)'
     A                                      COLOR(WHT)
     A                                  6 71'Créé le'
     A                                      COLOR(WHT)
     A          R SFLPRO                    SFL
     A*%%TS  SD  20261105  160533  REMI        REL-V7R5M0  5770-WDS
     A            PROCNAME      50   O  7  4
     A          R CTLPRO                    SFLCTL(SFLPRO)
     A*%%TS  SD  20261105  160533  REMI        REL-V7R5M0  5770-WDS
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A  72                                  SFLDSP
     A  70                                  SFLCLR
     A  71                                  SFLDSPCTL
     A  73                                  SFLEND(*MORE)
     A                                  1 16'Procédures exportées par le progra-
     A                                      mme de services'
     A                                      COLOR(WHT)
     A                                  3  3'Programme de service :'
     A                                  4  3'Nombre de procédures :'
     A            OBJNAM        10A  O  3 27
     A            LIBNAM        10A  O  3 57
     A                                  3 41'Bibliothèque :'
     A            PGMNMB         4S 0O  4 27
     A                                  6  4'Procédures'
     A                                      COLOR(WHT)
```
