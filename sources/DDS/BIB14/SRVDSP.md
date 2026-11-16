---
bibliotheque: BIB14
fichier_source: QDDSSRC
membre: SRVDSP
type: DDS
longueur_enregistrement: 100
lignes: 156
modifie: 2026-11-16
---

# BIB14/QDDSSRC/SRVDSP

```text
     A*%%TS  SD  20261105  112229  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CA03(03 'Exit')
     A          R MNU
     A*%%TS  SD  20261105  105706  XUAN        REL-V7R5M0  5770-WDS
     A                                  1 24'Analyse d''un programme de service'
     A                                      COLOR(WHT)
     A                                  4  8'Programme de service . :'
     A                                  5 10'Bibliothèque . . . . :'
     A            M_PGM         10   B  4 34
     A            M_LIB         10   B  5 34
     A                                  4 46'Nom'
     A                                  5 46'Nom, *LIBL'
     A                                 23  4'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 23 18'Entree=Valider'
     A                                      COLOR(BLU)
     A          R WIN
     A*%%TS  SD  20261105  112229  XUAN        REL-V7R5M0  5770-WDS
     A                                      CA12(12 'retour')
     A                                      WINDOW(7 14 11 55)
     A                                  1  3'Programme de service . :'
     A                                  2  5'Bibliothèque . . . . :'
     A            W_PGM         10A  O  1 30COLOR(WHT)
     A            W_LIB         10A  O  2 30COLOR(WHT)
     A                                  4  3'1. Programmes liés à ce programme -
     A                                      de service'
     A                                  5  3'2. Modules du programme de service'
     A                                  6  3'3. Procedures exportées'
     A                                  8  3'Choix . . . . . . . .  :'
     A            W_CHX          1A  B  8 29
     A                                 10  3'F3=Quitter'
     A                                      COLOR(BLU)
     A                                 10 19'F12=Retour'
     A                                      COLOR(BLU)
     A          R MODPIED
     A                                 23  2'F3=Quitter   F12=Retour'
     A                                      COLOR(BLU)
     A          R MODSFL                    SFL
     A*%%TS  SD  20261105  112229  XUAN        REL-V7R5M0  5770-WDS
     A            SM_MOD        10   O  7  3
     A            SM_LIB        10   O  7 14
     A            SM_ATT         8   O  7 25
     A            SM_SRC        33   O  7 35
     A            SM_DATE       10   O  7 70
     A          R CTLMOD                    SFLCTL(MODSFL)
     A*%%TS  SD  20261105  112229  XUAN        REL-V7R5M0  5770-WDS
     A                                      CA12(12 'retour')
     A                                      OVERLAY
     A  33                                  SFLDSP
     A  32                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  31                                  SFLEND
     A                                      SFLSIZ(0012)
     A                                      SFLPAG(0011)
     A N33                                  SFLMSG('(Aucun module lié a se SRVP-
     A                                      GM)' 33)
     A            SM_RRN         4S 0H      SFLRCDNBR
     A                                  1 25'Modules du programme de service'
     A                                      COLOR(WHT)
     A                                  3  3'Programme de service :'
     A                                  4  3'Nombre de modules  . :'
     A            CM_PGM        10   O  3 26
     A            CM_NB          3  0O  4 29
     A                                  3 38'Bibliothèque :'
     A            CM_LIB        10   O  3 53
     A                                  6  3'Module'
     A                                      COLOR(WHT)
     A                                  6 14'Biblio'
     A                                      COLOR(WHT)
     A                                  6 25'Attribut'
     A                                      COLOR(WHT)
     A                                  6 35'Source (bib/fichier(membre))'
     A                                      COLOR(WHT)
     A                                  6 68'créé le'
     A                                      COLOR(WHT)
     A          R USESFL                    SFL
     A* Option 5 saisissable uniquement sur les lignes *COPIE (N76)
     A            SUOPT          1A  B  9  2VALUES(' ' '5')
     A  76                                  DSPATR(ND PR)
     A            SU_PGM        10A  O  9  5
     A            SU_LIB        10A  O  9 16
     A            SU_TYPE        7A  O  9 27
     A            SU_LIBL       10A  O  9 35
     A            SU_SIG        32A  O  9 46
     A  75                                  COLOR(RED)
     A N75                                  COLOR(GRN)
     A          R USECTL                    SFLCTL(USESFL)
     A                                      CA12(12 'retour')
     A                                      OVERLAY
     A  33                                  SFLDSP
     A  32                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  31                                  SFLEND(*MORE)
     A                                      SFLSIZ(0500)
     A                                      SFLPAG(0012)
     A            SU_RRN         4S 0H      SFLRCDNBR
     A                                  1 21'Programmes lies au programme de -
     A                                      service'
     A                                      DSPATR(HI)
     A                                  3  2'Programme de service :'
     A            W_PGM         10A  O  3 25
     A                                  3 37'Bibliotheque :'
     A            W_LIB         10A  O  3 52
     A                                  4  2'Objets lies  . . . . :'
     A            CU_NB          4Y 0O  4 25EDTCDE(3)
     A                                  5  2'Toutes les bibliotheques (hors Q-
     A                                      RPLOBJ). *COPIE = liage par copie-
     A                                       des modules.'
     A                                      COLOR(BLU)
     A                                  6  2'Signature : verte = toujours exp-
     A                                      ortee par le *SRVPGM, rouge = per-
     A                                      imee.'
     A                                      COLOR(BLU)
     A                                  7  2'Saisir une option, puis Entree.  -
     A                                       5=Modules copies (lignes *COPIE)'
     A                                      COLOR(BLU)
     A                                  8  2'Op'
     A                                      DSPATR(HI)
     A                                  8  5'Programme'
     A                                      DSPATR(HI)
     A                                  8 16'Biblio'
     A                                      DSPATR(HI)
     A                                  8 27'Type'
     A                                      DSPATR(HI)
     A                                  8 35'Lie via'
     A                                      DSPATR(HI)
     A                                  8 46'Signature enregistree'
     A                                      DSPATR(HI)
     A          R EXPSFL                    SFL
     A            SENUM          4Y 0O  7  2EDTCDE(3)
     A            SENOM         70A  O  7  8
     A          R EXPCTL                    SFLCTL(EXPSFL)
     A                                      CA12(12 'retour')
     A                                      OVERLAY
     A  33                                  SFLDSP
     A  32                                  SFLDSPCTL
     A  30                                  SFLCLR
     A  31                                  SFLEND(*MORE)
     A                                      SFLSIZ(0999)
     A                                      SFLPAG(0014)
     A            SE_RRN         4S 0H      SFLRCDNBR
     A                                  1 18'Procedures exportees par le prog-
     A                                      ramme de service'
     A                                      DSPATR(HI)
     A                                  3  2'Programme de service :'
     A            W_PGM         10A  O  3 25
     A                                  3 37'Bibliotheque :'
     A            W_LIB         10A  O  3 52
     A                                  4  2'Procedures exportees :'
     A            CE_NB          4Y 0O  4 25EDTCDE(3)
     A                                  6  2'Rang'
     A                                      DSPATR(HI)
     A                                  6  8'Procedure'
     A                                      DSPATR(HI)
```
